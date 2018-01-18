package com.jni.consbench.simpleCall;

import java.text.NumberFormat;
import java.util.Locale;

public class BenchmarkArrayWriting {

	// default to 1 million
	private static long ITERATIONS = 1000000;
	private static boolean warmup = true;
	private static boolean isXPLink = true;

	private static String testName = "testArrayWriting";

	public final static void main(final String args[]) {

		if (args.length >= 1)
			ITERATIONS = Long.parseLong(args[0]);

		if (args.length >= 2)
			warmup = (Integer.parseInt(args[1]) != 0);

		if (args.length >= 3)
			isXPLink = (Integer.parseInt(args[2]) != 0);

		if (isXPLink)
			System.loadLibrary("xplinkjnibench");
		else
			System.loadLibrary("stdlinkjnibench");

		System.out.println("Using iteration count " + ITERATIONS + "\n\n");
		System.out.println(testName + " out of main " + (warmup ? "with warmup" : "no warmup"));

		if (warmup)
			doTest(false);

		doTest(true);
	}

	private static void doTest(boolean doPrint) {

		NumberFormat numberFormat = NumberFormat.getNumberInstance(Locale.US);

		long[] array = new long[1000];
		long[] result = new long[1000];

		for (int i = 0; i < 1000; ++i) {
			array[i] = i + 17;
		}

		if (doPrint)
			System.out.println("Starting test " + testName + " " + numberFormat.format(ITERATIONS) + " iterations");

		final long start1 = System.currentTimeMillis();
		final SimpleCalls simpleCalls = new SimpleCalls();

		for (long j = 0; j < ITERATIONS; j++) {
			simpleCalls.testArrayWriting(array, j, result);
		}

		final long end1 = System.currentTimeMillis();

		if (doPrint)
			System.out.println(testName + " out of main xplink " + (warmup ? "warmup " : "no warmup ")
					+ numberFormat.format(end1 - start1) + "ms\n\n");

	}
}
