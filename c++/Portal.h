
#include <assert.h>
#include "./nativebacked/Foo.h"

namespace consbench {

// Native class template
template<class PTR, class DERIVED>
class FooJniClass {
public:
	// Get the java class id
	static jclass getJClass(JNIEnv* env, const char* jclazz_name) {
		jclass jclazz = env->FindClass(jclazz_name);
		assert(jclazz != nullptr);
		return jclazz;
	}

	// Get the field id of the member variable to store
	// the ptr
	static jfieldID getHandleFieldID(JNIEnv* env) {

		static jfieldID fid = env->GetFieldID(DERIVED::getJClass(env),
				"_nativeHandle", "J");
		assert(fid != nullptr);
		return fid;
	}

	static jfieldID getJavaHandleFieldID(JNIEnv* env) {

		static jfieldID fid = env->GetFieldID(DERIVED::getJClass(env),
				"_javaObjHandle", "J");
		assert(fid != nullptr);
		return fid;
	}

	// Get the pointer from Java
	static PTR getHandle(JNIEnv* env, jobject jobj) {
		return reinterpret_cast<PTR>(env->GetLongField(jobj,
				getHandleFieldID(env)));
	}

	// Pass the pointer to the java side.
	static void setHandle(JNIEnv* env, jobject jdb, PTR ptr) {
		env->SetLongField(jdb, getHandleFieldID(env),
				reinterpret_cast<jlong>(ptr));
	}
};

/**
 *
 *
 *   The portal class for com.jni.consbench.nativebacked.FooByCallInvoke
 *
 * */
class FooByCallInvokeJni: public FooJniClass<consbench::Foo*, FooByCallInvokeJni> {
public:
	static jclass getJClass(JNIEnv* env) {
		return FooJniClass<consbench::Foo*, FooByCallInvokeJni>::getJClass(env,
				"com/jni/consbench/nativebacked/FooByCallInvoke");
	}
};


/**
 *
 *
 *  The portal class for com.jni.consbench.javabacked.FooByCallInvoke
 *
 *
 *  Note: the consbench::Foo* in the template is not needed...
 *
 * */
class FooByCallInvokeJniJavaBacked: public FooJniClass<void*,
		FooByCallInvokeJniJavaBacked> {
public:
	static jclass getJClass(JNIEnv* env) {
		return FooJniClass<void*, FooByCallInvokeJniJavaBacked>::getJClass(
				env, "com/jni/consbench/javabacked/FooByCallInvoke");
	}
};

} //end namespace
