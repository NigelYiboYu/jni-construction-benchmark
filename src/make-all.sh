
export IBM_JAVA_HOME="/jit/team/yunigel/sdk"
export OPENJDK_JAVA_HOME="/jit/team/yunigel/openJDK9/jdk-9+181"

# use lower version of java to compile
export JAVA="$IBM_JAVA_HOME/bin/java"
export JAVAC="$IBM_JAVA_HOME/bin/javac"
export JAVAH="$IBM_JAVA_HOME/bin/javah"





# use lower version of java to compile
export JAVA="$IBM_JAVA_HOME/bin/java"
export JAVAC="$IBM_JAVA_HOME/bin/javac"
export JAVAH="$IBM_JAVA_HOME/bin/javah"


pwd=`pwd`

#############################################################
#
#			Creating JNI header files with javah
#############################################################
echo "javac all java files"
rm -f com/jni/consbench/javaobj/*.class
rm -f com/jni/consbench/javaobj/bench/*.class

rm -f com/jni/consbench/nativeobj/*.class
rm -f com/jni/consbench/nativeobj/bench/*.class

rm -f com/jni/consbench/simpleCall/*.class


$JAVAC com/jni/consbench/javaobj/*.java
$JAVAC com/jni/consbench/javaobj/bench/*.java

$JAVAC com/jni/consbench/nativeobj/*.java
$JAVAC com/jni/consbench/nativeobj/bench/*.java

$JAVAC com/jni/consbench/simpleCall/*.java


rm -f ./*.so

#############################################################
#
#			Creating JNI header files with javah
#############################################################
echo "Creating JNI header files with javah"
rm -f ./*.h

$JAVAH com.jni.consbench.javaobj.FooByCall
$JAVAH com.jni.consbench.javaobj.FooByCallStatic
$JAVAH com.jni.consbench.javaobj.FooByCallInvoke

$JAVAH com.jni.consbench.nativeobj.FooByCall
$JAVAH com.jni.consbench.nativeobj.FooByCallStatic
$JAVAH com.jni.consbench.nativeobj.FooByCallInvoke

$JAVAH com.jni.consbench.simpleCall.SimpleCalls

#############################################################
#
#			Compiling C++ code into shared lib
#############################################################

echo "Compiling C++ code into shared lib"
cd ../c++
./make-all-cpp.sh

cd $pwd
cp ../c++/*.so .


#############################################################
#					Patch the SDK
#
#############################################################

if [ -d "$IBM_JAVA_HOME/jre/lib/s390x/compressedrefs" ]; then
	cp -v ./*.so $IBM_JAVA_HOME/jre/lib/s390x/compressedrefs/
fi


if [ -d "$IBM_JAVA_HOME/lib/s390x/compressedrefs" ]; then
	cp -v ./*.so $IBM_JAVA_HOME/lib/s390x/compressedrefs/
fi
