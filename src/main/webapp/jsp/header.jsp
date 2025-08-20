<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
    src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/2408-5@1.0/HakgyoansimDunggeunmisoTTF-B.woff2') format('woff2');
    font-weight: 700;
    font-style: normal;
}
#title{
	 font-family: 'HakgyoansimDunggeunmisoTTF-B';
}
.header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px 50px;
  background: linear-gradient(135deg, #FF6B6B, #FF8E53);
  color: white;
  
}
.logo {
  display: flex;
  align-items: center;
  text-decoration: none;
  color: white;
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
.search-box {
  display: flex;
  align-items: center;
  max-width: 600px;
}
.search-txt {
  border: 1px solid #ccc;
  min-width: 300px;
  padding: 8px;
  border-radius: 20px 0 0 20px;
  outline: none;
}
.search-btn {
  background-color: #008000;
  border: none;
  color: white;
  padding: 9px 12px;
  cursor: pointer;
  border-radius: 0 20px 20px 0;
}
#high-icon {
  margin-left: 20px;
  display: flex;
  align-items: center;
  gap: 15px;
}
#high-icon a {
  color: white;
  text-decoration: none;
}
#high-icon a:hover {
  text-decoration: underline;
}

/* 햄버거 버튼 (모바일에서만 보임) */
.hamburger-btn {
  display: none; /* 평소엔 숨김 */
  font-size: 24px;
  background: none;
  border: none;
  color: white;
  cursor: pointer;
}

/* 카테고리 네비게이션 (데스크톱) */
.category-nav {
  background-color: #f8f9fa;
  padding: 5px 0;
  border-bottom: 1px solid #dee2e6;
}
.category-nav .nav {
  justify-content: center;
}
.category-nav .nav-link {
  color: #333;
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 5px 15px;
  font-weight: bold;
}
.category-nav .nav-link:hover {
  color: #FF8E53;
  border-radius: 5px;
}
.category-nav .nav-link .icon {
  width: 28px;
  height: 28px;
  margin-bottom: 5px;
}
.category-nav .nav-link.active {
  color: #FF6B6B;
  font-weight: bold;
}
.category-nav hr {
    display: none; /* 데스크톱에서는 hr 숨김 */
}

/* 모바일 닫기 버튼 (사이드 메뉴 안에 위치) */
.close-btn {
    display: none; /* 평소엔 숨김 */
}


/* =================================================================
     반응형 스타일 (화면이 768px 이하일 때 적용)
     ================================================================= */
@media (max-width: 768px) {
  .header {
  	display: flex;
  	align-items: center;
  	justify-content: space-between;
    flex-wrap: wrap; /* 공간 부족 시 줄바꿈 */
  }
  .header-right {
    flex-grow: 1; /* 남은 공간을 모두 차지 */
    justify-content: flex-end; /* 오른쪽 정렬 */
  }
  
  /* 검색창을 로고와 아이콘 사이에 두기 위해 순서 변경 */
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

  /* 모바일에서 아이콘 옆 텍스트 숨기기 */
  #high-icon a .fa-text {
      display: none;
  }
  #high-icon a.login-group {
      display: flex;
      gap: 5px;
  }
  
  .hamburger-btn {
    display: block; /* 모바일에선 보임 */
    order: 1; /* 가장 왼쪽에 위치 */
    margin-left: 10px;
  }

  /* 데스크톱용 가로 카테고리를 숨기고, 모바일용 세로 메뉴로 변경 */
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
    box-shadow: 2px 0 10px rgba(0,0,0,0.1);
  }
  /* 햄버거 클릭 시 .open 클래스가 추가되면 메뉴가 보임 */
  .category-nav.open {
    left: 0;
  }

  .category-nav .container {
    padding: 0;
  }
  .category-nav .nav {
    flex-direction: column; /* 세로 정렬 */
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
  }
  .category-nav .nav-link .icon {
    margin-bottom: 0;
    margin-right: 15px;
  }
  
  /* 모바일 메뉴의 닫기 버튼 */
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
  
  /* 메뉴가 열렸을 때 뒷 배경을 어둡게 처리 */
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
  
  <a class="logo" href="${pageContext.request.contextPath}/jsp/main.jsp">
    <img id="main-icon" src="${pageContext.request.contextPath}/images/watermelon_icon.png" alt="수박 아이콘">
    <span id="title">수박나라</span>
  </a>
  
  <form class="search-box" method="get" action="${pageContext.request.contextPath}/jsp/search.jsp">
      <input type="text" class="search-txt" name="keyword" placeholder="원하는 상품을 검색하세요..." id="searchInput">
      <button type="submit" class="search-btn" id="searchBtn">
        <i class="fa-solid fa-magnifying-glass"></i>
      </button>
    </form>
    
  <div class="header-right">
    <div id="high-icon">
      <a href="${pageContext.request.contextPath}/jsp/sale.jsp"><i class="fas fa-shopping-cart"></i> <span class="fa-text">판매</span></a>
      <a href="#" data-bs-toggle="offcanvas" data-bs-target="#notificationOffcanvas" aria-controls="notificationOffcanvas"><i class="fas fa-bell"></i> <span class="fa-text">알림</span></a>
      <a href="${pageContext.request.contextPath}/jsp/login.jsp" class="login-group"><i class="fas fa-user"></i> <span class="fa-text">로그인 / 마이페이지</span></a>
    </div>
  </div>
</header>

<nav class="category-nav" id="categoryNav">
  <button class="close-btn" id="closeNavBtn">&times;</button>
  <div class="container">
    <ul class="nav d-flex">
      <li class="nav-item">
        <a class="nav-link <%= currentCategory == null ? "active" : "" %>" href="${pageContext.request.contextPath}/jsp/main.jsp" data-category="all">
          <img class="icon" src="${pageContext.request.contextPath}/images/fire.png" alt="인기 아이콘"> 인기
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link <%= "디지털".equals(currentCategory) ? "active" : "" %>" href="${pageContext.request.contextPath}/jsp/search.jsp?category=디지털" data-category="electronics">
          <img class="icon" src="${pageContext.request.contextPath}/images/phone.png" alt="핸드폰 아이콘"> 디지털
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link <%= "패션".equals(currentCategory) ? "active" : "" %>" href="${pageContext.request.contextPath}/jsp/search.jsp?category=패션" data-category="fashion">
          <img class="icon" src="${pageContext.request.contextPath}/images/cloth.png" alt="옷 아이콘"> 패션
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link <%= "뷰티".equals(currentCategory) ? "active" : "" %>" href="${pageContext.request.contextPath}/jsp/search.jsp?category=뷰티" data-category="beauty">
          <img class="icon" src="${pageContext.request.contextPath}/images/makeup.png" alt="뷰티 아이콘"> 뷰티
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link <%= "가구".equals(currentCategory) ? "active" : "" %>" href="${pageContext.request.contextPath}/jsp/search.jsp?category=가구" data-category="furniture">
          <img class="icon" src="${pageContext.request.contextPath}/images/sofar.png" alt="소파 아이콘"> 가구
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link <%= "도서".equals(currentCategory) ? "active" : "" %>" href="${pageContext.request.contextPath}/jsp/search.jsp?category=도서" data-category="books">
          <img class="icon" src="${pageContext.request.contextPath}/images/book.png" alt="책 아이콘"> 도서
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link <%= "스포츠".equals(currentCategory) ? "active" : "" %>" href="${pageContext.request.contextPath}/jsp/search.jsp?category=스포츠" data-category="sports">
          <img class="icon" src="${pageContext.request.contextPath}/images/ball.png" alt="공 아이콘"> 스포츠
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link <%= "생활".equals(currentCategory) ? "active" : "" %>" href="${pageContext.request.contextPath}/jsp/search.jsp?category=생활" data-category="auction">
          <img class="icon" src="${pageContext.request.contextPath}/images/living.png" alt="청소 아이콘"> 생활
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link <%= "관심".equals(currentCategory) ? "active" : "" %>" href="${pageContext.request.contextPath}/jsp/search.jsp?category=관심" data-category="interest">
          <img class="icon" src="${pageContext.request.contextPath}/images/heart.png" alt="관심 아이콘"> 관심
        </a>
      </li>
    </ul>
  </div>
  <hr>
</nav>

<div class="overlay" id="overlay"></div>

<div id="easterVideo" style="display:none; position:fixed; top:120px; left:20px; width:400px; background:#fff; border:2px solid #ccc; padding:10px; z-index:9999; box-shadow:0 0 10px rgba(0,0,0,0.3);">
  <div style="display:flex; justify-content:space-between; align-items:center;">
    <h4 style="margin:0;">🎉 수박나라 이스터에그 발견!</h4>
    <button id="closeVideoBtn" style="background:none; border:none; font-size:20px; cursor:pointer;">&times;</button>
  </div>
  <video controls width="100%">
    <source src="${pageContext.request.contextPath}/videos/watermelon-dance.mp4" type="video/mp4">
    이 브라우저는 동영상 태그를 지원하지 않습니다.
  </video>
</div>


<jsp:include page="notification.jsp"/>

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