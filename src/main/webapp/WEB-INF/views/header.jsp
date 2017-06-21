<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>

<style>
	/* 	Top Menu Bar CSS */
		.body-top {
		  padding-top: 240px;
		  
		}
		
		.body-bottom {
		  padding-top: 50px;
		  
		}

</style>
</head>
<body>
  <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
	  <div class="container">
        <div class="navbar-header">
    	   <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
			<span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">Hansung Meeting</a>
        </div>
        <div class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li><a href="/"><span class="glyphicon glyphicon-home"></span>Home</a></li>
            <li><a href="/board/register"><span class="glyphicon glyphicon-envelope"></span>글 등록</a></li>
          	<c:if test="${pageContext.request.userPrincipal.name != null }">
				<li><a href="/logout/"><span class="glyphicon glyphicon-info-sign"></span>로그아웃</a></li>
				<li><a href="/user/mypage/"><span class="glyphicon glyphicon-info-sign"></span>My Page</a></li>
			</c:if>
			<c:if test="${pageContext.request.userPrincipal.name == null }">
				 <li><a href="/login/"><span class="glyphicon glyphicon-info-sign"></span>Login</a></li>
			</c:if>
          </ul>
        </div>
      </div>
    </div>
</body>
</html>