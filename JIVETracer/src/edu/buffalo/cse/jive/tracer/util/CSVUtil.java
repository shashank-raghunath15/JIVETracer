/**
 * 
 */
package edu.buffalo.cse.jive.tracer.util;

import java.io.FileWriter;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import edu.buffalo.cse.jive.tracer.model.TraceModel;

/**
 * @author Shashank Raghunath
 * @email sraghuna@buffalo.edu
 *
 */
public class CSVUtil {

	private FileWriter fileWriter;

	public CSVUtil(String fileName) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("MM-dd-yyyy hhmmss");
		try {
			fileWriter = new FileWriter(fileName + dateFormat.format(new Date()) + ".csv");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void write(TraceModel traceModel) {
		try {
			StringBuilder stringBuilder = new StringBuilder();
			stringBuilder.append(traceModel.getObjectReference()).append(',');
			stringBuilder.append(traceModel.getFieldName()).append(',');
			stringBuilder.append(traceModel.getFieldValue());
			stringBuilder.append("\n");
			fileWriter.write(stringBuilder.toString());
			fileWriter.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	protected void finalize() throws Throwable {
		fileWriter.close();
	}
}
