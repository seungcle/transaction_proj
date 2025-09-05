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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/global.css">
<body>
	<jsp:include page="../component/header.jsp" />

	<div class="container mt-4">
		<h4 class="text-center my-4">🙋 1:1 문의</h4>
		<hr>

		<p class="text-muted">문의하실 내용을 작성해 주세요. (목업 페이지이며 실제 전송은 이루어지지
			않습니다)</p>

		<!-- 목업: submit 시 alert 후 본 페이지로 -->
		<form
			onsubmit="event.preventDefault(); alert('목업: 문의가 접수되었습니다.'); location.href='./inquiryForm.jsp';">
			<div class="row g-3">
				<div class="col-md-6">
					<label class="form-label">이메일</label> <input type="email"
						class="form-control" placeholder="example@email.com" required>
				</div>
				<div class="col-md-6">
					<label class="form-label">문의 유형</label> <select class="form-select"
						required>
						<option value="" selected disabled>선택하세요</option>
						<option>거래/결제</option>
						<option>회원/로그인</option>
						<option>신고/제재</option>
						<option>기타</option>
					</select>
				</div>
				<div class="col-12">
					<label class="form-label">제목</label> <input type="text"
						class="form-control" placeholder="제목을 입력하세요" required>
				</div>
				<div class="col-12">
					<label class="form-label">내용</label>
					<textarea class="form-control" rows="8"
						placeholder="문의 내용을 자세히 입력해 주세요" required></textarea>
				</div>
				<div class="col-12">
					<label class="form-label">첨부파일(선택)</label> <input type="file"
						class="form-control">
					<div class="form-text">이미지, PDF 등 증빙 파일 첨부 가능 (목업)</div>
				</div>
				<div class="col-12 form-check mt-2">
					<input class="form-check-input" type="checkbox" id="agree" required>
					<label class="form-check-label" for="agree"> (필수) 개인정보 수집 및
						이용에 동의합니다. </label>
				</div>
			</div>

			<div class="d-flex gap-2 mt-4">
				<button type="reset" class="btn btn-outline-secondary">초기화</button>
				<button type="submit" class="btn btn-primary">
					<i class="bi bi-send"></i> 문의 제출
				</button>
			</div>
		</form>
	</div>

	<!-- footer.jsp -->
	<jsp:include page="../component/footer.jsp" />
</body>
</html>
