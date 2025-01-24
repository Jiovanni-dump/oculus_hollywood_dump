#!/vendor/bin/sh

# Determine msm_drm IRQ at runtime
drm_irq=$(sed -En "s/^([0-9]+):.+msm_drm$/\1/p" /proc/interrupts)

setprop ro.vendor.drm.irq $drm_irq
