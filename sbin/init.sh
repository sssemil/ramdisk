#!/sbin/busybox sh
set +x 
_PATH="$PATH" 
export PATH=/sbin 

busybox cd / 
busybox date >>boot.txt 
exec >>boot.txt 2>&1 
busybox rm /init 

busybox insmod /modules/* 

# import device specific vars 
source /sbin/bootrec-device 

# create directories 
busybox mkdir -m 755 -p /dev/block 
busybox mkdir -m 755 -p /dev/input 
busybox mkdir -m 555 -p /proc 
busybox mkdir -m 755 -p /sys 
busybox mkdir -m 755 -p /data 
busybox mkdir -m 755 -p /linux 

# create device nodes 
busybox mknod -m 600 ${LINUX_BLOCK_NODE} 
busybox mknod -m 600 ${BOOTREC_EVENT_NODE} 
busybox mknod -m 666 /dev/null c 1 3 

# mount filesystems 
busybox mount -t proc proc /proc 
busybox mount -t sysfs sysfs /sys 
busybox mount -o rw -t ext2 ${LINUX_BLOCK} /linux 

# keycheck 
busybox cat ${BOOTREC_EVENT} > /dev/keycheck& 
busybox sleep 3 

# android ramdisk 
load_image=/sbin/ramdisk.cpio 

# boot decision 
if [ -s /dev/keycheck ] || [ -d /linux/boot_linux ]; then 
	busybox rm -rf /linux/boot_linux 
	busybox echo 'LINUX BOOT' >>boot.txt 
	busybox mount -o remount,rw / 
        
	# kill the keycheck process 
	busybox pkill -f "busybox cat ${BOOTREC_EVENT}" 
	 
	cd /linux 
	for n in * 
        do 
           busybox mkdir /$n
        done

	for m in *
        do
           if [ ! $m == "/sys" ] && [ ! $m == "/proc" ]; then
               busybox mount -o bind /linux/$m /$m
           fi
        done

	cd / 

	busybox date >>boot.txt
        busybox cat boot.txt > /linux/boot.txt
	export PATH="${_PATH}"

        busybox sh /sbin/insmod.sh

	exec /sbin/init
else 
	busybox echo 'ANDROID BOOT' >>boot.txt 
        
	# kill the keycheck process 
	busybox pkill -f "busybox cat ${BOOTREC_EVENT}" 

	# unpack the ramdisk image 
	busybox cpio -i < ${load_image} 

	busybox umount /proc 
	busybox umount /sys 

	busybox rm -fr /dev/* 
	busybox date >>boot.txt 
	export PATH="${_PATH}" 
	exec /init
fi
