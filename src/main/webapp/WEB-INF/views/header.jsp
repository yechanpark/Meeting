<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<html>
<head>
<meta name="viewport" content="width=device-width">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
	
</style>
</head>
<body>
	
  <div class="navbar navbar-inverse navbar-fixed-top" role="navigation" style="background-color: #ffffff; border-bottom: 1px solid #c4c4c4;">
	  <div class="container" style="background-color: #ffffff; border-color: #ffffff;">
        <div class="navbar-header">
    	   <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
			<span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="/"><img alt="NewFace" src="/resource/imageIcon/headerAndHome/headerLogo.png" style="height:100%;" /></a>
        </div>
        <div class="collapse navbar-collapse">
        	
          <ul class="nav navbar-nav navbar-right">
          	<c:if test="${pageContext.request.userPrincipal.name != null }">
          		<li><a href="/board/register"><span class="glyphicon glyphicon-pencil"></span> 글 등록</a></li>
				<li><a href="/user/mypage/">My Page</a></li>
				<li><a href="/logout/"><span class="glyphicon glyphicon-off"></span> 로그아웃</a></li>
			</c:if>
			<c:if test="${pageContext.request.userPrincipal.name == null }">
				 <li><a href="/login/">로그인</a></li>
			</c:if>
          </ul>
        </div>
      </div>
    </div>
</body>
</html>