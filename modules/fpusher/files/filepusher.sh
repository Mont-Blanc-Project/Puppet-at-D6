#!/bin/sh
### BEGIN INIT INFO
# Provides:          filepusher
# Required-Start:    $local_fs $network $named $time $syslog
# Required-Stop:     $local_fs $network $named $time $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Description:       Pushes temperature to cassandra DB
### END INIT INFO

LD_LIBRARY_PATH=/apps/power_monitor/arm/lib
SCRIPT=/apps/power_monitor/arm/bin/filepusher
OPTIONS="-a -t 10000 -h 192.168.0.1 /sys/class/thermal/thermal_zone0/temp"
RUNAS=root
 
PIDFILE=/var/run/filepusher.pid
LOGFILE=/var/log/filepusher.log
 
start() {
  if [ -f $PIDFILE ] && kill -0 $(cat $PIDFILE); then
    echo 'Service already running' >&2
    return 1
  fi
  echo 'Starting service…' >&2
  local CMD="LD_LIBRARY_PATH=$LD_LIBRARY_PATH $SCRIPT $OPTIONS &> \"$LOGFILE\" & echo \$!"
  su -c "$CMD" $RUNAS > "$PIDFILE"
  echo 'Service started' >&2
}
 
stop() {
  if [ ! -f "$PIDFILE" ] || ! kill -0 $(cat "$PIDFILE"); then
    echo 'Service not running' >&2
    return 1
  fi
  echo 'Stopping service…' >&2
  kill -15 $(cat "$PIDFILE") && rm -f "$PIDFILE"
  echo 'Service stopped' >&2
}
 
case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  restart)
    stop
    start
    ;;
  *)
    echo "Usage: $0 {start|stop|restart}"
esac
