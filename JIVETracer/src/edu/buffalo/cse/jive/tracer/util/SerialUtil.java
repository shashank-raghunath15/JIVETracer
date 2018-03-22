package edu.buffalo.cse.jive.tracer.util;

import java.util.HashMap;
import java.util.Map;

public class SerialUtil {

	private static Map<String, Long> map = new HashMap<>();
	private static Long sequence = Long.valueOf(0);

	public static long add(String context) {
		if (map.containsKey(context)) {
			return map.get(context);
		} else {
			map.put(context, ++sequence);
			return sequence;
		}
	}
}
