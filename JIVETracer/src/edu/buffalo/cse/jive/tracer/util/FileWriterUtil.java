package edu.buffalo.cse.jive.tracer.util;

import java.io.FileWriter;
import java.io.IOException;

public abstract class FileWriterUtil {

	private FileWriter fileWriter;
	private String fileName;

	public FileWriterUtil(String fileName) {
		super();
		this.fileName = fileName;
		try {
			this.fileWriter = new FileWriter(this.fileName);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	protected void finalize() throws Throwable {
		super.finalize();
		fileWriter.close();
	}

	public FileWriter getFileWriter() {
		return fileWriter;
	}

	public void setFileWriter(FileWriter fileWriter) {
		this.fileWriter = fileWriter;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	
}
