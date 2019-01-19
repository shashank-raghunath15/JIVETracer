package edu.buffalo.cse.jive.tracer.shutdownHook;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FilenameFilter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

public class CleanUpHook extends Thread {

	private static final String BASE_DIR = System.getProperty("user.dir");
	private static final String TRACE_DIR = BASE_DIR + File.separator + "traces";

	@Override
	public void run() {
		File baseDirectory = new File(BASE_DIR);
		File[] csvFiles = baseDirectory.listFiles(new FilenameFilter() {
			@Override
			public boolean accept(File dir, String name) {
				return name.endsWith(".csv");
			}
		});
		File traceDirectory = new File(TRACE_DIR);
		for (File file : csvFiles) {
			try {
				if (traceDirectory.exists()) {
					moveFile(file, TRACE_DIR);
				} else {
					if (traceDirectory.mkdirs()) {
						moveFile(file, TRACE_DIR);
					}
				}
			} catch (FileNotFoundException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	private void moveFile(File file, String traceDir) throws IOException {
		Files.move(Paths.get(file.getAbsolutePath()), Paths.get(traceDir, file.getName()));
	}

}
