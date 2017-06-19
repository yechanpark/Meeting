<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<html>
<head>
	
	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/latest/css/bootstrap.min.css">
	<script src="http://code.jquery.com/jquery-1.10.2.js"></script> 
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/latest/js/bootstrap.min.js"></script>
	<script src="/resource/masonry.pkgd.min.js"></script>
	<link href="<c:url value="/resource/css/main.css" />" rel="stylesheet">

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style>
	#baner {
		background-image: url('/resource/imageIcon/meetingbaner.jpg');
		background-repeat: no-repeat;
		background-size: 2000px 100%;
		height: 100%;
	}
	#banerContainer {
		height: 600px;
	}
	.fontSizeup{
		font-size: 300%;
	}
	
	a{
		color: black;
	}

</style>
</head>
<body>
  <jsp:include page="header.jsp" flush="false" />
	<div id="banerContainer" class="row">
		<div id="baner" class="row">
			<div class="col-sm-10"></div>
			<div class="col-sm-2">
				<br>
				<br>
				<br>
		
				
			</div>
				
		 </div>
	
	 </div> 
	
	<ul id="grid" class="grid effect-8">
	<c:forEach items="${boardList}" var="board" > 
		<li class="shown"><a href="/board/read?boardno=${board.boardno}" >
		
			<!-- 좋아요 , 댓글 개수 label -->
			<div class="listLabelContainer">
				<label class="listLabel"><span class="glyphicon glyphicon-heart listLabel" ></span> ${board.heartcnt} 개</label>
				<label class="listLabel"><span class="glyphicon glyphicon-comment listLabel" ></span> ${board.replycnt} 개</label>
			</div>
			<!-- 좋아요 , 댓글 개수 label -->
			
			<img src='/displayFile?fileName=${board.photo}' style="border-radius: 5px">
			<label>${board.title}</label>
			</a>
		</li>
	</c:forEach> 
	</ul>
	
	<br>
	<br>
	<br>
	<br>
	<br>

	
	<!-- <script src="http://code.jquery.com/jquery-1.10.2.js"></script>  -->
	<script type="text/javascript">
	 $(document).ready(function (){  
		 
			setTimeout(function(){
				$(".grid").masonry({ 
					itemSelector:'.shown',
					columnWidth: 0
					}); 
				
			}, 1);
	 
	});  
	</script>
			
</body>
</html>