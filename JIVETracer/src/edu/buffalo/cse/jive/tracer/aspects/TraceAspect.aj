/**
 * 
 */
package edu.buffalo.cse.jive.tracer.aspects;

import java.io.File;
import java.io.IOException;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;

import edu.buffalo.cse.jive.tracer.annotations.TraceAll;
import edu.buffalo.cse.jive.tracer.shutdownHook.CleanUpHook;
import edu.buffalo.cse.jive.tracer.util.BuildTraceModel;
import edu.buffalo.cse.jive.tracer.util.SocketWriterUtil;
import edu.buffalo.cse.jive.tracer.util.WriterUtil;

/**
 * @author Shashank Raghunath
 * @email sraghuna@buffalo.edu
 *
 */
@Aspect
public aspect TraceAspect {

	private static BigInteger sequence = new BigInteger("0");
	private WriterUtil writerUtil;

	public TraceAspect() {
		Runtime.getRuntime().addShutdownHook(new CleanUpHook());
		writerUtil = new SocketWriterUtil("localhost", 5000);
	}

	@Pointcut("set(@edu.buffalo.cse.jive.tracer.annotations.Trace * *)")
	public void trace() {
	}

	@Pointcut("within(@edu.buffalo.cse.jive.tracer.annotations.TraceAll *)")
	public void traceAll() {
	}

	@Before("trace()")
	public void trace(JoinPoint joinPoint) {
		if (joinPoint.getThis().getClass().getAnnotation(TraceAll.class) == null) {
			sequence = sequence.add(BigInteger.ONE);
			try {
				writerUtil.write(BuildTraceModel.buildFieldWriteTraceModel(joinPoint, sequence.toString()));
			} catch (IOException e) {
				System.exit(0);
			}
		}
	}

	@Before("traceAll()")
	public void traceAll(JoinPoint joinPoint) {
		if (joinPoint.getKind().equals(JoinPoint.FIELD_SET)) {
			sequence = sequence.add(BigInteger.ONE);
			try {
				writerUtil.write(BuildTraceModel.buildFieldWriteTraceModel(joinPoint, sequence.toString()));
			} catch (IOException e) {
				System.exit(0);
			}
		}
	}

	public String buildFileName() {
		StringBuilder fileName = new StringBuilder();
		fileName.append(System.getProperty("user.dir")).append(File.separator);
		StackTraceElement trace[] = Thread.currentThread().getStackTrace();
		if (trace.length > 0) {
			fileName.append(trace[trace.length - 1].getClassName());
		} else {
			fileName.append("trace");
		}
		fileName.append("-");
		fileName.append(new SimpleDateFormat("MM-dd-yyyy hhmmss").format(new Date()) + ".csv");
		return fileName.toString();
	}
}
