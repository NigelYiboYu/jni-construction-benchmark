#######################################################
#					Config
#######################################################

HOME_DIR="/trjit/sandbox/yunigel"


IBM_SDK="$HOME_DIR/sdk-31"
IBM_JAVA="$IBM_SDK/bin/java"
IBM_SDK_FLAV="s390/default"

BENCH_PATH="$HOME_DIR/jni-bench"
BENCH_NAME="com.jni.consbench.simpleCall.BenchmarkNoParamNoRet"

AGENT_OPT=''
DUMP_OPT=" -Xdump:system+java:events=vmstop "
DUMP_OPT=" -Xdump:none"

JVM_OPT=" -cp $BENCH_PATH/src"
JIT_OPT=' -Xjit:verbose,vlog=vlog,{com/jni/consbench/simpleCall/BenchmarkNoParamNoRet.doTest(Z)V}{hot}(traceFull,traceCG,log=trace-JNI-doTest),{com/jni/consbench/simpleCall/SimpleCalls.testNoParamNoRet()V}(traceFull,traceCG,log=trace-JNI-thunk)'


testIter=3000000000
doWarmup=0
useXPLINK=0

export LD_LIBRARY_PATH=`pwd`
#######################################################
#					Prep
#######################################################
rm -f $PROF_LOG_NAME
touch $PROF_LOG_NAME

turnOnCPs.sh 4


rm -f vlog*
rm -f trace*

#######################################################
#					patch SDK
#######################################################


echo "Patching SDK with benchmark DLL"


cp ./libstdlinkjnibench.so $IBM_SDK/jre/lib/$IBM_SDK_FLAV/
cp ./libstdlinkjnibench.so $IBM_SDK/lib/$IBM_SDK_FLAV/

cp ./libxplinkjnibench.so $IBM_SDK/jre/lib/$IBM_SDK_FLAV/
cp ./libxplinkjnibench.so $IBM_SDK/lib/$IBM_SDK_FLAV/


echo "***********************************************************"
echo "*         Benchmarking this java                           "
echo "***********************************************************"

$IBM_JAVA -version

echo "***********************************************************"

JAVA=$IBM_JAVA

#######################################################
#					Start benchmark
# use -Xdump:tool:events=vmstop,exec='sleep 10000' to wait
#######################################################
sleep 10
$JAVA $JIT_OPT  \
	$DUMP_OPT $AGENT_OPT  $JVM_OPT \
	$BENCH_NAME \
	$testIter $doWarmup $useXPLINK
