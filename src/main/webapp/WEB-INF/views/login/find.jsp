<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>아이디/비밀번호 찾기</title>
<link rel="icon" type="image/png" href="../images/watermelon_icon.ico">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/global.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/find.css">
</head>
<body>
	<div class="container">
		<a class="logo" href="${pageContext.request.contextPath}/main">
			<img id="main-icon"
			src="${pageContext.request.contextPath}/resources/images/watermelon_icon.png"
			alt="수박 아이콘"> <span>수박나라</span>
		</a>

		<div class="login-card p-4">
			<h3 class="text-center mb-4">아이디/비밀번호 찾기</h3>
			<p class="text-center text-muted">무엇을 찾고 있나요?</p>
			<div class="d-grid gap-3">
				<a href="${pageContext.request.contextPath}/find/username" class="btn btn-outline-secondary btn-lg">아이디 찾기</a> 
				<a href="${pageContext.request.contextPath}/find/password" class="btn btn-outline-secondary btn-lg">비밀번호 찾기</a>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>