<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/resource/main.css" />
<link rel="stylesheet" type="text/css" href="/resource/overview.css" />

<style type="text/css">

.item {
  margin-bottom: 10px;
}


</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

</head>
<body>


	<div class="container1">
		<c:forEach items="${boardList}" var="board" > 
		<div class="item" style="width:20%;height: 300px">
			<a href="/board/read?boardno=${board.boardno}" style="width: 100%; height: 100%"><img src='/displayFile?fileName=${board.photo}' width="100%" height="100%"></a>
		</div>
		</c:forEach>
	</div>
	
	
	
	<a href="/board/register">글쓰기</a>
	

	<script src="http://code.jquery.com/jquery-1.10.2.js"></script> 
	<script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.min.js"></script>
	<script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.js"></script> -->
	<script src="/resource/wookmark.js"></script>
	<script type='text/javascript'>
	
	$(document).ready(function () { 
		$(".container1").masonry({ 
		itemSelector:'.item',
		columnWidth: 120
		}); 
	}); 
	

		</script>
			
</body>
</html>