#!/system/bin/sh

# vision.img is placed in a subdirectory to get around
# several SELinux restrictions on writing to /data/misc
VISION_IMG="/data/misc/vision_img/vision.img"
VISION_SIZE="500MB"
VISION_LOOP_LINK_DST="/dev/block/vision_loop"

if [[ ! -f $VISION_IMG ]]; then
    fallocate -l $VISION_SIZE $VISION_IMG
    mkfs.ext4 $VISION_IMG
fi

LOOP_DEVICE=`losetup -s -f $VISION_IMG`

ln -sf "$LOOP_DEVICE" "$VISION_LOOP_LINK_DST"
