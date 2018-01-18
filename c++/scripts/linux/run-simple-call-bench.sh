export LD_LIBRARY_PATH=`pwd`
rm -f vlog*



sudo ./turnOnCPs.sh 4

uname -a | grep x86
isX86=$?
if [ "$isX86" -eq "0" ];
then
	echo "Using paths for x86"
	BENCH_PATH="/home/yunigel/jni-bench/"
	IBM_JAVA="/home/yunigel/sdk/bin/java"
	OPENJDK_JAVA="/home/yunigel/openJDK9/jdk-9+181/bin/java"
else
	echo "Using paths for zLinux"
	BENCH_PATH="/jit/team/yunigel/jni-bench/"
	IBM_JAVA="/jit/team/yunigel/sdk/bin/java"
	OPENJDK_JAVA="/jit/team/yunigel/openJDK9/jdk-9+181/bin/java"
fi

# 3 billion
testIter=3000000000
doWarmup=0
MAX_ITER=5
XPLINK=0

counter=0
doWarmup=0

if [[ $1 -ne 0 ]]; then
	doWarmup=1
fi

JIT_OPT=' -Xjit:verbose,vlog=vlog'
JIT_OPT=''
JVM_OPT=" -cp $BENCH_PATH/src"



echo "***********************************************************"
echo "*		Testing this java"
echo "***********************************************************"

$IBM_JAVA -version

echo "***********************************************************"

$OPENJDK_JAVA -version

echo "***********************************************************"

while [ $counter -lt $MAX_ITER ]; do
	echo iteration $counter in $MAX_ITER
	
	counter=$[$counter+1]
	#
	# test 1
	#
	
	echo "test 1"
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkNoParamNoRet $testIter $doWarmup $XPLINK
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkNoParamNoRet $testIter $doWarmup $XPLINK
	
	#
	# test 2
	#
	echo "test 2"
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkNoRet $testIter $doWarmup $XPLINK
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkNoRet $testIter $doWarmup $XPLINK
	
	
	#
	# test 3
	#
	echo "test 3"
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkRet $testIter $doWarmup $XPLINK
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkRet $testIter $doWarmup $XPLINK

	
	#
	# test 4
	#
	echo "test 4"
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkGetFieldID $testIter $doWarmup $XPLINK
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkGetFieldID $testIter $doWarmup $XPLINK
	
	#
	# test 5
	#
	echo "test 5"
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkSetLongField $testIter $doWarmup $XPLINK
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkSetLongField $testIter $doWarmup $XPLINK
	
	#
	# test 6
	#
	echo "test 6"
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkSetLongFieldStatic $testIter $doWarmup $XPLINK
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkSetLongFieldStatic $testIter $doWarmup $XPLINK
	
	#
	# test 7
	# uses 5 million iterations
	echo "test 7"
	
	oldIter=$testIter
	testIter=5000000
	
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkArrayWriting $testIter $doWarmup $XPLINK
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkArrayWriting $testIter $doWarmup $XPLINK
	
	testIter=$oldIter
done



counter=0
doWarmup=1
while [ $counter -lt $MAX_ITER ]; do
	echo iteration $counter in $MAX_ITER
	
	counter=$[$counter+1]
	#
	# test 1
	#
	
	echo "test 1"
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkNoParamNoRet $testIter $doWarmup $XPLINK
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkNoParamNoRet $testIter $doWarmup $XPLINK
	
	#
	# test 2
	#
	echo "test 2"
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkNoRet $testIter $doWarmup $XPLINK
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkNoRet $testIter $doWarmup $XPLINK
	
	
	#
	# test 3
	#
	echo "test 3"
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkRet $testIter $doWarmup $XPLINK
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkRet $testIter $doWarmup $XPLINK

	
	#
	# test 4
	#
	echo "test 4"
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkGetFieldID $testIter $doWarmup $XPLINK
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkGetFieldID $testIter $doWarmup $XPLINK
	
	#
	# test 5
	#
	echo "test 5"
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkSetLongField $testIter $doWarmup $XPLINK
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkSetLongField $testIter $doWarmup $XPLINK
	
	#
	# test 6
	#
	echo "test 6"
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkSetLongFieldStatic $testIter $doWarmup $XPLINK
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkSetLongFieldStatic $testIter $doWarmup $XPLINK
	
	#
	# test 7
	# uses 5 million iterations
	echo "test 7"
	
	oldIter=$testIter
	testIter=5000000
	
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkArrayWriting $testIter $doWarmup $XPLINK
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkArrayWriting $testIter $doWarmup $XPLINK
	
	testIter=$oldIter
done


