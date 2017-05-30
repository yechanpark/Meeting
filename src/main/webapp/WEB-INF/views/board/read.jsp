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

<h1>Board Read Page</h1>
<h1>${boardVO.boardno}</h1>
<h1>${boardVO.title}</h1>
<h1>${boardVO.username}</h1>
<h1>${boardVO.content}</h1>

<img src='/displayFile?fileName=${boardVO.photo}'class='boardImage'/>

</body>
</html>