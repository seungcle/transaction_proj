<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록 페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

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
    .category-select .list-group-item.active {
    	background-color: #eaf5ea;
    	color: #3c8a4b;
    	font-weight: bold;
    	border-color: #dee2e6;
    	border-left: 3px solid #3c8a4b;
	}
    .btn-check:checked+.btn-outline-secondary {
        background-color: #198754;
        color: white;
        border-color: #198754;
    }

    .form-check-input:checked {
        background-color: #198754;
        border-color: #198754;
    }

    .form-control, .input-group-text {
        border-radius: 0.5rem;
    }
    .form-control:focus {
        box-shadow: none;
        border-color: #333;
    }

    .preview-wrapper {
        width: 80px;
        height: 80px;
        position: relative;
    }
    .preview-wrapper img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        border-radius: 0.5rem;
        border: 1px solid #ced4da;
    }
    .preview-wrapper button {
        position: absolute;
        top: 0;
        right: 0;
        padding: 0.2rem 0.4rem;
        font-size: 0.8rem;
        line-height: 1;
    }
    .form-control::placeholder {
    color: #adb5bd; 
    font-style: italic;
	}
	
</style>
</head>
<body>
<!-- header.jsp -->
<jsp:include page="header.jsp" />

<div class="container my-5">
    <div class="form-container mx-auto">
        <!-- 이미지 업로드 -->
        <div class="mb-4">
            <label for="imageInput" class="form-label fw-bold">상품 이미지 (최대 10장)</label>
            <div id="imagePreviewContainer" class="d-flex flex-wrap gap-3 mb-2"></div>

            <div class="image-uploader" onclick="document.getElementById('imageInput').click();">
                <i class="bi bi-camera fs-3 text-muted"></i>
                <span class="text-muted small mt-1" id="imageCount">0/10</span>
            </div>

            <input type="file" id="imageInput" multiple accept="image/*" style="display:none;">
        </div>

        <!-- 상품명 -->
        <div class="mb-4">
            <input type="text" class="form-control form-control-lg" placeholder="상품명">
        </div>

        <!-- 카테고리 -->
        <div class="row category-select mb-4">
            <div class="col-7">
                <div class="list-group">
                    <a href="#" class="list-group-item list-group-item-action active">디지털</a>
                    <a href="#" class="list-group-item list-group-item-action">패션</a>
                    <a href="#" class="list-group-item list-group-item-action">뷰티</a>
                    <a href="#" class="list-group-item list-group-item-action">가구</a>
                    <a href="#" class="list-group-item list-group-item-action">도서</a>
                    <a href="#" class="list-group-item list-group-item-action">스포츠</a>
                    <a href="#" class="list-group-item list-group-item-action">생활</a>
                </div>
            </div>
            <div class="col-6 border-start"></div>
        </div>

        <!-- 가격 -->
        <div class="input-group mb-4">
            <span class="input-group-text">₩</span>
            <input type="number" class="form-control form-control-lg" placeholder="판매 시작가" step="1000">
        </div>

        <!-- 설명 -->
        <div class="mb-4">
            <textarea class="form-control" id="description" rows="8" placeholder="- 상품명(브랜드)
- 구매 시기 : (년, 월, 일)
- 사용 기간 :
- 하자 여부 :

* 실제 촬영한 사진과 함께 상세 정보를 입력해주세요.
* 부적절한 게시글 확인시 삭제될 수 있어요.
* 개인정보에 관한글은 유의해 주세요."></textarea>
            <div class="text-end text-muted small mt-1">
                <span id="charCount">0</span>/1000
            </div>
        </div>

    <!--     상품 상태
        <div class="mb-4">
            <label class="form-label fw-bold">상품상태</label>
            <div>
                <input type="radio" class="btn-check" name="condition" id="condition_used" autocomplete="off" checked>
                <label class="btn btn-outline-secondary" for="condition_used">중고</label>

                <input type="radio" class="btn-check" name="condition" id="condition_new" autocomplete="off">
                <label class="btn btn-outline-secondary" for="condition_new">새상품</label>
            </div>
        </div> -->


        <hr class="mb-4">

        <!-- 동의 -->
        <div class="form-check mb-4">
            <input class="form-check-input" type="checkbox" value="" id="agreeCheck">
            <label class="form-check-label small" for="agreeCheck">
                판매 정보가 실제 상품과 다를 경우, 책임은 판매자에게 있음을 동의합니다.
            </label>
        </div>

        <!-- 등록 -->
        <div class="d-grid">
            <button class="btn btn-dark btn-lg">판매 시작하기</button>
        </div>
    </div>
</div>


<script>
    // 설명 글자 수 카운터
    const descriptionTextarea = document.getElementById('description');
    const charCountSpan = document.getElementById('charCount');
    charCountSpan.textContent = descriptionTextarea.value.length;
    descriptionTextarea.addEventListener('input', () => {
        charCountSpan.textContent = descriptionTextarea.value.length;
    });

    // 이미지 업로드 및 삭제 기능
    const imageInput = document.getElementById('imageInput');
	const imagePreviewContainer = document.getElementById('imagePreviewContainer');
	const imageCount = document.getElementById('imageCount');

	let selectedFiles = [];

	imageInput.addEventListener('change', function () {
    	const newFiles = Array.from(imageInput.files);
    	const remainingSlots = 10 - selectedFiles.length;

    	if (newFiles.length > remainingSlots) {
        	alert(`이미지는 최대 10장까지 업로드할 수 있습니다. (${remainingSlots}장만 추가 가능)`);
        	newFiles.splice(remainingSlots); // 초과된 파일 제거
    	}

    	selectedFiles = selectedFiles.concat(newFiles);
    	
    	console.log("현재 선택된 전체 파일:", selectedFiles);
        console.log("현재 파일 개수:", selectedFiles.length);
        
    	imageInput.value = ""; // 동일한 파일 다시 선택 가능하게 초기화
    	renderPreviews();
    	
	});
	function renderPreviews() {
    	imagePreviewContainer.innerHTML = '';

    	selectedFiles.forEach((file, index) => {
        	const reader = new FileReader();
        	reader.onload = function (e) {
            	const wrapper = document.createElement('div');
            	wrapper.className = 'preview-wrapper';

            	const img = document.createElement('img');
            	img.src = e.target.result;

            	const deleteBtn = document.createElement('button');
            	deleteBtn.innerHTML = '&times;';
            	deleteBtn.className = 'btn btn-sm btn-danger';
            	deleteBtn.onclick = () => {
                selectedFiles.splice(index, 1);
                renderPreviews(); 
            };

            wrapper.appendChild(img);
            wrapper.appendChild(deleteBtn);
            imagePreviewContainer.appendChild(wrapper);
        };
        reader.readAsDataURL(file);
    });

    imageCount.textContent = selectedFiles.length+"/10";
    
}
	document.querySelectorAll('.category-select .list-group-item').forEach(item => {
        item.addEventListener('click', function (e) {
            e.preventDefault();
            document.querySelectorAll('.category-select .list-group-item').forEach(el => el.classList.remove('active'));
            this.classList.add('active');
        });
    });

</script>