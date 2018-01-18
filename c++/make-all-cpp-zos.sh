rm -f ./*.o
rm -f ./*.so

export INC_PATH=" -I/jit/team/yunigel/jni-bench/src  -I/jit/team/yunigel/sdk/include/zos -I/jit/team/yunigel/sdk/include/ "


# make a Std non-xplink DLL
#
#
#		NOTE: xlc can't handle files with the same name. Hence, the **JavaObject.cpp file names.
#	
echo  "Making std non-xplink DLL"
export CXXFLAGS=" -Dnullptr=NULL -Wc,convlit(ISO8859-1) -Wc,NOANSIALIAS -Wc,noxplink -O -qlanglvl=extended0x -Wc,DLL,EXPORTALL -Wa,DLL "

xlC $CXXFLAGS -o libstdlinkjnibench.so $INC_PATH \
	./nativeobj/Foo.cpp ./nativeobj/FooByCall.cpp \
	./nativeobj/FooByCallStatic.cpp ./nativeobj/FooByCallInvoke.cpp \
	./javaobj/FooByCallJavaObject.cpp ./javaobj/FooByCallStaticJavaObject.cpp ./javaobj/FooByCallInvokeJavaObject.cpp \
	./simplecall/SimpleCall.cpp  
	
	
	
	
echo  "Making 64-bit xplink DLL"
rm -f ./*.o
export CXXFLAGS=" -Dnullptr=NULL -Wc,convlit(ISO8859-1) -Wc,NOANSIALIAS -Wc,xplink -O -qlanglvl=extended0x -Wc,lp64 -Wc,DLL,EXPORTALL -Wa,DLL "
xlC $CXXFLAGS -o libxplinkjnibench.so $INC_PATH \
	./nativeobj/Foo.cpp ./nativeobj/FooByCall.cpp \
	./nativeobj/FooByCallStatic.cpp ./nativeobj/FooByCallInvoke.cpp \
	./javaobj/FooByCallJavaObject.cpp ./javaobj/FooByCallStaticJavaObject.cpp ./javaobj/FooByCallInvokeJavaObject.cpp \
	./simplecall/SimpleCall.cpp  

	
	
	
