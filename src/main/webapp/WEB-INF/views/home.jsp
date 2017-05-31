<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<html>
<head>
<style type="text/css">
  * {
        -webkit-box-sizing: border-box;
        -moz-box-sizing: border-box;
        box-sizing: border-box;
      }

      .item {
        width:  150px;
        height: 150px;
        float: left;
        background: #2296DD;
      }

      .item.thumbnail {
        width:  200px;
        height: 200px;
        background: #cfcfcf
      }

      .item.medium {
        width:  250px;
        height: 150px;
        background: #A6E392
      }

      .item.large {
        width:  300px;
        height: 200px;
        background: #D092E3
      }

</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

</head>
<body>


	<div class="container1">
		<c:forEach items="${boardList}" var="board" > 
		  <div class="item"><a href="/board/read?boardno=${board.boardno}" style="width: 100%; height: 100%"><img src='/displayFile?fileName=${board.photo}' width="100%" height="100%"></a></div>
      <div class="item">
      <a href="/board/read?boardno=${board.boardno}" style="width: 100%; height: 100%"><img src='/displayFile?fileName=${board.photo}' width="100%" height="100%"></a>
      </div>
      <div class="item thumbnail">
      <a href="/board/read?boardno=${board.boardno}" style="width: 100%; height: 100%"><img src='/displayFile?fileName=${board.photo}' width="100%" height="100%"></a>
      </div>
      <div class="item medium">
      <a href="/board/read?boardno=${board.boardno}" style="width: 100%; height: 100%"><img src='/displayFile?fileName=${board.photo}' width="100%" height="100%"></a>
      </div>
      <div class="item">
      <a href="/board/read?boardno=${board.boardno}" style="width: 100%; height: 100%"><img src='/displayFile?fileName=${board.photo}' width="100%" height="100%"></a>
      </div>
      <div class="item large">
      <a href="/board/read?boardno=${board.boardno}" style="width: 100%; height: 100%"><img src='/displayFile?fileName=${board.photo}' width="100%" height="100%"></a>
      </div>
      <div class="item">
      <a href="/board/read?boardno=${board.boardno}" style="width: 100%; height: 100%"><img src='/displayFile?fileName=${board.photo}' width="100%" height="100%"></a>
      </div>
      <div class="item medium">
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
		columnWidth: 0
		}); 
	}); 

		</script>
			
</body>
</html>