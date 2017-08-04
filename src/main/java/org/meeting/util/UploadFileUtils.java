package org.meeting.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.util.FileCopyUtils;


public class UploadFileUtils {
	
	 public static String uploadFile(String uploadPath, String originalName, byte[] fileData, String Mypath) throws Exception {
	      UUID uid = UUID.randomUUID();
	      String savedName = uid.toString()+"_"+originalName;
	      String savedPath = calcPath(uploadPath);
	      File target = new File(uploadPath+savedPath,savedName);
	      FileCopyUtils.copy(fileData, target);
	      String uploadedFileName = makeThumbnail(uploadPath, savedPath, savedName, Mypath);
	      return uploadedFileName;
	}
	 				
	private static String calcPath(String uploadPath) {  //오늘 날짜의 폴더 생성을 위해 날짜 계산 
		Calendar cal = Calendar.getInstance();
		String yearPath = File.separator+cal.get(Calendar.YEAR);
		
		String monthPath = yearPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.MONTH)+1);
		
		String datePath = monthPath + File.separator + new DecimalFormat("00").format(cal.get(Calendar.DATE));
		
		makeDir(uploadPath,yearPath,monthPath,datePath);
		
		
		
		return datePath;
	}

	private static void makeDir(String uploadPath,String...paths) {
		if(new File(paths[paths.length-1]).exists()){  //기존 날짜의 폴더가 있다면 return
			return;
		}
		for(String path: paths){
			
			File dirPath = new File(uploadPath+path);
			
			if(! dirPath.exists()){ //기존 날짜의 폴더가 없다면 폴더 생성
				dirPath.mkdir(); 
			}
		}
		// TODO Auto-generated method stub
	}
	
	 private static String makeThumbnail(String uploadPath, String path, String fileName, String Mypath) throws Exception {
	      BufferedImage sourceImg = ImageIO.read(new File(uploadPath+path,fileName));
	      BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC,400);
	      String thumbnailName = uploadPath+path+File.separator+"s_"+fileName;  //썸네일 네임
	      File newFile = new File(thumbnailName);
	      String formatName = fileName.substring(fileName.lastIndexOf(".")+1);
	      ImageIO.write(destImg, formatName.toUpperCase(), newFile);
	      String orginalFileName =uploadPath+path+File.separator+fileName; //파일 오리지널 네임
	      
	      if(Mypath !=null){ //mypage에서 업로드하면 썸네일 경로 리턴
	         return thumbnailName.substring(uploadPath.length()).replace(File.separatorChar,'/');
	      }else{//mypage가 아니면  일반 파일 경로 리턴
	         return orginalFileName.substring(uploadPath.length()).replace(File.separatorChar,'/');
	      }
	   
	   }
	
}
