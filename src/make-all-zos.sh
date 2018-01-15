export IBM_JAVA_HOME="/jit/team/yunigel/sdk"

# use lower version of java to compile
export JAVA="$IBM_JAVA_HOME/bin/java"
export JAVAC="$IBM_JAVA_HOME/bin/javac"
export JAVAH="$IBM_JAVA_HOME/bin/javah"


pwd=`pwd`

echo "javac all java files"
rm -f com/jni/consbench/javabacked/*.class
rm -f com/jni/consbench/nativebacked/*.class
rm -f com/jni/consbench/nativebacked/bench/*.class
rm -f com/jni/consbench/nativebacked/bench/*.class



$JAVAC com/jni/consbench/javabacked/*.java
$JAVAC com/jni/consbench/nativebacked/*.java
$JAVAC com/jni/consbench/nativebacked/bench/*.java
$JAVAC com/jni/consbench/nativebacked/bench/*.java


rm -f ./*.so


echo "Creating JNI header files with javah"
rm -f ./*.h

$JAVAH com.jni.consbench.javabacked.FooByCall
$JAVAH com.jni.consbench.javabacked.FooByCallStatic
$JAVAH com.jni.consbench.javabacked.FooByCallInvoke

$JAVAH com.jni.consbench.nativebacked.FooByCall
$JAVAH com.jni.consbench.nativebacked.FooByCallStatic
$JAVAH com.jni.consbench.nativebacked.FooByCallInvoke



echo "Compiling C++ code into shared lib"
cd ../c++
./make-all-cpp-zos.sh

cd $pwd
cp ../c++/*.so .