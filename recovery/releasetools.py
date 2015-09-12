"""Emit commands needed for Marvell devices during OTA installation
(installing uboot, obm and kernel image)."""

import common
import sha
import os

# the image name of each partition
RAMDISK_IMG =        'ramdisk.img'
KERNEL_IMG =         'uImage'
MAINTENANCE_IMG =    'uImage'
RECOVERY_IMG =       'ramdisk-recovery.img'
UBOOT_IMG =          'u-boot.bin'
ARBEL_IMG =          None
MSA_IMG =            None

# the path of each image
RAMDISK_PATH =       'out/target/product/u880/%s' % (RAMDISK_IMG)
KERNEL_PATH =        'kernel/out/%s' % (KERNEL_IMG)
MAINTENANCE_PATH =   'kernel/out/%s' % (MAINTENANCE_IMG)
RECOVERY_PATH =      'out/target/product/u880/%s' % (RECOVERY_IMG)
UBOOT_PATH =         'boot/out/%s' % (UBOOT_IMG)

# the mount point of each partition
RAMDISK_MOUNT =      '/ramdisk'
KERNEL_MOUNT =       '/kernel'
MAINTENANCE_MOUNT =  '/maintenance'
RECOVERY_MOUNT =     '/recovery'
MISC_MOUNT =         '/misc'
SYSTEM_MOUNT =       '/system'
DATA_MOUNT =         '/data'
NVM_MOUNT =          '/nvm'
TELEPHONY_MOUNT =    '/marvell'
UBOOT_MOUNT =        '/bootloader'
ARBEL_MOUNT =        '/arbelbinary'
MSA_MOUNT =          '/msabinary'

MSA_DIR =            'kernel/out/telephony'
ARBEL_DIR =          'kernel/out/telephony'
TELEPHONY_DIR =      'vendor/marvell/generic/ttc_telephony/drivers/output/marvell'
TELEPHONY_TARGETDIR =   'marvell'

def ChooseArbelBinary(binary_path):
  '''choose the arbelbinary based on platform.
     binary_path: the path of arbelbinary
  '''
  if os.path.isdir(binary_path):
    files = os.listdir(binary_path)
    for f in files:
      if f.startswith('Arbel_') and f.endswith('.bin'):
        return f

  return None

def ChooseMSABinary(binary_path):
  '''choose the msabinary name based on platform.
     binary_path: the path of msabinary
  '''
  if os.path.isdir(binary_path):
    files = os.listdir(binary_path)
    for f in files:
      if f.startswith('TT') and f.endswith('AI_A1_Flash.bin'):
        return f

  return None

def CopyTelephonyFiles(input_path, output_zip, dir_name, ko_files):
  '''copy the telephony files form TELEPHONY_DIR/ to OTA zip package, and store all the .ko files.
     input_path: the path of telephony
     output_zip: the object of OTA zip package
     dir_name: the direcotry name of telephony in OTA zip package
     ko_files: the list which stores all the .ko files under input_path
  '''
  if os.path.isdir(input_path):
    if input_path.endswith('/'):
      input_path = input_path[:-1]

    files = os.listdir(input_path)
    for f in files:
      whole_name = input_path + '/' + f
      target_name = dir_name + '/' + f
      if os.path.isfile(whole_name):
        try:
          tmp_file = open(whole_name)
          data = tmp_file.read()
          tmp_file.close()
        except KeyError:
          print "Error in reading file %s" % (whole_name)
        else:
          if f.endswith('.ko'):
              ko_files.append(target_name)
          output_zip.writestr(target_name, data)
      else:
        CopyTelephonyFiles(whole_name, output_zip, target_name, ko_files)

def SetTelephonyPermissions(script, mounted_dir, ko_files):
  '''set all the files under mounted_dir:
       all the .ko files with permission: system, system, 0644; ohters: system, system, 0755.
     script: the object of updater-script in OTA package
     mounted_dir: the mount point of the partition
     ko_files: the list stores all the .ko files
  '''
  script.SetPermissionsRecursive(mounted_dir, 1000, 1000, 0755, 0755)
  for f in ko_files:
    script.SetPermissions(f, 1000, 1000, 0644)

def UpdateTelephonyPartition(info, input_path, dir_name, mounted_dir, partition_name):
  '''update the telephony partition
     info: the module infomation
     input_path: the path of telephony
     dir_name: the direcotry name of telephony in OTA zip package
     mounted_dir: the mount point of the partition
     partition_name: the partition name in recovery.fstab
  '''
  ko_files = []
  CopyTelephonyFiles(input_path, info.output_zip, dir_name, ko_files)

  info.script.Print("Start updating %s partition..." % (partition_name))
  info.script.FormatPartition(mounted_dir)
  info.script.Mount(mounted_dir)
  info.script.UnpackPackageDir(dir_name, mounted_dir)
  SetTelephonyPermissions(info.script, mounted_dir, ko_files)
  info.script.UnmountAll()
  info.script.Print("Finish updating telephony Partition!")
  print "update %s successfully!" %(partition_name)

def UpdateRawPartition(info, img_name, img_path, partition_name):
  '''update the parition with type raw
     info: the module infomation
     img_name: the image's name of the partition
     partition_name: the name of the partition to be updated
  '''
  try:
    tmp_file = open(img_path, 'rb')
    tmp_img = tmp_file.read()
    tmp_file.close()
  except KeyError:
    print "no %s in update files; skip installing."%(img_name)
  else:
    common.ZipWriteStr(info.output_zip, img_name, tmp_img)
    info.script.Print("Start updating %s partition..." % (partition_name))
    info.script.AppendExtra('package_extract_file("%s", "/tmp/%s");' %(img_name, img_name))
    info.script.AppendExtra('write_raw_image("/tmp/%s", "%s");' %(img_name, partition_name))
    info.script.AppendExtra('delete("/tmp/%s");'%(img_name))
    info.script.Print("Finish updating %s!"%(partition_name))
    print "update %s successfully!" %(partition_name)

def WipePartition(info, mounted_dir, partition_name):
  '''erase the partition
     info: the module infomation
     mounted_dir: the mount point of the partition
     partition_name: the name of the partition to be updated
  '''
  info.script.Print("Start wiping %s partition..." % (partition_name))
  info.script.FormatPartition(mounted_dir)
  info.script.Print("Finish wiping %s!" % partition_name)
  print "wipe %s successfully!" % (partition_name)

def FullOTA_InstallEnd(info):
  info.script.UnmountAll()
  fstab = info.info_dict.get("fstab", None);
  if (0 == 1):
	  # ----------update bootloader----------
	  UpdateRawPartition(info, UBOOT_IMG, UBOOT_PATH, fstab[UBOOT_MOUNT].device)

	  # ----------update arbelbinary----------
	  ARBEL_IMG = ChooseArbelBinary(ARBEL_DIR)
	  if ARBEL_IMG != None:
	    UpdateRawPartition(info, ARBEL_IMG, ARBEL_DIR + '/' + ARBEL_IMG, fstab[ARBEL_MOUNT].device)

	  # ----------update msabinary----------
	  MSA_IMG = ChooseMSABinary(MSA_DIR)
	  if MSA_IMG != None:
	    UpdateRawPartition(info, MSA_IMG, MSA_DIR + '/' + MSA_IMG, fstab[MSA_MOUNT].device)

	  # ----------update ramdisk----------
	  UpdateRawPartition(info, RAMDISK_IMG, RAMDISK_PATH, fstab[RAMDISK_MOUNT].device)

	  # ----------update kernel----------
	  UpdateRawPartition(info, KERNEL_IMG, KERNEL_PATH, fstab[KERNEL_MOUNT].device)

	  # ----------update maintenance----------
	  UpdateRawPartition(info, MAINTENANCE_IMG, MAINTENANCE_PATH, fstab[MAINTENANCE_MOUNT].device)

	  # ----------update recovery----------
	  UpdateRawPartition(info, RECOVERY_IMG, RECOVERY_PATH, fstab[RECOVERY_MOUNT].device)

	  # ----------wipe nvm----------
	  WipePartition(info, NVM_MOUNT, fstab[NVM_MOUNT].device)

	  # ----------wipe userdata----------
	  WipePartition(info, DATA_MOUNT, fstab[DATA_MOUNT].device)

	  # ----------wipe misc----------
	  WipePartition(info, MISC_MOUNT, fstab[MISC_MOUNT].device)

	  # ----------update telephony----------
	  UpdateTelephonyPartition(info, TELEPHONY_DIR, TELEPHONY_TARGETDIR, TELEPHONY_MOUNT, fstab[TELEPHONY_MOUNT].device)

  info.script.ShowProgress(0.1, 1)

  info.script.Print("All done, just reboot and enjoy!")
