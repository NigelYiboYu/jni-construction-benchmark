package com.jni.consbench.javabacked;

/**
 * Follows <i>9.2.3 Pattern 1: Call</i> from Java Platform Performance by Steve
 * Wilson for setting up the handle to the native object
 */
public class FooByCall extends FooJavaObject {
	public FooByCall() {
		super();
		this._javaObjHandle = newFoo();
	}

	private native long newFoo();
}
