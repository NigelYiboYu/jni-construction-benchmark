rm -f ./*.o
rm -f ./*.so

export INC_PATH=" -I/jit/team/yunigel/jni-bench/src  -I/jit/team/yunigel/sdk/include/zos -I/jit/team/yunigel/sdk/include/ "


export CXXFLAGS=" -Wc,convlit(ISO8859-1) -Wc,NOANSIALIAS -Wc,xplink -O3 -qlanglvl=extended0x -Wc,lp64 -Wc,DLL,EXPORTALL -Wa,DLL "


xlC $CXXFLAGS -o libjnibench.so $INC_PATH \
	./nativebacked/Foo.cpp ./nativebacked/FooByCall.cpp \
	./nativebacked/FooByCallStatic.cpp ./nativebacked/FooByCallInvoke.cpp \
	./javabacked/FooByCall.cpp ./javabacked/FooByCallStatic.cpp ./javabacked/FooByCallInvoke.cpp  