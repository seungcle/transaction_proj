<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" errorPage="../error/subag_errorPage.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>수박처럼 시원한 중고 가격</title>
<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/watermelon_icon.ico">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap"
	rel="stylesheet">

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/global.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/layout.css">

</head>
<body>
	<jsp:include page="../component/header.jsp" />

	<jsp:include page="../component/maingrid.jsp" />

	<div class="container my-5">
		<div class="text-center mb-5">
			<h2 class="section-title">
				<i class="bi bi-fire text-danger"></i> 실시간 인기 경매
			</h2>
			<p class="section-subtitle">지금 바로 참여하고 특별한 상품을 만나보세요!</p>
		</div>

		<div class="row">
			<c:forEach var="item" items="${list}">
				<div class="col-lg-3 col-md-6 mb-4">
					<a href="${pageContext.request.contextPath}/item/${item.id}" class="text-decoration-none">
						<div class="card product-card h-100">
							<div class="card-img-container">
								<img src="${pageContext.request.contextPath}/${item.imageUrl}" class="card-img-top" alt="${item.title}">
								
								<span class="badge position-absolute top-0 start-0 m-3 countdown-timer" 
                                      data-end-time="${item.endTime.time}">
                                </span>
							</div>
							<div class="card-body d-flex flex-column">
								<h5 class="card-title mt-2">${item.title}</h5>
								<div class="mt-auto">
									<p class="price-label mb-1">현재 입찰가</p>
									<p class="price-text mb-0">${item.currentPrice}</p>
								</div>
							</div>
						</div>
					</a>
				</div>
			</c:forEach>
		</div>
	</div>

	<jsp:include page="../component/footer.jsp" />
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            
            // 페이지 내의 모든 카운트다운 타이머 요소를 선택
            const timers = document.querySelectorAll('.countdown-timer');

            function updateAllTimers() {
                timers.forEach(timer => {
                    // data-end-time 속성에서 경매 종료 시간을 숫자로 가져옴
                    const endTime = parseInt(timer.dataset.endTime, 10);
                    const now = new Date().getTime();
                    
                    // 남은 시간을 밀리초(ms) 단위로 계산
                    const remainingTime = endTime - now;

                    if (remainingTime > 0) {
                        // 경매가 아직 진행 중인 경우
                        timer.classList.add('bg-success'); // 부트스트랩 초록색 배경
                        timer.classList.remove('bg-secondary');

                        // 남은 시간을 일, 시, 분, 초로 변환
                        const days = Math.floor(remainingTime / (1000 * 60 * 60 * 24));
                        const hours = Math.floor((remainingTime % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                        const minutes = Math.floor((remainingTime % (1000 * 60 * 60)) / (1000 * 60));
                        const seconds = Math.floor((remainingTime % (1000 * 60)) / 1000);

                        // 숫자가 한 자리일 경우 앞에 0을 붙여줍니다 (예: 7 -> "07")
                        const pad = (num) => String(num).padStart(2, '0');

                        // 화면에 표시할 텍스트를 만듬
                        let timerText = '';
                        if (days > 0) {
                            timerText = `\${days}일 \${pad(hours)}:\${pad(minutes)}:\${pad(seconds)}`;
                        } else {
                            // 남은 시간이 24시간 미만이면 시:분:초만 표시
                            timerText = `\${pad(hours)}:\${pad(minutes)}:\${pad(seconds)}`;
                        }
                        
                        timer.textContent = timerText;

                    } else {
                        // 경매가 종료된 경우
                        timer.textContent = '경매 종료';
                        timer.classList.add('bg-secondary'); // 부트스트랩 회색 배경
                        timer.classList.remove('bg-success');
                    }
                });
            }

            // 페이지가 처음 로드될 때 타이머를 즉시 한 번 실행하여 1초의 지연을 없앰
            updateAllTimers(); 
            
            // 그 후 1초마다 updateAllTimers 함수를 반복해서 실행
            setInterval(updateAllTimers, 1000); 
        });
    </script>

</body>
</html>