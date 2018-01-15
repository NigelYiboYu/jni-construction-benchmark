#include <jni.h>
#include "com_jni_consbench_javabacked_FooByCallInvoke.h"
#include "../Portal.h"

/*
 * Class:     Java_com_jni_consbench_javabacked_FooByCallInvoke_newFoo
 * Method:    newFoo
 * Signature: ()J
 */
void Java_com_jni_consbench_javabacked_FooByCallInvoke_newFoo(JNIEnv* env,
		jobject jobj) {

	// create a java obj via JNI and retrun the _javaObjHandle in Java
	jclass newCls = env->FindClass("com/jni/consbench/javabacked/FooJavaObject");
	jmethodID initMethod = env->GetMethodID(newCls, "<init>", "()V");
	jobject newObj = env->NewObject(newCls, initMethod);

	consbench::FooByCallInvokeJniJavaBacked::setHandle(env, jobj,
			reinterpret_cast<void*>(newObj));
	return;
}
