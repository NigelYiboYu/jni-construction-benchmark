package com.jni.consbench.javabacked.bench;

import java.text.NumberFormat;
import java.util.Locale;

import com.jni.consbench.javabacked.FooByCall;

/**
 *
 * A small JNI Benchmark to show the difference in cost between various models
 * of Object Construction for a Java API that wraps a C++ API using JNI
 *
 * @author Adam Retter <adam.retter@googlemail.com>
 */
public class BenchmarkFooByCall {

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
		System.out.println("Only testing FooByCall() out of main " + (warmup ? "with warmup" : " no warmup"));

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
