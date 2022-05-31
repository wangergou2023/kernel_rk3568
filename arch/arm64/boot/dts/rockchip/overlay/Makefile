# SPDX-License-Identifier: GPL-2.0
ifeq ($(CONFIG_ARCH_ROCKCHIP), y)

dtbo-$(CONFIG_CPU_RK3568) += \
	lubancat2-uart3-overlay.dtbo

endif

scr-$(CONFIG_ARCH_ROCKCHIP) += \
	rockchip-fixup.scr

dtbotxt-$(CONFIG_ARCH_ROCKCHIP) += \
	README.rockchip-overlays

targets += $(dtbo-y) $(scr-y) $(dtbotxt-y)

always			:= $(dtbo-y) $(scr-y) $(dtbotxt-y)
clean-files		:= *.dtbo *.scr

