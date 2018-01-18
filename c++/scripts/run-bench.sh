export LD_LIBRARY_PATH=`pwd`


testIter=300000000
doWarmup=0

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
maxIter=5

doWarmup=0
while [ $counter -lt $maxIter ]; do
	echo iteration $counter in $maxIter
	
	counter=$[$counter+1]
	#
	# test 1
	#
	
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.javabacked.bench.BenchmarkFooByCall $testIter $doWarmup
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.javabacked.bench.BenchmarkFooByCall $testIter $doWarmup
	
	#
	# test 2
	#
	
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.javabacked.bench.BenchmarkFooByCallStatic $testIter $doWarmup
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.javabacked.bench.BenchmarkFooByCallStatic $testIter $doWarmup
	
	
	#
	# test 3
	#
	
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.javabacked.bench.BenchmarkFooByCallInvoke $testIter $doWarmup
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.javabacked.bench.BenchmarkFooByCallInvoke $testIter $doWarmup

done



counter=0
doWarmup=1
while [ $counter -lt $maxIter ]; do
	echo iteration $counter in $maxIter
	
	counter=$[$counter+1]
	#
	# test 1
	#
	
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.javabacked.bench.BenchmarkFooByCall $testIter $doWarmup
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.javabacked.bench.BenchmarkFooByCall $testIter $doWarmup
	
	#
	# test 2
	#
	
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.javabacked.bench.BenchmarkFooByCallStatic $testIter $doWarmup
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.javabacked.bench.BenchmarkFooByCallStatic $testIter $doWarmup
	
	
	#
	# test 3
	#
	
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.javabacked.bench.BenchmarkFooByCallInvoke $testIter $doWarmup
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.javabacked.bench.BenchmarkFooByCallInvoke $testIter $doWarmup
	

done
