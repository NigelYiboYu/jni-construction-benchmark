/**
 * Copyright © 2016, Evolved Binary Ltd
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of the <organization> nor the
 *       names of its contributors may be used to endorse or promote products
 *       derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
/**
 * */
package com.jni.consbench.nativeobj.bench;

import java.text.NumberFormat;
import java.util.Locale;

import com.jni.consbench.nativeobj.FooByCall;
import com.jni.consbench.nativeobj.FooByCallInvoke;
import com.jni.consbench.nativeobj.FooByCallStatic;

/**
 *
 * A small JNI Benchmark to show the difference in cost between various models
 * of Object Construction for a Java API that wraps a C++ API using JNI
 *
 * @author Adam Retter <adam.retter@googlemail.com>
 */
public class Benchmark {

	// default to 1 million
	private static long ITERATIONS = 1000000;
	private static boolean warmup = true;

	public final static void main(final String args[]) {

		if (args.length >= 1)
			ITERATIONS = Long.parseLong(args[0]);

		if (args.length >= 2)
			warmup = Integer.parseInt(args[1]) != 0;

		System.out.println("Calling JNI from main() function.");
		System.out.println("Using iteration count " + ITERATIONS + "\n\n");

		System.loadLibrary("xplinkjnibench");

		NumberFormat numberFormat = NumberFormat.getNumberInstance(Locale.US);

		if (warmup) {
			System.out.println("Warming up");
			// TEST1 - Foo By Call
			for (long j = 0; j < ITERATIONS; j++) {
				final FooByCall fooByCall = new FooByCall();
			}
			
			// TEST2 - Foo By Call Static
			for (long j = 0; j < ITERATIONS; j++) {
				final FooByCallStatic fooByCallStatic = new FooByCallStatic();
			}
			
			// TEST3 - Foo By Call Invoke
			for (long j = 0; j < ITERATIONS; j++) {
				final FooByCallInvoke fooByCallInvoke = new FooByCallInvoke();
			}
		}

		// TEST1 - Foo By Call
		System.out.println("Starting test FooByCall " + numberFormat.format(ITERATIONS) + " iterations");
		final long start1 = System.currentTimeMillis();
		for (long j = 0; j < ITERATIONS; j++) {
			final FooByCall fooByCall = new FooByCall();
		}

		final long end1 = System.currentTimeMillis();
		System.out.println("FooByCall: " + numberFormat.format(end1 - start1) + "ms\n\n");
		
		// TEST2 - Foo By Call Static
		System.out.println("Starting test FooByCallStatic " + numberFormat.format(ITERATIONS) + " iterations");
		final long start2 = System.currentTimeMillis();
		for (long j = 0; j < ITERATIONS; j++) {
			final FooByCallStatic fooByCallStatic = new FooByCallStatic();
		}

		final long end2 = System.currentTimeMillis();
		System.out.println("FooByCallStatic: " + numberFormat.format(end2 - start2) + "ms\n\n");
		// TEST3 - Foo By Call Invoke
		System.out.println("Starting test FooByCallInvoke " + numberFormat.format(ITERATIONS) + " iterations");
		final long start3 = System.currentTimeMillis();
		for (long j = 0; j < ITERATIONS; j++) {
			final FooByCallInvoke fooByCallInvoke = new FooByCallInvoke();
		}

		final long end3 = System.currentTimeMillis();
		System.out.println("FooByCallInvoke: " + numberFormat.format(end3 - start3) + "ms");
	}
}
