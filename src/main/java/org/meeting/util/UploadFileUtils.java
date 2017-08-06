package org.meeting.util;

import static org.hamcrest.CoreMatchers.nullValue;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.springframework.util.FileCopyUtils;

import com.drew.imaging.ImageMetadataReader;
import com.drew.imaging.ImageProcessingException;
import com.drew.metadata.Directory;
import com.drew.metadata.Metadata;
import com.drew.metadata.MetadataException;
import com.drew.metadata.exif.ExifIFD0Directory;


public class UploadFileUtils {
	
	 public static String uploadFile(String uploadPath, String originalName, byte[] fileData, String Mypath) throws Exception {
	      System.out.println("1");
		 UUID uid = UUID.randomUUID();
	      String savedName = uid.toString()+"_"+originalName;
	      System.out.println("2");
	      String savedPath = calcPath(uploadPath);
	      System.out.println("3");
	      File target = new File(uploadPath+savedPath,savedName);
	      System.out.println(savedName);
	      System.out.println(savedPath);
	      System.out.println("4");
	      String formatName = savedName.substring(savedName.lastIndexOf(".")+1);
	      System.out.println("5");
	      
	      BufferedInputStream bufferedIS = new BufferedInputStream(new ByteArrayInputStream(fileData));
	      ByteArrayInputStream byteIS = new ByteArrayInputStream(fileData);
	      BufferedImage buffredI = rotateImageForMobile(byteIS, getOrientation(bufferedIS));
	      System.out.println("6");
	      ImageIO.write(buffredI, formatName, target);
	      System.out.println("7");
	    // FileCopyUtils.copy(fileData, target);
	      //원본파일 생성
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
	

	 public static int getOrientation(BufferedInputStream is) throws IOException {
		 System.out.println("orientation 들어오나");
		 		Integer orientation = 1;
	               try {
	                     Metadata metadata = ImageMetadataReader.readMetadata(is);
	                     Directory directory = metadata.getDirectory(ExifIFD0Directory.class);
	                     System.out.println("orientation 들어오나2");
	                     try {
	                    	  System.out.println("orientation 들어오나 여기가 문제냐?");
	                    	  System.out.println("sdsd");
	                    	  System.out.println(directory);
	                    	  if(directory ==null){
	                    		  System.out.println("시발");
	                    	  }else{
	                    		  orientation = directory.getInt(ExifIFD0Directory. TAG_ORIENTATION);
	                    	  }
	                    	   
	                           System.out.println("orientation 들어오나 여기가 문제냐?2");
	                     } catch (MetadataException me) {
	                           System.out.println("Could not get orientation" );
	                     }
	              } catch (ImageProcessingException e) {
	                     e.printStackTrace();
	              }
	               System.out.println("orientation 들어오나3");
	               return orientation;
	       }
	 
	 public static BufferedImage rotateImageForMobile(InputStream is,int orientation) throws IOException {
		 System.out.println("rotateImageForMobile 들어오나");
            BufferedImage bi = ImageIO.read(is);

             if(orientation == 6){ //정위치

                    return rotateImage(bi, 90);

            } else if (orientation == 1){ //왼쪽으로 눞였을때

                    return bi;

            } else if (orientation == 3){//오른쪽으로 눞였을때

                    return rotateImage(bi, 180);

            } else if (orientation == 8){//180도

                    return rotateImage(bi, 270);      

            } else{

                    return bi;

            }       

     }
	 
	 public static BufferedImage rotateImage(BufferedImage orgImage,int radians) {
		 System.out.println("rotateImage 들어오나");
         BufferedImage newImage;

          if(radians==90 || radians==270){

                newImage = new BufferedImage(orgImage.getHeight(),orgImage.getWidth(),orgImage.getType());

         } else if (radians==180){

                newImage = new BufferedImage(orgImage.getWidth(),orgImage.getHeight(),orgImage.getType());

         } else{
        	 System.out.println("rotateImage 들어오나2");
                 return orgImage;

         }

         Graphics2D graphics = (Graphics2D) newImage.getGraphics();

         graphics.rotate(Math. toRadians(radians), newImage.getWidth() / 2, newImage.getHeight() / 2);

         graphics.translate((newImage.getWidth() - orgImage.getWidth()) / 2, (newImage.getHeight() - orgImage.getHeight()) / 2);

         graphics.drawImage(orgImage, 0, 0, orgImage.getWidth(), orgImage.getHeight(), null );

         

          return newImage;

  }
	
	 private static String makeThumbnail(String uploadPath, String path, String fileName, String Mypath) throws Exception { //썸네일 파일 생성
		  BufferedImage sourceImg = ImageIO.read(new File(uploadPath+path,fileName)); //원본 파일 읽기 
	      BufferedImage destImg = Scalr.resize(sourceImg, Scalr.Method.AUTOMATIC,400); //썸네일 설정후 변수 저장
	      String thumbnailName = uploadPath+path+File.separator+"s_"+fileName;  //썸네일 네임
	      File newFile = new File(thumbnailName);
	      String formatName = fileName.substring(fileName.lastIndexOf(".")+1); //file 확장자
	      ImageIO.write(destImg, formatName.toUpperCase(), newFile);
	      String orginalFileName =uploadPath+path+File.separator+fileName; //파일 오리지널 네임
	      
	      if(Mypath !=null){ //mypage에서 업로드하면 썸네일 경로 리턴
	         return thumbnailName.substring(uploadPath.length()).replace(File.separatorChar,'/');
	      }else{//mypage가 아니면  일반 파일 경로 리턴
	         return orginalFileName.substring(uploadPath.length()).replace(File.separatorChar,'/');
	      }
	   
	   }
	
}
