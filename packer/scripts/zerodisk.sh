# Zero out the free space to save space in the final image:
# dd if=/dev/zero of=/EMPTY bs=1M
# rm -f /EMPTY
# sync

DISK_USAGE_BEFORE_CLEANUP=$(df -h)

# Other locales will be removed from the VM
KEEP_LANGUAGE="en"
KEEP_LOCALE="en_US"
echo "==> Remove unused man page locales"
pushd /usr/share/man
if [ $(ls | wc -w) -gt 16 ]; then
  mkdir ../tmp_dir
  mv man* $KEEP_LANGUAGE $SECONDARY_LANGUAGE ../tmp_dir
  rm -rf *
  mv ../tmp_dir/* .
  rm -rf ../tmp_dir
  sync
fi
popd

echo "==> Clean up yum cache of metadata and packages to save space"
yum -y --enablerepo='*' clean all
rm -rf /var/cache/yum

echo "==> Clear core files"
rm -f /core*

echo "==> Removing temporary files used to build box"
rm -rf /tmp/*

echo "==> Rebuild RPM DB"
rpmdb --rebuilddb
rm -f /var/lib/rpm/__db*

echo '==> Clear out swap and disable until reboot'
set +e
swapuuid=$(/sbin/blkid -o value -l -s UUID -t TYPE=swap)
case "$?" in
	2|0) ;;
	*) exit 1 ;;
esac
set -e
if [ "x${swapuuid}" != "x" ]; then
    # Whiteout the swap partition to reduce box size
    # Swap is disabled till reboot
    swappart=$(readlink -f /dev/disk/by-uuid/$swapuuid)
    /sbin/swapoff "${swappart}"
    dd if=/dev/zero of="${swappart}" bs=1M || echo "dd exit code $? is suppressed"
    /sbin/mkswap -U "${swapuuid}" "${swappart}"
fi

echo '==> Zeroing out empty area to save space in the final image'
# Zero out the free space to save space in the final image.  Contiguous
# zeroed space compresses down to nothing.
dd if=/dev/zero of=/EMPTY bs=1M || echo "dd exit code $? is suppressed"
rm -f /EMPTY

# Block until the empty file has been removed, otherwise, Packer
# will try to kill the box while the disk is still full and that's bad
sync

echo "==> Disk usage before cleanup"
echo ${DISK_USAGE_BEFORE_CLEANUP}

echo "==> Disk usage after cleanup"
df -h
