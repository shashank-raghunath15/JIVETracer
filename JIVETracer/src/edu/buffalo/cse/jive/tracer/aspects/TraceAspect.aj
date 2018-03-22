/**
 * 
 */
package edu.buffalo.cse.jive.tracer.aspects;

import java.io.File;
import java.math.BigInteger;
import java.util.Arrays;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;

import edu.buffalo.cse.jive.tracer.model.TraceModel;
import edu.buffalo.cse.jive.tracer.util.CSVUtil;
import edu.buffalo.cse.jive.tracer.util.SerialUtil;

/**
 * @author Shashank Raghunath
 * @email sraghuna@buffalo.edu
 *
 */
@Aspect
public aspect TraceAspect {

	private static BigInteger sequence = new BigInteger("0");
	private CSVUtil csvUtil;

	public TraceAspect() {
		csvUtil = new CSVUtil(System.getProperty("user.dir") + File.separator + "trace");
	}

	@Pointcut("@annotation(edu.buffalo.cse.jive.tracer.annotations.Trace)")
	public void trace() {
	}

	// @Pointcut("execution(* *(..))")
	// public void atExecution() {
	// }

	@Pointcut("within(@edu.buffalo.cse.jive.tracer.annotations.TraceAll *)")
	public void traceAll() {
	}

	// @Before("trace()")
	// public void trace(JoinPoint joinPoint) {
	// TraceModel traceModel = new TraceModel();
	// if (joinPoint.getTarget() instanceof Thread) {
	// Object object = joinPoint.getTarget();
	// Thread thread = (Thread) joinPoint.getTarget();
	// traceModel.setObjectReference(object.getClass().getCanonicalName() + "@" +
	// thread.getId());
	// } else {
	// traceModel.setObjectReference(joinPoint.getTarget());
	// }
	// traceModel.setFieldName(joinPoint.getSignature().getName());
	// if (joinPoint.getArgs()[0] != null) {
	// if (joinPoint.getArgs().length > 1) {
	// traceModel.setFieldValue(Arrays.deepToString(joinPoint.getArgs()));
	// } else if (joinPoint.getArgs()[0].getClass().isArray()) {
	// String value = Arrays.deepToString(joinPoint.getArgs());
	// traceModel.setFieldValue(value.substring(1, value.length() - 1));
	// } else {
	// if (joinPoint.getArgs()[0] instanceof Thread) {
	// Object object = joinPoint.getArgs()[0];
	// Thread thread = (Thread) joinPoint.getArgs()[0];
	// traceModel.setFieldValue(object.getClass().getCanonicalName() + "@" +
	// thread.getId());
	// } else {
	//
	// traceModel.setFieldValue(joinPoint.getArgs()[0]);
	// }
	// }
	// } else {
	// traceModel.setFieldValue("null");
	// }
	//
	// csvUtil.write(traceModel);
	// }

	@Before("traceAll()")
	public void traceAll(JoinPoint joinPoint) {
		if (joinPoint.getKind().equals(JoinPoint.FIELD_SET)) {

			csvUtil.write(buildModel(joinPoint));
		}
	}

	private TraceModel buildModel(JoinPoint joinPoint) {
		sequence = sequence.add(BigInteger.ONE);

		TraceModel traceModel = new TraceModel();
		traceModel.setThreadName(Thread.currentThread().getName());
		traceModel.setSource(joinPoint.getSourceLocation().toString());
		traceModel.setType("Field Write");
		traceModel.setSequenceNumber(sequence.toString());
		StringBuilder builder = new StringBuilder();

		builder.append("context=");

		if (joinPoint.getTarget() instanceof Thread) {
			Object object = joinPoint.getTarget();
			Thread thread = (Thread) joinPoint.getTarget();
			builder.append(object.getClass().getCanonicalName() + ":"
					+ SerialUtil.add(object.getClass().getCanonicalName() + "@" + thread.getId()));
		} else {
			builder.append(joinPoint.getTarget().getClass().getCanonicalName() + ":"
					+ SerialUtil.add(String.valueOf(joinPoint.getTarget())));
		}
		builder.append(", ");
		builder.append(joinPoint.getSignature().getName() + "=");
		if (joinPoint.getArgs()[0] != null) {
			if (SerialUtil.contains(String.valueOf(joinPoint.getArgs()[0]))) {
				builder.append(joinPoint.getTarget().getClass().getCanonicalName() + ":"
						+ SerialUtil.add(String.valueOf(joinPoint.getTarget())));
			} else if (joinPoint.getArgs().length > 1) {
				builder.append(Arrays.deepToString(joinPoint.getArgs()));
			} else if (joinPoint.getArgs()[0].getClass().isArray()) {
				String value = Arrays.deepToString(joinPoint.getArgs());
				builder.append(value.substring(1, value.length() - 1));
			} else {
				if (joinPoint.getArgs()[0] instanceof Thread) {
					Object object = joinPoint.getArgs()[0];
					Thread thread = (Thread) joinPoint.getArgs()[0];
					builder.append(object.getClass().getCanonicalName() + "@" + thread.getId());
				} else {
					builder.append(joinPoint.getArgs()[0]);
				}
			}
		} else {
			builder.append("null");
		}
		traceModel.setDetails(builder.toString());
		return traceModel;
	}
}
