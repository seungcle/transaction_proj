<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
            <div class="col-md-auto">
                <div class="input-group">
                    <input type="number" class="form-control" placeholder="최소 가격">
                    <span class="input-group-text">~</span>
                    <input type="number" class="form-control" placeholder="최대 가격">
                    <button class="btn btn-dark">적용</button>
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
                    <img src="http://bitcdn.bit-play.com/fromchina/2018/05/18/18/e2c406415599c6eb327e3699c071ac15_457482_450.jpg?Text=Image+2" class="card-img-top" alt="상품 이미지">
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
                    <img src="http://bitcdn.bit-play.com/fromchina/2018/05/18/18/e2c406415599c6eb327e3699c071ac15_457482_450.jpg?Text=Image+2" class="card-img-top" alt="상품 이미지">
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
                    <img src="http://bitcdn.bit-play.com/fromchina/2018/05/18/18/e2c406415599c6eb327e3699c071ac15_457482_450.jpg?Text=Image+2" class="card-img-top" alt="상품 이미지">
                    <button class="wish-btn"><i class="bi bi-heart"></i></button>
                </div>
                <div class="card-body">
                    <p class="card-title mb-1">모르간 25SS 테일러드 원피스 1종 TV상품</p>
                    <p class="card-price mb-1">92,910원</p>
                    <div class="card-meta d-flex justify-content-between">
                        <span>GSSHOP | 광고</span>
                        <span>찜 3 · 채팅 1</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="col">
            <div class="product-card">
                <div class="card-img-container">
                    <img src="http://bitcdn.bit-play.com/fromchina/2018/05/18/18/e2c406415599c6eb327e3699c071ac15_457482_450.jpg?Text=Image+2" class="card-img-top" alt="상품 이미지">
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
                    <img src="http://bitcdn.bit-play.com/fromchina/2018/05/18/18/e2c406415599c6eb327e3699c071ac15_457482_450.jpg?Text=Image+2" class="card-img-top" alt="상품 이미지">
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
</body>
</html>