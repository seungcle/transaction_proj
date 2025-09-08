<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>상품 등록 페이지</title>
<link rel="icon" type="image/png" href="../images/watermelon_icon.ico">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/global.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sale.css">
</head>
<body>
	<jsp:include page="../component/header.jsp" />

	<div class="container my-5">
		<div class="form-container mx-auto">
			<div class="mb-4">
				<label for="imageInput" class="form-label fw-bold">상품 이미지
					(최대 10장)</label>
				<div id="imagePreviewContainer" class="d-flex flex-wrap gap-3 mb-2"></div>

				<div class="image-uploader"
					onclick="document.getElementById('imageInput').click();">
					<i class="bi bi-camera fs-3 text-muted"></i> <span
						class="text-muted small mt-1" id="imageCount">0/10</span>
				</div>

				<input type="file" id="imageInput" multiple accept="image/*"
					style="display: none;">
			</div>

			<div class="mb-4">
				<input type="text" name="title" class="form-control form-control-lg"
					placeholder="상품명">
			</div>

			<div class="row category-select mb-4">
				<div class="col-12 col-md-7">
					<div class="list-group">
						<a href="#" class="list-group-item list-group-item-action d-flex align-items-center">
							<span>디지털</span>
							<img src="${pageContext.request.contextPath}/resources/images/phone_subak.png" width="50px" class="ms-auto"> 
						</a>
						<a href="#" class="list-group-item list-group-item-action d-flex align-items-center">
							<span>패션</span>
							<img src="${pageContext.request.contextPath}/resources/images/cloth_subak.png" width="50px" class="ms-auto"> 
						</a>
						<a href="#" class="list-group-item list-group-item-action d-flex align-items-center">
							<span>뷰티</span>
							<img src="${pageContext.request.contextPath}/resources/images/makeup_subak.png" width="50px" class="ms-auto"> 
						</a>
						<a href="#" class="list-group-item list-group-item-action d-flex align-items-center">
							<span>가구</span>
							<img src="${pageContext.request.contextPath}/resources/images/sofar_subak.png" width="50px" class="ms-auto"> 
						</a>
						<a href="#" class="list-group-item list-group-item-action d-flex align-items-center">
							<span>도서</span>
							<img src="${pageContext.request.contextPath}/resources/images/book_subak.png" width="50px" class="ms-auto"> 
						</a>
						<a href="#" class="list-group-item list-group-item-action d-flex align-items-center">
							<span>스포츠</span>
							<img src="${pageContext.request.contextPath}/resources/images/ball_subak.png" width="50px" class="ms-auto"> 
						</a>
						<a href="#" class="list-group-item list-group-item-action d-flex align-items-center">
							<span>생활</span>
							<img src="${pageContext.request.contextPath}/resources/images/living_subak.png" width="50px" class="ms-auto"> 
						</a>
					</div>
				</div>
				<div class="col-12 col-md-5 border-md-start mt-3 mt-md-0"></div>
			</div>

			<div class="input-group mb-4">
				<span class="input-group-text">₩</span> <input type="text" name="startPrice"
					class="form-control form-control-lg" placeholder="판매 시작가" min="0"
					id="priceInput">
			</div>
			
			<div class="mb-4">
				<label class="form-label fw-bold">등록 기간</label>
				<div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="registrationDuration" id="duration1" value="1" checked>
						<label class="form-check-label" for="duration1">1일</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="registrationDuration" id="duration3" value="3">
						<label class="form-check-label" for="duration3">3일</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="registrationDuration" id="duration5" value="5">
						<label class="form-check-label" for="duration5">5일</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio" name="registrationDuration" id="duration7" value="7">
						<label class="form-check-label" for="duration7">7일</label>
					</div>
				</div>
			</div>

			<div class="mb-4">
				<textarea class="form-control" name="text" id="description" rows="8"
					placeholder="- 상품명(브랜드)
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

			<hr class="mb-4">

			<div class="form-check mb-4">
				<input class="form-check-input" type="checkbox" value=""
					id="agreeCheck"> <label class="form-check-label small"
					for="agreeCheck"> 판매 정보가 실제 상품과 다를 경우, 책임은 판매자에게 있음을 동의합니다.
				</label>
			</div>

			<div class="d-grid">
                <button class="btn btn-dark btn-lg" id="submitBtn" disabled>판매 시작하기</button>
			</div>
		</div>
	</div>

	<jsp:include page="../component/footer.jsp" />
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
	// 카테고리 색상 설정
	document.querySelectorAll('.category-select .list-group-item').forEach(item => {
        item.addEventListener('click', function (e) {
            e.preventDefault();
            document.querySelectorAll('.category-select .list-group-item').forEach(el => el.classList.remove('active'));
            this.classList.add('active');
        });
    });
	
	// 원 단위 ',' 설정
	const priceInput = document.getElementById('priceInput');

	priceInput.addEventListener('input', () => {
	  let value = priceInput.value.replace(/[^\d]/g, '');
	  if (value) {
	    priceInput.value = Number(value).toLocaleString();
	  } else {
	    priceInput.value = '';
	  }
	});

    const agreeCheck = document.getElementById('agreeCheck');
    const submitBtn = document.getElementById('submitBtn');

    agreeCheck.addEventListener('change', function() {
        submitBtn.disabled = !this.checked;
    });
	</script>

</body>
</html>