<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>수박나라 로그인</title>
  <link rel="icon" type="image/png" href="../images/watermelon_icon.ico">

  <link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
    rel="stylesheet" />

  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
</head>
<body>
  <div class="container">
    <a class="logo" href="${pageContext.request.contextPath}/jsp/main.jsp">
      <img id="main-icon" src="${pageContext.request.contextPath}/images/watermelon_icon.png" alt="수박 아이콘">
      <span>수박나라</span>
    </a>

    <div class="login-card">
      <img id="login-logo" src="${pageContext.request.contextPath}/images/login3.png" alt="수박나라 로고"/>

      <a class="btn-social btn-naver" href="https://nid.naver.com/oauth2.0/authorize">
        <img class="login-icon" src="${pageContext.request.contextPath}/images/naver-icon.png" alt="네이버 아이콘">
        네이버로 로그인
      </a>
      <a class="btn-social btn-kakao" href="https://kauth.kakao.com/oauth/authorize"> <img class="login-icon" src="${pageContext.request.contextPath}/images/kakao.png" alt="카카오 아이콘">
        카카오로 로그인
      </a>
      <a class="btn-social btn-google" href="https://accounts.google.com/o/oauth2/auth">
        <img class="login-icon" src="${pageContext.request.contextPath}/images/google.png" alt="구글 아이콘">
        구글로 로그인
      </a>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>