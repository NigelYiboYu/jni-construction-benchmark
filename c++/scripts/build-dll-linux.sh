rm -f ./*.o
rm -f ./*.so

export BENCH_HOME="/jit/team/yunigel/jni-bench"
export OPENJDK_HOME="/jit/team/yunigel/openJDK9/jdk-9+181"

CPP_FILES=`find .. | grep '\.cpp' | tr '\n' ' '`

CXXFLAGS="-shared -fPIC -std=c++11 -O1"
INC_PATH="-I$BENCH_HOME/c++/jniInclude/ -I$OPENJDK_HOME/include/ -I$OPENJDK_HOME/include/linux "


# use g++. gcc requires -lstdc++
g++ $CXXFLAGS -o libjnibench.so $INC_PATH $CPP_FILES
