<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록 페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>
    body {
        background-color: #f8f9fa;
    }
    .form-container {
        max-width: 700px;
        background-color: #fff;
        padding: 2rem 3rem;
        border-radius: 0.5rem;
    }

    /* 이미지 업로더 */
    .image-uploader {
        width: 100px;
        height: 100px;
        border: 1px dashed #ced4da;
        border-radius: 0.5rem;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        cursor: pointer;
        background-color: #f8f9fa;
    }
    .image-uploader:hover {
        border-color: #0d6efd;
    }

    /* 카테고리 선택 */
    .category-select .list-group-item.active {
        background-color: #fff;
        color: #0d6efd;
        font-weight: bold;
        border-color: #dee2e6;
        border-left: 3px solid #0d6efd;
    }

    /* 상품 상태 선택 (버튼형 라디오) */
    .btn-check:checked+.btn-outline-secondary {
        background-color: #198754; /* 초록색 */
        color: white;
        border-color: #198754;
    }

    /* 동의 체크박스 */
    .form-check-input:checked {
        background-color: #198754;
        border-color: #198754;
    }

    /* 폼 컨트롤 스타일 */
    .form-control, .input-group-text {
        border-radius: 0.5rem;
    }
    .form-control:focus {
        box-shadow: none;
        border-color: #333;
    }
</style>
</head>
<body>

<div class="container my-5">
    <div class="form-container mx-auto">
        <div class="mb-4">
            <div class="image-uploader">
                <i class="bi bi-camera fs-3 text-muted"></i>
                <span class="text-muted small mt-1">0/10</span>
            </div>
        </div>
        
        <div class="mb-4">
            <input type="text" class="form-control form-control-lg" placeholder="상품명">
        </div>

        <div class="row category-select mb-4">
            <div class="col-6">
                <div class="list-group">
                    <a href="#" class="list-group-item list-group-item-action active" aria-current="true">디지털</a>
                    <a href="#" class="list-group-item list-group-item-action">패션</a>
                    <a href="#" class="list-group-item list-group-item-action">뷰티</a>
                    <a href="#" class="list-group-item list-group-item-action">가구</a>
                    <a href="#" class="list-group-item list-group-item-action">도서</a>
                    <a href="#" class="list-group-item list-group-item-action">스포츠</a>
                </div>
            </div>
            <div class="col-6 border-start">
                </div>
        </div>

        <div class="input-group mb-4">
            <span class="input-group-text">₩</span>
            <input type="number" class="form-control form-control-lg" placeholder="판매가격">
        </div>

        <div class="mb-4">
            <textarea class="form-control" id="description" rows="8" placeholder="상품에 대한 설명을 자세히 적어주세요.">- 상품명(브랜드)
- 구매 시기 (년, 월, 일)
- 사용 기간
- 하자 여부

* 실제 촬영한 사진과 함께 상세 정보를 입력해주세요.
* 카카오톡 아이디 첨부 시 게시물 삭제 및 이용제재 처리될 수 있어요.
안전하고 건전한 거래환경을 위해 과학기술정보통신부, 한국인터넷진흥원, 중고나라가 함께합니다.</textarea>
            <div class="text-end text-muted small mt-1">
                <span id="charCount">0</span>/1000
            </div>
        </div>

        <div class="mb-4">
            <label class="form-label fw-bold">상품상태</label>
            <div>
                <input type="radio" class="btn-check" name="condition" id="condition_used" autocomplete="off" checked>
                <label class="btn btn-outline-secondary" for="condition_used">중고</label>

                <input type="radio" class="btn-check" name="condition" id="condition_new" autocomplete="off">
                <label class="btn btn-outline-secondary" for="condition_new">새상품</label>
            </div>
        </div>

        <div class="mb-5">
            <label class="form-label fw-bold">거래방법</label>
            <div class="d-flex">
                <div class="form-check me-4">
                    <input class="form-check-input" type="checkbox" value="" id="delivery" checked>
                    <label class="form-check-label" for="delivery">택배거래</label>
                </div>
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" value="" id="direct">
                    <label class="form-check-label" for="direct">직거래</label>
                </div>
            </div>
        </div>
        
        <hr class="mb-4">

        <div class="form-check mb-4">
            <input class="form-check-input" type="checkbox" value="" id="agreeCheck">
            <label class="form-check-label small" for="agreeCheck">
                판매 정보가 실제 상품과 다를 경우, 책임은 판매자에게 있음을 동의합니다.
            </label>
        </div>

        <div class="d-grid">
            <button class="btn btn-dark btn-lg">판매하기</button>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // 상세 설명 글자 수 카운터
    const descriptionTextarea = document.getElementById('description');
    const charCountSpan = document.getElementById('charCount');

    // 페이지 로드 시 초기 글자 수 계산
    charCountSpan.textContent = descriptionTextarea.value.length;

    descriptionTextarea.addEventListener('input', () => {
        const currentLength = descriptionTextarea.value.length;
        charCountSpan.textContent = currentLength;
    });
</script>
</body>
</html>