/**
 * 
 */
package edu.buffalo.cse.jive.tracer.util;

import java.io.IOException;

import edu.buffalo.cse.jive.tracer.model.TraceModel;

/**
 * @author Shashank Raghunath
 * @email sraghuna@buffalo.edu
 *
 */
public class CSVFileWriterUtil extends FileWriterUtil implements WriterUtil {

	public CSVFileWriterUtil(String fileName) {
		super(fileName);
	}

	public void write(TraceModel traceModel) throws IOException {
		getFileWriter().write(BuildTraceModel.toString(traceModel));
		getFileWriter().flush();
	}
}
