<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/latest/css/bootstrap.min.css">
	<script src="http://code.jquery.com/jquery-1.10.2.js"></script> 
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/latest/js/bootstrap.min.js"></script>
	<!-- 스프링 시큐리티 ajax csrf설정 403에러  -->
	<meta name="_csrf" content="${_csrf.token}"/>
	<!-- default header name is X-CSRF-TOKEN -->
	<meta name="_csrf_header" content="${_csrf.headerName}"/>
	<!-- 스프링 시큐리티 ajax csrf설정 403에러  -->
		
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/header.jsp" flush="false" />
	<div class="container">
	<h1>modify Page</h1>
	<form method="post">
		<div class="row form-group">
			<div class="col-sm-1">
				<label>제목</label>
			</div>
			<div class="col-sm-11 ">
				<input class="form-control" type="text" name="title" value="${boardVO.title}">
			</div>
		</div>
		
		<hr>
		<div class="row form-group">
			<div class="col-sm-1">
				<label>내용</label>
			</div>
			<div class="col-sm-11">
				<textarea rows="20" cols="50" id="content" name="content"></textarea>
				<input type="hidden" id="contentVal" value="${boardVO.content}">
			</div>
		</div>
		
		<hr>
		<div class="row form-group">
			<div class="col-sm-1">
				<label for="file">사진</label>
			</div>
			<div class="col-sm-11">
				<input type='file' name="file" id="file" >
				<p class="help-block">수정하고싶은 사진을 올려주세요</p>
				<input type="hidden" name="photo" value="${boardVO.photo}">
			</div>
		</div>
		
		<div id="imageBox"> 
			<img src='/displayFile?fileName=${boardVO.photo}'class='boardImage'/>
		</div>
		<hr>
		

		<a href="#" id="modifyBtn">수정완료</a>
		<a href="#" id="modifyCancle">수정취소</a>
		<hr>
		
		<input type="hidden" id="firstphoto" value="${boardVO.photo}">
		<input type="hidden" name="boardno" id="boardno" value="${boardVO.boardno}">
		<input type="hidden" id="username" value="${pageContext.request.userPrincipal.name}">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>
	</div>
	<script type="text/javascript">
	$(document).ready(function(){
		
		$(function () {
			var token = $("meta[name='_csrf']").attr("content");
			var header = $("meta[name='_csrf_header']").attr("content");
			$(document).ajaxSend(function(e, xhr, options) {
				xhr.setRequestHeader(header, token);
			});
		});
		
 		 var firstImageUrl = $("#firstphoto").val();
		 var check =false;
		 var preUrl = "";
		 
		 var contentText =$("#contentVal").val().replace(/<s>/g," ").replace(/<e>/g,"\n"); //텍스트 엔터,띄어쓰기 처리 부분
		 $("#content").text(contentText);
		 
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