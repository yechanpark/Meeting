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

	<div id="main" >
		<ul id="tiles" >
		<c:forEach items="${boardList}" var="board" > 
		<li><a href="/board/read?boardno=${board.boardno}"><img src='/displayFile?fileName=${board.photo}'class='boardImage'/></a> 
		<p>1</p>
		</li>
		</c:forEach>
		</ul>
	</div>
	
	<a href="/board/register">글쓰기</a>
	<script src="http://code.jquery.com/jquery-1.10.2.js"></script> 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.wookmark/2.1.2/wookmark.js"></script>
	<script type="text/javascript">
	 $(document).ready(function(){
	    var options = {
	    		  align: 'center',
	    		  autoResize: false,
	    		  comparator: null,
	    		  container: $('body'),
	    		  direction: undefined,
	    		  ignoreInactiveItems: true,
	    		  itemWidth: 0,
	    		  fillEmptySpace: false,
	    		  flexibleWidth: 0,
	    		  offset: 2,
	    		  onLayoutChanged: undefined,
	    		  outerOffset: 0,
	    		  possibleFilters: [],
	    		  resizeDelay: 50,
	    		  verticalOffset: undefined
	    		}

	    var handler = $("#tiles li"); 
	    handler.wookmark(options); 
	});
	 
	</script>

	
</body>
</html>