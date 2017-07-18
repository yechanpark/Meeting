<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<div class="container">
    <div class="row">
    	<div class="col-sm-3">
    	</div>
        <div class="col-sm-6">
            <div class="panel panel-default">
                <div class="panel-body">
                    <h5 class="text-center">- 비밀번호 재설정 -</h5>
                    <form action="/user/renewalpassword" role="form" method="post">
                    <div class="form-group">
                        <div class="input-group">
                            <span class="input-group-addon"><span class="glyphicon glyphicon-envelope"></span>
                            </span>
                            <input style="width:50%" type="text" id="username" class="form-control" name="username" placeholder="이메일 (ID)" required />
                            <label style="width:50%" class="form-control">@hansung.ac.kr</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group">
                            <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
                            <input type="password" class="form-control" name="password" placeholder="재설정 비밀번호" required />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group">
                            <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
                            <input type="password" class="form-control" name="password2" placeholder="재설정 비밀번호 (확인)" required />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group">
                            <span class="input-group-addon"><span class="glyphicon glyphicon-ok-circle"></span></span>
                            <input style="width:50%" type="text" id="hansungAuth" class="form-control" placeholder="인증번호" required />
                            <input style="width:50%" type="button" id="emailBtn" class="btn btn-default" value="인증번호받기">
                        </div>
                    </div>
                    <div class="form-group">
                    	<div class="input-group">
                    		<label>위의 웹메일계정으로 인증번호가 발송됩니다.<br>인증이 된 경우에만 위 계정의 비밀번호가 재설정됩니다.</label>
                    		
                    	</div>
                    </div>
                    <div>
                    	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    </div>
                    <div>
                    	<input style="width:100%" type="submit" id="submit" class="btn btn-default" value="비밀번호 재설정하기">
                    </div>
                 	</form>
	            </div>
	        </div>
	    </div>
	    <div class="col-sm-3">
	    </div>
	</div>
</div>
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
    
});
</script>
</body>
</html>