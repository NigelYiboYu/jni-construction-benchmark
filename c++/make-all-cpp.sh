rm -f ./*.o
rm -f ./*.so

export BENCH_HOME="/jit/team/yunigel/jni-bench"
export OPENJDK_HOME="/jit/team/yunigel/openJDK9/jdk-9+181"


CXXFLAGS="-shared -fPIC -std=c++11 -O1"
INC_PATH="-I$BENCH_HOME/src -I$OPENJDK_HOME/include/ -I$OPENJDK_HOME/include/linux "


# use g++. gcc requires -lstdc++
g++ $CXXFLAGS -o libjnibench.so $INC_PATH \
	./nativeobj/Foo.cpp ./nativeobj/FooByCall.cpp \
	./nativeobj/FooByCallStatic.cpp ./nativeobj/FooByCallInvoke.cpp \
	./javaobj/FooByCallJavaObject.cpp ./javaobj/FooByCallStaticJavaObject.cpp ./javaobj/FooByCallInvokeJavaObject.cpp \
	./simplecall/SimpleCall.cpp  
