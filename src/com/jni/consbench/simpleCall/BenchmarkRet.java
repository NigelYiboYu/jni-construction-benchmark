package com.jni.consbench.simpleCall;

import java.text.NumberFormat;
import java.util.Locale;

public class BenchmarkRet {

	// default to 1 million
	private static long ITERATIONS = 1000000;
	private static boolean warmup = true;

	private static String testName = "testRet";

	public final static void main(final String args[]) {
		System.loadLibrary("xplinkjnibench");

		if (args.length >= 1)
			ITERATIONS = Long.parseLong(args[0]);

		if (args.length >= 2)
			warmup = Integer.parseInt(args[1]) != 0;

		System.out.println("Using iteration count " + ITERATIONS + "\n\n");
		System.out.println(testName + " out of main " + (warmup ? "with warmup" : "no warmup"));

		if (warmup)
			doTest(false);

		doTest(true);
	}

	private static void doTest(boolean doPrint) {

		NumberFormat numberFormat = NumberFormat.getNumberInstance(Locale.US);

		if (doPrint)
			System.out.println("Starting test " + testName + " " + numberFormat.format(ITERATIONS) + " iterations");

		final long start1 = System.currentTimeMillis();
		final SimpleCalls simpleCalls = new SimpleCalls();

		for (long j = 0; j < ITERATIONS; j++) {
			simpleCalls.testNoRet(j);
		}

		final long end1 = System.currentTimeMillis();

		if (doPrint)
			System.out.println(testName + " out of main " + (warmup ? "warmup " : "no warmup ")
					+ numberFormat.format(end1 - start1) + "ms\n\n");

	}

}
