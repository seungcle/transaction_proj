<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	* 커스텀 체크박스 스타일 */
    .form-check .form-check-input {
        width: 1.25em;
        height: 1.25em;
        border-radius: 50%; /* 원형으로 만들기 */
        border: 1px solid #adb5bd;
        transition: background-color .15s ease-in-out, border-color .15s ease-in-out;
    }
    .form-check-input:checked {
        background-color: #6c757d; /* 체크 시 배경색 */
        border-color: #6c757d;
        /* 체크 아이콘 SVG 인코딩 */
        background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 20 20'%3e%3cpath fill='none' stroke='%23fff' stroke-linecap='round' stroke-linejoin='round' stroke-width='3' d='m6 10 3 3 6-6'/%3e%3c/svg%3e");
    }
    .form-check-input:focus {
        box-shadow: none;
        border-color: #adb5bd;
    }

    /* 상세 사유 입력창 스타일 */
    .form-control::placeholder {
        color: #ced4da;
    }
    .char-counter {
        font-size: 0.875em;
        color: #6c757d;
    }
</style>
</head>
<body>
	<div class="offcanvas offcanvas-end" tabindex="-1" id="withdrawOffcanvas" aria-labelledby="withdrawOffcanvasLabel">
    
    <div class="offcanvas-header">
    <button type="button" class="btn btn-link text-dark"
				data-bs-dismiss="offcanvas" aria-label="Close">
				<i class="bi bi-arrow-left fs-4"></i>
			</button>
        <h5 class="offcanvas-title w-100 text-center" id="offcanvasLabel">회원 탈퇴</h5>
    </div>
    
    <div class="offcanvas-body d-flex flex-column">
        <div class="mb-4">
            <h3>탈퇴 사유를 알려주시면<br>개선을 위해 노력하겠습니다</h3>
            <p class="text-muted small mt-3">다중 선택이 가능해요.</p>
        </div>
        
        <div class="reason-checklist mb-4">
            <div class="form-check mb-3">
                <input class="form-check-input" type="checkbox" value="" id="reason1">
                <label class="form-check-label" for="reason1">사용 빈도가 낮고 개인정보 및 보안 우려</label>
            </div>
            <div class="form-check mb-3">
                <input class="form-check-input" type="checkbox" value="" id="reason2">
                <label class="form-check-label" for="reason2">비매너 사용자들로 인한 불편 (사기 등)</label>
            </div>
            <div class="form-check mb-3">
                <input class="form-check-input" type="checkbox" value="" id="reason3">
                <label class="form-check-label" for="reason3">서비스 기능 불편 (상품등록/거래 등)</label>
            </div>
            <div class="form-check mb-3">
                <input class="form-check-input" type="checkbox" value="" id="reason4">
                <label class="form-check-label" for="reason4">이벤트 등의 목적으로 한시 사용</label>
            </div>
            <div class="form-check mb-3">
                <input class="form-check-input" type="checkbox" value="" id="reason5">
                <label class="form-check-label" for="reason5">기타</label>
            </div>
        </div>

        <div class="mb-4">
            <textarea class="form-control" id="detailsTextarea" rows="4" placeholder="상세 사유 작성 (예: 타 서비스 이용)" maxlength="200"></textarea>
            <div class="text-end mt-1 char-counter">
                <span id="charCount">0</span>/200
            </div>
        </div>

        <div class="mt-auto">
            <button class="btn btn-secondary w-100 btn-lg" style="background-color:#FF6B6B; border:1px solid white" disabled>회원 탈퇴</button>
        </div>
    </div>
</div>

<script>
    const detailsTextarea = document.getElementById('detailsTextarea');
    const charCountSpan = document.getElementById('charCount');

    // 상세 사유 입력 시 글자 수 업데이트
    detailsTextarea.addEventListener('input', () => {
        const currentLength = detailsTextarea.value.length;
        charCountSpan.textContent = currentLength;
    });

    // 하나 이상 선택 시 '회원 탈퇴' 버튼 활성화 로직
    const checkboxes = document.querySelectorAll('.reason-checklist .form-check-input');
    const withdrawalBtn = document.querySelector('.offcanvas-body .btn');

    checkboxes.forEach(checkbox => {
        checkbox.addEventListener('change', () => {
            let isAnyChecked = false;
            checkboxes.forEach(cb => {
                if (cb.checked) {
                    isAnyChecked = true;
                }
            });
            withdrawalBtn.disabled = !isAnyChecked;
        });
    });
</script>
</body>
</html>