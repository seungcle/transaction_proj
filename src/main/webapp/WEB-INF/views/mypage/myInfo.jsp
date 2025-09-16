<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="offcanvas offcanvas-end" tabindex="-1" id="myInfoOffcanvas" aria-labelledby="myInfoOffcanvasLabel">
	<div class="offcanvas-header">
		<h5 class="offcanvas-title" id="myInfoOffcanvasLabel">개인정보 수정</h5>
		<button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
	</div>
	<div class="offcanvas-body">
		<div class="d-flex align-items-center mb-4">
			<img src="https://i.pravatar.cc/100?u=a042581f4e29026704d" id="profileImagePreview" class="rounded-circle me-3" alt="Profile Image Preview" width="80" height="80">
			<div>
				<h5 class="mb-0">프로필 사진</h5>
				<p class="text-muted mb-0">프로필 사진을 변경하세요.</p>
			</div>
			<div class="ms-auto">
				<input type="file" class="d-none" id="profileImageInput" accept="image/*">
				<button type="button" class="btn btn-sm btn-outline-secondary" onclick="document.getElementById('profileImageInput').click();">변경</button>
			</div>
		</div>

		<hr>

		<div class="info-section d-flex justify-content-between align-items-center mb-4" id="nicknameDisplay">
			<div>
				<p class="text-muted mb-0">닉네임</p>
				<h5 id="currentNickname" class="fw-bold">자상한새벽스피넬</h5>
			</div>
			<button class="btn btn-sm btn-outline-secondary" id="editNicknameBtn">변경</button>
		</div>
		<div class="edit-section" id="nicknameEdit" style="display: none;">
			<label for="nicknameInput" class="form-label">새 닉네임</label>
			<div class="d-flex gap-2 mb-2">
				<input type="text" class="form-control form-control-sm" id="nicknameInput" placeholder="닉네임" required>
			</div>
			<div class="d-flex gap-2 justify-content-end">
				<button class="btn btn-sm btn-success" id="saveNicknameBtn">저장</button>
				<button class="btn btn-sm btn-secondary" id="cancelNicknameBtn">취소</button>
			</div>
			<div class="invalid-feedback d-block" id="nicknameFeedback" style="display: none;"></div>
		</div>

		<hr>

		<div class="info-section d-flex justify-content-between align-items-center mb-4" id="BioDisplay">
			<div>
				<p class="text-muted mb-0">한줄소개</p>
				<h6 id="currentbio" class="fw-bold text-dark">친절하고 안전한 거래를 약속합니다.</h6>
			</div>
			<button class="btn btn-sm btn-outline-secondary" id="editBioBtn">수정</button>
		</div>
		<div class="edit-section" id="BioEdit" style="display: none;">
			<label for="BioInput" class="form-label">새 한줄소개</label>
			<div class="d-flex gap-2 mb-2">
				<input type="text" class="form-control form-control-sm" id="bioInput" placeholder="한줄소개" value="친절하고 안전한 거래를 약속합니다.">
			</div>
			<div class="d-flex gap-2 justify-content-end">
				<button class="btn btn-sm btn-success" id="saveBioBtn">저장</button>
				<button class="btn btn-sm btn-secondary" id="cancelBioBtn">취소</button>
			</div>
		</div>

		<hr>

		<div class="info-section d-flex justify-content-between align-items-center mb-4" id="passwordDisplay">
			<div>
				<p class="text-muted mb-0">비밀번호</p>
				<h5 class="fw-bold">********</h5>
			</div>
			<button class="btn btn-sm btn-outline-secondary" id="editPasswordBtn">변경</button>
		</div>
		<div class="edit-section" id="passwordEdit" style="display: none;">
			<div class="mb-3">
				<label for="currentPasswordInput" class="form-label">현재 비밀번호</label> <input type="password" class="form-control form-control-sm" id="currentPasswordInput" required>
				<div class="invalid-feedback" id="currentPasswordFeedback"></div>
			</div>
			<div class="mb-3">
				<label for="newPasswordInput" class="form-label">새 비밀번호</label> <input type="password" class="form-control form-control-sm" id="newPasswordInput" minlength="8" required>
				<div class="invalid-feedback" id="newPasswordFeedback"></div>
			</div>
			<div class="mb-3">
				<label for="confirmPasswordInput" class="form-label">새 비밀번호 확인</label> <input type="password" class="form-control form-control-sm" id="confirmPasswordInput" required>
				<div class="invalid-feedback" id="passwordMatchFeedback"></div>
			</div>
			<div class="d-flex gap-2 justify-content-end">
				<button class="btn btn-sm btn-success" id="savePasswordBtn">저장</button>
				<button class="btn btn-sm btn-secondary" id="cancelPasswordBtn">취소</button>
			</div>
		</div>

	</div>
</div>
<script>
	document.addEventListener('DOMContentLoaded', function() {
		// 프로필 사진 변경
		const profileImageInput = document.getElementById('profileImageInput');
		const profileImagePreview = document.getElementById('profileImagePreview');
		profileImageInput.addEventListener('change', function(event) {
			const file = event.target.files[0];
			if (file) {
				const reader = new FileReader();
				reader.onload = function(e) {
					profileImagePreview.src = e.target.result;
					alert("프로필 사진이 변경되었습니다.");
				};
				reader.readAsDataURL(file);
			}
		});

		// 닉네임 수정
		setupEditSection('nickname');
		
		// 한줄소개 수정
		setupEditSection('bio');

		// 비밀번호 변경
		setupEditSection('password');

		// 공통 로직을 처리하는 함수
		function setupEditSection(sectionName) {
			const displayDiv = document.getElementById(sectionName + 'Display');
			const editDiv = document.getElementById(sectionName + 'Edit');
			const editBtn = document.getElementById('edit' + sectionName.charAt(0).toUpperCase() + sectionName.slice(1) + 'Btn');
			const saveBtn = document.getElementById('save' + sectionName.charAt(0).toUpperCase() + sectionName.slice(1) + 'Btn');
			const cancelBtn = document.getElementById('cancel' + sectionName.charAt(0).toUpperCase() + sectionName.slice(1) + 'Btn');
			const inputField = document.getElementById(sectionName + 'Input');
			const currentText = document.getElementById('current' + sectionName.charAt(0).toUpperCase() + sectionName.slice(1));
			
			// '수정' 버튼 클릭 시
			editBtn.addEventListener('click', function() {
				displayDiv.style.display = 'none';
				editDiv.style.display = 'block';
				if(inputField) {
					inputField.value = currentText.textContent;
				}
			});
			
			// '취소' 버튼 클릭 시
			cancelBtn.addEventListener('click', function() {
				displayDiv.style.display = 'flex';
				editDiv.style.display = 'none';
				clearValidationState(editDiv);
			});
			
			// '저장' 버튼 클릭 시
			saveBtn.addEventListener('click', function() {
				// 여기서 각 항목별 유효성 검사 및 서버 전송 로직 추가
				let isValid = true;
				
				if (sectionName === 'nickname') {
					if (!inputField.value) {
						showFeedback(inputField, '닉네임을 입력하세요.', false);
						isValid = false;
					} else if (inputField.value === "자상한새벽스피넬") {
						showFeedback(inputField, '이미 사용 중인 닉네임입니다.', false);
						isValid = false;
					} else {
						showFeedback(inputField, '', true);
					}
				} else if (sectionName === 'password') {
					const currentPasswordInput = document.getElementById('currentPasswordInput');
					const newPasswordInput = document.getElementById('newPasswordInput');
					const confirmPasswordInput = document.getElementById('confirmPasswordInput');
					
					if (!currentPasswordInput.value || !newPasswordInput.value || !confirmPasswordInput.value) {
						alert("비밀번호 변경 시 모든 필드를 입력해야 합니다.");
						isValid = false;
					} else if (newPasswordInput.value.length < 8) {
						showFeedback(newPasswordInput, '새 비밀번호는 8자 이상이어야 합니다.', false);
						isValid = false;
					} else if (newPasswordInput.value !== confirmPasswordInput.value) {
						showFeedback(confirmPasswordInput, '비밀번호가 일치하지 않습니다.', false);
						isValid = false;
					} else {
						// 실제 서버 전송 로직 (현재는 임시)
						showFeedback(currentPasswordInput, '', true);
						showFeedback(newPasswordInput, '', true);
						showFeedback(confirmPasswordInput, '', true);
					}
				}
				
				if (isValid) {
					// 서버 통신 성공 가정
					if (sectionName === 'nickname' || sectionName === 'bio') {
						currentText.textContent = inputField.value;
					}
					alert(sectionName === 'password' ? '비밀번호가 변경되었습니다!' : '정보가 수정되었습니다!');
					displayDiv.style.display = 'flex';
					editDiv.style.display = 'none';
					clearValidationState(editDiv);
				}
			});

			// 유효성 피드백 표시 함수
			function showFeedback(inputElement, message, isValid) {
				const feedbackElement = inputElement.nextElementSibling;
				if (isValid) {
					inputElement.classList.remove('is-invalid');
					inputElement.classList.add('is-valid');
					feedbackElement.style.display = 'none';
				} else {
					inputElement.classList.remove('is-valid');
					inputElement.classList.add('is-invalid');
					feedbackElement.textContent = message;
					feedbackElement.style.display = 'block';
				}
			}

			// 유효성 상태 초기화
			function clearValidationState(section) {
				const inputs = section.querySelectorAll('input');
				inputs.forEach(input => {
					input.classList.remove('is-invalid', 'is-valid');
				});
				const feedbacks = section.querySelectorAll('.invalid-feedback');
				feedbacks.forEach(feedback => {
					feedback.style.display = 'none';
				});
			}
		}

	});
</script>