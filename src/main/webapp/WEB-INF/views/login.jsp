<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf"%>
<link href="<c:url value="/resource/css/login.css" />" rel="stylesheet">
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/latest/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-1.10.2.js"></script> 
<script src="//maxcdn.bootstrapcdn.com/bootstrap/latest/js/bootstrap.min.js"></script>

<hr>
<jsp:include page="/WEB-INF/views/header.jsp" flush="false" /> 
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
                    <h5 class="text-center">로그인</h5>
                    <sf:form action="${pageContext.request.contextPath}/login" method="post" modelAttribute="userVO">
                    <div class="form-group">
                        <div class="input-group">
                            <span class="input-group-addon"><span class="glyphicon glyphicon-user"></span>
                            </span>
                            <sf:input style="width:50%" type="text" id="username" class="form-control" path="username" placeholder="이메일 (ID)" />
                            <label style="width:50%" class="form-control">@hansung.ac.kr</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="input-group">
                            <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></span>
                            <sf:input type="password" class="form-control" id="password" path="password" placeholder="비밀번호" />
                        </div>
                    </div>
                    <div class="form-group">
                    	<div class="input-group">
                    		<div class="container-wrapper">
								<div class="container">
									<c:if test="${not empty logout}">
										<div style="color:#0000ff"><h4>${logout} </h4></div>
									</c:if>
									<c:if test="${not empty error}">
										<div style="color:#ff0000"><h4>${error} </h4></div>
									</c:if>
								</div>
							</div>
                    	</div>
                    </div>
                    
                    <div>
                    	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    </div>
                    <div>
                    	<input style="width:100%" type="submit" id="submit" class="btn btn-default" value="로그인">
                    </div>
                    <hr>
                    <div class="form-group">
                    	<div class="input-group">
                    		<label><a href="/user/signup/">아직 HansungMeeting 회원이 아니신가요?</a></label>
                    	</div>
                    </div>
                    <div class="form-group">
                    	<div class="input-group">
                    		<label><a href="/user/renewalpassword/">비밀번호를 잊어버리셨나요?</a></label>
                    	</div>
                    </div>
                 	</sf:form>
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
 <jsp:include page="/WEB-INF/views/footer.jsp" flush="false" />

<script>
	$(document).ready(function(){
		console.log('자바스크립트 시작');
		$('#username').focus();
	});
</script>
