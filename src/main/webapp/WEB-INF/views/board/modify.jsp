<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-1.10.2.js"></script> 
<title>Insert title here</title>
</head>
<body>
<h1>modify Page</h1>
	<form method="post">
		<label>제목:</label>
		<input type="text" name="title" value="${boardVO.title}">
		<br>
		<label>내용:</label>
		<textarea rows="20" cols="70" name="content">
		${boardVO.content}
		</textarea>
		<br>
		<label>사진:</label>
		<div id="imageBox"> 
			<img src='/displayFile?fileName=${boardVO.photo}'class='boardImage'/>
		</div>
	
		<br>
		<input type='file' name="file" id="file" >
		<br>
		<br>
		<input type="hidden" name="photo">

		<a href="#" id="modifyBtn">수정완료</a>
		<a href="#" id="modifyCancle">수정취소</a>
		<input type="hidden" id="firstphoto" value="${boardVO.photo}">
		<input type="hidden" name="boardno" id="boardno" value="${boardVO.boardno}">
		<input type="hidden" name="username"  value="qjadud22">
	</form>
	
	<script type="text/javascript">
	$(document).ready(function(){
 		 var firstImageUrl = $("#firstphoto").val();
		 var check =false;
		 var preUrl = "";
	
	     $("#file").change(function(){
	    	 console.log("sss");
	    	 var formData = new FormData();
	         formData.append("file", $("input[name=file]")[0].files[0]);//파일의 정보를 formData에 삽입 
	        
	         $.ajax({ //image 파일 폴더에 생성
	             type : "post",
	             url : "/imageUpload",
	             dataType : "text",
	             data : formData,
	             processData : false,
	             contentType : false,
	             success : function(imgPath) {
	                if(imgPath) {
	                	if(check){
	                		imageDelete(preUrl,imgPath);
	                	 	$("input[name=photo]").val(imgPath);
	                     	preUrl = imgPath;
	                	}else{
	                		check = true;
	                	 	preUrl = imgPath;
		                	var str = "<img src='/displayFile?fileName="+imgPath+"'class='boardImage'/>";
		                	$("input[name=photo]").val(imgPath);
		                	$("#imageBox").empty(); //imageBox 안에 태그 비우기 
		                	$("#imageBox").append(str);
	                	}
	                } else {
	                   alert("Image File please");
	                }
	             }
	          });
	    });
		
	    function imageDelete(preUrl,imgPath) {
			console.log("imgPath"+imgPath);
			console.log("preUrl"+preUrl);
	         $.ajax({
	            url : "/deleteFile",
	            type : "post",
	            data : {
	               fileName : preUrl
	            },
	            dataType : "text",
	            success : function(result) {
	               $("#imageBox").empty(); //imageBox 안에 태그 비우기 
                	var str = "<img src='/displayFile?fileName="+imgPath+"'class='boardImage'/>";
                	$("#imageBox").append(str);
	            }
	         });
	      };
	      $("#modifyBtn").click(function(event){ //수정완료시
	  		event.preventDefault(); //화면 링크 방지 
	  		//기존 사진 삭제 
	  		$.ajax({
	              url : "/deleteFile",
	              type : "post",
	              data : {
	                 fileName : firstImageUrl
	              },
	              dataType : "text",
	              success : function(result) {
	             	if(result){
	             		$("form").attr("action","/board/modifyComplete");
	          			$("form").submit();	
	             	}
	              }
	           });
	  	});
	  	$("#modifyCancle").click(function(event){ //수정취소시
	  		event.preventDefault(); //화면 링크 방지 
	  		if(check){ //기존 사진 변화가 있으면
	  	 		$.ajax({
		              url : "/deleteFile",
		              type : "post",
		              data : {
		                 fileName : preUrl
		              },
		              dataType : "text",
		              success : function(result) {
		             	if(result){
		             		 var url = "/";
		                     $(location).attr('href', url);
		             	}
		              }
		           });
	  		}else{//기존 사진 변화가 없으면 
	  			 var url = "/";
                 $(location).attr('href', url);
	  		}
		});
	});
	
	
		
	
	
	</script>
</body>
</html>