# RUN ON CONTAINER

# BUILD
cd ../poky
source oe-init-build-env 
cat ../../poky_conf/bblayers.txt > /home/yocto/src/poky/build/conf/bblayers.conf
cat ../../poky_conf/local.txt > /home/yocto/src/poky/build/conf/local.conf
bitbake-layers add-layer /home/yocto/src/meta-openembedded/meta-oe &&
bitbake-layers add-layer /home/yocto/src/meta-openembedded/meta-python &&
bitbake-layers add-layer /home/yocto/src/meta-openembedded/meta-multimedia &&
bitbake-layers add-layer /home/yocto/src/meta-openembedded/meta-networking &&
bitbake-layers add-layer /home/yocto/src/meta-raspberrypi &&
bitbake-layers show-layers && 
# bitbake core-image-base --runonly=fetch &&
bitbake core-image-base &&

# COPY BUILD ONTO CASE SENSITIVE VOLUME MOUNTED FROM MAC HOST
cp -r ~/build/tmp-glibc/deploy/images/raspberrypi3-64 /mnt/yocto