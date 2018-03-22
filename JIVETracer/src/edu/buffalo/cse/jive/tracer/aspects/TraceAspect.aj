/**
 * 
 */
package edu.buffalo.cse.jive.tracer.aspects;

import java.io.File;
import java.io.IOException;
import java.math.BigInteger;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;

import edu.buffalo.cse.jive.tracer.shutdownHook.CleanUpHook;
import edu.buffalo.cse.jive.tracer.util.BuildTraceModel;
import edu.buffalo.cse.jive.tracer.util.CSVUtil;

/**
 * @author Shashank Raghunath
 * @email sraghuna@buffalo.edu
 *
 */
@Aspect
public aspect TraceAspect {

	private static BigInteger sequence = new BigInteger("0");
	private CSVUtil csvUtil;
	private String fileName = null;

	public TraceAspect() {
		setFileName();
		csvUtil = new CSVUtil(System.getProperty("user.dir") + File.separator + fileName);
		Runtime.getRuntime().addShutdownHook(new CleanUpHook());
	}

	@Pointcut("set(@edu.buffalo.cse.jive.tracer.annotations.Trace * *)")
	public void trace() {
	}

	@Pointcut("within(@edu.buffalo.cse.jive.tracer.annotations.TraceAll *)")
	public void traceAll() {
	}

	@Before("trace()")
	public void trace(JoinPoint joinPoint) {
		sequence = sequence.add(BigInteger.ONE);
		try {
			csvUtil.write(BuildTraceModel.buildFieldWriteTraceModel(joinPoint, sequence.toString()));
		} catch (IOException e) {
			System.exit(0);
		}
	}

	@Before("traceAll()")
	public void traceAll(JoinPoint joinPoint) {
		if (joinPoint.getKind().equals(JoinPoint.FIELD_SET)) {
			sequence = sequence.add(BigInteger.ONE);
			try {
				csvUtil.write(BuildTraceModel.buildFieldWriteTraceModel(joinPoint, sequence.toString()));
			} catch (IOException e) {
				System.exit(0);
			}
		}
	}

	public void setFileName() {
		if (fileName == null) {
			StackTraceElement trace[] = Thread.currentThread().getStackTrace();
			if (trace.length > 0) {
				fileName = trace[trace.length - 1].getClassName();
			} else {
				fileName = "trace";
			}
		}
	}
}
