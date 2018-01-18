package com.jni.consbench.javaobj.bench;

import java.text.NumberFormat;
import java.util.Locale;

import com.jni.consbench.javaobj.FooByCall;

public class BenchmarkFooByCall {

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
		System.out.println("Only testing FooByCall() javabacked out of main " + (warmup ? "with warmup" : "no warmup"));

		if (warmup)
			byCallLoop(false);

		byCallLoop(true);
	}

	private static void byCallLoop(boolean doPrint) {

		NumberFormat numberFormat = NumberFormat.getNumberInstance(Locale.US);

		// TEST1 - Foo By Call
		if (doPrint)
			System.out.println("Starting test FooByCall " + numberFormat.format(ITERATIONS) + " iterations");

		final long start1 = System.currentTimeMillis();
		for (long j = 0; j < ITERATIONS; j++) {
			final FooByCall fooByCall = new FooByCall();
		}

		final long end1 = System.currentTimeMillis();

		if (doPrint)
			System.out.println("FooByCall out of main " + (warmup ? "warmup " : "no warmup ")
					+ numberFormat.format(end1 - start1) + "ms\n\n");

	}

}
