<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 탈퇴</title>
<link rel="icon" type="image/png" href="../images/watermelon_icon.ico">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/withdraw.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
<div class="offcanvas offcanvas-end" tabindex="-1" id="withdrawOffcanvas" aria-labelledby="withdrawOffcanvasLabel">
  <div class="offcanvas-header">
    <h5 class="offcanvas-title w-100 text-center" id="withdrawOffcanvasLabel">회원 탈퇴</h5>
    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>

  <div class="offcanvas-body d-flex flex-column">
    <div class="mb-4">
      <h3>탈퇴 사유를 알려주시면<br>개선을 위해 노력하겠습니다</h3>
      <p class="text-muted small mt-3">다중 선택이 가능해요.</p>
    </div>

    <div class="reason-checklist mb-4">
      <div class="form-check mb-3">
        <input class="form-check-input" type="checkbox" id="reason1" value="freq_security">
        <label class="form-check-label" for="reason1">사용 빈도가 낮고 개인정보 및 보안 우려</label>
      </div>
      <div class="form-check mb-3">
        <input class="form-check-input" type="checkbox" id="reason2" value="bad_users">
        <label class="form-check-label" for="reason2">비매너 사용자들로 인한 불편 (사기 등)</label>
      </div>
      <div class="form-check mb-3">
        <input class="form-check-input" type="checkbox" id="reason3" value="feature_pain">
        <label class="form-check-label" for="reason3">서비스 기능 불편 (상품등록/거래 등)</label>
      </div>
      <div class="form-check mb-3">
        <input class="form-check-input" type="checkbox" id="reason4" value="temporary">
        <label class="form-check-label" for="reason4">이벤트 등의 목적으로 한시 사용</label>
      </div>
      <div class="form-check mb-3">
        <input class="form-check-input" type="checkbox" id="reason5" value="etc">
        <label class="form-check-label" for="reason5">기타</label>
      </div>
    </div>

    <div class="mb-4">
      <textarea class="form-control" id="detailsTextarea" rows="4"
                placeholder="상세 사유 작성 (예: 타 서비스 이용)"
                maxlength="200"></textarea>
      <div class="text-end mt-1 char-counter">
        <span id="charCount">0</span>/200
      </div>
    </div>

    <div class="mt-auto">
      <button class="btn btn-secondary w-100 btn-lg btn-withdraw" disabled>회원 탈퇴</button>
    </div>
  </div>
</div>

<script>
  // 글자수 카운터
  const detailsTextarea = document.getElementById('detailsTextarea');
  const charCountSpan = document.getElementById('charCount');
  detailsTextarea.addEventListener('input', () => {
    charCountSpan.textContent = detailsTextarea.value.length;
  });

  // 체크 여부에 따라 버튼 활성화
  const checkboxes = document.querySelectorAll('.reason-checklist .form-check-input');
  const withdrawalBtn = document.querySelector('.btn-withdraw');
  function refreshButtonState() {
    const isAnyChecked = Array.from(checkboxes).some(cb => cb.checked);
    withdrawalBtn.disabled = !isAnyChecked;
  }
  checkboxes.forEach(cb => cb.addEventListener('change', refreshButtonState));
</script>
</body>
</html>
