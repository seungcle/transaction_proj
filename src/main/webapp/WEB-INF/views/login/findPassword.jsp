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

			<div id="authCodeSection" class="mt-4" style="display: none;">
				<div class="mb-3">
					<input type="text" class="form-control" id="authCodeInput" placeholder="인증 코드를 입력하세요" required>
				</div>
				<div class="d-grid">
					<button type="button" id="verifyCodeBtn" class="btn btn-primary btn-lg">인증</button>
				</div>
			</div>

			<div id="resetPasswordSection" class="mt-4" style="display: none;">
				<div class="mb-3">
					<input type="password" class="form-control" id="newPasswordInput" placeholder="새 비밀번호" required>
				</div>
				<div class="mb-3">
					<input type="password" class="form-control" id="confirmPasswordInput" placeholder="새 비밀번호 확인" required>
				</div>
				<div class="d-grid">
					<button type="button" id="resetPasswordBtn" class="btn btn-primary btn-lg">비밀번호 재설정</button>
				</div>
			</div>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		$(document).ready(function() {
		    const findPasswordForm = $('#findPasswordForm');
		    const authCodeSection = $('#authCodeSection');
		    const resetPasswordSection = $('#resetPasswordSection');
		    const verifyCodeBtn = $('#verifyCodeBtn');
		    const resetPasswordBtn = $('#resetPasswordBtn');
		
		    // 1. 아이디와 이메일 확인
		    findPasswordForm.on('submit', function(e) {
		        e.preventDefault();
		        const username = $('#usernameInput').val();
		        const email = $('#emailInput').val();
		        if (!username || !email) {
		            alert('아이디와 이메일을 모두 입력해주세요.');
		            return;
		        }
		
		        $.ajax({
		            url: '${pageContext.request.contextPath}/ajax/user/check-user-and-send-email',
		            type: 'POST',
		            contentType: 'application/json',
                    dataType: 'json',
		            data: JSON.stringify({ username: username, email: email }),
		            success: function(response) {
		                if (response.success) {
		                    alert('이메일로 인증 코드가 발송되었습니다.');
		                    findPasswordForm.hide();
		                    authCodeSection.show();
		                } else {
		                    alert(response.message);
		                }
		            },
		            error: function() {
		                alert('서버 오류가 발생했습니다.');
		            }
		        });
		    });
		
		    // 2. 인증 코드 검증
		    verifyCodeBtn.on('click', function() {
		        const authCode = $('#authCodeInput').val();
		        if (!authCode) {
		            alert('인증 코드를 입력해주세요.');
		            return;
		        }
		
		        $.ajax({
		            url: '${pageContext.request.contextPath}/ajax/user/verify-auth-code',
		            type: 'POST',
		            contentType: 'application/json',
                    dataType: 'json',
		            data: JSON.stringify({ authCode: authCode }),
		            success: function(response) {
		                if (response.success) {
		                    alert('인증이 완료되었습니다. 새 비밀번호를 설정해주세요.');
		                    authCodeSection.hide();
		                    resetPasswordSection.show();
		                } else {
		                    alert(response.message);
		                }
		            },
		            error: function() {
		                alert('서버 오류가 발생했습니다.');
		            }
		        });
		    });
		
		    // 3. 비밀번호 재설정
		    resetPasswordBtn.on('click', function() {
		        const newPassword = $('#newPasswordInput').val();
		        const confirmPassword = $('#confirmPasswordInput').val();
		
		        if (!newPassword || !confirmPassword) {
		            alert('새 비밀번호를 모두 입력해주세요.');
		            return;
		        }
		        if (newPassword !== confirmPassword) {
		            alert('새 비밀번호가 일치하지 않습니다.');
		            return;
		        }
		
		        $.ajax({
		            url: '${pageContext.request.contextPath}/ajax/user/reset-password',
		            type: 'POST',
		            contentType: 'application/json',
                    dataType: 'json',
		            data: JSON.stringify({ newPassword: newPassword }),
		            success: function(response) {
		                if (response.success) {
		                    alert('비밀번호가 성공적으로 재설정되었습니다. 로그인 페이지로 이동합니다.');
		                    window.location.href = '${pageContext.request.contextPath}/login';
		                } else {
		                    alert(response.message);
		                }
		            },
		            error: function() {
		                alert('서버 오류가 발생했습니다.');
		            }
		        });
		    });
		});
	</script>
</body>
</html>