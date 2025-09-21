<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="offcanvas offcanvas-end" tabindex="-1" id="myInfoOffcanvas" aria-labelledby="myInfoOffcanvasLabel">
    <div class="offcanvas-header">
        <h5 class="offcanvas-title" id="myInfoOffcanvasLabel">개인정보 수정</h5>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <div class="offcanvas-body">
        <div class="d-flex align-items-center mb-4">
            <img src="<%=request.getContextPath()%>/${user.imageUrl}" id="profileImagePreview" class="rounded-circle me-3" alt="Profile Image Preview" width="80" height="80">
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
                <h5 id="currentNickname" class="fw-bold">${user.nickname}</h5>
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

        <div class="info-section d-flex justify-content-between align-items-center mb-4" id="bioDisplay">
            <div>
                <p class="text-muted mb-0">한줄소개</p>
                <h6 id="currentbio" class="fw-bold text-dark">${user.bio}</h6>
            </div>
            <button class="btn btn-sm btn-outline-secondary" id="editBioBtn">변경</button>
        </div>
        <div class="edit-section" id="bioEdit" style="display: none;">
            <label for="bioInput" class="form-label">새 한줄소개</label>
            <div class="d-flex gap-2 mb-2">
                <input type="text" class="form-control form-control-sm" id="bioInput" placeholder="한줄소개">
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
    // DB 연동을 위해 jQuery를 사용합니다.
    document.addEventListener('DOMContentLoaded', function() {
        // 프로필 사진 변경
        const profileImageInput = document.getElementById('profileImageInput');
        const profileImagePreview = document.getElementById('profileImagePreview');
        profileImageInput.addEventListener('change', function(event) {
            const file = event.target.files[0];
            if (file) {
                // 1. 미리보기 업데이트
                const reader = new FileReader();
                reader.onload = function(e) {
                    profileImagePreview.src = e.target.result;
                };
                reader.readAsDataURL(file);
                
                // 2. 서버로 파일 전송
                const formData = new FormData();
                formData.append('profileImage', file);

                $.ajax({
                    url: '<%=request.getContextPath()%>/upload-profile-image',
                    type: 'POST',
                    processData: false,
                    contentType: false,
                    data: formData,
                    success: function(response) {
                        if (response.success) {
                            console.log("프로필 사진이 성공적으로 변경되었습니다.");
                        } else {
                            console.error("사진 업로드 실패: " + response.message);
                            // 실패 시 기존 이미지로 복원
                            profileImagePreview.src = '<%=request.getContextPath()%>/' + '${user.imageUrl}';
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("서버 통신 오류: " + xhr.responseText);
                        // 오류 시 기존 이미지로 복원
                        profileImagePreview.src = '<%=request.getContextPath()%>/' + '${user.imageUrl}';
                    }
                });
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
            const displayDiv = $('#' + sectionName + 'Display');
            const editDiv = $('#' + sectionName + 'Edit');
            const editBtn = $('#edit' + sectionName.charAt(0).toUpperCase() + sectionName.slice(1) + 'Btn');
            const saveBtn = $('#save' + sectionName.charAt(0).toUpperCase() + sectionName.slice(1) + 'Btn');
            const cancelBtn = $('#cancel' + sectionName.charAt(0).toUpperCase() + sectionName.slice(1) + 'Btn');
            const inputField = $('#' + sectionName + 'Input');
            
            // 한줄소개(bio)와 다른 섹션의 ID 규칙이 다르므로 예외 처리
            const currentText = (sectionName === 'bio') ? $('#currentbio') : $('#current' + sectionName.charAt(0).toUpperCase() + sectionName.slice(1));
            
            // '수정' 버튼 클릭 시
            editBtn.on('click', function() {
                displayDiv.hide();
                editDiv.show();
                if(inputField.length) {
                    // 한줄소개는 비어있을 경우 초기값을 설정하지 않음
                    if (sectionName !== 'bio' || currentText.text().trim() !== '') {
                        inputField.val(currentText.text().trim());
                    } else {
                        inputField.val('');
                    }
                }
            });
            
            // '취소' 버튼 클릭 시
            cancelBtn.on('click', function() {
                displayDiv.css('display', 'flex');
                editDiv.hide();
                clearValidationState(editDiv);
            });
            
            // '저장' 버튼 클릭 시
            saveBtn.on('click', function() {
                let isValid = true;
                let data = {};
                let url = '';
                
                if (sectionName === 'nickname') {
                    const newNickname = inputField.val().trim();
                    if (!newNickname) {
                        showFeedback(inputField, '닉네임을 입력하세요.', false);
                        isValid = false;
                    } else {
                        data = { "newNickname": newNickname };
                        url = '<%=request.getContextPath()%>/update-nickname';
                    }
                } else if (sectionName === 'bio') {
                    const newBio = inputField.val().trim();
                    data = { "newBio": newBio };
                    url = '<%=request.getContextPath()%>/update-bio';
                } else if (sectionName === 'password') {
                    const currentPasswordInput = $('#currentPasswordInput');
                    const newPasswordInput = $('#newPasswordInput');
                    const confirmPasswordInput = $('#confirmPasswordInput');
                    
                    const currentPassword = currentPasswordInput.val();
                    const newPassword = newPasswordInput.val();
                    const confirmPassword = confirmPasswordInput.val();
                    
                    if (!currentPassword || !newPassword || !confirmPassword) {
                        alert("비밀번호 변경 시 모든 필드를 입력해야 합니다.");
                        isValid = false;
                    } else if (newPassword.length < 8) {
                        showFeedback(newPasswordInput, '새 비밀번호는 8자 이상이어야 합니다.', false);
                        isValid = false;
                    } else if (newPassword !== confirmPassword) {
                        showFeedback(confirmPasswordInput, '비밀번호가 일치하지 않습니다.', false);
                        isValid = false;
                    } else {
                        data = { "currentPassword": currentPassword, "newPassword": newPassword };
                        url = '<%=request.getContextPath()%>/update-password';
                    }
                }
                
                if (isValid) {
                    // 서버 통신
                    $.ajax({
                        url: url,
                        type: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify(data),
                        success: function(response) {
                            if (response.success) {
                                alert(response.message);
                                if (sectionName === 'nickname') {
                                    currentText.text(data.newNickname);
                                } else if (sectionName === 'bio') {
                                    currentText.text(data.newBio);
                                }
                                displayDiv.css('display', 'flex');
                                editDiv.hide();
                                clearValidationState(editDiv);
                            } else {
                                // 백엔드에서 받은 에러 메시지를 사용자에게 표시
                                if (sectionName === 'nickname') {
                                    showFeedback(inputField, response.message, false);
                                } else if (sectionName === 'password') {
                                    showFeedback($('#currentPasswordInput'), response.message, false);
                                }
                            }
                        },
                        error: function(xhr, status, error) {
                            // 서버 통신 자체에 문제가 있을 때
                            let errorMessage = "서버와 통신 중 오류가 발생했습니다.";
                            try {
                                const response = JSON.parse(xhr.responseText);
                                if(response && response.message) {
                                    errorMessage = response.message;
                                }
                            } catch (e) {
                                // JSON 파싱 실패 시 기본 메시지 사용
                            }
                            alert(errorMessage);
                        }
                    });
                }
            });

            // 유효성 피드백 표시 함수
            function showFeedback(inputElement, message, isValid) {
                const feedbackElement = inputElement.next('.invalid-feedback');
                if (isValid) {
                    inputElement.removeClass('is-invalid').addClass('is-valid');
                    feedbackElement.hide();
                } else {
                    inputElement.removeClass('is-valid').addClass('is-invalid');
                    feedbackElement.text(message).show();
                }
            }

            // 유효성 상태 초기화
            function clearValidationState(section) {
                section.find('input').removeClass('is-invalid is-valid');
                section.find('.invalid-feedback').text('').hide();
            }
        }
    });
</script>