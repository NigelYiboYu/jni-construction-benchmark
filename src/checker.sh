#TOOLS_DIR=/jit/instrumentation/jprof64
#export PATH=$TOOLS_DIR:$PATH
#export LIBPATH=$TOOLS_DIR:$LIBPATH
#export STEPLIB=$TOOLS_DIR:$STEPLIB



PROF_DURATION=15
DELAY=2
PROF_LOG_NAME=profile-run.log

while true; do

	grep -iq 'Starting test FooByCall 3' $PROF_LOG_NAME

   	if [ $? -eq 0 ]; then
      	break
   	fi

   	sleep 1

done


sleep $DELAY

starti

sleep $PROF_DURATION

stopi


javaPid=`ps -a | grep -i java | awk '{print $1}'`
echo 'Killing java process' $javaPid
kill -9 $javaPid


gcServerPid=`ps -a | grep -i GCServer | awk {print $1}`
echo 'Killing GC server process' $gcServerPid
kill -9 $gcServerPid

