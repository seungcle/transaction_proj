<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
    @font-face {
        font-family: 'MaplestoryOTFBold';
        src: url('https://fastly.jsdelivr.net/gh/projectnoonnu/noonfonts_20-04@2.1/MaplestoryOTFBold.woff') format('woff');
        font-weight: normal;
        font-style: normal;
        }
        body {
            background-color: var(--melon-bg);
            color: #333;
            margin: 0;
    		font-family: Arial, sans-serif;
    		.
            }
        .header {
          	display: flex;
   			justify-content: space-between;
    		align-items: center;
    		background: linear-gradient(135deg, #FF6B6B, #FF8E53);
    		color: white;
    		padding: 1rem 20px;
    		box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .header-right {
    		display: flex;
    		align-items: center;
    		gap: 15px;

		}
        
        .logo {
     		display: flex;
    		align-items: center;
    		gap: 0.5rem;
    		text-decoration: none;
    		font-weight: bold;
    		transition: all 0.3s ease;
    		padding-left: 6%;
        }
        .logo:hover {
            color: var(--bs-link-hover-color);
        }
        #main-icon {
            margin-left: 20px;
            height: 50px; 
            width: auto;
        }
        .logo span {
            font-size: 2rem;
            font-family: 'MaplestoryOTFBold'; 
            text-decoration: none;
            color: white;
            line-height: 1; 
        }
        .search-box {
            display: flex;
            margin-right: 400px;
            width: 400px;
        }
        .search-txt {
            flex: 1;
            padding: 10px 15px;
            border: none;
            border-radius: 25px 0 0 25px;
            outline: none;
            font-size: 1rem;
        }
        .search-btn {
            background: white;
            border: none;
            border-radius: 0 25px 25px 0;
            padding: 0 20px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .search-btn:hover {
            background: #f0f0f0;
        }
        .search-btn i {
            color: #FF6B6B;
            font-size: 1.2rem;
        }
       .category-nav .nav-item a {
       		display: flex;
        	align-items: center; 
        	gap: 5px;
        	color: black;
        	text-decoration: none;
        	padding: 10px 25px;
        	transition: background-color 0.3s ease;
        	margin: 20px 5px 10px 0px;
        	border-radius: 20px;
    	}
    	.icon {
    		height: 15px;
    		width: auto;
    	}
    	.category-nav .nav {
        	display: flex;
        	justify-content: center; 
        	list-style: none; 
        	padding: 0;
        	margin: 0;
    	}
    	.nav-link:hover, .nav-link.active {
    		background-color: #FF6B6B;
            color: white !important;
    	}
    	.nav-link:hover .icon, .nav-link.active .icon {
    		filter: brightness(0) invert(1);
    	}
    	#high-icon{
    		margin-right: 10px;
    	}
    	.text-white{
    		padding: 10px;
    	}
       
    </style>
</head>
<body>
<!-- 버튼 고정 -->
<script type="text/javascript">
	document.addEventListener('DOMContentLoaded', function() {
		const navLinks = document.querySelectorAll('.category-nav .nav-link');
		navLinks.forEach(link => {
			link.addEventListener('click', function(event) {
				 event.preventDefault();
				 navLinks.forEach(item => {
					 item.classList.remove('active');
				 });
				 this.classList.add('active');
			});
		});
	});
</script>
<!-- Header -->
<header class="header">
            <a class="logo" href="main.jsp">
                <img id="main-icon" src="../images/watermelon_icon.png" alt="수박 아이콘">
                <span>수박나라</span>
            </a>
            <div class="header-right">
             <form class="search-box">
             	<input type="text" class="search-txt" placeholder="원하는 상품을 검색하세요..." id="searchInput">
                <button type="button" class="search-btn" id="searchBtn">
                	<i class="fa-solid fa-magnifying-glass"></i>
                </button>
      		 </form>
      		 		<!-- 우측 선택 영역 -->
      		 		<div id="high-icon">
                    <a style="text-decoration: none; color: white;" href="#" class="text-white"><i class="fas fa-heart"></i> 관심</a>
                    <a style="text-decoration: none; color: white;" href="#" class="text-white"><i class="fas fa-bell"></i> 알림</a>
                    <a style="text-decoration: none; color: white;" href="#" class="text-white"><i class="fas fa-user"></i> 로그인</a>
                    </div>
             </div>
    </header>
        <!-- 카테고리 header.jsp에 포함 -->
    <nav class="category-nav">
        <div class="container">
            <ul  class="nav d-flex justify-content-center">
                <li class="nav-item">
                    <a class="nav-link active" href="#" data-category="all"><img class="icon" src="../images/fire.png" alt="인기 아이콘"> 인기</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" data-category="electronics"><img class="icon" src="../images/phone.png" alt="핸드폰 아이콘"> 디지털</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" data-category="fashion"><img class="icon" src="../images/cloth.png" alt="옷 아이콘"> 패션</a>
                </li>
                <li class="nav-item">
                    <a  class="nav-link" href="#" data-category="beauty"><img class="icon" src="../images/makeup.png" alt="뷰티 아이콘"> 뷰티</a>
                </li>
                <li class="nav-item">
                    <a  class="nav-link" href="#" data-category="furniture"><img class="icon" src="../images/sofar.png" alt="소파 아이콘"> 가구</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" data-category="books"><img class="icon" src="../images/book.png" alt="책 아이콘"> 도서</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" data-category="sports"><img class="icon" src="../images/ball.png" alt="공 아이콘">스포츠</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" data-category="auction"><img class="icon" src="../images/living.png" alt="청소 아이콘"> 생활</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" data-category="interest"><img class="icon" src="../images/heart.png">관심</a>
                </li>
            </ul>
        </div>
        <hr>
    </nav>
</body>
</html>