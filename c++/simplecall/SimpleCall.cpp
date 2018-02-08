//#define _AE_BIMODAL

#include <jni.h>
#include <assert.h>

#include "com_jni_consbench_simpleCall_SimpleCalls.h"
#include "../Portal.h"

// test 1
void Java_com_jni_consbench_simpleCall_SimpleCalls_testNoParamNoRet(
		JNIEnv * env, jobject jobj) {
	return;
}

// test 2
void Java_com_jni_consbench_simpleCall_SimpleCalls_testNoRet(JNIEnv* env,
		jobject jobj, jlong val) {
	val += 22;


	if ((val % 3000000) == 1)
	{
#pragma convert("IBM-1047")
		printf("hello ");
#pragma convert(pop)
	}

	return;
}

// test 3
jlong Java_com_jni_consbench_simpleCall_SimpleCalls_testRet(JNIEnv* env,
		jobject jobj, jlong val) {
	val += 2;
	return val;
}

// test 4
// get field id and DO NOTHING
void Java_com_jni_consbench_simpleCall_SimpleCalls_testGetFieldID(JNIEnv* env,
		jobject jobj) {

	jfieldID fid = jnibench::SimpleCallPortal::getHandleFieldID(env,
			"longField", "J");

	return;
}

// test 5
//  this is a non-static function that sets a non-static longField to the input value
void Java_com_jni_consbench_simpleCall_SimpleCalls_testSetLongField(JNIEnv* env,
		jobject jobj, jlong val) {

	jnibench::SimpleCallPortal::setLongHandle(env, jobj,
			reinterpret_cast<void*>(val), "longField");
	return;
}

// test 6
//  this is a static call that sets a static long field to the input value
void Java_com_jni_consbench_simpleCall_SimpleCalls_testSetLongFieldStatic(
		JNIEnv* env, jclass jcls, jlong val) {

	jnibench::SimpleCallPortal::setStaticLongHandle(env, jcls,
			reinterpret_cast<void*>(val), "longFieldStatic");
	return;
}

// test 7
//  takes an input array of long, add val to each element and writes the result back to
// a output long[] via jni
// The use of GetLongArrayElements() will cause full array copies.
void Java_com_jni_consbench_simpleCall_SimpleCalls_testArrayReadWriteElement(
		JNIEnv* env, jobject jobj, jlongArray input, jlong val,
		jlongArray output) {

	jsize inputLen = env->GetArrayLength(input);
	jsize outputLen = env->GetArrayLength(output);

	assert(inputLen != 0);
	assert(inputLen == outputLen);

	jlong* inputBody = env->GetLongArrayElements(input, 0);
	jlong* outputBody = env->GetLongArrayElements(output, 0);

	for (jsize i = 0; i < inputLen; ++i) {
		outputBody[i] = inputBody[i] + val;
	}

	env->ReleaseLongArrayElements(input, inputBody, JNI_COMMIT);
	env->ReleaseLongArrayElements(output, outputBody, JNI_COMMIT);

	return;
}

// test 8: avoiding full array copies
//  takes an input array of long, add val to each element and writes the result back to
// a output long[] via jni
void Java_com_jni_consbench_simpleCall_SimpleCalls_testArrayReadWriteRegion(
		JNIEnv* env, jobject jobj, jlongArray input, jlong val,
		jlongArray output, jint len) {

	jlong inputRegion[len] ;
	jlong outputRegion[len];

	env->GetLongArrayRegion(input, 0, len, inputRegion);

	for (jsize i = 0; i < len; ++i) {
		outputRegion[i] = inputRegion[i] + val;
	}

	env->SetLongArrayRegion(output, 0, len, outputRegion);
	return;
}
