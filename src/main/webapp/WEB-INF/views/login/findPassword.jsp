<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>비밀번호 찾기</title>
<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/watermelon_icon.ico">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/global.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/find.css">
</head>
<body>
	<div class="container">
		<a class="logo" href="${pageContext.request.contextPath}/main">
			<img id="main-icon"
			src="${pageContext.request.contextPath}/resources/images/watermelon_icon.png"
			alt="수박 아이콘"> <span>수박나라</span>
		</a>

		<div class="login-card p-4">
			<h3 class="text-center mb-4">비밀번호 찾기</h3>
			<form id="findPasswordForm">
				<div class="mb-3">
					<input type="text" class="form-control" id="usernameInput" placeholder="아이디를 입력하세요" required>
				</div>
				<div class="mb-4">
					<input type="email" class="form-control" id="emailInput" placeholder="가입 시 입력한 이메일 주소" required>
				</div>
				<div class="d-grid">
					<button type="submit" class="btn btn-primary btn-lg">확인</button>
				</div>
			</form>

		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		document.addEventListener('DOMContentLoaded', function() {
			const emailSelect = document.getElementById('emailSelect');
			const emailIdInput =
			$('#findPasswordForm').on('submit', function(e) {
				e.preventDefault();
				
				const username = $('#usernameInput').val();
				const email = $('#emailInput').val();
				
				if (!username || !email) {
					alert('아이디와 이메일을 모두 입력해주세요.');
					return;
				}
				
				// 서버로 아이디와 이메일 정보를 전송 (AJAX 사용)
				$.ajax({
					url: '${pageContext.request.contextPath}/find/password', // 서버의 비밀번호 찾기 처리 URL
					type: 'POST',
					contentType: 'application/json',
					data: JSON.stringify({
						username: username,
						email: email
					}),
					success: function(response) {
						if (response.status === 'success') {
							alert('이메일로 비밀번호 재설정 링크를 보냈습니다. 받은 링크를 통해 비밀번호를 변경해 주세요.');
							location.href = '${pageContext.request.contextPath}/login'; // 로그인 페이지로 이동
						} else {
							alert(response.message || '일치하는 회원 정보가 없습니다.');
						}
					},
					error: function() {
						alert('서버 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.');
					}
				});
			});
		});
	</script>
</body>
</html>