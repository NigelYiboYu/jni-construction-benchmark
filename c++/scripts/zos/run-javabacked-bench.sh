export LD_LIBRARY_PATH=`pwd`



turnOnCPs.sh 4

sleep 10



testIter=300000000
doWarmup=0

if [[ $1 -ne 0 ]]; then
	doWarmup=1
fi

rm -f vlog*

IBM_JAVA="/jit/team/yunigel/sdk/bin/java"
JIT_OPT=' -Xjit:verbose,vlog=vlog'
JIT_OPT=''
JVM_OPT=" -cp ../../src"


echo "***********************************************************"
echo "*		Testing this java"
echo "***********************************************************"

$IBM_JAVA -version

echo "***********************************************************"

counter=0
maxIter=5
JAVA=$IBM_JAVA

while [ $counter -lt $maxIter ]; do
	echo iteration $counter in $maxIter
	counter=$[$counter+1]
	
	#
	# test 1
	#
	
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.javabacked.bench.BenchmarkFooByCall $testIter 0
	
	
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.javabacked.bench.BenchmarkFooByCall $testIter 1
	
	#
	# test 2
	#
	
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.javabacked.bench.BenchmarkFooByCallStatic $testIter 0
	
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.javabacked.bench.BenchmarkFooByCallStatic $testIter 1
	
	#
	# test 3
	#

	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.javabacked.bench.BenchmarkFooByCallInvoke $testIter 0

	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.javabacked.bench.BenchmarkFooByCallInvoke $testIter 1

done

