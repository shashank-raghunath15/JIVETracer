/**
 * 
 */
package edu.buffalo.cse.jive.tracer.aspects;

import java.io.File;
import java.util.Arrays;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;

import edu.buffalo.cse.jive.tracer.model.TraceModel;
import edu.buffalo.cse.jive.tracer.util.CSVUtil;

/**
 * @author Shashank Raghunath
 * @email sraghuna@buffalo.edu
 *
 */
@Aspect
public aspect TraceAspect {

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

	@Before("trace()")
	public void trace(JoinPoint joinPoint) {
		TraceModel traceModel = new TraceModel();
		if (joinPoint.getTarget() instanceof Thread) {
			Object object = joinPoint.getTarget();
			Thread thread = (Thread) joinPoint.getTarget();
			traceModel.setObjectReference(object.getClass().getCanonicalName() + "@" + thread.getId());
		} else {
			traceModel.setObjectReference(joinPoint.getTarget());
		}
		traceModel.setFieldName(joinPoint.getSignature().getName());
		if (joinPoint.getArgs()[0] != null) {
			if (joinPoint.getArgs().length > 1) {
				traceModel.setFieldValue(Arrays.deepToString(joinPoint.getArgs()));
			} else if (joinPoint.getArgs()[0].getClass().isArray()) {
				String value = Arrays.deepToString(joinPoint.getArgs());
				traceModel.setFieldValue(value.substring(1, value.length() - 1));
			} else {
				traceModel.setFieldValue(joinPoint.getArgs()[0]);
			}
		} else {
			traceModel.setFieldValue("null");
		}

		csvUtil.write(traceModel);
	}

	@Before("traceAll()")
	public void traceAll(JoinPoint joinPoint) {
		if (joinPoint.getKind().equals(JoinPoint.FIELD_SET)) {
			TraceModel traceModel = new TraceModel();
			if (joinPoint.getTarget() instanceof Thread) {
				Object object = joinPoint.getTarget();
				Thread thread = (Thread) joinPoint.getTarget();
				traceModel.setObjectReference(object.getClass().getCanonicalName() + "@" + thread.getId());
			} else {
				traceModel.setObjectReference(joinPoint.getTarget());
			}
			traceModel.setFieldName(joinPoint.getSignature().getName());
			if (joinPoint.getArgs()[0] != null) {
				if (joinPoint.getArgs().length > 1) {
					traceModel.setFieldValue(Arrays.deepToString(joinPoint.getArgs()));
				} else if (joinPoint.getArgs()[0].getClass().isArray()) {
					String value = Arrays.deepToString(joinPoint.getArgs());
					traceModel.setFieldValue(value.substring(1, value.length() - 1));
				} else {
					traceModel.setFieldValue(joinPoint.getArgs()[0]);
				}
			} else {
				traceModel.setFieldValue("null");
			}
			csvUtil.write(traceModel);
		}
	}
}
