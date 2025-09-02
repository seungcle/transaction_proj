<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="icon" type="image/png" href="../images/watermelon_icon.ico">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<!-- 전역/페이지 전용 CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/global.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/mypage.css">
</head>
<body>
	<jsp:include page="header.jsp" />


	<div class="container mt-4">
		<h4 class="text-center my-4">📢 공지사항</h4>
		<hr>

		<div class="card shadow-sm">
			<div class="card-body p-0">
				<table class="table mb-0">
					<thead class="table-light">
						<tr>
							<th style="width: 80px">번호</th>
							<th>제목</th>
							<th style="width: 160px">작성일</th>
							<th style="width: 100px">조회수</th>
						</tr>
					</thead>
					<tbody>
						<!-- 목업 데이터 -->
						<tr>
							<td>3</td>
							<td><a href="#">[점검] 8/31(토) 시스템 점검 안내</a></td>
							<td>2025-08-18</td>
							<td>102</td>
						</tr>
						<tr>
							<td>2</td>
							<td><a href="#">여름 프로모션 종료 안내</a></td>
							<td>2025-08-10</td>
							<td>341</td>
						</tr>
						<tr>
							<td>1</td>
							<td><a href="#">수박나라 오픈 공지</a></td>
							<td>2025-07-30</td>
							<td>1024</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>

		<!-- 페이지네이션 목업 -->
		<nav class="mt-3">
			<ul class="pagination justify-content-center">
				<li class="page-item disabled"><a class="page-link" href="#">이전</a></li>
				<li class="page-item active"><a class="page-link" href="#">1</a></li>
				<li class="page-item"><a class="page-link" href="#">2</a></li>
				<li class="page-item"><a class="page-link" href="#">다음</a></li>
			</ul>
		</nav>
	</div>

	<!-- footer.jsp -->
	<jsp:include page="footer.jsp" />
</body>
</html>
