package com.jni.consbench.simpleCall;

import java.text.NumberFormat;
import java.util.Locale;

public class BenchmarkRet {

	// default to 1 million
	private static long ITERATIONS = 1000000;
	private static boolean warmup = true;
	private static boolean isXPLink = true;

	private static String testName = "testRet";
	
	static int count = 517;
	static long[] i = new long[count];
	static int[] j = new int[count];
	static boolean[] k = new boolean[count];
	static byte[] x = new byte[count];
	static char[] y = new char[count];
	static short[] z = new short[count];
	static float[] f1 = new float[count];
	static float[] f2 = new float[count];
	static float[] f3 = new float[count];
	static float[] f4 = new float[count];
	static float[] f5 = new float[count];
	static double[] d1 = new double[count];
	static double[] d2 = new double[count];
	
	
	static {
		for (int iter = 0; iter < count; ++iter) {
			i[iter] = iter*17;
			j[iter] = iter;
			k[iter] = (iter%7 == 1) ? true: false;
			
			x[iter] = (byte)(iter%256);
			y[iter] = (char)(iter%112);
			z[iter] = (short)((iter*11)%123);
			
			f1[iter] = (float) Math.sqrt(iter);
			f2[iter] = (float) Math.sqrt(iter%11);
			f3[iter] = (float) Math.sqrt(iter%7);
			f4[iter] = (float) Math.sqrt(iter%13);
			f5[iter] = (float) Math.sqrt(iter%17);
			
			d1[iter] = Math.sqrt(iter%7);
			d2[iter] = Math.sqrt(iter);
		}
	}
	
	
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

		if (warmup) {
			System.out.println("warming up");
			doTest(false);
		}

		doTest(true);
	}

	private static void doTest(boolean doPrint) {

		NumberFormat numberFormat = NumberFormat.getNumberInstance(Locale.US);

		if (doPrint)
			System.out.println("Starting test " + testName + " " + numberFormat.format(ITERATIONS) + " iterations");


		final long start1 = System.currentTimeMillis();
		final SimpleCalls simpleCalls = new SimpleCalls();

		for (int iter = 0; iter < ITERATIONS; iter++) {
			int index = iter%count;
			simpleCalls.testRet(i[index], j[index], k[index], 
					x[index], y[index], z[index], 
					f1[index], f2[index], f3[index], f4[index], f5[index], 
					d1[index], d2[index]);
		}

		final long end1 = System.currentTimeMillis();

		if (doPrint)
			System.out.println(testName + " out of main " + (warmup ? "warmup " : "no warmup ")
					+ (isXPLink ? "xplink " : "non-xplink ") + numberFormat.format(end1 - start1) + "ms\n\n");

	}
}
