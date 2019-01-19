package edu.buffalo.cse.jive.tracer.util;

import java.util.Arrays;

import org.aspectj.lang.JoinPoint;

import edu.buffalo.cse.jive.tracer.model.TraceModel;

public class BuildTraceModel {

	public static TraceModel buildFieldWriteTraceModel(JoinPoint joinPoint, String sequence) {
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

	public static TraceModel buildMethodCallTraceModel(JoinPoint joinPoint) {
		return null;
	}

	public static TraceModel buildVariableWriteTraceModel(JoinPoint joinPoint) {
		return null;
	}

	public static String toString(TraceModel traceModel) {
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.append("\"" + traceModel.getThreadName() + "\"").append(',');
		stringBuilder.append("\"" + traceModel.getSequenceNumber() + "\"").append(',');
		stringBuilder.append("\"" + traceModel.getSource() + "\"").append(',');
		stringBuilder.append("\"" + traceModel.getType() + "\"").append(',');
		stringBuilder.append("\"" + traceModel.getDetails() + "\"");
		stringBuilder.append("\n");
		return stringBuilder.toString();
	}
	
	public static String minToString(TraceModel traceModel) {
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.append("\"" + traceModel.getDetails() + "\"");
		stringBuilder.append("\n");
		return stringBuilder.toString();
	}
}
