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

<h1>home</h1>


<h3>게시판</h3>
	<div>
		<c:forEach items="${boardList}" var="board" > 
		<a href="/board/read?boardno=${board.boardno}">${board.title}</a>
		<br>
		<br>
		</c:forEach>
	</div>
	
	<a href="/board/register">글쓰기</a>
	
</body>
</html>