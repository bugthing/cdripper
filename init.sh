#!/bin/bash

DRIVE=/dev/sr0
LOCKDIR=rip.lock
LOGFILE=/dev/stdout

function wait  {
  while true; do
    cdinfo=$(setcd -i "$DRIVE")
    case "$cdinfo" in
        *'Disc found'*)
            rip
            sleep 3;
            ;;
        *'not ready'*)
            echo '(waiting for drive to be ready)' >&2;
            sleep 3;
            ;;
        *'is open'*)
            echo '(drive is open, please insert cd)' >&2;
            sleep 5;
            ;;
        *)
            printf 'Confused by setcd -i, bailing out:\n%s\n' "$cdinfo" &2
            exit 1
    esac
  done
}

function rip  {
  echo "$(date "+%d.%m.%Y %T") : started rip $$" >> $LOGFILE
  abcde -c ./abcde.conf
  echo "$(date "+%d.%m.%Y %T") : done! ejecting Disk"
  eject $DRIVE >> $LOGFILE 2>&1
}

function cleanup {
  if rmdir $LOCKDIR; then
    echo "$(date "+%d.%m.%Y %T") : finished" >> $LOGFILE
  else
    echo "Failed to remove lock dir '$LOCKDIR'" >> $LOGFILE
    exit 1
  fi
}

echo "Starting CD ripping process.."
if mkdir $LOCKDIR; then
    trap "cleanup" EXIT
    echo "Acquired Lock, running" >> $LOGFILE
    eject $DRIVE
    wait
else
    echo "Could not create lock, already running? '$LOCKDIR'"
    exit 1
fi
