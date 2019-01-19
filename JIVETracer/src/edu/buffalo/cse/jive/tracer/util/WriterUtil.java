package edu.buffalo.cse.jive.tracer.util;

import java.io.IOException;

import edu.buffalo.cse.jive.tracer.model.TraceModel;

/**
 * @author Shashank Raghunath
 * @email sraghuna@buffalo.edu
 *
 */
public interface WriterUtil {

	public void write(TraceModel model) throws IOException;
}
