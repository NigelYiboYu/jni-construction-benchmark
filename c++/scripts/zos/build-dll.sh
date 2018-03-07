rm -f ./*.o
rm -f ./*.so

export INC_PATH=" -I$HOME_DIR/jni-bench/c++/jniInclude/  -I$SDK_DIR/include/zos -I$SDK_DIR/include/ "


PWD=`pwd`
CPP_DIR="$PWD/../.."

cd $CPP_DIR

rm -f ./*.so
rm -f ./*.o
rm -f ./*.asmlist

CPP_FILES=`find . | grep '\.cpp' | tr '\n' ' '`

# make a Std non-xplink JNI benchmark DLL
#
#
#		NOTE: xlc can't handle files with the same name. Hence, the **JavaObject.cpp file names.
#	
echo  "Making 32-bit standard non-xplink JNI benchmark DLL"
export CXXFLAGS="-qlist=no-xplink.asmlist -Dnullptr=NULL -Wc,convlit(ISO8859-1) -Wc,NOANSIALIAS -q32 -Wc,noxplink -O -qlanglvl=extended0x -Wc,DLL,EXPORTALL -Wa,DLL -Wc,ARCH(7) -Wc,TUNE(10) "
xlC $CXXFLAGS -o libstdlinkjnibench.so $INC_PATH $CPP_FILES


echo  "Making 32-bit xplink JNI benchmark DLL"
export CXXFLAGS="-qlist=xplink32.asmlist -Dnullptr=NULL -Wc,convlit(ISO8859-1) -Wc,NOANSIALIAS -q32 -Wc,xplink -O -qlanglvl=extended0x -Wc,DLL,EXPORTALL -Wa,DLL -Wc,ARCH(7) -Wc,TUNE(10) "
xlC $CXXFLAGS -o libxplinkjnibench31.so $INC_PATH $CPP_FILES


echo  "Making 64-bit xplink JNI benchmark DLL"
rm -f ./*.o
export CXXFLAGS=" -qlist=xplink64.asmlist -Dnullptr=NULL -Wc,convlit(ISO8859-1) -Wc,NOANSIALIAS -Wc,xplink -Wc,lp64 -O -qlanglvl=extended0x -Wc,DLL,EXPORTALL -Wa,DLL -Wc,ARCH(7) -Wc,TUNE(10) "
xlC $CXXFLAGS -o libxplinkjnibench64.so $INC_PATH $CPP_FILES



cd $PWD