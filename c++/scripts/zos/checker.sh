#######################################################
#					Config
#######################################################
export JVM_TO_MEASURE=/jit/team/yunigel/sdk-31/

PROF_DURATION=60
DELAY=60
PROF_LOG_NAME=profile-run.log
#######################################################
#					Wait
#######################################################
echo "Waiting for test to start"


while true; do

	grep -iq 'Starting test' $PROF_LOG_NAME

   	if [ $? -eq 0 ]; then
      	break
   	fi

   	sleep 1

done

#######################################################
#					Start
#######################################################
echo "Delaying $DELAY sec before start_sampler"
sleep $DELAY

echo "Starting sampler"
starti

sleep $PROF_DURATION

stopi


javaPid=`ps -a | grep -i java | awk '{print $1}'`
echo 'Killing java process' $javaPid
kill -9 $javaPid


gcServerPid=`ps -a | grep -i GCServer | awk {print $1}`
echo 'Killing GC server process' $gcServerPid
kill -9 $gcServerPid

