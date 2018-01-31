#######################################################
#					Config
#######################################################
TOOLS_DIR=/jit/instrumentation/jprof

IBM_SDK="/jit/team/yunigel/sdk-31"
export JVM_TO_MEASURE=$IBM_SDK

IBM_JAVA="$IBM_SDK/bin/java"

IBM_SDK_FLAV="s390x/compressedrefs"
IBM_SDK_FLAV="s390/default"
IBM_SDK_BITNESS="31"

BENCH_PATH="/jit/team/yunigel/jni-bench"
BENCH_NAME="com.jni.consbench.simpleCall.BenchmarkNoParamNoRet"

AGENT_OPT='-agentlib:jprof=tprof,pidx,asid,LOGPATH=/jit/instrumentation/handson/results,LOGPREFIX=jprof'
JVM_OPT=" -Xdump:none -cp $BENCH_PATH/src"
JIT_OPT=' -Xjit:verbose,vlog=vlog'
JIT_OPT=''

PROF_LOG_NAME=profile-run.log

testIter=300000000
doWarmup=0
useXPLINK=0

export LD_LIBRARY_PATH=`pwd`
#######################################################
#					Prep
#######################################################
rm -f $PROF_LOG_NAME
touch $PROF_LOG_NAME

turnOnCPs.sh 4


#cleanall

rm -f vlog*



#######################################################
#					patch SDK
#######################################################

cp $TOOLS_DIR/libjprof$IBM_SDK_BITNESS.so $IBM_SDK/jre/lib/$IBM_SDK_FLAV/libjprof.so
cp $TOOLS_DIR/libjprof$IBM_SDK_BITNESS.so $IBM_SDK/lib/$IBM_SDK_FLAV/libjprof.so

echo "***********************************************************"
echo "*         Benchmarking this java                           "
echo "***********************************************************"

$IBM_JAVA -version

echo "***********************************************************"

JAVA=$IBM_JAVA

#######################################################
#					Start benchmark
#######################################################
sleep 10
$JAVA $JIT_OPT -Xdump:tool:events=vmstop,exec='sleep 10000' $AGENT_OPT  $JVM_OPT $BENCH_NAME $testIter $doWarmup $useXPLINK 2>&1 | tee -a $PROF_LOG_NAME
