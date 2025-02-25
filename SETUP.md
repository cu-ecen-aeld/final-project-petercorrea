# Building a RaspberryPi Image w/ Yocto (on macOS)

These instructions are intended for a macOS host. The following steps will guide the reader to creating a RaspberryPi image by creating a containerized yocto build environment.

## Not for Beginners

The provided scripts help to automate manual steps but assumes you have some understanding of the process. If you are not familiar with yocto, poky, or bitbake please refer to the docs for guidance: <https://docs.yoctoproject.org/brief-yoctoprojectqs/index.html>.

## Prereqs

1. Ensure a case sensitive volume named 'yocto' has been created on the host

2. Clone the necessary repos into the project folder.

    ```bash
    ./scripts/clone-repos.sh
    ```

3. Your project folder should look like this:

   ```bash
   meta-openembedded
   meta-raspberrypi
   poky
   poky_conf
   scripts
   sync
   docker-compose.yml
   Dockerfile
   ```

## Steps to Build Image

1. Build the yocto container on the host

    ```bash
   ./scripts/build-container.sh
   ```

2. Build the bootable image in the container

    ```bash
   ~/src/scripts/build-image.sh
    ```

3. From the host write the image onto an sdcard

    ```bash
    # make sure to update line 5
   .scripts/write-image.sh
    ```

## Sync Files From Host

```bash
# compile on the container
cd ~/src/sync && gcc -o hello hello.c
```

```bash
# run on host; make sure to update the path in the script
./scripts/sync.sh
```

## Set System Time

```bash
# on pi
sudo date -s "YYYY-MM-DD HH:MM:SS"
```

## Emulation

```bash
qemu-system-aarch64 \
-M raspi3b \
-kernel Image-raspberrypi3-64.bin \
-dtb bcm2710-rpi-3-b-plus-raspberrypi3-64.dtb \
-drive file=core-image-base-raspberrypi3-64.ext3,format=raw \
-append "root=/Volumes/yocto/raspberrypi3-64" \
-nographic
```

## Utilities

```bash
echo "Kernel Information: $(uname -a)"
echo "CPU Temperature: $(vcgencmd measure_temp)"
echo "Disk Space Usage: $(df -h)"
echo "RAM Usage: $(free -h)"
echo "Throttling Information: $(vcgencmd get_throttled)"
```

## Notes

- Mac can't format ext4
- bitbake needs to output to a case sensitive storage but Mac won't mount block devices (SD card) onto docker, so we create a case sensitive volume to copy the build onto, and transfer the build from there
- quilt didn't have permissions

## Resources

<https://docs.yoctoproject.org/>

<https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-manual-intro.html>

<https://meta-raspberrypi.readthedocs.io/en/latest/index.html>

<https://www.openembedded.org/wiki/Main_Page>
