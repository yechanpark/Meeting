<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<html>
<head>
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/latest/css/bootstrap.min.css">
   <script src="http://code.jquery.com/jquery-1.10.2.js"></script> 
   <script src="//maxcdn.bootstrapcdn.com/bootstrap/latest/js/bootstrap.min.js"></script>
  <link href="<c:url value="/resource/css/main.css" />" rel="stylesheet">
   <!-- 스프링 시큐리티 ajax csrf설정 403에러  -->
   <meta name="_csrf" content="${_csrf.token}"/>
   <!-- default header name is X-CSRF-TOKEN -->
   <meta name="_csrf_header" content="${_csrf.headerName}"/>
   <!-- 스프링 시큐리티 ajax csrf설정 403에러  -->
<title>Insert title here</title>
	<style>
/* 	#profileBox {
		text-align: center;
	} */
	
	#profileimage {
		width:  200px;
		height: 200px;		
	}
	
	body {
		background-color: #fafafa;
	}
	
	#textBox{
		font-style: italic;
		font-size: large;
		font-weight: bold;
		text-align: center;
		padding: 100px 0px;
	}
	
	.photoLi{
		width: 30%;
		float: left;
		margin: 2px;
		padding: 0px;
	}
	#photoBox {
		width: 100%;
		list-style: none;
	 	margin: 0px;
	 	padding: 0px;
	}

	</style>

</head>
<body>
 	<jsp:include page="/WEB-INF/views/header.jsp" flush="false" /> 
   <br>
   <br>
   <br>
   <br>
   <div class="container" style="padding: 0px">
   	<div class="row" style="padding: 50px 80px">
   		<div class="col-md-6 col-xs-12">
   			<div id="imageBox" class="row">
	   	<%-- 	<c:if test="${userinfo.profileimage eq 'noprofile'}">
	   		 	<img class="img-circle" id="profileimage" src="/resource/imageIcon/defaultprofile.png" alt="default"/> 
	   		</c:if> --%>
	   		<%-- <c:if test="${userinfo.profileimage ne 'noprofile' }"> --%>
	   		 	<img class="img-circle" id="profileimage" src="/displayFile?fileName=${userinfo.profileimage}" alt="${userinfo.profileimage}"  /> 
	   			<%-- <img class="img-circle" id="profileimage" src="/displayFile?fileName=/2017/06/25/761d390b-aa10-408f-8b96-bbf937c8c9a8_KakaoTalk_20170625_185931182.jpg" alt="${userinfo.profileimage}"  /> --%> 
	  <%--  		</c:if> --%>
	   		</div>
	   		 <div class="row form-group">
			      <div class="col-md-12">
			         <input type='file' name="file" id="file" >
			         <p class="help-block">보여주고싶은 사진을 올려주세요</p>
			      </div>
			  </div>
   		</div>
   		<div id="profileBox"class="col-md-6 col-xs-12" style="padding: 40px 0px">
   			<div class="row">
   				<div class="col-md-6 col-xs-6">
   					<label>${userinfo.username}</label>
   				</div>
   				<div class="col-md-6 col-xs-6" >
   					<button style="background: white">프로필 편집</button>
   				</div>
   			</div>
   			<div class="row">
   				<div class="col-md-3 col-xs-6">
   					<label>게시물</label>
   					<label>${boardCount.readBoardCount} 개</label>
   				</div>
   				<div class="col-md-3 col-xs-6">
   					<label>댓글 </label>
   					<label>${boardCount.readReplyCount} 개</label>
   				</div>
   				<div class="col-md-6"></div>
   			</div>
   			<div class="row">
   				<div class="col-md-3 col-xs-6">
   					<label>${userinfo.displayname}  </label>
   				</div>
   			</div>
   		</div>
   	</div>
   	
   	<div>
   		<a href="#" id="boardConfirm">게시물 확인</a>
   		<a href="#" id="replyConfirm">댓글 게시물 확인</a>
   	</div>
   	
   	<div class="row" style="margin: 0px;padding: 0px;">
   		<ul id="photoBox" style="width: 100%"></ul>
   	
   	</div>
   
	 <!--   	   
   <div class="row" style="background-color: gray">
   		<div>
   		</div>
   			<div>
   		</div>
   			<div>
   		</div>
   </div> -->
   <br>
   <br>
   <br>
   <br>
   	 <div class="row" style="height: 300px">
   	 	<div class="col-md-5">
   	 		<img src="/resource/imageIcon/insta.jpg" width="100%" height="100%">
   	 	</div>
   	 	<div class="col-md-7" style="background-color: white">
   	 		 <div style="height: 100%; width: 100%" id="textBox">
   	 		 	<p>소중한 순간을 포착하여 공유해보세요.</p>
   	 		 	<p>앱을 다운로드하고 첫 사진이나 동영상을 공유해보세요.</p>
   	 		 </div>
   	 	</div>
   		<!-- <div class="col-md-6 ">
   	 		<img src="/resource/imageIcon/insta.jpg" width="100%" height="100%">
   	 	</div> -->
  	 </div>
   </div>
   <input type="hidden" id="username" value="${userinfo.username}">
   
   	 <br>
   	 <br>
   	 <br>

   
</body>
<script type="text/javascript">
$(document).ready(function(){
/* 	var uimage= $("#profileimage").val();
	console.log(uimage) */
    $(function () {
       var token = $("meta[name='_csrf']").attr("content");
       var header = $("meta[name='_csrf_header']").attr("content");
       $(document).ajaxSend(function(e, xhr, options) {
          xhr.setRequestHeader(header, token);
       });
    });
	
	  var imageCheck = $("#profileimage").attr("alt"); //현재 이미지경로 
	  var username = $("#username").val();
  
  /* 이미지 처리 부분  */
  $("#file").change(function(){
     console.log("sss");
     var formData = new FormData();
      formData.append("file", $("input[name=file]")[0].files[0]);//파일의 정보를 formData에 삽입 

      $.ajax({ //image 파일 폴더에 생성
          type : "post",
          url : "/imageUpload?Mypath=my",
          dataType : "text",
          data : formData,
          processData : false,
          contentType : false,
          success : function(imgPath) {
        	  if(imgPath){
        		  if(imageCheck === "default"){
            		  $("#imageBox").empty(); //imageBox 안에 태그 비우기 
                      var str = "<img src='/displayFile?fileName="+imgPath+"'  id='profileimage' class='img-circle' />";
                      $("#imageBox").append(str);
            	  }else{
            		  imageDelete(imageCheck,imgPath);
            	  }
        		  imageDatabseUpload(imgPath);
        	  }else{
        		  alert("Image File please");
        	  }
          }
      
       });
  });
  
  //프로필 사진 경로 Db에 저장
  function imageDatabseUpload(imgPath){
	  $.ajax({
          url : "/user/myImageDatabaseUpload",
          type : "post",
          data : {
             fileName : imgPath,
             username : username
          },
          dataType : "text",
          success : function(result) {
        	  console.log("교체성공");
          }
       });
  }
  
  function imageDelete(preUrl,imgPath) { //이미지 삭제 
      console.log("imgPath"+imgPath);
      console.log("preUrl"+preUrl);
         $.ajax({
            url : "/deleteFile",
            type : "post",
            data : {
               fileName : preUrl
            },
            dataType : "text",
            success : function(result) {
               $("#imageBox").empty(); //imageBox 안에 태그 비우기 
                var str = "<img src='/displayFile?fileName="+imgPath+"' id= 'profileimage' class='img-circle' />";
                $("#imageBox").append(str);
            }
         });
     };
         
/* 이미지 처리 부분  */
 
 
 //내 게시물 확인 리스트
 $("#boardConfirm").click(function(event) {
	 console.log("board click");
	 $("#photoBox").empty();
	 $.ajax({
		    url : "/user/myBoardConfirm",
            type : "post",
            data : {
               username : username
            },
            dataType : "json",
            success : function(result) {
            	var listView="";
            	for(var k in result){
            		console.log(result[k]);
            		listView+="<li class='photoLi'>";
            		listView+=	'<a href="/board/read?boardno='+result[k].boardno+'"style="width="100%";height="100%"">';
            		listView+= '<img src="/displayFile?fileName='+result[k].photo+'" style="border-radius: 5px" width="100%"></a>';
            		listView+="</li>";
            	}
            /* 	댓글수 하트수 표시 */
            /* 	for(var k in result){
            		a+="<li class='photoLi'>"
            		a+=	'<a href="/board/read?boardno='+result[k].boardno+'" style="width="100%";height="100%""> <div class="listLabelContainer"><label class="listLabel"><span class="glyphicon glyphicon-heart listLabel" ></span>'+result[k].heartcnt+'개</label>';
        			a+=	'<label class="listLabel"><span class="glyphicon glyphicon-comment listLabel" ></span> '+result[k].replycnt+' 개</label>';
            		a+= '</div><img src="/displayFile?fileName='+result[k].photo+'" style="border-radius: 5px" width="100%" height="100%"></a>';
					a+="</li>";
            	} */
            	$("#photoBox").append(listView);
            }
	 });
});
	
 //댓글 게시물 확인 리스트
 $("#replyConfirm").click(function(event) {
	 console.log("reply click");
	 $("#photoBox").empty();
	 $.ajax({
		    url : "/user/myReplyConfirm",
            type : "post",
            data : {
               username : username
            },
            dataType : "json",
            success : function(result) {
            	var listView="";
            	for(var k in result){
            		console.log(result[k]);
            		listView+="<li class='photoLi'>";
            		listView+=	'<a href="/board/read?boardno='+result[k].boardno+'"style="width="100%";height="100%"">';
            		listView+= '<img src="/displayFile?fileName='+result[k].photo+'" style="border-radius: 5px" width="100%"></a>';
            		listView+="</li>";
            	}
            	console.log(listView);
           
            	$("#photoBox").append(listView);
            }
	  });
 });
 
});
</script>
</html>