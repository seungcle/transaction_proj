<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>물품 단체 채팅</title>
<link rel="icon" type="image/png" href="../images/watermelon_icon.ico">

<!-- 필요 시 상위 페이지에서 이미 포함되어 있으면 중복 제거 가능 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/global.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/chat.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
</head>
<body>
<div class="offcanvas offcanvas-end" tabindex="-1" id="chatOffcanvas" aria-labelledby="chatOffcanvasLabel">
  <div class="offcanvas-header">
    <h5 class="offcanvas-title" id="chatOffcanvasLabel">
      <i class="bi bi-chat-dots-fill"></i> 물품 단체 채팅방
    </h5>
    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>

  <div class="offcanvas-body d-flex flex-column">
    <!-- 채팅 목록 -->
    <div class="flex-grow-1 mb-3 chat-scroll">
      <div class="msg other">
        <div class="name">레트로매니아:</div>
        <div class="bubble">이거 혹시 청축인가요?</div>
        <div class="time">오후 3:15</div>
      </div>

      <div class="msg me">
        <div class="name">키보드사랑:</div>
        <div class="bubble">판매자님 응답이 없으시네요. 다들 얼마까지 생각하시나요?</div>
        <div class="time">오후 3:20</div>
      </div>

      <div class="msg other">
        <div class="name">기계식입문:</div>
        <div class="bubble">상태 좋아보이는데... 일단 8만원에 입찰해봅니다.</div>
        <div class="time">오후 3:28</div>
      </div>
    </div>

    <!-- 입력창 -->
    <div class="input-group chat-input">
      <input type="text" class="form-control" placeholder="메시지를 입력하세요...">
      <button class="btn btn-dark" type="button">
        <i class="bi bi-send-fill"></i>
      </button>
    </div>
  </div>
</div>
</body>
</html>
