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
<h1>${boardVO.content}</h1>

<img src='/displayFile?fileName=${boardVO.photo}'class='boardImage'/>
<form action="" method="post">
	<input type="hidden" name="boardno" value="${boardVO.boardno}">
	<a href="#" id="modify">수정</a>
	<a href="#" id="delete">삭제</a>
</form>


<script type="text/javascript">

$(document).ready(function(){
	
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
});


</script>
</body>
</html>