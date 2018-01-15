#include <assert.h>
#include "./nativeobj/Foo.h"

namespace jnibench {

// Native class template
template<class PTR, class DERIVED>
class JniPortal {
public:
	// Get the java class id
	static jclass getJClass(JNIEnv* env, const char* jclazz_name) {
		jclass jclazz = env->FindClass(jclazz_name);
		assert(jclazz != nullptr);
		return jclazz;
	}

	// Get the field id of the member variable to store
	// the ptr
	static jfieldID getHandleFieldID(JNIEnv* env, const char* fieldName,
			const char* fieldType) {

		static jfieldID fid = env->GetFieldID(DERIVED::getJClass(env),
				fieldName, fieldType);
		assert(fid != nullptr);
		return fid;
	}

	// Get the pointer from Java
	static PTR getHandle(JNIEnv* env, jobject jobj) {
		return reinterpret_cast<PTR>(env->GetLongField(jobj,
				getHandleFieldID(env)));
	}

	// Pass the pointer to the java object field as a long
	static void setLongHandle(JNIEnv* env, jobject jdb, PTR ptr,
			const char* fieldName) {
		env->SetLongField(jdb, getHandleFieldID(env, fieldName, "J"),
				reinterpret_cast<jlong>(ptr));
	}

	// Pass the pointer to the java object field as a long
	static void setStaticLongHandle(JNIEnv* env, jclass jcls, PTR ptr,
			const char* fieldName) {
		jfieldID fid = env->GetStaticFieldID(jcls, fieldName, "J");
		env->SetStaticLongField(jcls, fid, reinterpret_cast<jlong>(ptr));
	}
};

/**
 *   The portal class for com.jni.consbench.nativeobj.FooByCallInvoke
 *
 * */
class FooByCallInvokeJni: public JniPortal<jnibench::Foo*, FooByCallInvokeJni> {
public:
	static jclass getJClass(JNIEnv* env) {
		return JniPortal<jnibench::Foo*, FooByCallInvokeJni>::getJClass(env,
				"com/jni/consbench/nativeobj/FooByCallInvoke");
	}
};

/**
 *  The portal class for com.jni.consbench.javaobj.FooByCallInvoke
 *
 *
 *  Note: the jnibench::Foo* in the template is not needed...
 *
 * */
class FooByCallInvokeJniJavaObj: public JniPortal<void*,
		FooByCallInvokeJniJavaObj> {
public:
	static jclass getJClass(JNIEnv* env) {
		return JniPortal<void*, FooByCallInvokeJniJavaObj>::getJClass(env,
				"com/jni/consbench/javaobj/FooByCallInvoke");
	}
};

/**
 *  The portal class for com.jni.consbench.javaobj.FooByCallInvoke
 *
 *
 *  Note: the jnibench::Foo* in the template is not needed...
 *
 * */
class SimpleCallPortal: public JniPortal<void*, SimpleCallPortal> {
public:
	static jclass getJClass(JNIEnv* env) {
		return JniPortal<void*, SimpleCallPortal>::getJClass(env,
				"com/jni/consbench/simpleCall/SimpleCalls");
	}
};

} //end namespace
