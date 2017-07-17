<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/latest/css/bootstrap.min.css">
	<script src="http://code.jquery.com/jquery-1.10.2.js"></script> 
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/latest/js/bootstrap.min.js"></script>
	<!-- 스프링 시큐리티 ajax csrf설정 403에러  -->
	<meta name="_csrf" content="${_csrf.token}"/>
	<!-- default header name is X-CSRF-TOKEN -->
	<meta name="_csrf_header" content="${_csrf.headerName}"/>
	<!-- 스프링 시큐리티 ajax csrf설정 403에러  -->
		
	
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style>
body {
	background-color: #fafafa;
}
.registerBox {
	background-color: white;
}
</style>
</head>
<body style="#fafafa">
	<jsp:include page="/WEB-INF/views/header.jsp" flush="false" />
	<br>
	<br>
	<br>
	<div class="container registerBox" style="border: 1px solid gray; padding: 60px">
	<h1>Board Register Page</h1>
	<br>
	<form action="register" method="post">
	
	<input type="hidden" name="username" id="username" value="${pageContext.request.userPrincipal.name}">
	
	<div class="row form-group">
		<div class="col-sm-1">
			<label>제목</label>
		</div>
		<div class="col-sm-11 ">
			<input class="form-control" type="text" name="title">
		</div>
	</div>
	<hr>
	<div class="row form-group">
		<div class="col-sm-1">
			<label>내용</label>
		</div>
		<div class="col-sm-11">
			<textarea rows="15" cols="50" id="content" name="content"></textarea>
		</div>
	</div>
	<hr>
	<div class="row form-group">
		<div class="col-sm-1">
			<label for="file">사진</label>
		</div>
		<div class="col-sm-11">
			<input type='file' name="file" id="file" accept="image/*" capture="gallery" >
			<p class="help-block">보여주고싶은 사진을 올려주세요</p>
			<input type="hidden" name="photo">
		</div>
	</div>
	
	<div id="imageBox"> 
		
	</div>
	<hr>
		<button type="button" id="registerBtn">등록</button>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>
	
	
	</div>
	
	
 	<script src="http://code.jquery.com/jquery-1.10.2.js"></script> 
 	<script>
		 $(document).ready(function(){
				$(function () {
					var token = $("meta[name='_csrf']").attr("content");
					var header = $("meta[name='_csrf_header']").attr("content");
					$(document).ajaxSend(function(e, xhr, options) {
						xhr.setRequestHeader(header, token);
					});
				});
			 var check = false;
			 var preUrl = "";
		
			 $("#registerBtn").click(function(){

				 var content = $('#content').val().replace(/\n/g,'<e>').replace(/ /g,"<s>");
				 $("#content").val(content);
				 $("form").submit();		 
			});
			 
			 
			/* 이미지 처리 부분  */
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
		                if (imgPath) {
		                	if(check){
		                		imageDelete(preUrl,imgPath);
		                	 	$("input[name=photo]").val(imgPath);
		                     	preUrl = imgPath;
		                	}else{
		                		check = true;
		                	 	preUrl = imgPath;
			                	var str = "<img src='/displayFile?fileName="+imgPath+"'class='img-thumbnail'/>";
			                	$("input[name=photo]").val(imgPath);
			                	$("#imageBox").append(str);
		                	}
		                } else {
		                   alert("Image File please");
		                }
		             }
		          });
		    });
		     
		    function imageDelete(preUrl,imgPath) { //이미지 삭제 
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
	                	var str = "<img src='/displayFile?fileName="+imgPath+"' class='img-thumbnail' />";
	                	$("#imageBox").append(str);
		            }
		         });
		      };
		      
		         
		/* 이미지 처리 부분  */
		});
 
 	</script>
</body>
</html>