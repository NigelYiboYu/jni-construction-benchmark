TOOLS_DIR=/jit/instrumentation/jprof64
#export PATH=$TOOLS_DIR:$PATH
#export LIBPATH=$TOOLS_DIR:$LIBPATH
#export STEPLIB=$TOOLS_DIR:$STEPLIB
export LD_LIBRARY_PATH=`pwd`




PROF_LOG_NAME=profile-run.log
rm -f $PROF_LOG_NAME

touch $PROF_LOG_NAME

turnOnCPs.sh 4


#cleanall


testIter=300000000
doWarmup=0

if [[ $1 -ne 0 ]]; then
	echo "Do warmup = 1"
    doWarmup=1
fi

rm -f vlog*

IBM_SDK="/jit/team/yunigel/sdk"
IBM_JAVA="$IBM_SDK/bin/java"
BENCH_PATH="/jit/team/yunigel/jni-bench"
BENCH_NAME="com.jni.consbench.simpleCall.BenchmarkArrayWriting"

AGENT_OPT='-agentlib:jprof=tprof,pidx,asid,LOGPATH=/jit/instrumentation/handson/results,LOGPREFIX=jprof'
JVM_OPT=" -Xdump:none -cp $BENCH_PATH/src"
JIT_OPT=' -Xjit:verbose,vlog=vlog'
JIT_OPT=''


#######################################################
#					patch SDK
#######################################################

cp $TOOLS_DIR/libjprof.so $IBM_SDK/jre/lib/s390x/compressedrefs/libjprof.so
cp $TOOLS_DIR/libjprof.so $IBM_SDK/lib/s390x/compressedrefs/libjprof.so

echo "***********************************************************"
echo "*         Testing this java                                "
echo "***********************************************************"

$IBM_JAVA -version

echo "***********************************************************"

JAVA=$IBM_JAVA


sleep 10
$JAVA $JIT_OPT -Xdump:tool:events=vmstop,exec='sleep 10000' $AGENT_OPT  $JVM_OPT $BENCH_NAME $testIter 0 2>&1 | tee -a $PROF_LOG_NAME
