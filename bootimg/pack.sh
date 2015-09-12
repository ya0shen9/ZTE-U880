cd ramdisk
#must name ram.cpio.gz then rename to ramdisk.img
find .|cpio -o -H newc|gzip> ../ram.cpio.gz

cd ..
mv ram.cpio.gz ramdisk_new.img
#rm -f ramdisk.cpio.gz

