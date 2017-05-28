<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>Board Register Page</h1>

<!-- <form action="register" method="post">

	<input type="hidden" name="idkey"  value="2">
	<label>제목:</label>
	<input type="text" name="title">
	<br>
	<label>내용:</label>
	<textarea rows="10" cols="10">
	
	</textarea>
	<br>
	<label>사진:</label>
	<input type="text" name="photo">
	<input type="submit" value="등록">	
</form> -->

<button type="button" id="te">클릭</button>
<form id="imgUpload" action="uploadForm" method="post" enctype="multipart/form-data">
	<input type='file' name="file" id="file" onchange="getCmaFileView(this,'name')">
</form>

 	<script src="http://code.jquery.com/jquery-1.10.2.js"></script> 
 	<script>
		 $(document).ready(function(){
		
		     $("#file").change(function(event){
		    	 var files = event.originalEvent.dataTransfer.files;
		    	 var file = files[0];
		    	 console.log(file);
		    });
		
		});
 
 	</script>
</body>
</html>