package com.jni.consbench.simpleCall;

import java.text.NumberFormat;
import java.util.Locale;

public class BenchmarkArrayReadWriteRegion {

	// default to 1 million
	private static long ITERATIONS = 1000000;
	private static boolean warmup = true;
	private static boolean isXPLink = true;

	private static int chunkSize = 10;
	private static final int arraySize = 1000;

	private static String testName = "testArrayReadWriteRegion";

	public final static void main(final String args[]) {

		if (args.length >= 1)
			ITERATIONS = Long.parseLong(args[0]);

		if (args.length >= 2)
			warmup = (Integer.parseInt(args[1]) != 0);

		if (args.length >= 3)
			isXPLink = (Integer.parseInt(args[2]) != 0);

		if (args.length >= 4)
			chunkSize = Integer.parseInt(args[3]);

		if (isXPLink)
			System.loadLibrary("xplinkjnibench");
		else
			System.loadLibrary("stdlinkjnibench");

		System.out.println("Using iteration count " + ITERATIONS + "\n\n");
		System.out.println(testName + " out of main " + (warmup ? "with warmup" : "no warmup"));

		if (warmup) {
			System.out.println("warming up");
			doTest(false);
		}

		doTest(true);
	}

	private static void doTest(boolean doPrint) {

		NumberFormat numberFormat = NumberFormat.getNumberInstance(Locale.US);

		long[] array = new long[arraySize];
		long[] result = new long[arraySize];

		for (int i = 0; i < arraySize; ++i) {
			array[i] = i + 17;
		}

		if (doPrint)
			System.out.println("Starting test " + testName + " " + numberFormat.format(ITERATIONS) + " iterations");

		final long start1 = System.currentTimeMillis();
		final SimpleCalls simpleCalls = new SimpleCalls();

		for (long j = 0; j < ITERATIONS; j++) {
			simpleCalls.testArrayReadWriteRegion(array, j, result, chunkSize);
		}

		final long end1 = System.currentTimeMillis();

		if (doPrint)
			System.out.println(testName + " out of main " + (warmup ? "warmup " : "no warmup ")
					+ (isXPLink ? "xplink" : "non-xplink") + " chunk size " + chunkSize + ": "
					+ numberFormat.format(end1 - start1) + "ms\n\n");

	}
}
