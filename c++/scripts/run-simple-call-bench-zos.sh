export LD_LIBRARY_PATH=`pwd`



turnOnCPs.sh 4

sleep 10


# 3 billion for simple calls
testIter=3000000000
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
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkNoParamNoRet $testIter 0
	
	
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkNoParamNoRet $testIter 1
	
	#
	# test 2
	#
	
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkNoRet $testIter 0
	
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkNoRet $testIter 1
	
	#
	# test 3
	#

	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkRet $testIter 0

	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkRet $testIter 1
		
	#
	# test 4
	#

	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkGetFieldID $testIter 0

	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkGetFieldID $testIter 1
	
	
	#
	# test 5
	#

	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkSetLongField $testIter 0

	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkSetLongField $testIter 1


	#
	# test 6
	#

	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkSetLongFieldStatic $testIter 0

	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkSetLongFieldStatic $testIter 1
	
	#
	# test 7
	# This takes too much time on zOS. just run it once
	#

	if [[ $counter -eq "0" ]]; then
	    oldIter=$testIter
	    testIter=5000000
	
		sleep 10
		$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkArrayWriting $testIter 0
	
		sleep 10
		$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkArrayWriting $testIter 1
		
		testIter=$oldIter
	else
		echo "Skipping test 7"
	fi
done

