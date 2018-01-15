package com.jni.consbench.javabacked;

/**
 * Follows <i>9.2.7 Pattern 4: Call-Invoke</i> from Java Platform Performance by
 * Steve Wilson for setting up the handle to the native object
 */
public class FooByCallInvoke extends FooJavaObject {
	public FooByCallInvoke() {
		super();
		newFoo(); // the native method, will find _javaObjHandle from the class and set it directly
	}

	private native void newFoo();
}
