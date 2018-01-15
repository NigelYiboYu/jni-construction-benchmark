package com.jni.consbench.javaobj.bench;

import java.text.NumberFormat;
import java.util.Locale;

import com.jni.consbench.javaobj.FooByCallInvoke;

public class BenchmarkFooByCallInvoke {

	// default to 1 million
	private static long ITERATIONS = 1000000;
	private static boolean warmup = true;

	public final static void main(final String args[]) {
		System.loadLibrary("jnibench");

		if (args.length >= 1)
			ITERATIONS = Long.parseLong(args[0]);

		if (args.length >= 2)
			warmup = Integer.parseInt(args[1]) != 0;

		System.out.println("Using iteration count " + ITERATIONS + "\n\n");
		System.out.println("Only testing FooByCallInvoke() javabacked out of main " + (warmup ? "with warmup" : "no warmup"));

		if (warmup)
			byCallInvokeLoop(false);

		byCallInvokeLoop(true);

	}

	private static void byCallInvokeLoop(boolean doPrint) {

		NumberFormat numberFormat = NumberFormat.getNumberInstance(Locale.US);

		// TEST3 - Foo By Call Invoke
		if (doPrint)
			System.out.println("Starting test FooByCallInvoke " + numberFormat.format(ITERATIONS) + " iterations");

		final long start3 = System.currentTimeMillis();
		for (long j = 0; j < ITERATIONS; j++) {
			final FooByCallInvoke fooByCallInvoke = new FooByCallInvoke();
		}

		final long end3 = System.currentTimeMillis();

		if (doPrint)
			System.out.println("FooByCallInvoke out of main " + (warmup ? "warmup " : "no warmup ")
					+ numberFormat.format(end3 - start3) + "ms");
	}
}
