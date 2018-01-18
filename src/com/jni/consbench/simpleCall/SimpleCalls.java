package com.jni.consbench.simpleCall;

public class SimpleCalls {

	private int intField;
	private long longField;

	private static long longFieldStatic = 56789;

	public SimpleCalls() {
		intField = 123;
		longField = 12345;
	}

	// test 1
	// call with no parameters and returns nothing
	public native void testNoParamNoRet();

	// test 2
	// call that takes an long as parameter, increment the long in native code but
	// returns nothing.
	public native void testNoRet(long i);

	// test 3
	// takes input long i, increment by a constant amount, and return the result
	public native long testRet(long i);

	// test 4
	// just get the field ID of a non-static long field. Do nothing on this field
	public native void testGetFieldID();

	// test 5
	// get the field ID of a non-static long field, and assign input long value to
	// it
	public native void testSetLongField(long j);

	// test 6
	// static version of the one above. uses a static long field.
	public static native void testSetLongFieldStatic(long j);

	// test 7
	// Java passes an array of const length (e.g. long[] of lenth 1000) to C++,
	// which increments each element
	// by j and writes results back to Java array via JNI.
	// i.e this is performing an element-wise operation: result = array + j.
	public native void testArrayWriting(long[] array, long j, long[] result);
}
