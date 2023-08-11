#!/system/bin/sh

moddir="/data/adb/modules/phantomsocks"
scripts_dir="/data/adb/modules/phantomsocks/scripts"
service="${scripts_dir}/phantomsocks.service"

start_service () {
  settings put global ntp_server pool.ntp.org
  if [ ! -f "${scripts_dir}/disable" ]; then
    ${service} start > /data/phantomsocks/run/service.log
  fi
  inotifyd "${scripts_dir}/phantomsocks.inotify" "${moddir}/":mynd >> "/dev/null" &
}

if [ -f /data/phantomsocks/manual ] ; then
  exit 1
fi

start_service
