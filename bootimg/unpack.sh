mkdir ramdisk
gunzip -c ramdisk.img>ramdisk.cpio
cd ramdisk
cpio -i -F ../ramdisk.cpio
cd ..
rm -f ramdisk.cpio
