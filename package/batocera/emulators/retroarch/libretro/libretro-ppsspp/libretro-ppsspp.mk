################################################################################
#
# LIBRETRO PPSSPP
#
################################################################################
# Version.: Commits on Jan 12, 2020
LIBRETRO_PPSSPP_VERSION = e717366fa5913c0b7669c567c3131c8538906b2c
LIBRETRO_PPSSPP_SITE = https://github.com/hrydgard/ppsspp.git
LIBRETRO_PPSSPP_SITE_METHOD=git
LIBRETRO_PPSSPP_GIT_SUBMODULES=YES
LIBRETRO_PPSSPP_LICENSE = GPLv2

LIBRETRO_PPSSPP_CONF_OPTS = -DLIBRETRO=ON

# x86
ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_X86),y)
	LIBRETRO_PPSSPP_CONF_OPTS += -DX86=ON 
endif

# x86_64
ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_X86_64),y)
	LIBRETRO_PPSSPP_CONF_OPTS += -DX86_64=ON
endif

# rpi3
ifeq ($(BR2_PACKAGE_BATOCERA_TARGET_RPI3),y)
	LIBRETRO_PPSSPP_CONF_OPTS += -DRASPBIAN=ON 
	LIBRETRO_PPSSPP_CONF_OPTS += -DARMV7=ON 
	LIBRETRO_PPSSPP_CONF_OPTS += -DUSING_GLES2=ON
	LIBRETRO_PPSSPP_CONF_OPTS += -DUSING_EGL=OFF
	LIBRETRO_PPSSPP_CONF_OPTS += -DUSING_X11_VULKAN=OFF 
	LIBRETRO_PPSSPP_CONF_OPTS += -DUSING_FBDEV=ON
	LIBRETRO_PPSSPP_CONF_OPTS += -DUSE_SYSTEM_FFMPEG=ON
endif

define LIBRETRO_PPSSPP_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS)" CXXFLAGS="$(TARGET_CXXFLAGS)" $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" \
		LD="$(TARGET_LD)" RANLIB="$(TARGET_RANLIB)" AR="$(TARGET_AR)" -C $(@D)/libretro -f Makefile platform="$(LIBRETRO_PLATFORM)"
endef

define LIBRETRO_PPSSPP_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/lib/ppsspp_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/ppsspp_libretro.so
endef

$(eval $(cmake-package))
