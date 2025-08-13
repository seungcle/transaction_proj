<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="offcanvas offcanvas-end" tabindex="-1" id="chatOffcanvas" aria-labelledby="chatOffcanvasLabel">
		<div class="offcanvas-header">
			<h5 class="offcanvas-title" id="chatOffcanvasLabel">
				<i class="bi bi-chat-dots-fill"></i> 물품 단체 채팅방
			</h5>
			<button type="button" class="btn-close" data-bs-dismiss="offcanvas"
				aria-label="Close"></button>
		</div>
		<div class="offcanvas-body d-flex flex-column">
			<div class="flex-grow-1 mb-3" style="overflow-y: auto;">
				<div class="mb-2">
					<strong>레트로매니아:</strong>
					<div class="p-2 bg-light rounded d-inline-block">이거 혹시 청축인가요?</div>
					<div class="text-muted small">오후 3:15</div>
				</div>
				<div class="mb-2 text-end">
					<strong>키보드사랑:</strong>
					<div class="p-2 bg-primary-subtle rounded d-inline-block">판매자님
						응답이 없으시네요. 다들 얼마까지 생각하시나요?</div>
					<div class="text-muted small">오후 3:20</div>
				</div>
				<div class="mb-2">
					<strong>기계식입문:</strong>
					<div class="p-2 bg-light rounded d-inline-block">상태 좋아보이는데...
						일단 8만원에 입찰해봅니다.</div>
					<div class="text-muted small">오후 3:28</div>
				</div>
			</div>
			<div class="input-group">
				<input type="text" class="form-control" placeholder="메시지를 입력하세요...">
				<button class="btn btn-dark" type="button">
					<i class="bi bi-send-fill"></i>
				</button>
			</div>
		</div>
	</div>
</body>
</html>