export LD_LIBRARY_PATH=`pwd`

echo "***********************************************************"
echo "*							  clean up						 "
echo "***********************************************************"
rm -f vlog*


echo "***********************************************************"
echo "*							  setup						     "
echo "***********************************************************"

turnOnCPs.sh 4

sleep 10

# 3 billion for simple calls
# test7 5 Million
# test8 200 million
testIter=3000000000
defaultIter=3000000000
test7Iter=5000000
test8Iter=200000000

MAX_NUM_RUNS=5

doWarmup=0
counter=0
useXPlink=0

if [[ $1 -ne 0 ]]; then
	doWarmup=1
fi


HOME_DIR="/jit/team/yunigel"
IBM_SDK_DIR="$HOME_DIR/sdk-31"
IBM_JAVA="$IBM_SDK_DIR/bin/java"
BENCH_PATH="$HOME_DIR/jni-bench"

JAVA=$IBM_JAVA


JIT_OPT=' -Xjit:verbose,vlog=vlog'
JIT_OPT=' -Xjit '
JVM_OPT=" -cp $BENCH_PATH/src"




export enable_ronu_bin_insert=1
export ronu_bin_path="$IBM_SDK_DIR/ronu.bin"


echo "***********************************************************"
echo "*		Testing this java"
echo "***********************************************************"

echo "test date " date
#$IBM_JAVA -version

echo "***********************************************************"


while [ $counter -lt $MAX_NUM_RUNS ]; do
	echo iteration $counter in $MAX_NUM_RUNS
	
	#
	# test 1
	#
	
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkNoParamNoRet $testIter 0 $useXPlink
	
	
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkNoParamNoRet $testIter 1 $useXPlink
	
	#
	# test 2
	#
	
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkNoRet $testIter 0 $useXPlink
	
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkNoRet $testIter 1 $useXPlink
	
	#
	# test 3
	#

	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkRet $testIter 0 $useXPlink

	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkRet $testIter 1 $useXPlink
		
	#
	# test 4
	# getFieldID()

	#sleep 10
	#$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkGetFieldID $testIter 0 $useXPlink

	#sleep 10
	#$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkGetFieldID $testIter 1 $useXPlink
	echo "Skipping test 4"
	
	#
	# test 5
	#	setLongFiled()

	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkSetLongField $testIter 0 $useXPlink

	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkSetLongField $testIter 1 $useXPlink


	#
	# test 6
	# setStaticLongField()
    if [[ $counter -eq 0 ]]; then
	
		sleep 10
		$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkSetLongFieldStatic $testIter 0 $useXPlink
    
		sleep 10
		$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkSetLongFieldStatic $testIter 1 $useXPlink
	else
		echo "Skipping test 6"
	fi
	
	#
	# test 7
	# arrayReadWriteElements()
	#
	# This takes too much time on zOS. just run it once
	#

	if [[ $counter -eq 0 ]]; then
		testIter=$test7Iter
	
		sleep 10
		$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkArrayReadWriteElement $testIter 0 $useXPlink
	
		sleep 10
		$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkArrayReadWriteElement $testIter 1 $useXPlink
		
		testIter=$defaultIter
	else
		echo "Skipping test 7"
	fi
	
	
	#
	# test 8
	#  arrayReadWriteRegion()
	# run 200 Million times

	testIter=$test8Iter
	
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkArrayReadWriteRegion $testIter 0 $useXPlink
	
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkArrayReadWriteRegion $testIter 1 $useXPlink
		
	testIter=$defaultIter

	
	
	#
	#	test loop counter
	#
	counter=$[$counter+1]
done



counter=0
useXPlink=0


unset enable_ronu_bin_insert=1
unset ronu_bin_path="$IBM_SDK_DIR/ronu.bin"


while [ $counter -lt $MAX_NUM_RUNS ]; do
	echo iteration $counter in $MAX_NUM_RUNS
	
	#
	# test 1
	#
	
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkNoParamNoRet $testIter 0 $useXPlink
	
	
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkNoParamNoRet $testIter 1 $useXPlink
	
	#
	# test 2
	#
	
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkNoRet $testIter 0 $useXPlink
	
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkNoRet $testIter 1 $useXPlink
	
	#
	# test 3
	#

	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkRet $testIter 0 $useXPlink

	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkRet $testIter 1 $useXPlink
		
	#
	# test 4
	# getFieldID()

	#sleep 10
	#$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkGetFieldID $testIter 0 $useXPlink

	#sleep 10
	#$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkGetFieldID $testIter 1 $useXPlink
	echo "Skipping test 4"
	
	#
	# test 5
	#	setLongFiled()

	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkSetLongField $testIter 0 $useXPlink

	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkSetLongField $testIter 1 $useXPlink


	#
	# test 6
	# setStaticLongField()
    if [[ $counter -eq 0 ]]; then
	
		sleep 10
		$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkSetLongFieldStatic $testIter 0 $useXPlink
    
		sleep 10
		$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkSetLongFieldStatic $testIter 1 $useXPlink
	else
		echo "Skipping test 6"
	fi
	
	#
	# test 7
	# arrayReadWriteElements()
	#
	# This takes too much time on zOS. just run it once
	#

	if [[ $counter -eq 0 ]]; then
		testIter=$test7Iter
	
		sleep 10
		$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkArrayReadWriteElement $testIter 0 $useXPlink
	
		sleep 10
		$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkArrayReadWriteElement $testIter 1 $useXPlink
		
		testIter=$defaultIter
	else
		echo "Skipping test 7"
	fi
	
	
	#
	# test 8
	#  arrayReadWriteRegion()
	# run 200 Million times

	testIter=$test8Iter
	
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkArrayReadWriteRegion $testIter 0 $useXPlink
	
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkArrayReadWriteRegion $testIter 1 $useXPlink
		
	testIter=$defaultIter

	
	
	#
	#	test loop counter
	#
	counter=$[$counter+1]
done







counter=0
useXPlink=1


unset enable_ronu_bin_insert=1
unset ronu_bin_path="$IBM_SDK_DIR/ronu.bin"


while [ $counter -lt $MAX_NUM_RUNS ]; do
	echo iteration $counter in $MAX_NUM_RUNS
	
	#
	# test 1
	#
	
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkNoParamNoRet $testIter 0 $useXPlink
	
	
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkNoParamNoRet $testIter 1 $useXPlink
	
	#
	# test 2
	#
	
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkNoRet $testIter 0 $useXPlink
	
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkNoRet $testIter 1 $useXPlink
	
	#
	# test 3
	#

	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkRet $testIter 0 $useXPlink

	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkRet $testIter 1 $useXPlink
		
	#
	# test 4
	# getFieldID()

	#sleep 10
	#$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkGetFieldID $testIter 0 $useXPlink

	#sleep 10
	#$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkGetFieldID $testIter 1 $useXPlink
	echo "Skipping test 4"
	
	#
	# test 5
	#	setLongFiled()

	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkSetLongField $testIter 0 $useXPlink

	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkSetLongField $testIter 1 $useXPlink


	#
	# test 6
	# setStaticLongField()
    if [[ $counter -eq 0 ]]; then
	
		sleep 10
		$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkSetLongFieldStatic $testIter 0 $useXPlink
    
		sleep 10
		$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkSetLongFieldStatic $testIter 1 $useXPlink
	else
		echo "Skipping test 6"
	fi
	
	#
	# test 7
	# arrayReadWriteElements()
	#
	# This takes too much time on zOS. just run it once
	#

	if [[ $counter -eq 0 ]]; then
		testIter=$test7Iter
	
		sleep 10
		$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkArrayReadWriteElement $testIter 0 $useXPlink
	
		sleep 10
		$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkArrayReadWriteElement $testIter 1 $useXPlink
		
		testIter=$defaultIter
	else
		echo "Skipping test 7"
	fi
	
	
	#
	# test 8
	#  arrayReadWriteRegion()
	# run 200 Million times

	testIter=$test8Iter
	
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkArrayReadWriteRegion $testIter 0 $useXPlink
	
	sleep 10
	$JAVA  $JIT_OPT $JVM_OPT com.jni.consbench.simpleCall.BenchmarkArrayReadWriteRegion $testIter 1 $useXPlink
		
	testIter=$defaultIter

	
	
	#
	#	test loop counter
	#
	counter=$[$counter+1]
done