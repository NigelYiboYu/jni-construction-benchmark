rm -f ./*.o
rm -f ./*.so

export BENCH_HOME="/jit/team/yunigel/jni-bench"
export OPENJDK_HOME="/jit/team/yunigel/openJDK9/jdk-9+181"


CXXFLAGS="-shared -fPIC -std=c++11 -O1"
INC_PATH="-I$BENCH_HOME/src -I$OPENJDK_HOME/include/ -I$OPENJDK_HOME/include/linux "


# use g++. gcc requires -lstdc++
g++ $CXXFLAGS -o libjnibench.so $INC_PATH Foo.cpp FooByCall.cpp FooByCallStatic.cpp FooByCallInvoke.cpp
