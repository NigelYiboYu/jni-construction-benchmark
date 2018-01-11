
export IBM_JAVA_HOME="/jit/team/yunigel/sdk"
export OPENJDK_JAVA_HOME="/jit/team/yunigel/openJDK9/jdk-9+181"


# use lower version of java to compile
export JAVA="$IBM_JAVA_HOME/bin/java"
export JAVAC="$IBM_JAVA_HOME/bin/javac"
export JAVAH="$IBM_JAVA_HOME/bin/javah"



#export JAVA="$OPENJDK_JAVA_HOME/bin/java"
#export JAVAC="$OPENJDK_JAVA_HOME/bin/javac"
#export JAVAH="$OPENJDK_JAVA_HOME/bin/javah"

pwd=`pwd`
echo "javac all java files"
rm -f com/jni/consbench/*.class
$JAVAC com/jni/consbench/*.java
rm -f ./*.so


echo "Creating JNI header files with javah"
rm -f ./*.h

$JAVAH com.jni.consbench.FooByCall
$JAVAH com.jni.consbench.FooByCallStatic
$JAVAH com.jni.consbench.FooByCallInvoke



echo "Compiling C++ code into shared lib"
cd ../c++
./make-all-cpp.sh

cd $pwd
cp ../c++/*.so .
