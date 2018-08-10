#!/bin/bash
set -xeo pipefail
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $DIR

LOGFILE=/tmp/build_script.out

touch $LOGFILE

(
  COUNTER=0
  while [  $COUNTER -lt 30 ]; do
    echo The counter is $COUNTER $(date)
    let COUNTER=COUNTER+1
    sleep 60
    echo "Muted, but still building. Last 100 lines:"
    tail -100 $LOGFILE
  done
  echo "Timing out after 30 minutes."
) &
MUTED_PID=$!

echo "Running: $@"
$@ 2>&1 | tee -a $LOGFILE
MAKE_RESULT=$?

tail -1000 $LOGFILE
if ps -p $MUTED_PID > /dev/null
then
   kill $MUTED_PID
fi

echo exit $MAKE_RESULT
exit $MAKE_RESULT
