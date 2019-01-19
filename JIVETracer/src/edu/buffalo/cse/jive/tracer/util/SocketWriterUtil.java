package edu.buffalo.cse.jive.tracer.util;

import java.io.BufferedOutputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.Socket;
import java.net.UnknownHostException;

import edu.buffalo.cse.jive.tracer.model.TraceModel;

public class SocketWriterUtil implements WriterUtil {

	private String host;
	private int port;
	private Socket socket;
	private DataOutputStream dataOutputStream;

	public SocketWriterUtil(String host, int port) {
		super();
		this.host = host;
		this.port = port;
		try {
			this.socket = new Socket(host, port);
			this.dataOutputStream = new DataOutputStream(new BufferedOutputStream(socket.getOutputStream(), 512));
		} catch (UnknownHostException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public String toString() {
		return "SocketWriterUtil [host=" + host + ", port=" + port + "]";
	}

	public String getHost() {
		return host;
	}

	public void setHost(String host) {
		this.host = host;
	}

	public int getPort() {
		return port;
	}

	public void setPort(int port) {
		this.port = port;
	}

	@Override
	public void write(TraceModel traceModel) throws IOException {
		dataOutputStream.writeUTF(BuildTraceModel.minToString(traceModel));
		dataOutputStream.flush();
	}

	@Override
	protected void finalize() throws Throwable {
		super.finalize();
		socket.close();
	}

}
