# SPDX-License-Identifier: GPL-2.0
ifeq ($(CONFIG_ARCH_ROCKCHIP), y)

dtbo-$(CONFIG_CPU_RK3568) += \
	lubancat-dsi0-mipi-display-overlay.dtbo \
	lubancat-gmac1-disable-overlay.dtbo \
	lubancat-i2c3-m0-overlay.dtbo \
	lubancat-i2c5-m0-overlay.dtbo \
	lubancat-pwm3-ir-overlay.dtbo \
	lubancat-pwm8-m0-overlay.dtbo \
	lubancat-pwm9-m0-overlay.dtbo \
	lubancat-pwm10-m0-overlay.dtbo \
	lubancat-pwm11-ir-m0-overlay.dtbo \
	lubancat-pwm14-m0-overlay.dtbo \
	lubancat-spi3-m1-overlay.dtbo \
	lubancat-spi3-m1-gpio-cs-overlay.dtbo \
	lubancat-uart3-m0-overlay.dtbo \
	lubancat-uart3-m1-overlay.dtbo \
	lubancat-uart8-m0-overlay.dtbo 

endif

scr-$(CONFIG_ARCH_ROCKCHIP) += \
	rockchip-fixup.scr

dtbotxt-$(CONFIG_ARCH_ROCKCHIP) += \
	README.rockchip-overlays.md

targets += $(dtbo-y) $(scr-y) $(dtbotxt-y)

always			:= $(dtbo-y) $(scr-y) $(dtbotxt-y)
clean-files		:= *.dtbo *.scr

