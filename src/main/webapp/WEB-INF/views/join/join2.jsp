<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입</title>
<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/watermelon_icon.ico">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/global.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/register2.css">
<style>

</style>
</head>
<body>
	<div class="container">
		<a class="logo" href="${pageContext.request.contextPath}/main">
			<img id="main-icon"
			src="${pageContext.request.contextPath}/resources/images/watermelon_icon.png"
			alt="수박 아이콘"> <span>수박나라</span>
		</a>

		<div class="login-card p-4">
			<h3 class="text-center mb-4">회원가입</h3>
			<p class="text-center text-muted">필수 정보를 입력하고 회원가입을 완료하세요.</p>

			<nav class="mb-4">
				<ol class="list-unstyled d-flex justify-content-between text-muted fw-bold">
					<li>1. 약관동의</li>
					<li style="color: #2E8B57;">2. 정보입력</li>
					<li>3. 가입완료</li>
				</ol>
				<div class="progress" style="height: 10px;">
					<div class="progress-bar bg-success" role="progressbar" style="width: 50%;" aria-valuenow="50" aria-valuemin="0" aria-valuemax="100"></div>
				</div>
			</nav>

			<form action="${pageContext.request.contextPath}/join" method="post" id="registerForm">
				<table class="table table-borderless">
					<tbody>
						<tr>
							<td class="text-start align-middle label-cell">
								<label for="username" class="col-form-label">아이디</label>
							</td>
							<td class="text-start">
                                <div class="d-flex input-group-gap">
								    <input type="text" class="form-control" id="username" name="username" placeholder="아이디를 입력하세요" required>
                                    <button type="button" class="btn btn-outline-success btn-sm check-button" id="checkUsername">중복확인</button>
                                </div>
                                <div id="usernameFeedback" class="mt-2" style="font-size: 0.875em;"></div>
							</td>
						</tr>
						<tr>
							<td class="text-start align-middle label-cell">
								<label for="password" class="col-form-label">비밀번호</label>
							</td>
							<td class="text-start">
								<input type="password" class="form-control" id="password" name="password" placeholder="비밀번호를 입력하세요" required>
							</td>
						</tr>
						<tr>
							<td class="text-start align-middle label-cell">
								<label for="confirmPassword" class="col-form-label">비밀번호 확인</label>
							</td>
							<td class="text-start">
								<input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="비밀번호를 한 번 더 입력하세요" required>
							</td>
						</tr>
						<tr>
							<td class="text-start align-middle label-cell">
								<label for="name" class="col-form-label">닉네임</label>
							</td>
							<td class="text-start">
                                <div class="d-flex input-group-gap">
								    <input type="text" class="form-control" id="nickname" name="nickname" placeholder="닉네임을 입력하세요" required>
                                    <button type="button" class="btn btn-outline-success btn-sm check-button" id="checkNickname">중복확인</button>
                                </div>
                                <div id="nicknameFeedback" class="mt-2" style="font-size: 0.875em;"></div>
							</td>
						</tr>
						<tr>
							<td class="text-start align-middle label-cell">
								<label for="email" class="col-form-label">이메일</label>
							</td>
							<td class="text-start">
								<input type="email" class="form-control" id="email" name="email" placeholder="이메일 주소를 입력하세요" required>
							</td>
						</tr>
					</tbody>
				</table>

				<div class="d-grid gap-2 mt-4">
					<button type="submit" class="btn btn-success" id="submitBtn">가입하기</button>
				</div>
			</form>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script>
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('registerForm');
            const usernameInput = document.getElementById('username');
            const nicknameInput = document.getElementById('nickname');
            const checkUsernameBtn = document.getElementById('checkUsername');
            const checkNicknameBtn = document.getElementById('checkNickname');
            const usernameFeedback = document.getElementById('usernameFeedback');
            const nicknameFeedback = document.getElementById('nicknameFeedback');
            const submitBtn = document.getElementById('submitBtn');

            let isUsernameChecked = false;
            let isNicknameChecked = false;

            // 아이디 중복 확인 함수
            checkUsernameBtn.addEventListener('click', function() {
                const username = usernameInput.value;
                if (username.length < 4) {
                    usernameFeedback.innerHTML = '<span class="text-danger">아이디는 4자 이상이어야 합니다.</span>';
                    isUsernameChecked = false;
                    return;
                }
                
                if (username === 'testuser') {
                    usernameFeedback.innerHTML = '<span class="text-danger">이미 사용 중인 아이디입니다.</span>';
                    isUsernameChecked = false;
                } else {
                    usernameFeedback.innerHTML = '<span class="text-success">사용 가능한 아이디입니다.</span>';
                    isUsernameChecked = true;
                }
                updateSubmitButtonState();
            });

            // 닉네임 중복 확인 함수
            checkNicknameBtn.addEventListener('click', function() {
                const nickname = nicknameInput.value;
                if (nickname.length < 2) {
                    nicknameFeedback.innerHTML = '<span class="text-danger">닉네임은 2자 이상이어야 합니다.</span>';
                    isNicknameChecked = false;
                    return;
                }

                if (nickname === 'testnick') {
                    nicknameFeedback.innerHTML = '<span class="text-danger">이미 사용 중인 닉네임입니다.</span>';
                    isNicknameChecked = false;
                } else {
                    nicknameFeedback.innerHTML = '<span class="text-success">사용 가능한 닉네임입니다.</span>';
                    isNicknameChecked = true;
                }
                updateSubmitButtonState();
            });
            
            // 입력창 내용 변경 시 중복확인 상태 초기화
            usernameInput.addEventListener('input', function() {
                isUsernameChecked = false;
                usernameFeedback.innerHTML = '';
                updateSubmitButtonState();
            });

            nicknameInput.addEventListener('input', function() {
                isNicknameChecked = false;
                nicknameFeedback.innerHTML = '';
                updateSubmitButtonState();
            });

            // 가입하기 버튼 상태 업데이트 함수
            function updateSubmitButtonState() {
                if (isUsernameChecked && isNicknameChecked) {
                    submitBtn.disabled = false;
                } else {
                    submitBtn.disabled = true;
                }
            }
            
            updateSubmitButtonState();
        });
	</script>
</body>
</html>