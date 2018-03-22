package edu.buffalo.cse.jive.tracer.util;

import java.io.FileWriter;

public class FileWriterUtility {

	public static FileWriter fileWriter;

	public static FileWriter getFileWriter() {
		return fileWriter;
	}

	public static void setFileWriter(FileWriter fileWriter) {
		FileWriterUtility.fileWriter = fileWriter;
	}
}
