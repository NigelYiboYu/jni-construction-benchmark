export IBM_JAVA_HOME="/home/yunigel/sdk"

# use lower version of java to compile
export JAVA="$IBM_JAVA_HOME/bin/java"
export JAVAC="$IBM_JAVA_HOME/bin/javac"
export JAVAH="$IBM_JAVA_HOME/bin/javah"


# scriptDir is ./c++/scripts
scriptDir=`pwd`
rootDir="$scriptDir/../../.."
CPP_DIR="$rootDir/c++"
jniIncludeDir="$CPP_DIR/jniInclude"

JVM_OPTS=" "
#############################################################
#
#			JAVAC all Java files
#############################################################
echo "JAVAC all Java files"

cd "$rootDir/src"
JAVA_FILES=`find . | grep '\.java' | tr '\n' ' '`
CLASS_FILES=`find . | grep '\.class' | tr '\n' ' '`

rm -f $CLASS_FILES

$JAVAC $JVM_OPTS $JAVA_FILES


#############################################################
#
#			Creating JNI header files with javah
#############################################################
echo "Creating JNI header files with javah"
rm -f ./*.h
mkdir -p $jniIncludeDir
rm -f "$jniIncludeDir/*.h"

$JAVAH  $JVM_OPTS com.jni.consbench.javaobj.FooByCall
$JAVAH  $JVM_OPTS com.jni.consbench.javaobj.FooByCallStatic
$JAVAH  $JVM_OPTS com.jni.consbench.javaobj.FooByCallInvoke

$JAVAH  $JVM_OPTS com.jni.consbench.nativeobj.FooByCall
$JAVAH  $JVM_OPTS com.jni.consbench.nativeobj.FooByCallStatic
$JAVAH  $JVM_OPTS com.jni.consbench.nativeobj.FooByCallInvoke

$JAVAH  $JVM_OPTS com.jni.consbench.simpleCall.SimpleCalls

mv ./*.h $jniIncludeDir

#############################################################
#
#			Compiling C++ code into shared lib
#############################################################
cd $scriptDir
echo "Compiling C++ code into shared lib"
./build-dll.sh
cp $CPP_DIR/*.so $scriptDir/
#############################################################
#					Patch the SDK
#
#############################################################

cd $scriptDir
if [ -d "$IBM_JAVA_HOME/jre/lib/amd64/compressedrefs" ]; then
	echo "Patching $IBM_JAVA_HOME/jre/lib/amd64/compressedrefs"
	cp -v ./*.so $IBM_JAVA_HOME/jre/lib/amd64/compressedrefs/
fi


if [ -d "$IBM_JAVA_HOME/lib/amd64/compressedrefs" ]; then
	echo "Patching $IBM_JAVA_HOME/lib/amd64/compressedrefs"
	cp -v ./*.so $IBM_JAVA_HOME/lib/amd64/compressedrefs/
fi
