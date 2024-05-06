#!/system/bin/sh

SKIPUNZIP=1
ASH_STANDALONE=0

ZT_PATH=/data/adb/zerotier
CONF_PATH=/sdcard/Android/zerotier
CONF_NAME=network_id.txt

ui_print "- unzip"
unzip -o "${ZIPFILE}" -x 'META-INF/*' -d "${MODPATH}" >&2

ui_print "- set file permission"
set_perm_recursive ${MODPATH}/zerotier 0 0 0755 0755

ui_print "- create work dir"
mkdir -p ${ZT_PATH}
mv ${MODPATH}/zerotier/* ${ZT_PATH}

ln -s ${ZT_PATH}/zerotier-one ${ZT_PATH}/zerotier-cli
ln -s ${ZT_PATH}/zerotier-one ${ZT_PATH}/zerotier-idtool

ui_print "- create config dir"
mkdir -p ${CONF_PATH}
touch ${CONF_PATH}/${CONF_NAME}
echo "1111111111111111" > ${CONF_PATH}/${CONF_NAME}

ui_print "- clean up"
rm -rf ${MODPATH}/customize.sh 2>/dev/null
rm -rf ${MODPATH}/bin 2>/dev/null
sleep 1

ui_print "- installed"

set_perm_recursive ${MODPATH} 0 0 0755 0644

ui_print "---------- information -----------"
ui_print "- zerotier root: ${ZT_PATH}"
ui_print "- zerotier version: $(grep_prop version ${TMPDIR}/module.prop)"
ui_print "- config file path: ${CONF_PATH}/${CONF_NAME}"


