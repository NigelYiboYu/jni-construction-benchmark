
#include <jni.h>
#include "com_jni_consbench_nativeobj_FooByCallStatic.h"
#include "Foo.h"

/*
 * Class:     Java_com_jni_consbench_nativeobj_FooByCallStatic_newFoo
 * Method:    newFoo
 * Signature: ()J
 */
jlong Java_com_jni_consbench_nativeobj_FooByCallStatic_newFoo(JNIEnv* env, jclass jcls) {
	jnibench::Foo* foo = new jnibench::Foo();
  return reinterpret_cast<jlong>(foo);
}

/*
 * Class:     Java_com_jni_consbench_nativeobj_FooByCallStatic_disposeInternal
 * Method:    disposeInternal
 * Signature: (J)V
 */
void Java_com_jni_consbench_nativeobj_FooByCallStatic_disposeInternal(JNIEnv* env, jobject jobj, jlong handle) {
    delete reinterpret_cast<jnibench::Foo*>(handle);
}
