<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>아이디 찾기</title>
<link rel="icon" type="image/png" href="../images/watermelon_icon.ico">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/global.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/findUserName.css">
</head>
<body>
	<div class="container">
		<a class="logo" href="${pageContext.request.contextPath}/main">
			<img id="main-icon"
			src="${pageContext.request.contextPath}/resources/images/watermelon_icon.png"
			alt="수박 아이콘"> <span>수박나라</span>
		</a>

		<div class="login-card p-4">
			<h3 class="text-center mb-4">아이디 찾기</h3>
			<p class="text-center text-muted">본인 확인을 위해 이름과 이메일 주소를 입력해주세요.</p>
			
			<form action="${pageContext.request.contextPath}/find/username" method="post">
				<div class="mb-3">
					<div class="input-group">
						<input type="text" class="form-control" id="emailId" placeholder="이메일" required>
						<span class="input-group-text">@</span>
						<input type="text" class="form-control" id="emailDomain" placeholder="직접입력" required>
						<select class="form-select" id="emailSelect">
							<option value="direct">직접입력</option>
							<option value="naver.com">naver.com</option>
							<option value="gmail.com">gmail.com</option>
							<option value="hanmail.net">hanmail.net</option>
							<option value="daum.net">daum.net</option>
							<option value="hotmail.com">hotmail.com</option>
						</select>
					</div>
					<input type="hidden" name="email" id="fullEmail">
				</div>
				<div class="d-grid gap-2">
					<button type="submit" class="btn btn-primary">아이디 찾기</button>
				</div>
			</form>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		document.getElementById('emailSelect').addEventListener('change', function() {
			const domainInput = document.getElementById('emailDomain');
			if (this.value === 'direct') {
				domainInput.value = '';
				domainInput.readOnly = false;
				domainInput.focus();
			} else {
				domainInput.value = this.value;
				domainInput.readOnly = true;
			}
		});

		// 폼 제출 시 이메일 값을 하나로 합쳐서 hidden input에 넣는 스크립트
		document.querySelector('form').addEventListener('submit', function(e) {
			const emailId = document.getElementById('emailId').value;
			const emailDomain = document.getElementById('emailDomain').value;
			const fullEmail = emailId + '@' + emailDomain;
			
			document.getElementById('fullEmail').value = fullEmail;
		});
	</script>
</body>
</html>