<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입 완료</title>
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
			<h3 class="text-center mb-4">회원가입 완료🎉</h3>
			<p class="text-center text-muted">수박나라의 회원이 되신 것을<br>진심으로 축하드립니다!</p>

			<nav class="mb-4">
				<ol class="list-unstyled d-flex justify-content-between text-muted fw-bold">
					<li>1. 약관동의</li>
					<li>2. 정보입력</li>
					<li style="color: #2E8B57;">3. 가입완료</li>
				</ol>
				<div class="progress" style="height: 10px;">
					<div class="progress-bar bg-success" role="progressbar" style="width: 100%;" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
				</div>
			</nav>

            <div class="text-center my-5">
                <img src="${pageContext.request.contextPath}/resources/images/welcome_icon.png" alt="웰컴 수박 월드" class="d-block m-auto" style="width: 120px; height: 120px;"/>
            </div>

			<div class="d-grid gap-2 mt-4">
				<a href="${pageContext.request.contextPath}/main" class="btn btn-success">메인으로 이동</a>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>