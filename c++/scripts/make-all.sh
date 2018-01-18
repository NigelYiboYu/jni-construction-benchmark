export IBM_JAVA_HOME="/home/yunigel/sdk"

# use lower version of java to compile
export JAVA="$IBM_JAVA_HOME/bin/java"
export JAVAC="$IBM_JAVA_HOME/bin/javac"
export JAVAH="$IBM_JAVA_HOME/bin/javah"


# scriptDir is ./c++/scripts
scriptDir=`pwd`
rootDir="$scriptDir/../.."
jniIncludeDir="$rootDir/c++/jniInclude"

#############################################################
#
#			JAVAC all Java files
#############################################################
echo "javac all java files"

cd ../../src


JAVA_FILES=`find . | grep '\.java' | tr '\n' ' '`
CLASS_FILES=`find . | grep '\.class' | tr '\n' ' '`

rm -f $CLASS_FILES

$JAVAC $JAVA_FILES


#############################################################
#
#			Creating JNI header files with javah
#############################################################
echo "Creating JNI header files with javah"
rm -f ./*.h
mkdir -p $jniIncludeDir
rm -f "$jniIncludeDir/*.h"

$JAVAH com.jni.consbench.javaobj.FooByCall
$JAVAH com.jni.consbench.javaobj.FooByCallStatic
$JAVAH com.jni.consbench.javaobj.FooByCallInvoke

$JAVAH com.jni.consbench.nativeobj.FooByCall
$JAVAH com.jni.consbench.nativeobj.FooByCallStatic
$JAVAH com.jni.consbench.nativeobj.FooByCallInvoke

$JAVAH com.jni.consbench.simpleCall.SimpleCalls

mv ./*.h $jniIncludeDir

#############################################################
#
#			Compiling C++ code into shared lib
#############################################################

echo "Compiling C++ code into shared lib"
cd $scriptDir
./build-dll.sh


#############################################################
#					Patch the SDK
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
