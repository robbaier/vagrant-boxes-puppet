yum -y update
yum -y clean all

yum -y erase gtk2 libX11 hicolor-icon-theme avahi freetype bitstream-vera-fonts
yum -y erase kernel-devel kernel-firmware kernel-headers gcc

rm -rf /etc/yum.repos.d/{puppetlabs,epel}.repo
rm -rf VBoxGuestAdditions_*.iso

# Remove Documentation
rm -rf /usr/share/doc/*

# Remove Locales
rm -rf /usr/lib/locale/*
rm -rf /usr/share/locale/*

# Remove traces of mac address from network configuration
sed -i /HWADDR/d /etc/sysconfig/network-scripts/ifcfg-eth0
rm /etc/udev/rules.d/70-persistent-net.rules
