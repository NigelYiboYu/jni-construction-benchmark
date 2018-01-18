export LD_LIBRARY_PATH=`pwd`


# 3 billion
testIter=3000000000
doWarmup=0
MAX_ITER=5

if [[ $1 -ne 0 ]]; then
	doWarmup=1
fi

JIT_OPT=' -Xjit:verbose,vlog=vlog'
JIT_OPT=''
JVM_OPT=" -cp ../../"

rm -f vlog*

IBM_JAVA="/jit/team/yunigel/sdk/bin/java"
OPENJDK_JAVA="/jit/team/yunigel/openJDK9/jdk-9+181/bin/java"

echo "***********************************************************"
echo "*		Testing this java"
echo "***********************************************************"

$IBM_JAVA -version

echo "***********************************************************"

$OPENJDK_JAVA -version

echo "***********************************************************"

counter=0
doWarmup=0


while [ $counter -lt $MAX_ITER ]; do
	echo iteration $counter in $MAX_ITER
	
	counter=$[$counter+1]
	#
	# test 1
	#
	
	echo "test 1"
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkNoParamNoRet $testIter $doWarmup
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkNoParamNoRet $testIter $doWarmup
	
	#
	# test 2
	#
	echo "test 2"
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkNoRet $testIter $doWarmup
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkNoRet $testIter $doWarmup
	
	
	#
	# test 3
	#
	echo "test 3"
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkRet $testIter $doWarmup
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkRet $testIter $doWarmup

	
	#
	# test 4
	#
	echo "test 4"
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkGetFieldID $testIter $doWarmup
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkGetFieldID $testIter $doWarmup
	
	#
	# test 5
	#
	echo "test 5"
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkSetLongField $testIter $doWarmup
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkSetLongField $testIter $doWarmup
	
	#
	# test 6
	#
	echo "test 6"
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkSetLongFieldStatic $testIter $doWarmup
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkSetLongFieldStatic $testIter $doWarmup
	
	#
	# test 7
	# uses 5 million iterations
	echo "test 7"
	
	oldIter=$testIter
	testIter=5000000
	
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkArrayWriting $testIter $doWarmup
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkArrayWriting $testIter $doWarmup
	
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
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkNoParamNoRet $testIter $doWarmup
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkNoParamNoRet $testIter $doWarmup
	
	#
	# test 2
	#
	echo "test 2"
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkNoRet $testIter $doWarmup
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkNoRet $testIter $doWarmup
	
	
	#
	# test 3
	#
	echo "test 3"
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkRet $testIter $doWarmup
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkRet $testIter $doWarmup

	
	#
	# test 4
	#
	echo "test 4"
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkGetFieldID $testIter $doWarmup
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkGetFieldID $testIter $doWarmup
	
	#
	# test 5
	#
	echo "test 5"
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkSetLongField $testIter $doWarmup
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkSetLongField $testIter $doWarmup
	
	#
	# test 6
	#
	echo "test 6"
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkSetLongFieldStatic $testIter $doWarmup
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkSetLongFieldStatic $testIter $doWarmup
	
	#
	# test 7
	# uses 5 million iterations
	echo "test 7"
	
	oldIter=$testIter
	testIter=5000000
	
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkArrayWriting $testIter $doWarmup
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkArrayWriting $testIter $doWarmup
	
	testIter=$oldIter
done


