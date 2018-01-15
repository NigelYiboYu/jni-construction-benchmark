#include <jni.h>
#include "com_jni_consbench_nativeobj_FooByCallInvoke.h"
#include "Foo.h"
#include "../Portal.h"

/*
 * Class:     Java_com_jni_consbench_nativeobj_FooByCallInvoke_newFoo
 * Method:    newFoo
 * Signature: ()J
 */
void Java_com_jni_consbench_nativeobj_FooByCallInvoke_newFoo(JNIEnv* env,
		jobject jobj) {
	jnibench::Foo* foo = new jnibench::Foo();

	//set the _nativeHandle in Java
	jnibench::FooByCallInvokeJni::setLongHandle(env, jobj, foo,
			"_nativeHandle");
}

/*
 * Class:     Java_com_jni_consbench_nativeobj_FooByCallInvoke_disposeInternal
 * Method:    disposeInternal
 * Signature: (J)V
 */
void Java_com_jni_consbench_nativeobj_FooByCallInvoke_disposeInternal(
		JNIEnv* env, jobject jobj, jlong handle) {
	delete reinterpret_cast<jnibench::Foo*>(handle);
}
