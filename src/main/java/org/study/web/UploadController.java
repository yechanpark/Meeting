package org.study.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.meeting.util.MediaUtils;
import org.meeting.util.UploadFileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

@RestController
public class UploadController {

	// servlet-context.xml ���� ������ Bean ������� ����
	@Resource(name = "boardUploadPath")
	private String boardUploadPath;

	@RequestMapping(value = "/imageUpload", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> imageUpload(MultipartFile file, HttpServletRequest request, String Mypath)
			throws Exception {

		String rootDirectory = request.getSession().getServletContext().getRealPath("/");

		return new ResponseEntity<String>(UploadFileUtils.uploadFile(rootDirectory + boardUploadPath,
				file.getOriginalFilename(), file.getBytes(), Mypath), HttpStatus.CREATED);
	}

	@RequestMapping(value = "/displayFile", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	public ResponseEntity<byte[]> displayFile(String fileName, HttpServletRequest request) throws Exception {
		
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
		String rootDirectory = request.getSession().getServletContext().getRealPath("/");

		MediaType mtype = MediaUtils.getMediaType(formatName);
		try {
			HttpHeaders headers = new HttpHeaders();
			in = new FileInputStream(rootDirectory + boardUploadPath + fileName);
			headers.setContentType(mtype);
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
			
		} finally {
			if(in != null) in.close();
		}
		
		return entity;
	}

	@RequestMapping(value = "/deleteFile", method = RequestMethod.POST)
	public ResponseEntity<String> deleteFile(String fileName) {

		String front = fileName.substring(0, 12);
		String end = fileName.substring(14);

		new File(boardUploadPath + (front + end).replace('/', File.separatorChar)).delete();
		new File(boardUploadPath + fileName.replace('/', File.separatorChar)).delete();

		return new ResponseEntity<String>("deleted", HttpStatus.OK);
	}

}
