<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css"> --%>
<%-- 기존 header.css 대신 아래 style 태그를 사용합니다. 필요시 기존 파일에 내용을 합치세요. --%>

<%
String currentCategory = request.getParameter("category");
%>

<style>
/* 기본 헤더 스타일 (데스크톱) */
@font-face {
	font-family: 'HakgyoansimDunggeunmisoTTF-B';
	src:
		url('https://fastly.jsdelivr.net/gh/projectnoonnu/2408-5@1.0/HakgyoansimDunggeunmisoTTF-B.woff2')
		format('woff2');
	font-weight: 700;
	font-style: normal;
}

#title {
	font-family: 'HakgyoansimDunggeunmisoTTF-B';
}

.header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 20px 50px;
	background: white;
	color: black;
}

.logo {
	display: flex;
	align-items: center;
	text-decoration: none;
	color: black;
	font-size: 24px;
	font-weight: bold;
}

.logo img {
	width: 40px;
	margin-right: 10px;
}

.header-right {
	display: flex;
	align-items: center;
}

#high-icon {
	margin-left: 20px;
	display: flex;
	align-items: center;
	gap: 15px;
}

#high-icon a {
	display: inline-flex;
	align-items: center;
	gap: 6px; 
	color: #333; /* 기본 텍스트 색상 수정 */
	text-decoration: none;
	transition: color 0.2s ease; /* 부드러운 색상 전환 */
}

#high-icon a:hover {
	color: #FF8E53; /* 호버 시 색상 변경 */
	text-decoration: none;
}
/* 상단 아이콘 크기 조정 */
.icon-images {
	width: 20px;
	height: auto;
	display: block; 
}
/* 햄버거 버튼 (모바일에서만 보임) */
.hamburger-btn {
	display: none; /* 평소엔 숨김 */
	font-size: 24px;
	background: none;
	border: none;
	color: black;
	cursor: pointer;
}

/* 모바일 닫기 버튼 (사이드 메뉴 안에 위치) */
.close-btn {
	display: none; /* 평소엔 숨김 */
}

/* 검색창 스타일 */
.search-box {
	display: flex;
	align-items: center;
	background-color: white;
	border-radius: 50px; /* 완전한 캡슐 형태 */
	padding: 2px; /* 내부 여백 */
	max-width: 900px;
	border: 2px solid transparent; /* 포커스 효과를 위한 투명 테두리 */
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
	transition: all 0.3s ease; /* 부드러운 전환 효과 */
	width: 100%;
}

.search-box:focus-within {
	border-color: #FF8E53;
	box-shadow: 0 0 0 3px rgba(255, 142, 83, 0.3);
}

.search-txt {
	flex-grow: 1; /* 남는 공간을 모두 차지 */
	border: none;
	background: none;
	padding: 8px 20px;
	outline: none;
	font-size: 16px;
	color: #333;
}

.search-btn {
	background-color: #FF6B6B; /* 헤더 그라데이션과 어울리는 색상 */
	border: none;
	color: white;
	width: 40px;
	height: 40px;
	border-radius: 50%; /* 동그란 버튼 모양 */
	cursor: pointer;
	display: flex;
	justify-content: center;
	align-items: center;
	transition: background-color 0.2s ease;
}

.search-btn:hover {
	background-color: #e65a5a; /* 호버 시 살짝 어두운 색 */
}

/* =================================================================
     ★★★ 개선된 네비게이션 메뉴 스타일 ★★★
   ================================================================= */
.category-nav {
	/* background-color: white; */ /* 기존 흰색 배경 대신 아래 색상 사용 */
	background-color: #f8f9fa; /* 은은하고 세련된 연한 회색 배경 */
	padding: 5px 0;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05); /* 은은한 그림자 효과 */
	border-bottom: 1px solid #dee2e6; /* 배경색과 어울리도록 테두리 색상 조정 */
	justify-content: center;
	align-items: flex-start;
}

.category-nav .nav {
	justify-content: center;
	position: relative;
}

.category-nav .nav-link {
	color: #555; /* 기본 텍스트 색상 */
	
	display: flex;
	flex-direction: column;
	align-items: center;
	padding: 10px 20px; /* 좌우 여백 증가 */
	font-weight: bold;
	position: relative; /* 밑줄 애니메이션을 위한 기준점 */
	transition: color 0.3s ease;
	overflow: hidden;
}

/* 데스크톱: 호버 시 밑줄 애니메이션 효과 */
.category-nav .nav-link::after {
	content: '';
	position: absolute;
	bottom: 0;
	left: 0;
	width: 100%;
	height: 3px;
	background-color: #FF8E53;
	transform: scaleX(0); /* 처음엔 안보이게 */
	transform-origin: center;
	transition: transform 0.3s ease-out;
}

.category-nav .nav-link:hover {
	color: #FF8E53; /* 호버 시 텍스트 색상 변경 */
}

.category-nav .nav-link:hover::after {
	transform: scaleX(1); /* 호버 시 밑줄 나타남 */
}

/* 활성화된 메뉴 아이템 스타일 */
.category-nav .nav-link.active {
	color: #FF6B6B; /* 활성화 시 텍스트 색상 */
	font-weight: bold;
}

.category-nav .nav-link.active::after {
	transform: scaleX(1); /* 활성화 시 밑줄 항상 표시 */
	background-color: #FF6B6B; /* 활성화 시 밑줄 색상 */
}

.category-nav .nav-link .icon {
	width: 28px;
	height: 28px;
	margin-bottom: 5px;
}

.category-nav hr {
	display: none;
}


/* =================================================================
     반응형 스타일 (화면이 768px 이하일 때 적용)
   ================================================================= */
@media ( max-width : 768px) {
	.header {
		padding: 10px 15px;
		display: flex;
		align-items: center;
		justify-content: space-between;
		flex-wrap: wrap; /* 공간 부족 시 줄바꿈 */
		overflow-x: hidden; /* 잘림 방지 */
	}
	.header-right {
		flex-grow: 1; /* 남은 공간을 모두 차지 */
		justify-content: flex-end; /* 오른쪽 정렬 */
	}
	.search-box {
		order: 2;
		width: 100%;
		margin-top: 10px;
	}
	.search-txt {
		width: 100%;
	}
	#high-icon {
		order: 3;
		margin-left: 15px;
	}
	.logo {
		order: 0;
		justify-content: flex-start;
		width: auto;
		display: flex;
		align-items: center;
	}
	#high-icon a .fa-text {
		display: none;
	}
	#high-icon a.login-group {
		display: flex;
		gap: 5px;
	}
	.hamburger-btn {
		display: block;
		order: 1;
		margin-left: 10px;
	}

	/* 모바일용 세로 메뉴로 변경 */
	.category-nav {
		position: fixed;
		top: 0;
		left: -100%; /* 화면 밖에 숨겨둠 */
		width: 280px;
		height: 100vh;
		background-color: white;
		z-index: 1050;
		transition: left 0.3s ease-in-out;
		padding-top: 60px; /* 닫기 버튼을 위한 공간 */
		overflow-y: auto;
		border-right: 1px solid #ccc;
		box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
	}
	.category-nav.open {
		left: 0;
	}

	/* 모바일에서는 밑줄 애니메이션 제거 */
	.category-nav .nav-link::after {
		display: none;
	}
	.category-nav .container {
		padding: 0;
	}
	.category-nav .nav {
		flex-direction: column;
		align-items: flex-start;
		padding: 10px;
	}
	.category-nav .nav-item {
		width: 100%;
	}
	.category-nav .nav-link {
		flex-direction: row; /* 아이콘과 텍스트를 가로로 */
		justify-content: flex-start;
		width: 100%;
		padding: 15px;
		border-bottom: 1px solid #f0f0f0;
		border-radius: 8px; /* 부드러운 모서리 */
		transition: background-color 0.2s ease, color 0.2s ease;
	}

	/* 모바일: 호버/활성 시 배경색 변경으로 피드백 */
	.category-nav .nav-link:hover {
		background-color: #f8f9fa;
		color: #FF8E53;
	}
	.category-nav .nav-link.active {
		background-color: #fff2ed; /* 연한 주황색 배경 */
		color: #FF6B6B;
	}
	.category-nav .nav-link .icon {
		margin-bottom: 0;
		margin-right: 15px;
	}
	.close-btn {
		display: block;
		position: absolute;
		top: 15px;
		right: 20px;
		font-size: 30px;
		background: none;
		border: none;
		cursor: pointer;
		color: #333;
	}
	.overlay {
		position: fixed;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background: rgba(0, 0, 0, 0.5);
		z-index: 1040;
		display: none; /* 평소엔 숨김 */
	}
	.overlay.show {
		display: block;
	}
}
</style>

<header class="header">
	<button class="hamburger-btn" id="hamburgerBtn">
		<i class="fas fa-bars"></i>
	</button>

	<a class="logo" href="${pageContext.request.contextPath}/jsp/main.jsp"> <img id="main-icon" src="${pageContext.request.contextPath}/images/watermelon_icon.png" alt="수박 아이콘"> <span id="title">수박나라</span>
	</a>

	<form class="search-box" method="get" action="${pageContext.request.contextPath}/jsp/search.jsp">
		<input type="text" class="search-txt" name="keyword" placeholder="원하는 상품을 검색하세요..." id="searchInput">
		<button type="submit" class="search-btn" id="searchBtn">
			<i class="fa-solid fa-magnifying-glass"></i>
		</button>
	</form>

	<div class="header-right">
		<div id="high-icon">
			<a href="${pageContext.request.contextPath}/jsp/sale.jsp"><img src="../images/cart.png" class="icon-images"><span class="fa-text">판매</span></a>
			<a href="#" data-bs-toggle="offcanvas" data-bs-target="#notificationOffcanvas" aria-controls="notificationOffcanvas"><img src="../images/bell.png" class="icon-images"> <span class="fa-text">알림</span></a>
			<a href="${pageContext.request.contextPath}/jsp/login.jsp" class="login-group"><img src="../images/human.png" class="icon-images"> <span class="fa-text">로그인</span></a> 
			/ 
			<a href="${pageContext.request.contextPath}/jsp/mypage.jsp" class="login-group"><img src="../images/human.png" class="icon-images"> <span class="fa-text">마이페이지</span></a>
		</div>
	</div>
</header>

<nav class="category-nav" id="categoryNav">
	<button class="close-btn" id="closeNavBtn">&times;</button>
	<div class="container">
		<ul class="nav d-flex">
			<li class="nav-item"><a class="nav-link <%= currentCategory == null ? "active" : "" %>" href="${pageContext.request.contextPath}/jsp/main.jsp" data-category="all"> <img class="icon" src="${pageContext.request.contextPath}/images/fire.png" alt="인기 아이콘"> 인기
			</a></li>
			<li class="nav-item"><a class="nav-link <%= "디지털".equals(currentCategory) ? "active" : "" %>" href="${pageContext.request.contextPath}/jsp/search.jsp?category=디지털" data-category="electronics"> <img class="icon" src="${pageContext.request.contextPath}/images/phone.png" alt="핸드폰 아이콘"> 디지털
			</a></li>
			<li class="nav-item"><a class="nav-link <%= "패션".equals(currentCategory) ? "active" : "" %>" href="${pageContext.request.contextPath}/jsp/search.jsp?category=패션" data-category="fashion"> <img class="icon" src="${pageContext.request.contextPath}/images/cloth.png" alt="옷 아이콘"> 패션
			</a></li>
			<li class="nav-item"><a class="nav-link <%= "뷰티".equals(currentCategory) ? "active" : "" %>" href="${pageContext.request.contextPath}/jsp/search.jsp?category=뷰티" data-category="beauty"> <img class="icon" src="${pageContext.request.contextPath}/images/makeup.png" alt="뷰티 아이콘"> 뷰티
			</a></li>
			<li class="nav-item"><a class="nav-link <%= "가구".equals(currentCategory) ? "active" : "" %>" href="${pageContext.request.contextPath}/jsp/search.jsp?category=가구" data-category="furniture"> <img class="icon" src="${pageContext.request.contextPath}/images/sofar.png" alt="소파 아이콘"> 가구
			</a></li>
			<li class="nav-item"><a class="nav-link <%= "도서".equals(currentCategory) ? "active" : "" %>" href="${pageContext.request.contextPath}/jsp/search.jsp?category=도서" data-category="books"> <img class="icon" src="${pageContext.request.contextPath}/images/book.png" alt="책 아이콘"> 도서
			</a></li>
			<li class="nav-item"><a class="nav-link <%= "스포츠".equals(currentCategory) ? "active" : "" %>" href="${pageContext.request.contextPath}/jsp/search.jsp?category=스포츠" data-category="sports"> <img class="icon" src="${pageContext.request.contextPath}/images/ball.png" alt="공 아이콘"> 스포츠
			</a></li>
			<li class="nav-item"><a class="nav-link <%= "생활".equals(currentCategory) ? "active" : "" %>" href="${pageContext.request.contextPath}/jsp/search.jsp?category=생활" data-category="auction"> <img class="icon" src="${pageContext.request.contextPath}/images/living.png" alt="청소 아이콘"> 생활
			</a></li>
			<li class="nav-item"><a class="nav-link <%= "관심".equals(currentCategory) ? "active" : "" %>" href="${pageContext.request.contextPath}/jsp/search.jsp?category=관심" data-category="interest"> <img class="icon" src="${pageContext.request.contextPath}/images/heart.png" alt="관심 아이콘"> 관심
			</a></li>
		</ul>
	</div>
	<hr>
</nav>

<div class="overlay" id="overlay"></div>

<div id="easterVideo" style="display: none; position: fixed; top: 120px; left: 20px; width: 400px; background: #fff; border: 2px solid #ccc; padding: 10px; z-index: 9999; box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);">
	<div style="display: flex; justify-content: space-between; align-items: center;">
		<h4 style="margin: 0;">🎉 수박나라 이스터에그 발견!</h4>
		<button id="closeVideoBtn" style="background: none; border: none; font-size: 20px; cursor: pointer;">&times;</button>
	</div>
	<video controls width="100%">
		<source src="${pageContext.request.contextPath}/videos/watermelon-dance.mp4" type="video/mp4">
		이 브라우저는 동영상 태그를 지원하지 않습니다.
	</video>
</div>


<jsp:include page="notification.jsp" />

<script>
document.addEventListener('DOMContentLoaded', function() {
    // 이스터에그 스크립트
    const searchBtn = document.getElementById('searchBtn');
    const searchInput = document.getElementById('searchInput');
    const videoBox = document.getElementById('easterVideo');
    const closeVideoBtn = document.getElementById('closeVideoBtn');

    if (searchBtn) {
        searchBtn.addEventListener('mouseover', () => {
            const input = searchInput.value.trim().toLowerCase();
            if (input.includes('이승찬')) {
                videoBox.style.display = 'block';
                searchInput.value = '';
            }
        });
    }

    if (closeVideoBtn) {
        closeVideoBtn.addEventListener('click', () => {
            videoBox.style.display = 'none';
        });
    }

    // 반응형 햄버거 메뉴 스크립트
    const hamburgerBtn = document.getElementById('hamburgerBtn');
    const categoryNav = document.getElementById('categoryNav');
    const closeNavBtn = document.getElementById('closeNavBtn');
    const overlay = document.getElementById('overlay');

    const openNav = () => {
        categoryNav.classList.add('open');
        overlay.classList.add('show');
        document.body.style.overflow = 'hidden'; // 스크롤 방지
    };

    const closeNav = () => {
        categoryNav.classList.remove('open');
        overlay.classList.remove('show');
        document.body.style.overflow = ''; // 스크롤 복원
    };

    if (hamburgerBtn) {
        hamburgerBtn.addEventListener('click', openNav);
    }
    
    if (closeNavBtn) {
        closeNavBtn.addEventListener('click', closeNav);
    }

    if (overlay) {
        overlay.addEventListener('click', closeNav);
    }
});
</script>