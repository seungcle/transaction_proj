<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<style>
    /* 전체적인 폰트와 배경색 설정 */
    body {
        background-color: #f8f9fa; /* 연한 회색 배경으로 변경 */
        font-family: 'Pretendard', sans-serif;
    }

    /* 사이드바 스타일 */
    .sidebar .nav-link {
        color: #343a40;
        font-size: 1rem;
        padding: 0.8rem 1rem;
        margin-bottom: 0.5rem;
        border-radius: 0.5rem; /* 부드러운 모서리 */
        transition: all 0.2s ease-in-out;
    }
    .sidebar .nav-link .bi {
        margin-right: 0.8rem;
        font-size: 1.2rem;
    }
    .sidebar .nav-link:hover {
        background-color: #FF6B6B;
        color: #000;
    }
    .sidebar .nav-link.active {
        background-color: #0d6efd; /* 활성 메뉴 포인트 색상 */
        color: white;
        font-weight: bold;
    }

    /* 카드 스타일 */
    .card {
        border: none;
        box-shadow: 0 4px 12px rgba(0,0,0,0.08); /* 부드러운 그림자 효과 */
    }

    /* 프로필 별점 스타일 */
    .rating-stars {
        font-size: 2rem;
        color: #ffc107; /* 별점 색상 */
    }
    
    /* 상품 탭 스타일 */
    .product-tabs .nav-link {
        padding: 0.5rem 1rem;
        border-radius: 0.5rem;
        color: #6c757d;
        font-weight: 500;
    }
    .product-tabs .nav-link.active {
        background-color: #FF6B6B;
        color: white;
    }

    /* 상품 없음 영역 스타일 */
    .empty-content {
        padding: 4rem;
    }
    .empty-content .bi {
        font-size: 4rem;
        color: #dee2e6;
    }
 	.offcanvas.offcanvas-end {
  		 width: 700px;
  		 max-width: 100%;
	}
	.title {
		padding: 10px;
		color: #FF6B6B;
		font-weight: bold;
	}
	.offcanvas-title {
		margin-left: 40%;
	}
	
</style>
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="container py-5">
    <div class="row">
        <aside class="col-md-3">
            <h4 class="mb-4 ps-2">마이페이지</h4>
            <div class="sidebar">
                <div class="nav flex-column nav-pills">
                    <span class="text-muted small ps-2 mb-2">거래 정보</span>
                    <a class="nav-link" href="#" data-bs-toggle="offcanvas" data-bs-target="#mySalesOffcanvas" aria-controls="mySalesOffcanvas"><i class="bi bi-receipt"></i>판매내역</a>
                    <a class="nav-link" href="#" data-bs-toggle="offcanvas" data-bs-target="#myPurchasesOffcanvas" aria-controls="myPurchasesOffcanvas"><i class="bi bi-bag"></i>구매내역</a>
                    <a class="nav-link" href="#" data-bs-toggle="offcanvas" data-bs-target="#myInterestsOffcanvas" aria-controls="myInterestsOffcanvas"><i class="bi bi-heart"></i>찜한 상품</a>
                    <hr>
                    <span class="text-muted small ps-2 mb-2">내 정보</span>
                    <a class="nav-link" href="#" data-bs-toggle="offcanvas" data-bs-target="#chatOffcanvas" aria-controls="chatOffcanvas"><i class="bi bi-geo-alt"></i>배송지 관리</a>
                    <a class="nav-link" href="#" data-bs-toggle="offcanvas" data-bs-target="#chatOffcanvas" aria-controls="chatOffcanvas"><i class="bi bi-star"></i>거래 후기</a>
                    <a class="nav-link text-danger" href="#" data-bs-toggle="offcanvas" data-bs-target="#chatOffcanvas" aria-controls="chatOffcanvas"><i class="bi bi-box-arrow-right"></i>탈퇴하기</a>
                </div>
            </div>
        </aside>

        <main class="col-md-9">
            <div class="card mb-4">
                <div class="card-body p-4">
                    <div class="d-flex align-items-center mb-4">
                        <img src="https://i.pravatar.cc/100?u=a042581f4e29026704d" class="rounded-circle me-3" alt="avatar" width="80" height="80">
                        <div>
                            <h3 class="card-title mb-0">자상한새벽스피넬</h3>
                            <p class="card-text text-muted">친절하고 안전한 거래를 약속합니다.</p>
                        </div>
                    </div>
                    <h6 class="text-muted">나의 별점</h6>
                    <div class="d-flex align-items-center">
                        <div class="rating-stars me-2">
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-fill"></i>
                            <i class="bi bi-star-half"></i>
                        </div>
                        <span class="fs-4 fw-bold">4.5</span>
                        <span class="text-muted ms-2">/ 5.0</span>
                    </div>
                </div>
            </div>

            <div class="card">
                <div class="card-body p-4">
                    <h4 class="mb-4">내 상품</h4>
                     <ul class="nav nav-pills product-tabs mb-4">
                        <li class="nav-item">
                            <a class="nav-link" href="#">전체</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">판매중</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#">예약중</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" aria-current="page" href="#">판매완료</a>
                        </li>
                    </ul>

                    <div class="text-center empty-content">
                        <i class="bi bi-box2-heart mb-3"></i>
                        <h5>아직 판매완료된 상품이 없어요.</h5>
                        <p class="text-muted">당신의 멋진 상품들이 주인을 기다리고 있어요!</p>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
<jsp:include page="mySales.jsp"/>
<jsp:include page="myPurchases.jsp"/>
<jsp:include page="myInterests.jsp"/>
<jsp:include page="groupChat.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>