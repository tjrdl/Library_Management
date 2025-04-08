<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>도서관리 시스템 - 로그인</title>
<link rel="stylesheet" type="text/css" href="/pilotpjt/resources/css/loginview.css">
<script src="/pilotpjt/resources/js/login.js"></script>
</head>
<body>
	<jsp:include page="header.jsp" />
	
	<div class="container">
	    <div class="library-logo">
	        <img src="/pilotpjt/resources/images/logo_2.png" alt="InkTree" onerror="this.src='/pilotpjt/resources/images/default-logo.png'; this.onerror=null;">
	    </div>
	    
<!-- 		<h2>도서관리 시스템 로그인</h2> -->
		
		<div class="welcome-text">
		    <p>잉크트리에 오신 것을 환영합니다</p>
		</div>

		<%-- 로그인 실패 시 메시지 표시 --%>
<%-- 		<c:if test="${not empty error}"> --%>
<%-- 			<div class="error-message">${error}</div> --%>
<%-- 		</c:if> --%>

		<form method="post" action="/pilotpjt/login" class="login-form">
			<div class="form-group">
			    <label for="userId">아이디</label>
			    <input type="text" id="userId" name="userId" placeholder="아이디를 입력하세요" required>
			</div>
			
			<div class="form-group">
			    <label for="userPw">비밀번호</label>
			    <input type="password" id="userPw" name="userPw" placeholder="비밀번호를 입력하세요" required>
			</div>
			
			<div class="forgot-password">
			    <a href="/pilotpjt/forgotPassword">비밀번호를 잊으셨나요?</a>
			</div>
			
			<div class="button-group">
			    <input type="submit" value="로그인" class="btn btn-primary">
			    <input type="button" value="회원가입" onclick="location='/pilotpjt/joinView'" class="btn btn-secondary">
			</div>
		</form>
		
		<div class="login-options">
		    <p>또는 다음 계정으로 로그인</p>
		    <div class="social-login">
		        <a href="/pilotpjt/oauth/naver" class="social-btn">
		            <img src="/pilotpjt/resources/images/naver-icon.png" alt="네이버 로그인" 
		                 onerror="this.src='/pilotpjt/resources/images/naver-default.png'; this.onerror=null;">
		        </a>
		        <a href="/pilotpjt/oauth/kakao" class="social-btn">
		            <img src="/pilotpjt/resources/images/kakao-icon.png" alt="카카오 로그인"
		                 onerror="this.src='/pilotpjt/resources/images/kakao-default.png'; this.onerror=null;">
		        </a>
		        <a href="/pilotpjt/oauth/google" class="social-btn">
		            <img src="/pilotpjt/resources/images/google-icon.png" alt="구글 로그인"
		                 onerror="this.src='/pilotpjt/resources/images/google-default.png'; this.onerror=null;">
		        </a>
		    </div>
		    
		    <p>도서관 회원이 아니신가요? <a href="/pilotpjt/joinView" style="color: #1e3a8a; text-decoration: none;">회원가입</a></p>
<!-- 		    <p><a href="/pilotpjt/guestAccess" style="color: #6b7280; text-decoration: none;">게스트로 둘러보기</a></p> -->
		</div>
	</div>
</body>
</html>