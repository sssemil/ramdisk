#!/sbin/busybox sh

busybox mkdir -m 755 -p /system

# создаем нод системного раздела и подключаем его
busybox mknod -m 600 /dev/block/nandd b 93 24
busybox mount -o rw -t ext4 /dev/block/nandd /system

bysybox insmod /system/vendor/modules/8188eu.ko
bysybox insmod /system/vendor/modules/gslX680.ko
bysybox insmod /system/vendor/modules/mma8452.ko
bysybox insmod /system/vendor/modules/rtl8150.ko
bysybox insmod /system/vendor/modules/mcs7830.ko
bysybox insmod /system/vendor/modules/qf9700.ko
bysybox insmod /system/vendor/modules/asix.ko
bysybox insmod /system/vendor/modules/sunxi_temperature.ko
bysybox insmod /system/vendor/modules/sw_device.ko
bysybox insmod /system/vendor/modules/g2d_33.ko
bysybox insmod /system/vendor/modules/vfe_v4l2.ko
bysybox insmod /system/vendor/modules/gc2035.ko
bysybox insmod /system/vendor/modules/gc0307.ko
bysybox insmod /system/vendor/modules/ov5640.ko
bysybox insmod /system/vendor/modules/vfe_subdev.ko
bysybox insmod /system/vendor/modules/vfe_os.ko
bysybox insmod /system/vendor/modules/cci.ko
bysybox insmod /system/vendor/modules/ad5820_act.ko
bysybox insmod /system/vendor/modules/actuator.ko
bysybox insmod /system/vendor/modules/cam_detect.ko
bysybox insmod /system/vendor/modules/videobuf_dma_contig.ko
bysybox insmod /system/vendor/modules/videobuf_core.ko
bysybox insmod /system/vendor/modules/dc_sunxi.ko
bysybox insmod /system/vendor/modules/pvrsrvkm.ko
bysybox insmod /system/vendor/modules/hdmi.ko
bysybox insmod /system/vendor/modules/lcd.ko
bysybox insmod /system/vendor/modules/disp.ko
bysybox insmod /system/vendor/modules/nand.ko

