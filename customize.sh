#!/sbin/sh
#####################
# phantomsocks Customization
#####################
SKIPUNZIP=1

# prepare phantomsocks execute environment
ui_print "- Prepare phantomsocks execute environment."
mkdir -p /data/phantomsocks
mkdir -p /data/phantomsocks/run
mkdir -p $MODPATH/scripts
mkdir -p $MODPATH/system/bin
# install phantomsocks execute file
ui_print "- Install phantomsocks core $ARCH execute files"
unzip -j -o "${ZIPFILE}" "phantomsocks/bin/*" -d $MODPATH/system/bin >&2
unzip -j -o "${ZIPFILE}" 'phantomsocks/scripts/*' -d $MODPATH/scripts >&2
unzip -j -o "${ZIPFILE}" 'service.sh' -d $MODPATH >&2
unzip -j -o "${ZIPFILE}" 'uninstall.sh' -d $MODPATH >&2
# copy phantomsocks data and config
ui_print "- Copy phantomsocks config and data files"
unzip -j -o "${ZIPFILE}" "phantomsocks/etc/resolv.conf" -d /data/phantomsocks >&2
ln -s /data/phantomsocks/resolv.conf $MODPATH/system/etc/resolv.conf
unzip -j -o "${ZIPFILE}" "config.json" -d /data/phantomsocks >&2
unzip -j -o "${ZIPFILE}" "default.conf" -d /data/phantomsocks >&2
# generate module.prop
ui_print "- Generate module.prop"
rm -rf $MODPATH/module.prop
touch $MODPATH/module.prop
echo "id=phantomsocks" > $MODPATH/module.prop
echo "name=Phantomsocks for Android" >> $MODPATH/module.prop
echo -n "version=" >> $MODPATH/module.prop
echo "0.1" >> $MODPATH/module.prop
echo "versionCode=20230809" >> $MODPATH/module.prop
echo "author=macronut" >> $MODPATH/module.prop
echo "description=phantomsocks with service scripts for Android" >> $MODPATH/module.prop
ifconfig

inet_uid="3003"
net_raw_uid="3004"
set_perm_recursive $MODPATH 0 0 0755 0644
set_perm  $MODPATH/service.sh    0  0  0755
set_perm  $MODPATH/uninstall.sh    0  0  0755
set_perm  $MODPATH/scripts/start.sh    0  0  0755
set_perm  $MODPATH/scripts/phantomsocks.inotify    0  0  0755
set_perm  $MODPATH/scripts/phantomsocks.service    0  0  0755
set_perm  /data/phantomsocks ${inet_uid}  ${inet_uid}  0755
set_perm  $MODPATH/system/bin/phantomsocks  ${inet_uid}  ${inet_uid}  0755
