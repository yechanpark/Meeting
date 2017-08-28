<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<html>
<head>
	
	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/latest/css/bootstrap.min.css">
	<script src="http://code.jquery.com/jquery-1.10.2.js"></script> 
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/latest/js/bootstrap.min.js"></script>
	<script src="/resource/masonry.pkgd.min.js"></script>
	<link href="<c:url value="/resource/css/main.css"/>" rel="stylesheet"/>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Insert title here</title>

<style>
	body {
		background-color: #fafafa;
	}
	#banerContainer {
	}
	.fontSizeup{
		font-size: 300%;
	}
</style>
</head>
<body >

<div class="row" style="margin-top: 90px">
	<div class="col-sm-3">	
	</div>
	<div class="col-sm-6 text-center">
		<p><img alt="mainLogo" src="/resource/imageIcon/headerAndHome/mainLogo.png" style="width:30%"></p>
		<h3>Yes I want some newface !</h3>
		<h3><b>'뉴페이스'</b>는 오직 한성대학교 학생들만의 익명 <b>'미팅'</b> 서비스입니다.</h3>	
	</div>
	<div class="col-sm-3">	
	</div>
 </div> 

	<div style="min-height: 600px; padding: 100px 0px;"> 
	<ul id="grid" class="grid effect-8">
	<c:forEach items="${boardList}" var="board" > 
		<li class="shown"><a href="/board/read?boardno=${board.boardno}" style="padding:0px">
		
			<!-- 좋아요 , 댓글 개수 label -->
			<div class="listLabelContainer">
				<label class="listLabel"><span class="glyphicon glyphicon-heart listLabel" ></span> ${board.heartcnt} 개</label>
				<label class="listLabel"><span class="glyphicon glyphicon-comment listLabel" ></span> ${board.replycnt} 개</label>
			</div>
			<!-- 좋아요 , 댓글 개수 label -->
			<div style="width: 100%; background-color: black;" >
				<img class="mainBoardImage" src='/displayFile?fileName=${board.photo}' style="border-radius: 5px" width="100%" >
			</div>
			<label style="width: 80%">${board.title}</label>
			</a>
		</li>
	</c:forEach> 
	</ul>
	
 </div> 
	
	
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
	
	<script>
	 $(document).ready(function (){  
			setTimeout(function(){
				$(".grid").masonry({ 
					itemSelector:'.shown',
					columnWidth: 40
					}); 
				
			}, 0.5);
	 
	});  
	</script>
			
</body>
</html>