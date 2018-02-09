#######################################################
#					Config
#######################################################

HOME_DIR="/trjit/sandbox/yunigel"
IBM_SDK="$HOME_DIR/sdk-31"


IBM_JAVA="$IBM_SDK/bin/java"
IBM_SDK_FLAV="s390/default"
#IBM_SDK_FLAV="s390x/compressedrefs"

BENCH_PATH="$HOME_DIR/jni-bench"
BENCH_NAME="com.jni.consbench.simpleCall.BenchmarkNoRet"

DUMP_OPT=" -Xdump:system+java:events=vmstop "
DUMP_OPT=" -Xdump:none"

JVM_OPT=" -cp $BENCH_PATH/src -Xoptionsfile=$BENCH_PATH/c++/scripts/zos/optfile"


testIter=300000000
doWarmup=0
useXPLINK=0
BITNESS=31

export LD_LIBRARY_PATH=`pwd`
#######################################################
#					Prep and cleanup
#######################################################
rm -f $PROF_LOG_NAME
touch $PROF_LOG_NAME

rm -f javacore*
rm -f jitdump*
rm -f core*
rm -f Snap*
rm -f vlog*
rm -f trace*

#######################################################
#					patch SDK
#######################################################


echo "Patching SDK with benchmark DLL"


if [[ $BITNESS -eq "31" ]];
then
	if [[ -z $IBM_SDK/jre/lib/$IBM_SDK_FLAV/ ]];
	then
		cp ./libstdlinkjnibench.so $IBM_SDK/jre/lib/$IBM_SDK_FLAV/
	fi
	
	if [[ -z $IBM_SDK/lib/$IBM_SDK_FLAV/ ]];
	then
		cp ./libstdlinkjnibench.so $IBM_SDK/lib/$IBM_SDK_FLAV/
	fi
	
fi


	
if [[ -z $IBM_SDK/jre/lib/$IBM_SDK_FLAV/ ]];
then
	cp ./libxplinkjnibench$BITNESS.so $IBM_SDK/jre/lib/$IBM_SDK_FLAV/libxplinkjnibench.so
fi


if [[ -z $IBM_SDK/lib/$IBM_SDK_FLAV/ ]];
then
	cp ./libxplinkjnibench$BITNESS.so $IBM_SDK/lib/$IBM_SDK_FLAV/libxplinkjnibench.so
fi


echo "***********************************************************"
echo "*         Benchmarking this java                           "
echo "***********************************************************"

#$IBM_JAVA -version

echo "***********************************************************"

JAVA=$IBM_JAVA

#######################################################
#					Start benchmark
# use -Xdump:tool:events=vmstop,exec='sleep 10000' to wait
#######################################################
$JAVA $DUMP_OPT $JVM_OPT $BENCH_NAME $testIter $doWarmup $useXPLINK
