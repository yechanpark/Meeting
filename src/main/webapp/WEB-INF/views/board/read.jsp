<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/latest/css/bootstrap.min.css">
	<script src="http://code.jquery.com/jquery-1.10.2.js"></script> 
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/latest/js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">

	body {
	background: #d4d6d8;
	}
	.container {
		background: white;
	 	padding: 2% 10%;
	}
	.glyphicon glyphicon-heart{
		background: white;
		color: white;
	}
	
	hr {
		border : 1px solid #d4d6d8;
	}
	
/* 	 .c1 {
		border-top: 1px solid gray;
		border-left: 1px solid gray; 
		border-right: 1px solid gray;
	}
	 .c2 {
		border-left: 1px solid gray; 
		border-right: 1px solid gray;
	}
	.c3 {
		border-left: 1px solid gray; 
		border-right: 1px solid gray;
	} */

</style>
</head>
<body>
	<div class="container">
		<div class="row c1">
			<label>${boardVO.username}</label>
			<br>
			<br>
			<label>${boardVO.title}</label>
			<hr>
		</div>
		<div class="row c2">
		  <img src='/displayFile?fileName=${boardVO.photo}' width="100%" height="600px"/>
		  	<hr>
		</div>
		<div class="row c3">
			
      		<a href="#" id="heartCancle" style="display:none;height: 50px"><img src="/resource/imageIcon/heartClick.ico"  width="40px" height="30px"></a>
			<br>
			<a href="#" id="heartClick"style="height: 50px"><img src="/resource/imageIcon/heartNoClick.png" width="40px" height="30px"></a>
			<br>
			<br>
			<br>
			<label>좋아요</label> 
			<label id="heartCnt">${boardVO.heartcnt}</label>
			<label>개</label>
			<br>
			<br>
			<input type="hidden" id="contentVal" value="${boardVO.content}">
			<label id="content"></label>
			<br>
			<br>
			<hr>
		</div>
		
		<div>
		<a href="#" id="modify">수정</a>
		<a href="#" id="delete">삭제</a>
		</div>
		
			
		<form action="" method="post">
			<input type="hidden" name="boardno" id="boardno" value="${boardVO.boardno}">
		</form>
			
	</div>


<!-- 실제로 댓글이 보이는 부분 -->
	<div id="replyarea"></div>
	 	
<script type="text/javascript">

$(document).ready(function(){
	var contentText =$("#contentVal").val().replace(/<s>/g," ").replace(/<e>/g,"\n");
	$("#content").text(contentText);
	$("#modify").click(function(event) {
		event.preventDefault(); //화면 링크 방지 
		$("form").attr("action","/board/modify");
		$("form").submit();
	});
	
	$("#delete").click(function(event) {
		event.preventDefault(); //화면 링크 방지 
		$("form").attr("action","/board/delete");
		$("form").submit();
	});
	
	$("#heartClick").click(function(event){
		event.preventDefault(); //화면 링크 방지 
		$('#heartClick').css("display","none"); 
	    $('#heartCancle').css("display","block"); 
	    var heartCnt = $("#heartCnt").text();
		heartCnt = parseInt(heartCnt)+1;
		$("#heartCnt").text(heartCnt);
		
		var boardno = $("#boardno").val();
		var username = "qjadud22";
		
	    $.ajax({
            url : "/board/heartClick",
            type : "post",
            data : {
              	boardno : boardno,
              	username : username
            },
            dataType : "text",
            success : function(result) {
         		if(result==="success"){
					console.log("success");
         		}else{
         			console.log("Fail");
         		}
            }
         });
	});
	
	
	$("#heartCancle").click(function(event){
		event.preventDefault(); //화면 링크 방지 
		$('#heartClick').css("display","block"); 
	    $('#heartCancle').css("display","none"); 
	    var heartCnt = $("#heartCnt").text();
		heartCnt = parseInt(heartCnt)-1;
		$("#heartCnt").text(heartCnt);
		
		var boardno = $("#boardno").val();
		var username = "qjadud22";
		
	    $.ajax({
            url : "/board/heartCancle",
            type : "post",
            data : {
              	boardno : boardno,
              	username : username
            },
            dataType : "text",
            success : function(result) {
         		if(result==="success"){
					console.log("success");
         		}else{
         			console.log("Fail");
         		}
            }
         });
		
	});
	
});


</script>
</body>
</html>