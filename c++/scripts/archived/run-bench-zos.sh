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
	$JAVA  $JIT_OPT -cp . com.jni.consbench.BenchmarkFooByCall $testIter 0
	
	
	sleep 10
	$JAVA  $JIT_OPT -cp . com.jni.consbench.BenchmarkFooByCall $testIter 1
	
	#
	# test 2
	#
	
	sleep 10
	$JAVA  $JIT_OPT -cp . com.jni.consbench.BenchmarkFooByCallStatic $testIter 0
	
	sleep 10
	$JAVA  $JIT_OPT -cp . com.jni.consbench.BenchmarkFooByCallStatic $testIter 1
	
	#
	# test 3
	#

	sleep 10
	$JAVA  $JIT_OPT -cp . com.jni.consbench.BenchmarkFooByCallInvoke $testIter 0

	sleep 10
	$JAVA  $JIT_OPT -cp . com.jni.consbench.BenchmarkFooByCallInvoke $testIter 1
	
	#
	# test 4
	#
	
	sleep 10
	$JAVA  $JIT_OPT -cp . com.jni.consbench.BenchmarkInMainFooByCall $testIter 0

	
	sleep 10
	$JAVA  $JIT_OPT -cp . com.jni.consbench.BenchmarkInMainFooByCall $testIter 1
	
	#
	# test 5
	#
	
	sleep 10
	$JAVA  $JIT_OPT -cp . com.jni.consbench.BenchmarkInMainFooByCallStatic $testIter 0
	
	sleep 10
	$JAVA  $JIT_OPT -cp . com.jni.consbench.BenchmarkInMainFooByCallStatic $testIter 1
	
	#
	# test 6
	#
	
	sleep 10
	$JAVA  $JIT_OPT -cp . com.jni.consbench.BenchmarkInMainFooByCallInvoke $testIter 0
	
	sleep 10
	$JAVA  $JIT_OPT -cp . com.jni.consbench.BenchmarkInMainFooByCallInvoke $testIter 1

done

