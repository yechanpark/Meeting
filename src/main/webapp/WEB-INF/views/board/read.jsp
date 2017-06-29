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
.c1 {
	height: 10%;
	border-bottom: 1px solid #dee0e2;
}
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
  	height: 15%;
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
    padding: 0px 10px; 
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
  	<jsp:include page="/WEB-INF/views/header.jsp" flush="false" /> 
  	<br>
  	<br>
  	<br>
  	<br>
  	<br>
  	<div class="boardBox">
			<div class="c1" > <!-- 유저이름,타이틀 div -->
				<br>
				<div><img src="/displayFile?fileName=${boardVO.profileimage}" class="img-circle" width="40px" height="40px"> <label>${boardVO.displayname}</label> </div>
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
				<div id='replyArea' class="row">
		
					<div id='replyShow'>
		
						글쓴이 내용 기능
		
						<!-- 현재 이 글에 있는 댓글들을 추가할 div-->
						<div id='replyAttacher'>
		
							<!-- 실제 reply들을 포함. (안쪽 행 하나하나는 div id='replyXXX') : 등록 후 HttpStatus.OK 를 받으면 Attach -->
							<div id='repliesArea'></div>
		
						</div>
		
		
					</div>
		
				</div>
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
	<br>
	<br>
	<br>
	<label>sssssssssss</label>
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

	// 1차 댓글 작성 후 request 버튼
	$("#replySend").click(function(event) {
		if(username){
			var content = $("#replyInput").val();
			sendReply(content, 0);} 
		else alert('어디 씨팔년이 로그인도안하고 댓글씨부리냐');
	});
	
	loadReplies();
	
	if(username){
		console.log(username);
		//로그인 회원이 좋아요 체크했는지 
		heartCheck(username,boardno);
	}else{
		console.log("가입 없음");
	}

	
	/* @@@@@@@@@@@@@@@@@@@@@@@@@@@@@밑에서부터 예찬 소스 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
	
	// 처음 게시물 열 때 댓글 로드
			function loadReplies(){
				
				// 댓글 전체 프레임 지움
				$('#repliesArea').remove();
				
				// 댓글 전체 프레임 생성
				var repliesArea = "<div id='repliesArea'> </div>";
				
				// 댓글 영역에 댓글 전체 프레임 붙임
				$('#replyAttacher').append(repliesArea);
				// 댓글 요청
				$.ajax({
					type : 'GET',
					url : '/rest/reply/' + '${boardVO.boardno}',
					dataType : 'json',
					data : {"boardHolder" : '${boardVO.username}'},
					success : function(response, httpstatus) {
						// 게시물에 댓글이 아예 없는 경우
						if(httpstatus == 'nocontent'){
							alert('댓글 없다');
							return 0;
						}
						
						/* response 내용
						{   
							"secretReplyCount":1,
							"replies":[{
									(replies[0] 내용)
									"boardno":99,
									"content":"asdasd",
									"parentno":0,
									"replydate":{...},
									"replyno":36,
									"username":"dpcks",
									"childReplies" :[
										{chuldReplies[0]...},
										{chuldReplies[1]...},
										{chuldReplies[2]...}
										]
									},
									{(replies[1] 내용 ...)}
							]
						}*/
						
						// 이 게시물에서의 비밀댓글 갯수(1차만 표현)
						var secretReplyCount = response.secretReplyCount;
						for(var i in response.replies) {
							
							// 1차 댓글의 번호, 댓글쓴이, 내용 
							var replyno = response.replies[i].parentReply.replyno;
							var username = response.replies[i].parentReply.username;
							var content = response.replies[i].parentReply.content;
							
							// '댓글달기' 버튼 생성
							var reReplyBtn = document.createElement("input");
							reReplyBtn.type="button";
							reReplyBtn.value="댓글달기";
							
							// 1차 댓글 프레임
							var newParentReply = "<div id='reply" + replyno + "'>"+
										    	"<span id='username'></span>"+
										   		"<span id='content'></span>"+
										  	 	"<span id='reReplyBtn'></span>"+
										  	 	"<div id='reReplyArea'></div>"+
										   "</div>";
								
							// 1차 댓글영역에 댓글 프레임을 달고
							$('#repliesArea').append(newParentReply);
							
							// 댓글 영역 -> 1차 댓글 프레임 -> 댓글쓴이,내용, 댓글달기 버튼 innerHTML 표시 및 이벤트 설정
							$('#repliesArea').children('#reply'+ replyno).children('#username').append(username);
							$('#repliesArea').children('#reply'+ replyno).children('#content').append(content);
							$('#repliesArea').children('#reply'+ replyno).children('#reReplyBtn').append(reReplyBtn);
							
							// 1차 댓글의 createReply()인자는 자기 자신의 번호
							$('#repliesArea').children('#reply'+ replyno).children('#reReplyBtn').click(function (){
								alert('부모 버튼');
								createReply(replyno);});
							
							// 만약 1차 댓글에 2차 댓글이 달렸으면(null이 아니면)
							if(response.replies[i].childReplies != null){
								// 모든 i번째 1차 댓글에 대한 2차 댓글을 돌면서
								for(var j in response.replies[i].childReplies) {
									// 2차 댓글의 번호, 댓글쓴이, 내용, 부모의 번호 저장
									var childReplyno = response.replies[i].childReplies[j].replyno;
									var childUsername = response.replies[i].childReplies[j].username;
									var childContent = response.replies[i].childReplies[j].content;
									
									// 2차 댓글 프레임
									var newChildReply = "<div id='reply" + childReplyno + "'>"+
												    	"<span id='username'></span>"+
												   		"<span id='content'></span>"+
												  	 	"<span id='reReplyBtn'></span>"+
												  	 	"<div id='reReplyArea'></div>"+
												   "</div>";
									// 댓글 영역 -> 1차 댓글 프레임 -> 2차 댓글 영역 -> 2차 댓글 프레임 달기
								   $('#repliesArea').find('#reply'+ replyno).children('#reReplyArea').append(newChildReply);
									
									// 댓글 영역 -> 1차 댓글 프레임 -> 2차 댓글 영역 -> 2차 댓글 프레임 -> 댓글쓴이,내용, 댓글달기 버튼 innerHTML 표시 및 이벤트 설정
								   $('#repliesArea').find('#reply'+ childReplyno).children('#username').append(childUsername);
								   $('#repliesArea').find('#reply'+ childReplyno).children('#content').append(childContent);
								   $('#repliesArea').find('#reply'+ childReplyno).children('#reReplyBtn').append(reReplyBtn);
								   
								   // 2차 댓글의 createReply()인자는 자신과 관계된 1차 댓글의 번호
								   $('#repliesArea').find('#reply'+ childReplyno).children('#reReplyBtn').click(function (){
									   alert('자식 버튼');
									   createReply(replyno);});
								}
							}
						}
					},
					error : function(response) { // 실패시
						alert("reply load Failed! " + response.status);
					}
				});
			}; // loadReplies()
			
			// 2차 댓글 입력창 만드는 함수
			// 1차 댓글 답글 -> 1차 댓글 번호가 인자
		    // 2차 댓글 답글 -> 2차 댓글과 연관된 1차 댓글의 번호가 인자
		    // 즉, 이 댓글이 만들어 질 때 무조건 parentno로 설정될 번호가 넘어온다.
			function createReply(parentno){
				// 2차 댓글 입력 프레임 생성
				var childReplyInput = "<div id='inputReply'>"
				+ "<input id=newReplyText type='text'/>"
				+ "<input id=newReplySubmit type='button' value='2차달기'/>"
				+ "</div>";
				
				$('#repliesArea').find('#inputReply').remove();
				// 2차 댓글 입력 프레임 1차 댓글 맨 아래(2차 댓글 여러개 있으면 그 중 맨 아래)에 삽입
				$('#reply'+parentno).children('#reReplyArea').append(childReplyInput);
				
				// 2차 댓글 입력 프레임에서 버튼 가져옴
				var sendBtn = $('#reply'+parentno).children('#reReplyArea').children('#inputReply').children('#newReplySubmit');
				
				// 버튼에 리스너 설정
				sendBtn.click(function(){
					var content = $('#reply'+parentno).children('#reReplyArea').children('#inputReply').children('#newReplyText').val();
					sendReply(content, parentno);
				});
				
				
			}; // createReply()
		
		
			// 댓글 등록 요청  (댓글내용, 루트 댓글 번호(1차 댓글은 0))
			function sendReply(content, parentno){
					var datas = {
									"reply" : {	
										"boardno" : '${boardVO.boardno}',
										"username" : username,
										"content" : content
									},
									"parentno" : parentno
								};
					var jsonData = JSON.stringify(datas);
					
					$.ajax({
						method : 'POST',
						url : '/rest/reply/' + '${boardVO.boardno}',
						data : jsonData,
						contentType: "application/json",
						success : function(response){
							loadReplies();
						},
						error : function(response){
							if(response.status == "409") // CONFLICT
								alert('이미 댓글을 달아서 안된다');
							else if(response.status == "400") // BAD_REQUEST
								alert('로그인해라');
							else alert("sendReply실패");
						}
					});
			};  
});
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