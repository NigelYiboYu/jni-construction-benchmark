package com.jni.consbench.simpleCall;

public class SimpleCalls {

	private int intField;
	private long longField;

	private static long longFieldStatic = 56789;

	public SimpleCalls() {
		intField = 123;
		longField = 12345;
	}

	/**
	 * \brief Test 1
	 * <p>
	 * call with no parameters and returns nothing
	 * 
	 */
	public native void testNoParamNoRet();

	/**
	 * \brief Test 2
	 * <p>
	 * call that takes an long as parameter, increment the long in native code but
	 * returns nothing.
	 */
	public native void testNoRet(long i);

	/**
	 * \brief Test 3
	 * <p>
	 * takes input long i, increment by a constant amount, and return the result
	 * 
	 */
	public native long testRet(long i);

	/**
	 * \brief test 4
	 * <p>
	 * @deprecated, not best JNI practice. Not tested. just get the field ID of a
	 * non-static long field. Do nothing on this field
	 */
	@Deprecated
	public native void testGetFieldID();

	/**
	 * \brief Test 5
	 * <p>
	 * get the field ID of a non-static long field, and assign input long value to
	 * it
	 */
	public native void testSetLongField(long j);

	/**
	 * \brief Test 6
	 * <p>
	 * static version of the one above. uses a static long field.
	 */
	public static native void testSetLongFieldStatic(long j);

	/**
	 * \brief test 7
	 * <p>
	 * Java passes an array of const length (e.g. long[] of lenth 1000) to C++,
	 * which increments each element by j and writes results back to Java array via
	 * JNI. i.e this is performing an element-wise operation: result = array + j.
	 */
	public native void testArrayReadWriteElement(long[] array, long j, long[] result);

	/**
	 * \brief test 8
	 * <p>
	 * similar to test-7 except the native side doesn't make copies of arrays Java
	 * passes an array of const length (e.g. long[] of lenth 1000) to C++, which
	 * increments each element by j and writes results back to Java array via JNI.
	 * i.e this is performing an element-wise operation: result = array + j.
	 */
	public native void testArrayReadWriteRegion(long[] array, long j, long[] result, int len);
}
