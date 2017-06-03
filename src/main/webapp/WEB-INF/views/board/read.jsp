<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="http://code.jquery.com/jquery-1.10.2.js"></script> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>Board Read Page</h1>
<h1>${boardVO.boardno}</h1>
<h1>${boardVO.title}</h1>
<h1>${boardVO.username}</h1>
<input type="hidden" id="contentVal" value="${boardVO.content}">
<textarea rows="20" cols="70" id="content"></textarea>

<img src='/displayFile?fileName=${boardVO.photo}'class='boardImage'/>
<form action="" method="post">
	<input type="hidden" name="boardno" value="${boardVO.boardno}">
	<a href="#" id="modify">수정</a>
	<a href="#" id="delete">삭제</a>
</form>

<!-- 실제로 댓글이 보이는 부분 -->
	<div id="replyarea"></div>
	 
	
<script type="text/javascript">

$(document).ready(function(){
	var contentText =$("#contentVal").val().replace(/<s>/g," ").replace(/<e>/g,"\n");
	$("#content").val(contentText);
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
	
	
	
	/*댓글  아작스로 가져오는 부분  */
	$.ajax({
		type : 'GET', // GET방식으로 요청
		url : '/rest/reply/' + ${boardVO.boardno}, // Request보낼 URL
		success : function(data) { // 성공적으로 수행 시 response를 data라는 인자로 받는다.
			//자바스크립트 객체에 data의 0번째 배열에서 content에 해당하는 텍스트값을 저장
			var description = $('<p>').text(data[0].content);
			// 자바스크립트 객체를 id값이 'replyarea'인 태그에 html을 그림
			$('#replyarea').append(description); 
		},
		error : function() { // 실패시
			alert("AJAX 댓글 실패 씨발!");
		}
	});
	
});


</script>
</body>
</html>