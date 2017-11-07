include $(TOPDIR)/rules.mk

# Makefile for LEDE
#
# Huanle Zhang
# www.huanlezhang.com


PKG_NAME:=dtc_show_ip
PKG_RELEASE:=1

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
	SECTION:=dtc
	CATEGORY:=dtc
	TITLE:=auto upload ip to my website
	MAINTAINER:=Huanle Zhang
	URL:=www.huanlezhang.com
	DEFAULT:=y
endef

define Package/$(PKG_NAME)/description
	Automatically upload ip to my website when interface is up 
		www.huanlezhang.com
	
	More information about this tool refer to my github:
	https://github.com/dtczhl/dtc-show-ip 
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)/files
	$(CP) * !(Makefile) $(PKG_BUILD_DIR)/files/
	mv $(PKG_BUILD_DIR)/files/Makefile_empty $(PKG_BUILD_DIR)/files/Makefile
endef 

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/dtc-show-ip.sh $(1)/usr/bin/
	$(INSTALL_DIR) $(1)/etc/hotplug.d/iface
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/files/90-dtcShowIp $(1)/etc/hotplug.d/iface/
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
