<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입</title>
<link rel="icon" type="image/png"
	href="${pageContext.request.contextPath}/resources/images/watermelon_icon.ico">

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
		<a class="logo" href="${pageContext.request.contextPath}/main"> <img
			id="main-icon"
			src="${pageContext.request.contextPath}/resources/images/watermelon_icon.png"
			alt="수박 아이콘"> <span>수박나라</span>
		</a>

		<div class="login-card p-4">
			<h3 class="text-center mb-4">회원가입</h3>
			<p class="text-center text-muted">필수 정보를 입력하고 회원가입을 완료하세요.</p>

			<nav class="mb-4">
				<ol
					class="list-unstyled d-flex justify-content-between text-muted fw-bold">
					<li>1. 약관동의</li>
					<li style="color: #2E8B57;">2. 정보입력</li>
					<li>3. 가입완료</li>
				</ol>
				<div class="progress" style="height: 10px;">
					<div class="progress-bar bg-success" role="progressbar"
						style="width: 50%;" aria-valuenow="50" aria-valuemin="0"
						aria-valuemax="100"></div>
				</div>
			</nav>

			<form action="${pageContext.request.contextPath}/join" method="post"
				id="registerForm">
				<table class="table table-borderless">
					<tbody>
						<tr>
							<td class="text-start align-middle label-cell"><label
								for="username" class="col-form-label">아이디</label></td>
							<td class="text-start">
								<div class="d-flex input-group-gap">
									<input type="text" class="form-control" id="username"
										name="username" placeholder="아이디를 입력하세요" required>
									<button type="button"
										class="btn btn-outline-success btn-sm check-button"
										id="checkUsername">중복확인</button>
								</div>
								<div id="usernameFeedback" class="mt-2"
									style="font-size: 0.875em;"></div>
							</td>
						</tr>
						<tr>
							<td class="text-start align-middle label-cell"><label
								for="password" class="col-form-label">비밀번호</label></td>
							<td class="text-start"><input type="password"
								class="form-control" id="password" name="password"
								placeholder="비밀번호를 입력하세요" required></td>
						</tr>
						<tr>
							<td class="text-start align-middle label-cell"><label
								for="confirmPassword" class="col-form-label">비밀번호 확인</label></td>
							<td class="text-start"><input type="password"
								class="form-control" id="confirmPassword" name="confirmPassword"
								placeholder="비밀번호를 한 번 더 입력하세요" required></td>
						</tr>
						<tr>
							<td class="text-start align-middle label-cell"><label
								for="name" class="col-form-label">닉네임</label></td>
							<td class="text-start">
								<div class="d-flex input-group-gap">
									<input type="text" class="form-control" id="nickname"
										name="nickname" placeholder="닉네임을 입력하세요" required>
									<button type="button"
										class="btn btn-outline-success btn-sm check-button"
										id="checkNickname">중복확인</button>
								</div>
								<div id="nicknameFeedback" class="mt-2"
									style="font-size: 0.875em;"></div>
							</td>
						</tr>
						<tr>
							<td class="text-start align-middle label-cell"><label
								for="email" class="col-form-label">이메일</label></td>
							<td class="text-start">
								<div class="d-flex input-group-gap">
									<input type="email" class="form-control" id="email"
										name="email" placeholder="이메일 주소를 입력하세요" required>
									<button type="button"
										class="btn btn-outline-success btn-sm check-button"
										id="sendEmailBtn">번호 인증</button>
								</div>
								<div id="emailFeedback" class="mt-2" style="font-size: 0.875em;"></div>
							</td>
						</tr>

						<tr id="authCodeRow" style="display: none;">
							<td class="text-start align-middle label-cell"><label
								for="authCode" class="col-form-label">인증번호</label></td>
							<td class="text-start">
								<div class="d-flex input-group-gap">
									<input type="text" class="form-control" id="authCode"
										placeholder="인증번호 입력">
									<button type="button" class="btn btn-outline-success btn-sm check-button"
										id="verifyEmailBtn">확인</button>
								</div>
								<div id="authCodeFeedback" class="mt-2"
									style="font-size: 0.875em;"></div>
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
	    const emailInput = document.getElementById('email');
	    const authCodeInput = document.getElementById('authCode');
	    const checkUsernameBtn = document.getElementById('checkUsername');
	    const checkNicknameBtn = document.getElementById('checkNickname');
	    const sendEmailBtn = document.getElementById('sendEmailBtn');
	    const verifyEmailBtn = document.getElementById('verifyEmailBtn');
	    const usernameFeedback = document.getElementById('usernameFeedback');
	    const nicknameFeedback = document.getElementById('nicknameFeedback');
	    const emailFeedback = document.getElementById('emailFeedback');
	    const authCodeFeedback = document.getElementById('authCodeFeedback');
	    const submitBtn = document.getElementById('submitBtn');
	    const authCodeRow = document.getElementById('authCodeRow');

	    // 인증 상태 변수
	    let isUsernameChecked = false;
	    let isNicknameChecked = false;
	    let isEmailVerified = false;

	    // 아이디 중복 확인
	    checkUsernameBtn.addEventListener('click', function() {
	        const username = usernameInput.value.trim();
	        if (username.length < 4) {
	            usernameFeedback.innerHTML = '<span class="text-danger">아이디는 4자 이상이어야 합니다.</span>';
	            isUsernameChecked = false;
	            updateSubmitButtonState();
	            return;
	        }

	        const xhr = new XMLHttpRequest();
	        xhr.open('POST', '${pageContext.request.contextPath}/ajax/checkUsername', true);
	        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	        xhr.onreadystatechange = function() {
	            if (xhr.readyState === XMLHttpRequest.DONE) {
	                if (xhr.status === 200) {
	                    const response = xhr.responseText.trim();
	                    if (response === 'exists') {
	                        usernameFeedback.innerHTML = '<span class="text-danger">이미 사용 중인 아이디입니다.</span>';
	                        isUsernameChecked = false;
	                    } else {
	                        usernameFeedback.innerHTML = '<span class="text-success">사용 가능한 아이디입니다.</span>';
	                        isUsernameChecked = true;
	                    }
	                    updateSubmitButtonState();
	                }
	            }
	        };
	        xhr.send('username=' + encodeURIComponent(username));
	    });

	    // 닉네임 중복 확인
	    checkNicknameBtn.addEventListener('click', function() {
	        const nickname = nicknameInput.value.trim();
	        if (nickname.length < 2) {
	            nicknameFeedback.innerHTML = '<span class="text-danger">닉네임은 2자 이상이어야 합니다.</span>';
	            isNicknameChecked = false;
	            updateSubmitButtonState();
	            return;
	        }

	        const xhr = new XMLHttpRequest();
	        xhr.open('POST', '${pageContext.request.contextPath}/ajax/checkNickname', true);
	        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	        xhr.onreadystatechange = function() {
	            if (xhr.readyState === XMLHttpRequest.DONE) {
	                if (xhr.status === 200) {
	                    const response = xhr.responseText.trim();
	                    if (response === 'exists') {
	                        nicknameFeedback.innerHTML = '<span class="text-danger">이미 사용 중인 닉네임입니다.</span>';
	                        isNicknameChecked = false;
	                    } else {
	                        nicknameFeedback.innerHTML = '<span class="text-success">사용 가능한 닉네임입니다.</span>';
	                        isNicknameChecked = true;
	                    }
	                    updateSubmitButtonState();
	                }
	            }
	        };
	        xhr.send('nickname=' + encodeURIComponent(nickname));
	    });

	    // 이메일 인증번호 전송
	    sendEmailBtn.addEventListener('click', function() {
	        const email = emailInput.value.trim();
	        if (!email) {
	            emailFeedback.innerHTML = '<span class="text-danger">이메일을 입력하세요.</span>';
	            return;
	        }
	        const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	        if (!emailRegex.test(email)) {
	            emailFeedback.innerHTML = '<span class="text-danger">유효한 이메일 형식이 아닙니다.</span>';
	            return;
	        }

	        emailFeedback.innerHTML = '<span class="text-muted">인증번호를 전송 중입니다...</span>';

	        const xhr = new XMLHttpRequest();
	        xhr.open('POST', '${pageContext.request.contextPath}/ajax/sendAuthEmail', true);
	        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	        xhr.onreadystatechange = function() {
	            if (xhr.readyState === XMLHttpRequest.DONE) {
	                if (xhr.status === 200) {
	                    const response = xhr.responseText.trim();
	                    if (response === 'success') {
	                        emailFeedback.innerHTML = '<span class="text-success">인증번호가 이메일로 전송되었습니다.</span>';
	                        authCodeRow.style.display = 'table-row';
	                        isEmailVerified = false;
	                    } else {
	                        emailFeedback.innerHTML = '<span class="text-danger">인증번호 전송에 실패했습니다.</span>';
	                    }
	                } else {
	                    emailFeedback.innerHTML = '<span class="text-danger">서버 오류가 발생했습니다.</span>';
	                }
	                updateSubmitButtonState();
	            }
	        };
	        xhr.send('email=' + encodeURIComponent(email));
	    });

	    // 인증번호 확인
	    verifyEmailBtn.addEventListener('click', function() {
	        const inputAuthCode = authCodeInput.value.trim();
	        if (!inputAuthCode) {
	            authCodeFeedback.innerHTML = '<span class="text-danger">인증번호를 입력하세요.</span>';
	            isEmailVerified = false;
	            updateSubmitButtonState();
	            return;
	        }

	        const xhr = new XMLHttpRequest();
	        xhr.open('POST', '${pageContext.request.contextPath}/ajax/verifyAuthCode', true);
	        xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	        xhr.onreadystatechange = function() {
	            if (xhr.readyState === XMLHttpRequest.DONE) {
	                if (xhr.status === 200) {
	                    const response = xhr.responseText.trim();
	                    if (response === 'success') {
	                        authCodeFeedback.innerHTML = '<span class="text-success">인증 성공!</span>';
	                        isEmailVerified = true;
	                        emailInput.disabled = true;
	                        sendEmailBtn.disabled = true;
	                        authCodeRow.style.display = 'none';
	                    } else {
	                        authCodeFeedback.innerHTML = '<span class="text-danger">인증번호가 일치하지 않습니다.</span>';
	                        isEmailVerified = false;
	                    }
	                    updateSubmitButtonState();
	                } else {
	                    authCodeFeedback.innerHTML = '<span class="text-danger">서버 오류가 발생했습니다.</span>';
	                }
	            }
	        };
	        xhr.send('authCode=' + encodeURIComponent(inputAuthCode) + '&email=' + encodeURIComponent(emailInput.value.trim()));
	    });

	    // 입력창 변경 시 상태 초기화
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

	    emailInput.addEventListener('input', function() {
	        isEmailVerified = false;
	        emailFeedback.innerHTML = '';
	        authCodeFeedback.innerHTML = '';
	        authCodeRow.style.display = 'none';
	        emailInput.disabled = false;
	        sendEmailBtn.disabled = false;
	        updateSubmitButtonState();
	    });

	    // 가입하기 버튼
	    function updateSubmitButtonState() {
	        submitBtn.disabled = !(isUsernameChecked && isNicknameChecked && isEmailVerified);
	    }

	    updateSubmitButtonState();
	});

	</script>
</body>
</html>