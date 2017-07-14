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
	body {
		background-color: #fafafa;
	}
	#baner {
		background-image: url('/resource/imageIcon/bb2.png');
		background-repeat: no-repeat;
		background-size: 100%;
		height: 400px;
	}
	#banerContainer {
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
		 </div>
	 </div> 
	 <br>
	 <br>
	<!--  <div style="width: 100%;height: 400px">
 	<img src="/resource/imageIcon/bbbb.jpg" width="100%", height="100%"> 
	 
	 </div> -->
	
	<ul id="grid" class="grid effect-8">
	<c:forEach items="${boardList}" var="board" > 
		<li class="shown"><a href="/board/read?boardno=${board.boardno}" >
		
			<!-- 좋아요 , 댓글 개수 label -->
			<div class="listLabelContainer">
				<label class="listLabel"><span class="glyphicon glyphicon-heart listLabel" ></span> ${board.heartcnt} 개</label>
				<label class="listLabel"><span class="glyphicon glyphicon-comment listLabel" ></span> ${board.replycnt} 개</label>
			</div>
			<!-- 좋아요 , 댓글 개수 label -->
			<img src='/displayFile?fileName=${board.photo}' style="border-radius: 5px" width="100%" >
			<label style="width: 80%">${board.title}</label>
			</a>
		</li>
	</c:forEach> 
	</ul>
	
	<br>
	<br>
	<br>
	 <jsp:include page="footer.jsp" flush="false" />

	
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