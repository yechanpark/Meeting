package org.study.web;

import java.io.FileInputStream;
import java.io.InputStream;

import javax.annotation.Resource;

import org.apache.commons.io.IOUtils;
import org.meeting.util.MediaUtils;
import org.meeting.util.UploadFileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class UploadController {

	@Resource(name="boardUploadPath")  //servlet-context.xml 에서 생성한 Bean 폴더경로 주입
	private String boardUploadPath;
	
	
	@ResponseBody
	@RequestMapping(value="/uimageUpload", method=RequestMethod.POST,produces="text/plain;charset=UTF-8")
	public ResponseEntity<String> uimageUpload(MultipartFile file) throws Exception{
		
		System.out.println(file.getOriginalFilename());
		System.out.println(file.getSize());
		System.out.println(file.getContentType());
		
		return new ResponseEntity<String>(UploadFileUtils.uploadFile(boardUploadPath, file.getOriginalFilename(), file.getBytes()),HttpStatus.CREATED);
		
	}
	
	@ResponseBody
	@RequestMapping(value="/displayFile")
	public ResponseEntity<byte[]> displayFile(String fileName) throws Exception{
		System.out.println(fileName);
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
		
		
		MediaType mtype = MediaUtils.getMediaType(formatName);
		try {
			HttpHeaders headers = new HttpHeaders();
			in = new FileInputStream(boardUploadPath+fileName);
			headers.setContentType(mtype);
			
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in),headers,HttpStatus.CREATED);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		}finally {
			in.close();
		}
	
		return entity;
		
	}

	
}
