package com.whu.tools.filter;

import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.util.zip.GZIPOutputStream;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

public class GZipServletResponseWrapper extends SecurityWrapperResponse {

	private final HttpServletResponse response;
	private GZIPResponseStream outStream;
	private PrintWriter writer;

	GZipServletResponseWrapper(HttpServletResponse response) {
		super(response);
		this.response = response;
	}

	@Override
	public ServletOutputStream getOutputStream() throws IOException {
		if (this.writer != null)
			throw new IllegalStateException("getWriter() has already been called for this response");

		if (this.outStream == null) {
			this.outStream = new GZIPResponseStream(this.response.getOutputStream());
			this.response.addHeader("Content-Encoding", "gzip");
		}

		return this.outStream;
	}

	@Override
	public PrintWriter getWriter() throws IOException {
		if (this.writer == null) {
			if (this.outStream != null)
				throw new IllegalStateException("getOutputStream() has already been called for this response");

			this.outStream = new GZIPResponseStream(this.response.getOutputStream());
			this.writer = new PrintWriter(this.outStream);
			this.response.addHeader("Content-Encoding", "gzip");
		}

		return this.writer;
	}

	public void finish() throws IOException {
		if (this.writer != null) {
			this.writer.flush(); // HTTP 1.1 chunked encoding
			this.outStream.finish();
			//this.response.addHeader("Content-Length", Integer.toString(this.outStream.getCount()));
			this.writer.close();
		} else if (this.outStream != null) {
			this.outStream.flush(); // HTTP 1.1 chunked encoding
			this.outStream.finish();
			//this.response.addHeader("Content-Length", Integer.toString(this.outStream.getCount()));
			this.outStream.close();
		}
	}
}

class GZIPResponseStream extends ServletOutputStream {
	private final GZIPOutputStream gzipstream;
	private int count;

	GZIPResponseStream(ServletOutputStream stream) throws IOException {
		this.gzipstream = new GZIPOutputStream(stream);
	}

	@Override
	public void write(int b) throws IOException {
		this.gzipstream.write(b);
		this.count++;
	}

	@Override
	public void write(byte[] b) throws IOException {
		this.gzipstream.write(b);
		this.count += b.length;
	}

	@Override
	public void write(byte[] b, int off, int len) throws IOException {
		this.gzipstream.write(b, off, len);
		this.count += len;
	}

	@Override
	public void flush() throws IOException {
		this.gzipstream.flush();
	}

	@Override
	public void close() throws IOException {
		this.gzipstream.close();
	}

	public void finish() throws IOException {
		this.gzipstream.finish();
	}

	public int getCount() {
		return this.count;
	}
}