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
}

.c1, .c2, .c3, .c4, .c5 {
  width: 100%;
  height: 200px;
/*   border: 1px solid gray; */
}

.c1, .c3, .c4, .c5 {
	padding: 0px 20px;
}
/* .c1 {
	height: 150px;
}	
.c2{
	height: 600px;
}

.c3{
	height: 200px;
} */
/* @media (min-width: 600px) {
   .c1 {
    width: 60%;
    -webkit-order: 2;
    order: 2;
  }
  .c2 {
    width: 40%;
    -webkit-order: 1;
    order: 1;
  }
  .c3 {
    width: 100%;
    -webkit-order: 3;
    order: 3;
  }
} */


@media (min-width: 800px) {
  .c2 {
  	  order: 2;
	  position: absolute;
	  float: left;
	  width: 60%;
	  height: 800px;
	  border-right: 1px solid #dee0e2
  }
  .c3{
  	order: 4;
  	height: 100px;
  	margin-left : 60%;
 	width: 40%;
 	border-bottom: 1px solid #dee0e2;
  }
  .c5{
  	order: 5;
  	height: 100px;
  	margin-left : 60%;
 	width: 40%;

  }
  .c4 {
  	order: 3;
    height: 500px;
 	margin-left : 60%;
 	width: 40%;
 	overflow:scroll; 
 	border-bottom: 1px solid #dee0e2;
  }
  .c1 {
  	order: 1;
  	height:100px;
  	margin-left : 60%;
  	width: 40%;
  	border-bottom: 1px solid #dee0e2;
  }
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
  	<br>
  	<br>
  	
  	<div class="boardBox" style="width: 80%;" >
			<div class="c1" >
				<label>${boardVO.username}</label> <br> <br> <label>${boardVO.title}</label>
			</div>
			<div class="c2">
			<img src='/displayFile?fileName=${boardVO.photo}' width="100%"
				height="800px" />
			</div>
			
			<div class="c3">
			<a href="#" id="heartCancle" style="display: none; color:red"><span class="glyphicon glyphicon-heart" style="font-size: 50px; "></span></a>
			<a href="#" id="heartClick" style="display: block; color: red"><span class="glyphicon glyphicon-heart-empty" style="font-size:50px;"></span></a>
			<br><label>좋아요</label>
			<label id="heartCnt">${boardVO.heartcnt}</label> <label>개</label> <br>
			
			</div>
			
			<div class="c4" >
			<br> <input type="hidden" id="contentVal"
				value="${boardVO.content}"> <label id="content"></label> <br>
			<br>
			
			<label>
				댓글
			</label>
			</div>
			
			<div class="c5">
				<input type="text" placeholder="댓글 달기..">
			</div>
			
		</div>
	<div  class="container" style="padding: 2% 10%;">
		
		
		<div class="row">
			<label>${boardVO.username}</label> <br> <br> <label>${boardVO.title}</label>
			<hr>
		</div>
		<div class="row">
			<img src='/displayFile?fileName=${boardVO.photo}' width="100%"
				height="600px" style="border-radius: 10px"/>
			<hr>
		</div>
		<div class="row">
			<a href="#" id="heartCancle" style="display: none; color:red"><span class="glyphicon glyphicon-heart" style="font-size: 50px; "></span></a>
			<a href="#" id="heartClick" style="display: block; color: red"><span class="glyphicon glyphicon-heart-empty" style="font-size:50px;"></span></a>
			
			<br><label>좋아요</label>
			<label id="heartCnt">${boardVO.heartcnt}</label> <label>개</label> <br>
			<br> <input type="hidden" id="contentVal"
				value="${boardVO.content}"> <label id="content"></label> <br>
			<br>
			<hr>
		</div>

		<div class="row">
			<!-- 댓글창 -->
			<table id='attacharea'>
				<thead>
					<tr>
						<td>글쓴이</td>
						<td>내용</td>
						<td></td>
					</tr>
				</thead>

				<tbody id='attacher'>

				</tbody>
			</table>

			<input id="inputReply" type="text" /> <input id="replyBtn"
				type="button" />

		</div>

		<br>
		<br>
		<br>
		<br>
		<br>
		<div>
			<!-- 게시판 주인과 로그인 유저의 아이디가 같을시 수정,삭제 버튼 활성화 -->
			<c:if
				test="${boardVO.username eq pageContext.request.userPrincipal.name}">
				<a href="#" id="modify">수정</a>
				<a href="#" id="delete">삭제</a>
			</c:if>
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
	</div>
	
		<br>
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
	$(document).ready(function(){
	
	var boardno = $("#boardno").val(); //게시판번호
	var username = $("#username").val();//username 
	
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
	

	roadReplies(); //get이니깐 문제가 없었고 
	
	if(username){
		console.log(username);
		//로그인 회원이 좋아요 체크했는지 
		heartCheck(username,boardno);
	}else{
		console.log("가입 없음");
	}

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
	
	
	/* @@@@@@@@@@@@@@@@@@@@@@@@@@@@@밑에서부터 예찬 소스 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*/
	
// 댓글 로드
function roadReplies(){
	
	$('#attacher').remove();
	
	var attacher = "<tbody id='attacher'></tbody>";
	$('#attacharea').append(attacher);
	//AJAX로 댓글 가져오는 JS
	$.ajax({
		type : 'GET', // GET방식으로 요청
		url : '/rest/reply/' + ${boardVO.boardno}, // Request보낼 URL
		dataType : 'json',
		success : function(response) {
			/* response 내용
			{
				"secretReplyCount":1,
				"replies":[
					{
						"boardno":99,
						"content":"asdasd",
						"parentno":0,
						"replydate":{...},
						"replyno":36,
						"username":"dpcks"
					},{...},{...}
				]
			}
			*/
			
			// 이 게시물에 대한 총 1차 댓글 갯수
			var secretReplyCount = response.secretReplyCount;
			
			for(var i in response.replies) {
				
				var replyno = response.replies[i].replyno;

				// 자바스크립트 객체를 id값이 'attacharea'인 태그의  innerHTML을 그림
				var newreply = "<tr id='tr"+ replyno + "'>"+
					"<td id='usernamearea" + replyno + "'></td>"+
					"<td id='contentarea"  + replyno + "'></td>"+
					"<td id='rereplyarea"  + replyno + "'></td>"+
					"</tr>";
					
				$('#attacher').append(newreply);
				
				// reply 3대 요소 글쓴이, 내용, 답글버튼
				var username = response.replies[i].username;
				var content = response.replies[i].content;
				var rereplyButton = document.createElement("input");
				rereplyButton.type="button";
				rereplyButton.value="댓글달기";
				
				$('#usernamearea'+ replyno).append(username);
				$('#contentarea' + replyno).append(content);
				
				$('#rereplyarea' + replyno).click(function (){createReply(replyno);});
				$('#rereplyarea' + replyno).append(rereplyButton);
				
			}
		},
		error : function() { // 실패시
			alert("reply load Failed!");
		}
	});
};
//댓글 등록 Request
function sendReply(content, parentno){
		var username = $("#username").val();
		var datas = {
						"reply" : {	
							"boardno" : ${boardVO.boardno},
							"username" : username,
							"content" : content
						},
						"parentno" : parentno
					};
		var jsonData = JSON.stringify(datas);
		
		$.ajax({
			method : 'POST',
			url : '/rest/reply/' + ${boardVO.boardno},
			data : jsonData,
			contentType: "application/json",
			success : function(response){
				roadReplies();
			},
			error : function(response){
				if(response.status == "409") // CONFLICT
					alert('이미 댓글을 달아서 안된다');
				else alert("sendReply실패");
			}
		});
		
		
};

// 댓글의 댓글 입력창 만드는 함수

function createReply(parentno){
	alert('createReply(' + parentno + ') 실행');
	// 2차 댓글 자리   ->   작업중
	var newReplyTr = "<tr>"
	+"<td> <input id=newReplyText type='text'> </td>"
	+"<td> <input id=newReplySubmit type='button' value='2차달기'> </td>"
	+ "</tr>";
	
	$('#tr'+parentno).append(newReplyTr);
	
	
	$('#newReplySubmit').click(function(){
		var content = $('#newReplyText').val();
		sendReply(content, parentno);
	});
	
};

// 1차 댓글 작성 후 request 버튼
$("#replyBtn").click(function(event) {
	var content = $("#inputReply").val();
	sendReply(content,null);
});
</script>
</body>
</html>