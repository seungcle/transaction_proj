<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>수박나라 로그인</title>
<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/watermelon_icon.ico">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/global.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/login.css">
</head>
<body>
	<div class="container">
		<a class="logo" href="${pageContext.request.contextPath}/main">
			<img id="main-icon"
			src="${pageContext.request.contextPath}/resources/images/watermelon_icon.png"
			alt="수박 아이콘"> <span>수박나라</span>
		</a>

		<div class="login-card p-4">
			<h3 class="text-center mb-4">로그인</h3>
			<form action="${pageContext.request.contextPath}/login" method="post">
				<div class="mb-3">
					<label for="username" class="form-label">아이디</label> 
					<input type="text" class="form-control" id="username" name="username" placeholder="아이디를 입력하세요" required>
				</div>
				<div class="mb-3">
					<label for="password" class="form-label">비밀번호</label> 
					<input type="password" class="form-control" id="password" name="password" placeholder="비밀번호를 입력하세요" required>
				</div>
				<div class="d-grid gap-2 mb-3">
					<button type="submit" class="btn btn-primary">로그인</button>
				</div>
				<div class="d-flex justify-content-between small text-muted">
					<a href="../find.jsp">아이디/비밀번호 찾기</a> 
					<a href="${pageContext.request.contextPath}/join">회원가입</a>
				</div>
			</form>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>