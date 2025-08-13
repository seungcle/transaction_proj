<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>수박나라 로그인</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <style>
    body {
      background-color: #f8f9fa;
    }
    .logo {
  		display: flex;
  		align-items: center;
  		justify-content: center;
  		gap: 10px;
  		margin: 8rem 10px 20px 10px;
  		text-decoration: none;
  		font-size: 1.5rem;
  		font-weight: bold;
  		color: #333;
		}

	#main-icon {
  		width: 40px;
  		height: 40px;
	}
    
    .login-card {
      max-width: 400px;
      margin: 20px auto;
      padding: 2rem;
      border-radius: 1rem;
      box-shadow: 0 0 20px rgba(0,0,0,0.1);
      background-color: #fff;
      text-align: center;
    }
    .login-card h2 {
      margin-bottom: 1rem;
    }
    .login-card img.logo {
      width: 100px;
      margin-bottom: 1.5rem;
    }
    .login-btn {
      width: 100%;
      margin-bottom: 1rem;
      font-weight: bold;
    }
    #login-logo{
    	width: 60%;
    }
    .login-icon{
    	width:7%;
    }
    a{
    	align-items: center; 
    }
    #naver{
    	background-color: #00bf18;
    	display: flex;
    	align-items: center;
    	justify-content: center;
    	gap: 8px;
    	padding: 10px 16px;
    	text-decoration: none;
    }
    #kakao{
    	background-color: #fae100;
    	display: flex;
    	align-items: center;
    	justify-content: center;
    	gap: 8px;
    	padding: 10px 16px;
    	text-decoration: none;
    	color: black;"
    }
    #google{
    	background-color: #e02f2f;
    	display: flex;
    	align-items: center;
    	justify-content: center;
    	gap: 8px;
    	padding: 10px 16px;
    	text-decoration: none;
    	color: white;"
    }
  </style>
</head>
<body>
	<a class="logo" href="main.jsp">
		<img id="main-icon" src="../images/watermelon_icon.png" alt="수박 아이콘">
		<span>수박나라</span>
 	</a>
 	<div class="login-card">
    	<!-- 로고 이미지 -->
    	<img id="login-logo" src="../images/login3.png" alt="수박나라 로고"/>

    	<!-- 네이버 로그인 -->
    	<a id="naver" href="https://nid.naver.com/oauth2.0/authorize" class="btn btn-success login-btn">
    		<img class ="login-icon" src="../images/naver-icon.png">
      		네이버로 로그인
    	</a>

    	<!-- 카카오톡 로그인 -->
   		<a id="kakao" href="https://nid.kakao.com/oauth2.0/authorize" class="btn btn-warning login-btn">
    		<img class ="login-icon" src="../images/kakao.png">
      		카카오로 로그인
    	</a>

    	<!-- 구글 로그인 -->
    	<a id="google" href="https://accounts.google.com/o/oauth2/auth" class="btn btn-danger login-btn">
    		<img class ="login-icon" src="../images/google.png">
      		구글로 로그인
    	</a>
  	</div>
</body>
</html>
