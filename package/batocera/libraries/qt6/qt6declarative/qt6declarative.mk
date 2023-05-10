################################################################################
#
# qt6declarative
#
################################################################################

QT6DECLARATIVE_VERSION = $(QT6_VERSION)
QT6DECLARATIVE_SITE = $(QT6_SITE)
QT6DECLARATIVE_SOURCE = qt6declarative-$(QT6_SOURCE_TARBALL_PREFIX)-$(QT6DECLARATIVE_VERSION).tar.xz
QT6DECLARATIVE_INSTALL_STAGING = YES
QT6DECLARATIVE_SUPPORTS_IN_SOURCE_BUILD = NO

QT6DECLARATIVE_LICENSE = \
    GPL-2.0+ or LGPL-3.0, \
    GPL-3.0, GFDL-1.3 no invariants (docs)

QT6DECLARATIVE_LICENSE_FILES = \
    LICENSES/GPL-2.0-only.txt \
    LICENSES/GPL-3.0-only.txt \
    LICENSES/LGPL-3.0-only.txt \
    LICENSES/GFDL-1.3-no-invariants-only.txt

QT6DECLARATIVE_CONF_OPTS = \
    -GNinja \
    -DQT_HOST_PATH=$(HOST_DIR) \
    -DBUILD_WITH_PCH=OFF \
    -DQT_BUILD_EXAMPLES=OFF \
    -DQT_BUILD_TESTS=OFF

QT6DECLARATIVE_DEPENDENCIES = qt6base

define QT6DECLARATIVE_BUILD_CMDS
    $(TARGET_MAKE_ENV) $(BR2_CMAKE) --build $(QT6DECLARATIVE_BUILDDIR)
endef

define QT6DECLARATIVE_INSTALL_STAGING_CMDS
    $(TARGET_MAKE_ENV) DESTDIR=$(STAGING_DIR) $(BR2_CMAKE) --install $(QT6DECLARATIVE_BUILDDIR)
endef

define QT6DECLARATIVE_INSTALL_TARGET_CMDS
    $(TARGET_MAKE_ENV) DESTDIR=$(TARGET_DIR) $(BR2_CMAKE) --install $(QT6DECLARATIVE_BUILDDIR)
endef

$(eval $(cmake-package))