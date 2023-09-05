#!/bin/bash

echo -e "\e[36m Generate extLinuxBoot image start\e[0m"

set -x

#获取路径
CMD=`realpath $0`
COMMON_DIR=`dirname $CMD`
TOP_DIR=$(realpath $COMMON_DIR)
KERNEL_VERSION=$(cat $TOP_DIR/include/config/kernel.release)
EXTBOOT_IMG=${TOP_DIR}/extboot.img
EXTBOOT_DIR=${TOP_DIR}/extboot
EXTBOOT_DTB=${EXTBOOT_DIR}/dtb/

#创建目录
rm -rf $EXTBOOT_DIR
mkdir -p $EXTBOOT_DIR/extlinux
mkdir -p $EXTBOOT_DTB/overlay
mkdir -p $EXTBOOT_DIR/uEnv
mkdir -p $EXTBOOT_DIR/kerneldeb

#写入配置
echo -e "label kernel-$KERNEL_VERSION" >> $EXTBOOT_DIR/extlinux/extlinux.conf
echo -e "\tkernel /Image-$KERNEL_VERSION" >> $EXTBOOT_DIR/extlinux/extlinux.conf
echo -e "\tdevicetreedir /" >> $EXTBOOT_DIR/extlinux/extlinux.conf
echo -e "\tappend  root=/dev/mmcblk0p3 earlyprintk console=ttyFIQ0 console=tty1 consoleblank=0 loglevel=7 rootwait rw rootfstype=ext4 cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory swapaccount=1 switolb=1 coherent_pool=1m" >> $EXTBOOT_DIR/extlinux/extlinux.conf

#拷贝文件
cp ${TOP_DIR}/arch/${RK_ARCH}/boot/dts/rockchip/*.dtb $EXTBOOT_DTB
cp ${TOP_DIR}/arch/${RK_ARCH}/boot/dts/rockchip/overlay/*.dtbo $EXTBOOT_DTB/overlay
cp ${TOP_DIR}/arch/${RK_ARCH}/boot/dts/rockchip/uEnv/uEnv*.txt $EXTBOOT_DIR/uEnv
cp ${TOP_DIR}/arch/${RK_ARCH}/boot/dts/rockchip/uEnv/boot.cmd $EXTBOOT_DIR/
cp ${TOP_DIR}/arch/${RK_ARCH}/boot/Image $EXTBOOT_DIR/Image-$KERNEL_VERSION

cp -f $EXTBOOT_DTB/${RK_KERNEL_DTS}.dtb $EXTBOOT_DIR/rk-kernel.dtb

if [[ -e ${TOP_DIR}/lubancat-bin/initrd/initrd-$KERNEL_VERSION ]]; then
    cp ${TOP_DIR}/lubancat-bin/initrd/initrd-$KERNEL_VERSION $EXTBOOT_DIR/initrd-$KERNEL_VERSION
fi
if [[ -e $EXTBOOT_DIR/boot.cmd ]]; then
    mkimage -T script -C none -d $EXTBOOT_DIR/boot.cmd $EXTBOOT_DIR/boot.scr
fi


cp ${TOP_DIR}/.config $EXTBOOT_DIR/config-$KERNEL_VERSION
cp ${TOP_DIR}/System.map $EXTBOOT_DIR/System.map-$KERNEL_VERSION
cp ${TOP_DIR}/logo_kernel.bmp $EXTBOOT_DIR/
cp ${TOP_DIR}/logo_boot.bmp $EXTBOOT_DIR/logo.bmp
cp ${TOP_DIR}/linux-headers-"$KERNEL_VERSION"_"$KERNEL_VERSION"-*.deb $EXTBOOT_DIR/kerneldeb
cp ${TOP_DIR}/linux-image-"$KERNEL_VERSION"_"$KERNEL_VERSION"-*.deb $EXTBOOT_DIR/kerneldeb
rm -rf $EXTBOOT_IMG && truncate -s 128M $EXTBOOT_IMG
fakeroot mkfs.ext2 -F -L "boot" -d $EXTBOOT_DIR $EXTBOOT_IMG


exit 0

set +x
