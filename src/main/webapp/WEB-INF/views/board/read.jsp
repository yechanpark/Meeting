<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

	<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/latest/css/bootstrap.min.css">
	<script src="http://code.jquery.com/jquery-1.10.2.js"></script> 
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/latest/js/bootstrap.min.js"></script>
	<!-- 스프링 시큐리티 ajax csrf설정 403에러  -->
	<meta name="_csrf" content="${_csrf.token}" />
	<!-- default header name is X-CSRF-TOKEN -->
	<meta name="_csrf_header" content="${_csrf.headerName}" />
	<!-- 스프링 시큐리티 ajax csrf설정 403에러  -->
	
	
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>

body {
/* 	background-color: #fafafa; */
    box-shadow : rgba(0,0,0,0.5) 0 0 0 9999px;
	background: #f4f5f7;
	line-height: 20px;
}

#popupDiv {
	top : 0px;
	position: absolute;
	display: none; 
}
#popup_mask {
	position: fixed;
	width: 100%;
	height: 100%;
	top: 0px;
	left: 0px;
 	display: none; 
 	background-color:#000;
 	opacity: 0.8;
}


.glyphicon glyphicon-heart {
	background: white;
	color: white;
}

hr {
	border: 1px solid #d4d6d8;
}
.boardBox {
  display: -webkit-flex;
  display: flex;
  -webkit-flex-flow: row wrap;
  flex-flow: row wrap;
  position: relative;
  margin: auto;
  border: 1px solid #dee0e2;
  width: 100%;
  background-color: white;
 /*  overflow: hidden; */
}
/* .c1 {
	height: 20%;
	border-bottom: 1px solid #dee0e2;
} */
.c2 {
	/* min-height: 400px; */
/* 	height: 40%; */
	border-bottom: 1px solid #fafafa;
}

.c3 {
	height: 10%;
	border-bottom: 1px solid #fafafa;
}
.c4{
/* 	
	height: 30%;
	border-bottom: 1px solid #fafafa; */
}

.c5{
	height: 10%;
	border-bottom: 1px solid #fafafa;
}

.c1, .c2, .c3, .c4, .c5 {
  width: 100%;
/*   border: 1px solid gray; */
}

.c1, .c3, .c4, .c5 {
	padding: 0px 20px;
}

/* PC화면일시  */
@media (min-width: 800px) {  
	.boardBox {
	  max-width: 1000px;
	  height: 800px;
	}
  .c2 {
  	  order: 2;
	  position: absolute;
	  float: left;
	  width: 60%;
	  height: 100%;
	  text-align: center;
	
	  border-right: 1px solid #fafafa;
  }	
  .c1 {
  	order: 1;
  	height: 20%;
  	margin-left : 60%;
  	width: 40%;
  	padding: 0px 10px;
  	border-bottom: 1px solid #fafafa;
  }
  .c3{
 	position: relative;
  	order: 4;
  	height: 15%;
  	margin-left : 60%;
 	width: 40%;
 	border-bottom: 1px solid #fafafa;
 	padding: 0px 10px;
  }
  .c5{
  	order: 5;
  	height: 10%;
  	margin-left : 60%;
 	width: 40%;
	padding: 0px 10px;
  }
  .c4 {
  	order: 3;
    height: 60%;
  /* 	position: absolute; */
 	margin-left : 60%;
 	width: 40%;
 	overflow:scroll; 
 	border-bottom: 1px solid #fafafa;
 	overflow-x:hidden;
    padding: 0px 30px; 
  }

}
.replyTextArea {
	background: 0 0;
    border: none;
    color: #262626;
    font-size: inherit;
    outline: none;
    padding: 0;
    resize: none; 
    max-height: 60px;
/*     max-height: 200px; */
}
	
</style>
</head>
<body>
  	<br>
  	<br>
  	<br>
  	<br>
  	<br>
  	<div class="boardBox">
			<div class="c1" > <!-- 유저이름,타이틀 div -->
				<br>
				<div><img src="/displayFile?fileName=${boardVO.profileimage}" class="img-circle" width="80px" height="80px"> <label>${boardVO.displayname}</label> </div>
				<div><label>${boardVO.title}</label></div>
				<div>
				<!-- 게시판 주인과 로그인 유저의 아이디가 같을시 수정,삭제 버튼 활성화 -->
					<c:if
						test="${boardVO.username eq pageContext.request.userPrincipal.name}">
						<a href="#" id="modify">수정</a>
						<a href="#" id="delete">삭제</a>
					</c:if>
				</div>	
			</div>
		
			<div class="c2">
			    <img src="/displayFile?fileName=${boardVO.photo}" style="width: 100%; height: 100%; vertical-align: middle" />
			</div>
			
			<div class="c3">
				<a href="#" id="heartCancle" style="display: none; color:red"><span class="glyphicon glyphicon-heart" style="font-size: 50px; "></span></a>
				<a href="#" id="heartClick" style="display: block; color: red"><span class="glyphicon glyphicon-heart-empty" style="font-size:50px;"></span></a>
				<br><label>좋아요</label>
				<label id="heartCnt">${boardVO.heartcnt}</label> <label>개</label> <br>
			</div>
			
			<div class="c4" >
				<div>
					<label>${boardVO.username}</label>
				</div>
				<input type="hidden" id="contentVal" value="${boardVO.content}"> <span id="content"></span> <br>
				<br>
				<label> 댓글  </label>
				<!-- 댓글영역 -->
				<div id="replyArea" class="row">
				
					<c:choose>
						<c:when test="${not empty pageContext.request.userPrincipal.name}">
							<!-- 로그인한 사람이 댓글을 쓴 사람이거나 글을 쓴 사람이면 전부 보여줌  -->
							<c:forEach items="${replies}" var="reply">
								<c:choose>
									<c:when test="${reply.username eq pageContext.request.userPrincipal.name ||
											      boardVO.username eq pageContext.request.userPrincipal.name}">
								
										<div class="reply">
											<c:if test="${reply.parentno ne '0'}">
												<img style="margin-left:<c:out value='${20*(reply.depth)}'/>" src="/resource/imageIcon/rereplyIcon.jpg"/>
											</c:if>
											<input class="replyno" type="hidden" value="${reply.replyno}"/>
											<input class="parentno" type="hidden" value="${reply.parentno}"/>
											<input class="groupid" type="hidden" value="${reply.groupid}"/>
											<input class="seq" type="hidden" value="${reply.seq}"/>
											<img src="/displayFile?fileName=${reply.profileimage}" class="img-circle" width="40px" height="40px">
											<span class="username">${reply.username}</span>
											<span class="content">${reply.content}</span>
											<c:if test="${reply.username eq pageContext.request.userPrincipal.name}">
												<a href="#" class="replyModifyButton">수정</a>
												<a href="#" class="replyDeleteButton">삭제</a>
											</c:if>
											<a href="#" class="rereplyAddButton">답글</a>
											<div class="rereplyInputTextArea"></div>
										</div>
									</c:when>
									<c:otherwise>
										<p style="color:red">비밀댓글입니다</p>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</c:when>
						<c:otherwise>
							댓글은 로그인해야 볼 수 있습니다.
						</c:otherwise>
					</c:choose>
				</div>
				<!-- 댓글 끝 -->
			</div>
			
			<div class="c5">
<!-- 			<input id="inputReply" type="text" />  -->
			<textarea id="replyInput" class="replyTextArea" style="height: 20px" rows="2" cols="40" placeholder="댓글달기..."></textarea>
			<input id="replySend"type="button" value="등록"/>
			</div>
		
				
			
		</div>

		<form action="" method="post">
			<input type="hidden" name="boardno" id="boardno"
				value="${boardVO.boardno}"> <input type="hidden"
				name="${_csrf.parameterName}" value="${_csrf.token}" />
		</form>
		<input type="hidden" id="username"
			value="${pageContext.request.userPrincipal.name}">
		<!-- 현재 로그인 유저 아이디 -->
		<input type="hidden" id="boardUsername" value="${boardVO.username}">
		<!-- 게시판 주인 아이디 -->
		<br>
		<br>
		<br>
		<br>
	<br>
	<br>
	
	<div id ="popup_mask" class="popup">
	</div>
	<div id="popupDiv" style="height: 400px; width: 350px" class="popup">
		<img src="" id="popupImg" width="400px" height="350px">
		<button id="popCloseBtn">close</button>
	<!-- 	  	이미지 사이즈를 고정하거나 DIV를 고정 (수정사항 고민중) -->
	</div>	
	<img src="/displayFile?fileName=${boardVO.profileimage}" class="img-circle testimg" width="40px" height="40px">
				
	
	
	<br>
	<br>
	<br>
	<script type="text/javascript">
 
	 
	// 처리 도중 서버에 Request를 보내는 함수가 있다면 늦게 처리돼서 
	// 이 부분을 가장 먼저 수행(403 Forbidden 방지) 
	$(function () {
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$(document).ajaxSend(function(e, xhr, options) {
			xhr.setRequestHeader(header, token);
		});
	});
	
	var loadingImage;
	loadingImage = "<img id='loadingImage' src='${pageContext.request.contextPath}/resource/imageIcon/replyloading.gif'>";
	$(document).ready(function(){
	
	var boardno = $("#boardno").val(); //게시판번호
	var username = $("#username").val();//username 


	$(".replyTextArea").on('keydown keyup', function () {
 		adjustHeight();
	});
	var adjustHeight = function() {
		  var textEle = $(".replyTextArea")
		  var textEleHeight = $(".replyTextArea").prop('scrollHeight');
		  textEle.css('height', textEleHeight);
		};
	var contentText =$("#contentVal").val().replace(/<s>/g," ").replace(/<e>/g,"\n");
	$("#content").text(contentText);

	
	$("#modify").click(function(event) {
		event.preventDefault(); //화면 링크 방지 
		$("form").attr("action","/board/modify");
		$("form").submit();
	});
	
	$("#delete").click(function(event) {
		event.preventDefault(); //화면 링크 방지 
		$("form").attr("action","/board/delete");
		$("form").submit();
	});
	
	$("#heartClick").click(function(event){
		event.preventDefault(); //화면 링크 방지 
		if(username){
		$('#heartClick').css("display","none"); 
	    $('#heartCancle').css("display","block"); 
	    var heartCnt = $("#heartCnt").text();
		heartCnt = parseInt(heartCnt)+1;
		$("#heartCnt").text(heartCnt);
		
	    $.ajax({
            url : "/board/heartClick",
            type : "post",
            data : {
              	boardno : boardno,
              	username : username
            },
            dataType : "text",
            success : function(result) {
         		if(result==="success"){
					console.log("success");
         		}else{
         			console.log("Fail");
         		}
            }
         });
		}else{
			alert("로그인 해주세요");
		}
	});
	$("#heartCancle").click(function(event){
		event.preventDefault(); //화면 링크 방지 
		$('#heartClick').css("display","block"); 
	    $('#heartCancle').css("display","none"); 
	    var heartCnt = $("#heartCnt").text();
		heartCnt = parseInt(heartCnt)-1;
		$("#heartCnt").text(heartCnt);
		
	    $.ajax({
            url : "/board/heartCancle",
            type : "post",
            data : {
              	boardno : boardno,
              	username : username
            },
            dataType : "text",
            success : function(result) {
         		if(result==="success"){
					console.log("success");
         		}else{
         			console.log("Fail");
         		}
            }
         }); 
			
	});
	
	$(".testimg").click(function(event){
		console.log("클릭");
	
	 	$("#popupImg").attr('src',$(this).attr('src')); 
	 	
	 /* 	var tx = ($(window).width()-$("#popupDiv").width())/2;
	 	var ty = ($(window).height()-$("#popupDiv").height())/2; */
	 	
	 /* 	 $("#popupDiv").css({left:tx+"px",top:ty+"px"}); */
		 $("#popupDiv").css({
			"top": (($(window).height()-$("#popupDiv").outerHeight())/2+$(window).scrollTop())+"px",
			"left": (($(window).width()-$("#popupDiv").outerWidth())/2+$(window).scrollLeft())+"px"
		}); 
		
	    $("#popup_mask").css("display","block"); 
	    $("#popupDiv").css("display","block"); 
	    
		$("body").css("overflow","hidden");//스크롤바 없애기
	});
	
	$("#popCloseBtn").click(function(event){
		console.log("closeBtn 클릭");
		$("#popup_mask").css("display","none"); 
		$("#popupDiv").css("display","none"); 
		$("body").css("overflow","auto");//스크롤바 생성
	});
	
	$(".popup").click(function(event){
		console.log("closeBtn 클릭");
		$("#popup_mask").css("display","none"); 
		$("#popupDiv").css("display","none"); 
		$("body").css("overflow","auto");//스크롤바 생성
	});
	
	if(username){
		console.log(username);
		//로그인 회원이 좋아요 체크했는지 
		heartCheck(username,boardno);
	}else{
		console.log("가입 없음");
	}

	/* @@@@@@@@@@@@@@@@@@@@@@@@@@@@@밑에서부터 예찬 소스 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
	// 1차 댓글 작성 후 request 버튼
	$("#replySend").click(function() {
		if(username){
			var content = $("#replyInput").val();
			addReply(content, 0);
		} else alert('로그인 후 댓글 달것');
	});
	

	// 댓글 프레임 만들어서 리턴
	function getReplyFrame(reply){
			var replyFrame =
			"<div class='reply'>" +
				"<input class='replyno' type='hidden' value='" + reply.replyno + "'/>" +
				"<input class='parentno' type='hidden' value='" + reply.parentno + "'/>" +
				"<input class='groupid' type='hidden' value='" + reply.groupid + "'/>" +
				"<input class='seq' type='hidden' value='" + reply.seq + "'/>"; // 2-1-1-2 (seq = 4)
				
			if(reply.parentno != 0){
				var imageMarginLeft = reply.depth*20;
	 			replyFrame += "<img style='margin-left:" + imageMarginLeft + "' src='/resource/imageIcon/rereplyIcon.jpg'/>"; 
			}
			
			replyFrame += "<img src='/displayFile?fileName="+ reply.profileimage + "' class='img-circle' width='40px' height='40px'>";
			replyFrame += "<span class='username'> " + reply.username + "</span>";
			replyFrame += "<span class='content'> " + reply.content + "</span>";
			
			if(reply.username == '${pageContext.request.userPrincipal.name}'){
				replyFrame += "<a href='#' class='replyModifyButton'> 수정</a>";
				replyFrame += "<a href='#' class='replyDeleteButton'> 삭제</a>";
			}
			
			replyFrame += "<a href='#' class='rereplyAddButton'> 답글</a>";
			replyFrame += "<div class='rereplyInputTextArea'></div></div>";
			
			return replyFrame;
	};
	
	// 처음 버튼 + 동적 추가 버튼 까지 모두 설정, .rereplyAddButton class 속성을 가진 버튼이 this가 된다.
	$(document).on('click','.rereplyAddButton', function(){
		 // retrieve current state, initially undefined
	    var state = $(this).data('state');  
	    var textArea;
	    var sendButton;
	    
	    // toggle the state - first click will make this "true"
	    state = !state; 

	    // do your stuff
	    if (state) {
	    	textArea= $("<input/>", {type : "text"}); // 입력창 
	    	sendButton= $("<a>전송</a>", {href : "#"});// 전송버튼
	
			$(this).siblings(".rereplyInputTextArea").append(textArea);
			$(this).siblings(".rereplyInputTextArea").append(sendButton);
			
			$(this).siblings(".rereplyInputTextArea").children("a").click(function(){
				
				var content = $(this).siblings("input").val();
				var parentno = $(this).parent().siblings(".replyno").val();
					
		    	$(".rereplyInputTextArea").children("input").remove();
		    	$(".rereplyInputTextArea").children("a").remove();
		    	
				addReply(content, parentno);
			});
	    } else {
	    	$(this).siblings(".rereplyInputTextArea").children("a").remove();
	    	$(this).siblings(".rereplyInputTextArea").children("input").remove();
	    }

	    // put the state back
	    $(this).data('state', state);  
	});
	
	// 부모 append
	function appendParent(reply){
		var parentReply = getReplyFrame(reply);
		$("#replyArea").append(parentReply);
	};
	
	// 자식 append
	function appendChild(reply){
		var childReply = getReplyFrame(reply);
		var countGroupReplies = 0; // 같은 그룹의 기존 댓글의 갯수 (2-1-1-2가 올 땐 5개)
		var childReplies = $("#replyArea").children("div[class='reply']"); // 기존 댓글들
		
		// 전체 댓글 중 groupid가 같은 댓글의 갯수 카운트(count)
		$(childReplies).each(function(){
			var groupValue = $(this).children("input[class='groupid']").attr("value");
			if(groupValue == reply.groupid)
				countGroupReplies++;
		});
		
		
		/* 그룹 내 가장 마지막에 오는 경우  */
		// seq과 기존 댓글 갯수가 같으면 eq(seq-1)에서 insertAfter
		if( reply.seq == countGroupReplies ){
			alert('그룹 내 가장 마지막에 오는 경우');
			$(childReplies).each(function(){
				var groupValue = $(this).children("input[class='groupid']").attr("value");
				var seqValue = $(this).children("input[class='seq']").attr("value");
				
				if( (groupValue == reply.groupid) && (seqValue == (reply.seq-1)) )
					$(childReply).insertAfter(this);
				
			});
		}
		
		
		/* 그룹 내 중간에 오는 경우 */
		// seq와 기존 댓글 갯수가 다르므로 기존 댓글에서 seq이 현재 seq보다 큰 seq을 모두 증가 후 eq(seq)에서 insertBefore
		//           4 !=         5 
		else if( reply.seq != countGroupReplies ) { 
			$(childReplies).each(function(){
				var groupValue = $(this).children("input[class='groupid']").attr("value"); // 기존 댓글의 group값
				var seqValue = parseInt($(this).children("input[class='seq']").attr("value")); // 기존 댓글의 seq값
				
				// 같은 그룹 이면서 && 자신의 seq과 같거나 큰 seq값 모두 +1
														// 
				if( (groupValue == reply.groupid) && (seqValue >= reply.seq) )
					// 자바스크립트 변수에 parseInt를 쓰지 않으면 문자로 취급되어 제대로 계산되지 않는다. 변수의 값이 4라면 "4"+1 = "41"이 된다.
					$(this).children("input[class='seq']").attr("value", seqValue+1);
				
		
			});

			
			$(childReplies).each(function(){
				var groupValue = $(this).children("input[class='groupid']").attr("value");
				var seqValue = $(this).children("input[class='seq']").attr("value");
				// 자신의 seq보다 1 큰 것에서 insertBefore
				if( (groupValue == reply.groupid) && (seqValue == reply.seq+1) ){ 
					alert(reply.seq+1);
					$(childReply).insertBefore(this);
				}
			});

		}

	};
	
	// 댓글 추가  (댓글내용, 부모 댓글 번호)
	function addReply(content, parentReplyno){
			var datas = {
							"boardno" : '${boardVO.boardno}',
							"username" : '${pageContext.request.userPrincipal.name}',
							"content" : content,
							"parentno" : parentReplyno
						};
			
			$.ajax({
				method : 'post',
				url : '/rest/reply/',
				data : JSON.stringify(datas),
				contentType: "application/json",
				success : function(response){
					if(parentReplyno == 0)
						appendParent(response);
					else
						appendChild(response);
				},
				error : function(response){
					if(response.status == "409") // CONFLICT
						alert('이미 댓글을 달아서 안된다');
					else if(response.status == "400") // BAD_REQUEST
						alert('로그인해라');
					else
						alert("addReply실패");
				}
			});
	};    
	
	// 댓글 수정 -> 내용, 기본키 필요
	function updateReply(content, replyno){
		var datas = {
				"content" : content
		};
		
		$.ajax({
			method : 'PUT',
			url : '/rest/reply/' + replyno,
			data : JSON.stringify(datas),
			contentType: "application/json",
			success : function(){
				// (updateReply 성공) replyno에 해당하는 댓글 내용을 content로 변경
			},
			error : function(response){
				if(response.status == "409"); // CONFLICT
				else if(response.status == "400"); // BAD_REQUEST
				else alert("updateReply실패");
			}
		});
	};
	
	// 댓글 삭제
	function deleteReply(replyno){		
		$.ajax({
			method : 'DELETE',
			url : '/rest/reply/' + replyno,
			success : function(){
				// (deleteReply 성공) replyno에 해당하는 댓글 삭제
			},
			error : function(response){
				if(response.status == "409"); // CONFLICT
				else if(response.status == "400"); // BAD_REQUEST
				else alert("deleteReply실패");
			}
		});
	};
	
}); // $(document).ready(function(){...});

	//회원 좋아요 체크상태 확인
	function heartCheck(username,boardno) {
	 $.ajax({
        url : "/board/heartCheck",
        type : 'get',
        data : {
          	boardno : boardno,
          	username : username
        },
        dataType : "text",
        success : function(result) {
     		if(result==="check"){
     			$('#heartClick').css("display","none"); 
      		    $('#heartCancle').css("display","block"); 
     		}else{
     			console.log("NoCheck");
     		}
        }
     });	
}	 
</script>
</body>
</html>