<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>수박나라 로그인</title>
<link rel="icon" type="image/png" href="../images/watermelon_icon.ico">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/global.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login.css">
</head>
<body>
	<div class="container">
		<a class="logo" href="${pageContext.request.contextPath}/main">
			<img id="main-icon"
			src="${pageContext.request.contextPath}/resources/images/watermelon_icon.png"
			alt="수박 아이콘"> <span>수박나라</span>
		</a>

		<div class="login-card">
		<form action="${pageContext.request.contextPath}/login" method="post">
		    <input type="text" name="username" placeholder="아이디" required>
		    <input type="password" name="password" placeholder="비밀번호" required>
		    <button type="submit">로그인</button>
		    <c:if test="${not empty error}">
		        <p style="color:red">${error}</p>
		    </c:if>
		</form>
		<a href="${pageContext.request.contextPath}/join">회원가입</a>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>