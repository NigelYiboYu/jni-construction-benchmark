#include <jni.h>
#include "com_jni_consbench_javabacked_FooByCallStatic.h"

/*
 * Class:     Java_com_jni_consbench_javabacked_FooByCallStatic_newFoo
 * Method:    newFoo
 * Signature: ()J
 */
jlong Java_com_jni_consbench_javabacked_FooByCallStatic_newFoo(JNIEnv* env,
		jclass jcls) {

	// create a java obj via JNI and retrun the _javaObjHandle in Java
	jclass newCls = env->FindClass("com/jni/consbench/javabacked/FooJavaObject");
	jmethodID initMethod = env->GetMethodID(newCls, "<init>", "()V");
	jobject newObj = env->NewObject(newCls, initMethod);

	return reinterpret_cast<jlong>(newObj);
}
