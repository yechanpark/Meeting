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
<style type="text/css">

.glyphicon glyphicon-heart {
	background: white;
	color: white;
}

hr {
	border: 1px solid #d4d6d8;
}


</style>
</head>
<body>
  	<jsp:include page="/WEB-INF/views/header.jsp" flush="false" />
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
	
function roadReplies(){
	
	$('#attacher').remove();
	
	var attacher = "<tbody id='attacher'></tbody>";
	$('#attacharea').append(attacher);
	//AJAX로 댓글 가져오는 JS
	$.ajax({
		type : 'GET', // GET방식으로 요청
		url : '/rest/reply/' + ${boardVO.boardno}, // Request보낼 URL
		dataType : 'json',
		success : function(replies) { // 성공적으로 수행 시 response를 data라는 인자로 받는다.
			
			for(var index in replies) {
				
				// 자바스크립트 객체를 id값이 'attacharea'인 태그의  innerHTML을 그림
				var newreply = "<tr id='tr"+ replies[index].replyno + "'>"+
					"<td id='usernamearea" + replies[index].replyno + "'></td>"+
					"<td id='contentarea"  + replies[index].replyno + "'></td>"+
					"<td id='rereplyarea"  + replies[index].replyno + "'></td>"+
					"</tr>";
					
				$('#attacher').append(newreply);
				
				// reply 3대 요소 글쓴이, 내용, 답글버튼
				var username = replies[index].username;
				var content = replies[index].content;
				var rereply = "<input type='button' value='댓글달기' onlclick='createReply(" + replies[index].replyno + ")'/>";
				
				$('#usernamearea'+replies[index].replyno).append(username);
				$('#contentarea' +replies[index].replyno).append(content);
				$('#rereplyarea' +replies[index].replyno).append(rereply);
			}
		},
		error : function() { // 실패시
			alert("reply load Failed!");
		}
	});
};

//'답글'버튼을 눌렀을 때 새로운 댓글창을 여는 함수.
//자기자신의 인덱스 번호가 인자로 넘어오며 이를 자식 댓글의 외래키로 설정해야함
//작업중
function createReply(replyno){
	/*  replyno == 1이라고 가정
	<table>
		<thead>
			<tr>
				<td>작성자
				<td>내용
				<td></td>
			</tr> 
		</thead>

		<tbody id='attacharea'>
			<tr id="tr1">
				<td id="usernamearea1"> 리플1 작성자
				<td id="contentarea1"> 리플1 내용
				<td id="rereplyarea1"> <input type='button' value='댓글달기' onlclick='createReply(1)'/> </td>
			</tr>
		</tbody>
	</table>
	*/
	
	var thisReplyTrTag = document.getElementById("tr"+replyno);
	var table = thisReplyTrTag.parentElement;
	
	// 새로운 댓글창 전체
	var replyObject = document.createElement("tr");
	
	// 텍스트 입력창 자리, 댓글 전송버튼 자리
	var replyTextField = document.createElement("td");
	var replyButtonField = document.createElement("td");
	
	// 텍스트 입력창
	var replyTextInput = document.createElement("input");
	replyTextInput.type="text";
	// 전송버튼
	var replyRequestButton = document.createElement("input");
	replyRequestButton.type="button";
	replyRequestButton.onclick = "sendReply("+replyTextInput.value+","+replyno+")";
	
	alert(this);
	replyObject.append(replyTextField);
	replyObject.append(replyButtonField);
	replyTextField.append(replyTextInput);
	replyButtonField.append(replyRequestButton);
	
	table.append(replyObject);
};

//'댓글확인'버튼을 눌렀을 때 Request보내는 함수
//http://blog.naver.com/brilliantjay/220959677882 참조
function sendReply(content, parentno){
		var username = $("#username").val();
		var datas = {"reply" : {
							replyno : null,
							boardno : '${boardVO.boardno}',
							username : username,							
							content : content 
					},
					"parentno" : parentno
		};
		var jsonData = JSON.stringify(datas);
		
		$.ajax({
			method : 'POST',
			url : '/rest/reply/'+ ${boardVO.boardno},
			data : jsonData,
			contentType: "application/json",
			success : function(){
				roadReplies();
			},
			error : function(){alert("sendReply실패")}
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