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

	public CSVUtil(String fileName) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("MM-dd-yyyy hhmmss");
		try {
			FileWriter fileWriter = new FileWriter(fileName + "-" + dateFormat.format(new Date()) + ".csv");
			FileWriterUtility.setFileWriter(fileWriter);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void write(TraceModel traceModel) throws IOException {
		FileWriter fileWriter = FileWriterUtility.getFileWriter();

		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.append("\"" + traceModel.getThreadName() + "\"").append(',');
		stringBuilder.append("\"" + traceModel.getSequenceNumber() + "\"").append(',');
		stringBuilder.append("\"" + traceModel.getSource() + "\"").append(',');
		stringBuilder.append("\"" + traceModel.getType() + "\"").append(',');
		stringBuilder.append("\"" + traceModel.getDetails() + "\"");
		stringBuilder.append("\n");
		fileWriter.write(stringBuilder.toString());
	}
}
