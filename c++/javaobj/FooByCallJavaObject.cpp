#include <jni.h>
#include "com_jni_consbench_javaobj_FooByCall.h"

jlong Java_com_jni_consbench_javaobj_FooByCall_newFoo(JNIEnv* env,
		jobject jobj) {

	// create a java obj via JNI and retrun the _javaObjHandle in Java
	jclass newCls = env->FindClass("com/jni/consbench/javaobj/FooJavaObject");
	jmethodID initMethod = env->GetMethodID(newCls, "<init>", "()V");
	jobject newObj = env->NewObject(newCls, initMethod);

	return reinterpret_cast<jlong>(newObj);
}
