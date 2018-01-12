export LD_LIBRARY_PATH=`pwd`
turnOnCPs.sh 4

TOOLS_DIR=/jit/instrumentation/jprof64
#export PATH=$TOOLS_DIR:$PATH
#export LIBPATH=$TOOLS_DIR:$LIBPATH
#export STEPLIB=$TOOLS_DIR:$STEPLIB

cleanall


testIter=300000000
doWarmup=0

if [[ $1 -ne 0 ]]; then
        doWarmup=1
fi

rm -f vlog*

IBM_SDK="/jit/team/yunigel/sdk"
IBM_JAVA="$IBM_SDK/bin/java"

#
#	patch SDK
#

cp $TOOLS_DIR/../jprof/libjprof64.so $IBM_SDK/jre/lib/s390x/compressedrefs/libjprof.so


AGENT_OPT='-agentlib:jprof=tprof,pidx,asid,LOGPATH=/jit/instrumentation/handson/results,LOGPREFIX=jprof'

JIT_OPT=' -Xjit:verbose,vlog=vlog'
JIT_OPT=''

echo "***********************************************************"
echo "*         Testing this java"
echo "***********************************************************"

$IBM_JAVA -version

echo "***********************************************************"

counter=0
maxIter=5
JAVA=$IBM_JAVA


sleep 10
$JAVA  $JIT_OPT -Xdump:tool:events=vmstop,exec='sleep 10000' $AGENT_OPT  -cp . com.jni.consbench.BenchmarkFooByCall $testIter 0
