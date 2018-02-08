#############################################################
#
#			Configurations
#############################################################

export HOME_DIR="/home/yunigel"

export IBM_JAVA_HOME="$HOME_DIR/sdk"
export OPEN_JDK_HOME=""


# SDK_DIR used to compile java and generate JNI headers
# use lower version of java to compile
export SDK_DIR=$IBM_JAVA_HOME
export JAVA="$SDK_DIR/bin/java"
export JAVAC="$SDK_DIR/bin/javac"
export JAVAH="$SDK_DIR/bin/javah"


# scriptDir is ./c++/scripts
scriptDir=`pwd`
rootDir="$scriptDir/../../.."
CPP_DIR="$rootDir/c++"
jniIncludeDir="$CPP_DIR/jniInclude"

JVM_OPTS="-J-Xifa:off"
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

echo "Compiling C++ code into shared lib"
cd $scriptDir
./build-dll.sh
cp $CPP_DIR/*.so ./
#############################################################
#					Patch the IBM SDK
#
#############################################################

if [ -d "$IBM_JAVA_HOME/jre/lib/s390x/compressedrefs" ]; then
	echo "Patching $IBM_JAVA_HOME/jre/lib/s390x/compressedrefs"
	cp -v ./*.so $IBM_JAVA_HOME/jre/lib/s390x/compressedrefs/
fi


if [ -d "$IBM_JAVA_HOME/lib/s390x/compressedrefs" ]; then
	echo "Patching $IBM_JAVA_HOME/lib/s390x/compressedrefs"
	cp -v ./*.so $IBM_JAVA_HOME/lib/s390x/compressedrefs/
fi
