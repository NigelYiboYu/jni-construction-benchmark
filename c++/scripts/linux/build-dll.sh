rm -f ./*.o
rm -f ./*.so


uname -a | grep x86

isX86=$?

if [ "$isX86" -eq "0" ];
then
	echo "Using paths for x86"
	export BENCH_HOME="/home/yunigel/jni-bench"
	export OPENJDK_HOME="/home/yunigel/openJDK9/jdk-9+181"
else
	echo "Using paths for zLinux"
	export BENCH_HOME="/jit/team/yunigel/jni-bench"
	export OPENJDK_HOME="/jit/team/yunigel/openJDK9/jdk-9+181"
fi

PWD=`pwd`
CPP_DIR="$PWD/../.."
cd $CPP_DIR

rm -f ./*.o
rm -f ./*.so

CPP_FILES=`find . | grep '\.cpp' | tr '\n' ' '`

CXXFLAGS="-shared -fPIC -std=c++11 -O1"
INC_PATH="-I$BENCH_HOME/c++/jniInclude/ -I$OPENJDK_HOME/include/ -I$OPENJDK_HOME/include/linux "


# use g++. gcc requires -lstdc++
g++ $CXXFLAGS -o libstdlinkjnibench.so $INC_PATH $CPP_FILES

cd $PWD