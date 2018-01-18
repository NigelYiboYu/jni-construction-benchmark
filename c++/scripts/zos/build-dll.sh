rm -f ./*.o
rm -f ./*.so

export INC_PATH=" -I/jit/team/yunigel/jni-bench/c++/jniInclude/  -I/jit/team/yunigel/sdk/include/zos -I/jit/team/yunigel/sdk/include/ "


PWD=`pwd`
CPP_DIR="$PWD/../.."

cd $CPP_DIR

rm -f ./*.so
rm -f ./*.o

CPP_FILES=`find . | grep '\.cpp' | tr '\n' ' '`

# make a Std non-xplink JNI benchmark DLL
#
#
#		NOTE: xlc can't handle files with the same name. Hence, the **JavaObject.cpp file names.
#	
echo  "Making std non-xplink JNI benchmark DLL"
export CXXFLAGS="-Dnullptr=NULL -Wc,convlit(ISO8859-1) -Wc,NOANSIALIAS -q32 -Wc,noxplink -O -qlanglvl=extended0x -Wc,DLL,EXPORTALL -Wa,DLL "
xlC $CXXFLAGS -o libstdlinkjnibench.so $INC_PATH $CPP_FILES


echo  "Making 64-bit xplink JNI benchmark DLL"
rm -f ./*.o
export CXXFLAGS=" -Dnullptr=NULL -Wc,convlit(ISO8859-1) -Wc,NOANSIALIAS -Wc,xplink -Wc,lp64 -O -qlanglvl=extended0x -Wc,DLL,EXPORTALL -Wa,DLL "
xlC $CXXFLAGS -o libxplinkjnibench.so $INC_PATH $CPP_FILES



cd $PWD