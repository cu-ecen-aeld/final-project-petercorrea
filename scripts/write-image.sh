# RUN ON HOST
cd /Volumes/yocto/raspberrypi3-64
diskutil unmountDisk /dev/disk4 && 
# update image name
bzcat core-image-base-raspberrypi3-64.rootfs-20240415044317.wic.bz2 | sudo dd of=/dev/disk4 bs=4M status=progress conv=fsync &&
diskutil eject /dev/disk4