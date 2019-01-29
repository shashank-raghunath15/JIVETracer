package edu.buffalo.cse.jive.tracer.util;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public abstract class FileWriterUtil {

	private FileWriter fileWriter;
	private File file;

	public FileWriterUtil(String fileName) {
		super();
		try {
			this.file = new File(fileName);
			this.fileWriter = new FileWriter(this.file);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	protected void finalize() throws Throwable {
		fileWriter.close();
	}

	public FileWriter getFileWriter() {
		return fileWriter;
	}

	public void setFileWriter(FileWriter fileWriter) {
		this.fileWriter = fileWriter;
	}
}
