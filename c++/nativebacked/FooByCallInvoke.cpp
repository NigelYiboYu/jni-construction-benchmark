
#include <jni.h>
#include "com_jni_consbench_nativebacked_FooByCallInvoke.h"
#include "Foo.h"
#include "../Portal.h"

/*
 * Class:     Java_com_jni_consbench_nativebacked_FooByCallInvoke_newFoo
 * Method:    newFoo
 * Signature: ()J
 */
void Java_com_jni_consbench_nativebacked_FooByCallInvoke_newFoo(JNIEnv* env, jobject jobj) {
  consbench::Foo* foo = new consbench::Foo();

  //set the _nativeHandle in Java
  consbench::FooByCallInvokeJni::setHandle(env, jobj, foo);
}

/*
 * Class:     Java_com_jni_consbench_nativebacked_FooByCallInvoke_disposeInternal
 * Method:    disposeInternal
 * Signature: (J)V
 */
void Java_com_jni_consbench_nativebacked_FooByCallInvoke_disposeInternal(JNIEnv* env, jobject jobj, jlong handle) {
    delete reinterpret_cast<consbench::Foo*>(handle);
}
