export LD_LIBRARY_PATH=`pwd`


./turnOnCPs.sh 4


testIter=300000000
doWarmup=0
XPLINK=0

if [[ $1 -ne 0 ]]; then
	doWarmup=1
fi


uname -a | grep x86
isX86=$?
if [ "$isX86" -eq "0" ];
then
	echo "Using paths for x86"
	IBM_JAVA="/home/yunigel/sdk/bin/java"
	OPENJDK_JAVA="/home/yunigel/openJDK9/jdk-9+181/bin/java"
else
	echo "Using paths for zLinux"
	IBM_JAVA="/jit/team/yunigel/sdk/bin/java"
	OPENJDK_JAVA="/jit/team/yunigel/openJDK9/jdk-9+181/bin/java"
fi

JIT_OPT=' -Xjit:verbose,vlog=vlog'
JIT_OPT=''
JVM_OPT=" -cp ../../src"

rm -f vlog*



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
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.javabacked.bench.BenchmarkFooByCall $testIter $doWarmup $XPLINK
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.javabacked.bench.BenchmarkFooByCall $testIter $doWarmup $XPLINK
	
	#
	# test 2
	#
	
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.javabacked.bench.BenchmarkFooByCallStatic $testIter $doWarmup $XPLINK
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.javabacked.bench.BenchmarkFooByCallStatic $testIter $doWarmup $XPLINK
	
	
	#
	# test 3
	#
	
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.javabacked.bench.BenchmarkFooByCallInvoke $testIter $doWarmup $XPLINK
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.javabacked.bench.BenchmarkFooByCallInvoke $testIter $doWarmup $XPLINK

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
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.javabacked.bench.BenchmarkFooByCall $testIter $doWarmup $XPLINK
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.javabacked.bench.BenchmarkFooByCall $testIter $doWarmup $XPLINK
	
	#
	# test 2
	#
	
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.javabacked.bench.BenchmarkFooByCallStatic $testIter $doWarmup $XPLINK
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.javabacked.bench.BenchmarkFooByCallStatic $testIter $doWarmup $XPLINK
	
	
	#
	# test 3
	#
	
	JAVA=$IBM_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.javabacked.bench.BenchmarkFooByCallInvoke $testIter $doWarmup $XPLINK
	
	JAVA=$OPENJDK_JAVA
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.javabacked.bench.BenchmarkFooByCallInvoke $testIter $doWarmup $XPLINK
	

done
