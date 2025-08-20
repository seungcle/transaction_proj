<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>검색 결과 페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>
    /* 커스텀 스타일 */
    .filter-section {
        background-color: #f8f9fa;
        border-radius: 0.5rem;
    }
    .product-card {
        border: none;
    }
    .product-card .card-img-container {
        position: relative;
    }
    .product-card .card-img-top {
        border-radius: 0.5rem;
        aspect-ratio: 1 / 1; /* 이미지 비율 1:1로 유지 */
        object-fit: cover;
    }
    .product-card .wish-btn {
        position: absolute;
        bottom: 0.5rem;
        right: 0.5rem;
        background-color: rgba(255, 255, 255, 0.7);
        border: none;
        border-radius: 50%;
        width: 30px;
        height: 30px;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #333;
    }
    .product-card .card-body {
        padding: 0.75rem 0.25rem;
    }
    .product-card .card-title {
        font-size: 0.9rem;
        color: #212529;
        /* 제목이 길어지면 ...으로 표시 */
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
    .product-card .card-price {
        font-size: 1.1rem;
        font-weight: bold;
    }
    .product-card .card-meta {
        font-size: 0.8rem;
        color: #6c757d;
    }
</style>
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="container mt-4 mb-5">
    <h2 class="mb-3">검색 결과</h2>
    <hr>
    <%
    	String category = request.getParameter("category"); 
    	if (category == null) category = "전체";
	%>
    
    <div class="filter-section p-3 mb-4">
        <div class="row align-items-center g-3">
            <div class="col-md-auto fw-bold">카테고리</div>
            <div class="col-md-auto">
                <button class="btn btn-dark btn-sm"><%= category %></button>
            </div>
        </div>
        <hr class="my-2">
        <div class="row align-items-center g-3">
            <div class="col-md-auto fw-bold">가격</div>
            <div class="col-md">
                <div class="row g-2 align-items-center">
                    <div class="col">
                        <input type="text" class="form-control form-control-sm priceInput" placeholder="최소 가격">
                    </div>
                    <div class="col-auto">~</div>
                    <div class="col">
                        <input type="text" class="form-control form-control-sm priceInput" placeholder="최대 가격">
                    </div>
                    <div class="col-12 col-sm-auto mt-2 mt-sm-0">
                        <button class="btn btn-dark btn-sm w-100">적용</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="d-flex justify-content-end align-items-center mb-3">
        <a href="#" class="text-decoration-none text-dark fw-bold small me-3">추천순</a>
        <a href="#" class="text-decoration-none text-muted small me-3">최신순</a>
        <a href="#" class="text-decoration-none text-muted small me-3">낮은가격순</a>
        <a href="#" class="text-decoration-none text-muted small">높은가격순</a>
    </div>

    <div class="row row-cols-2 row-cols-md-3 row-cols-lg-5 g-4">
        
        <div class="col">
            <div class="product-card">
                <div class="card-img-container">
                    <img src="data:image/jpeg;base64,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" class="card-img-top" alt="상품 이미지">
                    <button class="wish-btn"><i class="bi bi-heart"></i></button>
                </div>
                <div class="card-body">
                    <p class="card-title mb-1">말본 골프 컬러 블록 원피스 그린S 새상품</p>
                    <p class="card-price mb-1">20,000원</p>
                    <div class="card-meta d-flex justify-content-between">
                        <span>다사읍 | 10분 전</span>
                        <span>찜 4 · 채팅 0</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="col">
            <div class="product-card">
                <div class="card-img-container">
                    <img src="https://img2.joongna.com/media/original/2024/08/24/1724504730088yxM_JmP7T.jpg" class="card-img-top" alt="상품 이미지">
                    <button class="wish-btn"><i class="bi bi-heart-fill text-danger"></i></button>
                </div>
                <div class="card-body">
                    <p class="card-title mb-1">세느뉴 CHEMISE SASSY 블라우스 34사이즈</p>
                    <p class="card-price mb-1">100,000원</p>
                    <div class="card-meta d-flex justify-content-between">
                        <span>덕풍1동 | 3분 전</span>
                        <span>찜 3 · 채팅 1</span>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col">
            <div class="product-card">
                <div class="card-img-container">
                    <img src="https://asset.m-gs.kr/prod/1069144804/5/550" class="card-img-top" alt="상품 이미지">
                    <button class="wish-btn"><i class="bi bi-heart"></i></button>
                </div>
                <div class="card-body">
                    <p class="card-title mb-1">모르간 25SS 테일러드 원피스 1종 TV상품</p>
                    <p class="card-price mb-1">92,910원</p>
                    <div class="card-meta d-flex justify-content-between">
                        <span>룡남동 | 20분전</span>
                        <span>찜 3 · 채팅 1</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="col">
            <div class="product-card">
                <div class="card-img-container">
                    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUwevA7g6ZxEUyQ2slu469WxcI8qS0Tl-oSg&s" class="card-img-top" alt="상품 이미지">
                    <button class="wish-btn"><i class="bi bi-heart"></i></button>
                </div>
                <div class="card-body">
                    <p class="card-title mb-1">바이씨니 제작 하이시나ops 블랙 라지 새상품</p>
                    <p class="card-price mb-1">110,000원</p>
                    <div class="card-meta d-flex justify-content-between">
                        <span>12분 전</span>
                        <span>찜 3 · 채팅 0</span>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col">
            <div class="product-card">
                <div class="card-img-container">
                    <img src="https://media.bunjang.co.kr/product/340944073_1_1750653267_w360.jpg" class="card-img-top" alt="상품 이미지">
                    <button class="wish-btn"><i class="bi bi-heart"></i></button>
                </div>
                <div class="card-body">
                    <p class="card-title mb-1">(S) 아디다스 바람막이 점퍼</p>
                    <p class="card-price mb-1">25,000원</p>
                    <div class="card-meta d-flex justify-content-between">
                        <span>5분 전</span>
                        <span>찜 2 · 채팅 0</span>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
<jsp:include page="footer.jsp"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
// 원 단위 ',' 설정
const inputs = document.getElementsByClassName('priceInput');

Array.from(inputs).forEach(input => {
  input.addEventListener('input', () => {
    let value = input.value.replace(/[^\d]/g, '');
    input.value = value ? Number(value).toLocaleString() : '';
  });
});

</script>
</body>
</html>