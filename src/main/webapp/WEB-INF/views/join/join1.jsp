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
			<h3 class="text-center mb-4">회원가입</h3>
			<p class="text-center text-muted">수박나라 회원으로 가입하고 다양한 혜택을 누리세요.</p>

			<nav class="mb-4">
				<ol class="list-unstyled d-flex justify-content-between text-muted fw-bold">
					<li style="color: #2E8B57;">1. 약관동의</li>
					<li>2. 정보입력</li>
					<li>3. 가입완료</li>
				</ol>
				<div class="progress" style="height: 10px;">
					<div class="progress-bar bg-success" role="progressbar" style="width: 0%;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
				</div>
			</nav>

			<form action="${pageContext.request.contextPath}/join2" method="get" id="agreementForm">
				<div class="card p-3 mb-4">
					<div class="form-check mb-2">
						<input class="form-check-input" type="checkbox" id="checkAll">
						<label class="form-check-label fw-bold" for="checkAll">
							전체 동의
						</label>
					</div>
					<hr>
					<div class="form-check mb-2 d-flex justify-content-between align-items-center">
						<div>
							<input class="form-check-input required-check" type="checkbox" id="check1" required>
							<label class="form-check-label" for="check1">
								이용약관 동의 <span class="text-danger">(필수)</span>
							</label>
						</div>
						<a href="#" class="btn btn-sm btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#termsModal">보기</a>
					</div>
					<div class="form-check mb-2 d-flex justify-content-between align-items-center">
						<div>
							<input class="form-check-input required-check" type="checkbox" id="check2" required>
							<label class="form-check-label" for="check2">
								개인정보 수집 및 이용 동의 <span class="text-danger">(필수)</span>
							</label>
						</div>
						<a href="#" class="btn btn-sm btn-outline-secondary" data-bs-toggle="modal" data-bs-target="#privacyModal">보기</a>
					</div>
					<div class="form-check d-flex justify-content-between align-items-center">
						<div>
							<input class="form-check-input" type="checkbox" id="check3">
							<label class="form-check-label" for="check3">
								마케팅 정보 수신 동의 <span class="text-muted">(선택)</span>
							</label>
						</div>
						<a href="#" class="btn btn-sm btn-outline-secondary">보기</a>
					</div>
				</div>
				<div class="d-grid gap-2">
					<button type="submit" class="btn btn-success" disabled>다음</button>
				</div>
			</form>
		</div>
	</div>
	
	<div class="modal fade" id="termsModal" tabindex="-1" aria-labelledby="termsModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="termsModalLabel">수박나라 이용약관</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p>제1조 (목적)</p>
					<p>본 약관은 수박나라 서비스 이용과 관련하여 회사와 회원 간의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다.</p>
					<p>제2조 (용어의 정의)</p>
					<p>① "서비스"라 함은 구현되는 단말기(PC, 휴대용 단말기 등의 각종 유무선 장치를 포함)와 상관없이 "회원"이 이용할 수 있는 수박나라 관련 제반 서비스를 의미합니다.</p>
					<p>② "회원"이라 함은 회사의 "서비스"에 접속하여 본 약관에 따라 "회사"와 이용계약을 체결하고 "회사"가 제공하는 "서비스"를 이용하는 고객을 말합니다.</p>
					</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

	<div class="modal fade" id="privacyModal" tabindex="-1" aria-labelledby="privacyModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="privacyModalLabel">개인정보 수집 및 이용 동의</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<p>개인정보보호법에 따라 수박나라는 아래와 같이 이용자의 개인정보를 수집 및 이용합니다.</p>
					<ul>
						<li>수집 항목: 닉네임, 아이디, 비밀번호, 이메일 주소</li>
						<li>수집 목적: 회원 식별, 서비스 제공, 고객 응대</li>
						<li>보유 및 이용 기간: 회원 탈퇴 시 일주일 후 파기</li>
					</ul>
					</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		const checkAll = document.getElementById('checkAll');
		const requiredChecks = document.querySelectorAll('.required-check');
		const nextButton = document.querySelector('button[type="submit"]');

		function checkRequired() {
			let allChecked = true;
			requiredChecks.forEach(checkbox => {
				if (!checkbox.checked) {
					allChecked = false;
				}
			});
			nextButton.disabled = !allChecked;
		}

		checkAll.addEventListener('change', function() {
			document.querySelectorAll('.form-check-input').forEach(checkbox => {
				checkbox.checked = this.checked;
			});
			checkRequired();
		});

		document.querySelectorAll('.form-check-input').forEach(checkbox => {
			checkbox.addEventListener('change', function() {
				if (!this.checked) {
					checkAll.checked = false;
				}
				checkRequired();
			});
		});

		checkRequired();
	</script>
</body>
</html>