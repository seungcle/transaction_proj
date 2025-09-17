<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>아이디 찾기</title>
<link rel="icon" type="image/png"
	href="${pageContext.request.contextPath}/resources/images/watermelon_icon.ico">

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
			
			<div class="mb-3">
				<div class="input-group">
					<input type="text" class="form-control" id="emailId" placeholder="이메일" required>
					<span class="input-group-text">@</span>
					<input type="text" class="form-control" id="emailDomain" placeholder="직접입력" required>
					<select class="form-select" id="emailSelect">
						<option value="direct">직접입력</option>
						<option value="naver.com">naver.com</option>
						<option value="gmail.com">gmail.com</option>
						<option value="daum.net">daum.net</option>
						<option value="hotmail.com">hotmail.com</option>
					</select>
				</div>
			</div>

			<div class="d-grid gap-2 mb-3">
				<button id="sendCodeBtn" class="btn btn-primary">인증코드 발송</button>
			</div>

			<div id="verifySection" style="display:none;">
				<div class="input-group mb-3">
					<input type="text" class="form-control" id="authcode" placeholder="인증코드 입력">
					<button id="verifyBtn" class="btn btn-success"  for="authCode">인증 확인</button>
				</div>
			</div>

			<div id="result" class="text-center fw-bold mt-3"></div>
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
		
		// 이메일 인증번호 전송
		document.getElementById('sendCodeBtn').addEvenetListener('click', function(){
			const email = emilInput.value.trim();
			if(!email){
				document.getElemnetByud('emailFeedback').innerHTML='<span class="text-danger">이메일을 입력하세요.</span>';
				return;
			}
			const xh= newXMLHttpRequest();
			xhr.open('POST', '${pageContext.request.contextPath}/ajax/sendAuthEmail')
		})
	</script>
</body>
</html>