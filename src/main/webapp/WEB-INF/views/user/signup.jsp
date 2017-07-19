<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<html>
<head>
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/latest/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-1.10.2.js"></script> 
<script src="//maxcdn.bootstrapcdn.com/bootstrap/latest/js/bootstrap.min.js"></script>
 <!-- 스프링 시큐리티 ajax csrf설정 403에러  -->
<meta name="_csrf" content="${_csrf.token}"/>
<!-- default header name is X-CSRF-TOKEN -->
<meta name="_csrf_header" content="${_csrf.headerName}"/>
<!-- 스프링 시큐리티 ajax csrf설정 403에러  -->
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<div class="container">
    <div class="row">
    	<div class="col-sm-3">
    	</div>
        <div class="col-sm-6">
            <div class="panel panel-default">
                <div class="panel-body">
                    <h5 class="text-center">- 회원가입 -</h5>
                    
                    <sf:form action="${pageContext.request.contextPath}/user/signup"
						method="post" modelAttribute="userVO">
                    <div class="form-group">
                        <div class="input-group">
                            <span class="input-group-addon"><span class="glyphicon glyphicon-envelope"></span>
                            </span>
                            <sf:input path="username" style="width:50%" id="username" class="form-control" placeholder="이메일 (ID)" />
                            
                            <label style="width:50%" class="form-control">@hansung.ac.kr</label>
                        </div>
                        <sf:errors path="username" cssStyle="color:#ff0000" />
                    </div>
                    <div>
                    	<label id="checkUid" class="checkLabel">필수 정보입니다.</label>
   						<label id="checkUid1" class="checkLabel">아이디 중복</label>
                    </div>
                    <div class="form-group">
                        <div class="input-group">
                            <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span></span>
                            <sf:input path="displayname" class="form-control" placeholder="닉네임" />
                        	
                        </div>
                        <sf:errors path="displayname" cssStyle="color:#ff0000" />
                    </div>
                    <div class="form-group">
                        <div class="input-group">
                            <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
                            <sf:password path="password" class="form-control" placeholder="비밀번호"  />
                        	
                        </div>
                        <sf:errors path="password" cssStyle="color:#ff0000" />
                    </div>
                    <div class="form-group">
                        <div class="input-group">
                            <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
                            <input type="password" name="password2" class="form-control" placeholder="비밀번호 (확인)" />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group">
                            <span class="input-group-addon"><span class="glyphicon glyphicon-star"></span></span>
                            <sf:input path="kakaoid" class="form-control" placeholder="카카오톡 아이디"   />
                            
                        </div>
                        <sf:errors path="kakaoid" cssStyle="color:#ff0000" />
                    </div>
                    <div class="form-group">
                        <div class="input-group">
                            <span class="input-group-addon"><span class="glyphicon glyphicon-ok-circle"></span></span>
                            <input path="hansungAuth" style="width:50%" id="hansungAuth" class="form-control" placeholder="인증번호" />
                      
                            <input style="width:50%" type="button" id="emailBtn" class="btn btn-default" value="인증번호받기">
                        </div>
                    </div>
                 	</sf:form>
                 	 <div>
                    	<input style="width:100%" type="submit" id="submit" class="btn btn-default" value="가입하기">
                    </div>
	            </div>
	        </div>
	    </div>
	    <div class="col-sm-3">
	    </div>
	</div>
</div>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<script type="text/javascript">
$(document).ready(function(){
	var emailAuth = null;
	/* 스프링 시큐리티 ajax csrf설정 403에러 */
	$(function () {
		var token = $("meta[name='_csrf']").attr("content");
		var header = $("meta[name='_csrf_header']").attr("content");
		$(document).ajaxSend(function(e, xhr, options) {
			xhr.setRequestHeader(header, token);
		});
	});
	/* 스프링 시큐리티 ajax csrf설정 403에러 */
	
    $("#emailBtn").click(function(){
    	var username = $('#username').val();   	
    	 $.ajax({ //image 파일 폴더에 생성
             type : "post",
             url : "/sendMail/auth",
             dataType : "text",
             data : {'username' : username},
             success : function(result) {
            	 emailAuth=result;
             }
          });
   });
    $("#submit").click(function(event){
   	 	if($("#hansungAuth").val()===emailAuth){
	       		console.log("success");
	       		$("form").submit();
        	}
       	else{
       		alert('이메일 인증 실패');
       	}
    });
    
    $(".checkLabel").hide();


    $('#username').blur(function(){
      IdCheck();
   }); 
    function IdCheck(){
   	   $.ajax({
   	      type : "post",
   	      url : "/user/signUpIdCheck",
   	      dataType : "text",
   	      data :{
   	         username : $("#username").val()
   	      },
   	      success : function(result) {
   	         if(result == "SUCCESS"){
   	         	console.log("아이디 사용가능.");
   	         }
   	         else{
   	          	console.log("아이디 중복");
   	         }
   	      }
   	   });
    }
});
</script>
</body>
</html>