<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>아이디 찾기</title>
<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/watermelon_icon.ico">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/global.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/findUserName.css">
</head>
<body>
<div class="container">
    <a class="logo" href="${pageContext.request.contextPath}/main">
        <img id="main-icon" src="${pageContext.request.contextPath}/resources/images/watermelon_icon.png" alt="수박 아이콘">
        <span>수박나라</span>
    </a>

    <div class="login-card p-4">
        <h3 class="text-center mb-4">아이디 찾기</h3>
        <p class="text-center text-muted">본인 확인을 위해 이메일 주소를 입력해주세요.</p>

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
            <div id="emailFeedback" class="mt-2" style="font-size: 0.875em;"></div>
        </div>

        <div class="d-grid gap-2 mb-3">
            <button id="sendCodeBtn" class="btn btn-success">인증코드 발송</button>
        </div>

        <div id="authCodeRow" style="display: none;">
            <div class="input-group mb-3">
                <input type="text" class="form-control" id="authCodeInput" placeholder="인증코드 입력">
                <button id="verifyBtn" class="btn btn-success">인증 확인</button>
            </div>
            <div id="authCodeFeedback" class="mt-2" style="font-size: 0.875em;"></div>
        </div>

        <div id="result" class="text-center fw-bold mt-3"></div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
    const emailSelect = document.getElementById('emailSelect');
    const domainInput = document.getElementById('emailDomain');
    const emailIdInput = document.getElementById('emailId');
    const sendCodeBtn = document.getElementById('sendCodeBtn');
    const authCodeRow = document.getElementById('authCodeRow');
    const authCodeInput = document.getElementById('authCodeInput');
    const verifyBtn = document.getElementById('verifyBtn');
    const emailFeedback = document.getElementById('emailFeedback');
    const authCodeFeedback = document.getElementById('authCodeFeedback');
    const resultDiv = document.getElementById('result');

    emailSelect.addEventListener('change', function() {
        if (this.value === 'direct') {
            domainInput.value = '';
            domainInput.readOnly = false;
            domainInput.focus();
        } else {
            domainInput.value = this.value;
            domainInput.readOnly = true;
        }
    });

    sendCodeBtn.addEventListener('click', function() {
    	const email = (emailIdInput.value.trim() + '@' + domainInput.value.trim()).trim();
        if (!emailIdInput.value.trim() || !domainInput.value.trim()) {
            emailFeedback.innerHTML = '<span class="text-danger">이메일 주소를 입력하세요.</span>';
            return;
        }

        const xml = new XMLHttpRequest();
        xml.open('POST', '${pageContext.request.contextPath}/ajax/sendFindIdEmail', true);
        xml.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xml.onload = function() {
            if (xml.responseText.trim() === 'success') {
                emailFeedback.innerHTML = '<span class="text-success">인증번호가 전송되었습니다.</span>';
                authCodeRow.style.display = 'block';
                sendCodeBtn.disabled = true;
                emailIdInput.readOnly = true;
                domainInput.readOnly = true;
            } else {
                emailFeedback.innerHTML = '<span class="text-danger">인증번호 전송에 실패했습니다.</span>';
            }
        };
        xml.send('email=' + encodeURIComponent(email));
    });

    verifyBtn.addEventListener('click', function() {
        const email = emailIdInput.value.trim() + '@' + domainInput.value.trim();
        const code = authCodeInput.value.trim();
        if (!code) {
            authCodeFeedback.innerHTML = '<span class="text-danger">인증번호를 입력하세요.</span>';
            return;
        }

        const xml = new XMLHttpRequest();
        xml.open('POST', '${pageContext.request.contextPath}/ajax/verifyAuthCode', true);
        xml.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        xml.onload = function() {
            if (xml.responseText.trim() === 'success') {
                authCodeFeedback.innerHTML = '<span class="text-success">인증 성공!</span>';

                // 인증 후 아이디 찾기
                const findIdReq = new XMLHttpRequest();
                findIdReq.open('POST', '${pageContext.request.contextPath}/ajax/findId', true);
                findIdReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                findIdReq.onload = function() {
                    const res = findIdReq.responseText.trim();
                    if (res !== 'fail') {
                        resultDiv.innerHTML = '<div class="alert alert-success mt-3">회원님의 아이디는 <strong>' + res + '</strong> 입니다.</div>';
                        verifyBtn.disabled = true;
                        authCodeInput.readOnly = true;
                    } else {
                        resultDiv.innerHTML = '<div class="alert alert-danger mt-3">아이디를 찾을 수 없습니다.</div>';
                    }
                };
                findIdReq.send('email=' + encodeURIComponent(email) + '&code=' + encodeURIComponent(code));
            } else {
                authCodeFeedback.innerHTML = '<span class="text-danger">인증번호가 일치하지 않습니다.</span>';
            }
        };
        xml.send('authCode=' + encodeURIComponent(code) + '&type=findId');
    });
});
</script>
</body>
</html>
