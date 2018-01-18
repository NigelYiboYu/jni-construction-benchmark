#include <jni.h>
#include "com_jni_consbench_javaobj_FooByCallStatic.h"

jlong Java_com_jni_consbench_javaobj_FooByCallStatic_newFoo(JNIEnv* env,
		jclass jcls) {

	// create a java obj via JNI and retrun the _javaObjHandle in Java
	jclass newCls = env->FindClass("com/jni/consbench/javaobj/FooJavaObject");
	jmethodID initMethod = env->GetMethodID(newCls, "<init>", "()V");
	jobject newObj = env->NewObject(newCls, initMethod);

	return reinterpret_cast<jlong>(newObj);
}
