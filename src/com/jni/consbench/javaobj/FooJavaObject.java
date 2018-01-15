package com.jni.consbench.javaobj;

public class FooJavaObject {
	
	protected long _javaObjHandle;
	protected boolean _nativeOwner;


	public FooJavaObject() {
		_nativeOwner = false;
		_javaObjHandle = 0;
	}
}
