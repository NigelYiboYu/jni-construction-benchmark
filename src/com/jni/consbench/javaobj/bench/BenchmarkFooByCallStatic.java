
package com.jni.consbench.javaobj.bench;

import java.text.NumberFormat;
import java.util.Locale;

import com.jni.consbench.javaobj.FooByCallStatic;

public class BenchmarkFooByCallStatic {

	// default to 1 million
	private static long ITERATIONS = 1000000;
	private static boolean warmup = true;

	public final static void main(final String args[]) {
		System.loadLibrary("xplinkjnibench");

		if (args.length >= 1)
			ITERATIONS = Long.parseLong(args[0]);

		if (args.length >= 2)
			warmup = Integer.parseInt(args[1]) != 0;

		System.out.println("Using iteration count " + ITERATIONS + "\n\n");
		System.out.println("Only testing FooByCallStatic() javabacked out of main " + (warmup ? "with warmup" : "no warmup"));

		if (warmup)
			byCallStaticLoop(false);

		byCallStaticLoop(true);
	}

	private static void byCallStaticLoop(boolean doPrint) {

		NumberFormat numberFormat = NumberFormat.getNumberInstance(Locale.US);

		// TEST2 - Foo By Call Static
		if (doPrint)
			System.out.println("Starting test FooByCallStatic " + numberFormat.format(ITERATIONS) + " iterations");

		final long start2 = System.currentTimeMillis();
		for (long j = 0; j < ITERATIONS; j++) {
			final FooByCallStatic fooByCallStatic = new FooByCallStatic();
		}

		final long end2 = System.currentTimeMillis();

		if (doPrint)
			System.out.println("FooByCallStatic out of main " + (warmup ? "warmup " : " no warmup ")
					+ numberFormat.format(end2 - start2) + "ms\n\n");

	}
}
