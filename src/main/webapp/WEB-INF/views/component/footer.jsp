<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/footer.css">
</head>
<meta charset="UTF-8">


<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
	<footer class="footer">
		<div class="container">
			<div class="row">
				<div class="col-md-4 mb-4">
					<h5>
						<i class="fas fa-watermelon-slice"></i> 수박나라
					</h5>
					<p class="small">수익에 박동을 가하다</p>
					<div class="d-flex gap-3 mt-3">
						<a href="https://youtube.com/channel/UCromqxUKtK4v6Q5bRIgwPVw?feature=shared" target="_blank"><i class="fab fa-youtube"></i></a>
					</div>
				</div>
				<div class="col-md-2 mb-4">
					<h6>고객지원</h6>
					<ul class="list-unstyled small">
						<li><a
							href="${pageContext.request.contextPath}/jsp/complaint_list.jsp">공지사항</a></li>
						<li>자주하는 질문</li>
						<li><a
							href="${pageContext.request.contextPath}/jsp/inquiryForm.jsp">1:1
								문의</a></li>
						<li><a href="#">신고센터</a></li>
					</ul>

				</div>
				<div class="col-md-2 mb-4">
					<h6>이용안내</h6>
					<ul class="list-unstyled small">
						<li><a href="../service/tos.jsp">이용약관</a></li>
						<li><a href="../service/privacy.jsp">개인정보처리방침</a></li>
						<li><a href="../service/protectio.jsp">청소년보호정책</a></li>
					</ul>
				</div>
				<div class="col-md-4 mb-4">
					<h6>고객센터</h6>
					<div class="small">
						<p>
							<i class="fas fa-envelope"></i> fake@gmail.com
						</p>
						<p>평일/주말/공휴일 휴무</p>
					</div>
				</div>
			</div>
			<hr class="my-4">
			<div class="text-center small">
				<p>© 2027 수박나라. All rights reserved.</p>
				<p>서울 종로구 창경궁로 254 4층</p>
			</div>
		</div>
	</footer>
</body>
</html>
