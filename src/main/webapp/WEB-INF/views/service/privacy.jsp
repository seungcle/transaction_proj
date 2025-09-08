<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수박나라 개인정보처리방침</title>
<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/watermelon_icon.ico">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/global.css">
</head>
<body>
	<jsp:include page="../component/header.jsp" />

	<div class="container my-5">
		<h2 class="text-center mb-4">🍉 수박나라 개인정보처리방침</h2>
		<hr>

		<div class="card p-4 shadow-sm">
			<p>수박나라(이하 "회사")는 회원의 개인정보를 소중하게 생각하며, 「개인정보 보호법」 등 관련 법규를 준수하고 있습니다. 이 개인정보처리방침은 회원이 제공하는 개인정보가 어떤 용도와 방식으로 이용되고 있으며, 개인정보보호를 위해 어떤 조치가 취해지고 있는지 알려드립니다.</p>

			<h4 class="text-primary mt-4">제1조 (개인정보의 수집 항목 및 이용 목적)</h4>
			<p>회사는 다음과 같은 목적을 위해 최소한의 개인정보를 수집 및 이용하고 있습니다. 회원이 제공한 모든 개인정보는 아래 명시된 목적 이외의 용도로는 사용되지 않으며, 이용 목적이 변경될 경우 사전에 동의를 구할 것입니다.</p>
			
			<h6 class="mt-3">1. 회원가입 및 서비스 이용 시 수집 항목</h6>
			<ul>
				<li><strong>필수 항목:</strong> 아이디, 비밀번호, 성명, 휴대전화번호, 이메일 주소, 생년월일</li>
				<li><strong>선택 항목:</strong> 주소 (배송 관련), 프로필 사진, 관심 분야</li>
				<li><strong>이용 목적:</strong> 회원 식별 및 본인 확인, 불량 회원의 부정 이용 방지, 회원 서비스 제공, 고지사항 전달, 민원 처리, 분쟁 조정을 위한 기록 보존</li>
			</ul>

			<h6 class="mt-3">2. 경매 및 거래 서비스 이용 시 수집 항목</h6>
			<ul>
				<li><strong>필수 항목:</strong> 결제 정보(신용카드 정보, 은행 계좌 정보), 배송 정보(받는 사람 성명, 주소, 연락처)</li>
				<li><strong>이용 목적:</strong> 거래 대금 정산, 물품 배송, 구매/판매 내역 관리</li>
			</ul>
			
			<h6 class="mt-3">3. 서비스 이용 과정에서 자동으로 생성되는 정보</h6>
			<ul>
				<li><strong>항목:</strong> IP 주소, 접속 로그, 쿠키, 방문 일시, 기기 정보(OS, 브라우저 종류), 결제 기록</li>
				<li><strong>이용 목적:</strong> 서비스 이용 분석, 불법/부정 이용 방지, 통계 분석, 서비스 개선</li>
			</ul>
			
			<h4 class="text-primary mt-5">제2조 (개인정보의 보유 및 이용 기간)</h4>
			<p>회사는 법령에 따른 개인정보 보유 및 이용 기간 또는 회원으로부터 개인정보를 수집 시 동의 받은 보유 및 이용 기간 내에서 개인정보를 처리 및 보유합니다.</p>
			<ul>
				<li><strong>회원 탈퇴 시:</strong> 회원가입 시 수집된 개인정보는 탈퇴 즉시 파기됩니다.</li>
				<li><strong>다만, 관계 법령에 따라 보존할 필요가 있는 경우:</strong>
					<ul>
						<li>계약 또는 청약철회 등에 관한 기록: 5년 (전자상거래 등에서의 소비자보호에 관한 법률)</li>
						<li>대금결제 및 재화 등의 공급에 관한 기록: 5년 (전자상거래 등에서의 소비자보호에 관한 법률)</li>
						<li>소비자의 불만 또는 분쟁처리에 관한 기록: 3년 (전자상거래 등에서의 소비자보호에 관한 법률)</li>
					</ul>
				</li>
			</ul>
			
			<h4 class="text-primary mt-5">제3조 (개인정보의 파기 절차 및 방법)</h4>
			<p>회사는 개인정보 보유기간의 경과, 처리 목적 달성 등 개인정보가 불필요하게 되었을 때 지체 없이 해당 개인정보를 파기합니다.</p>
			<ul>
				<li><strong>파기 절차:</strong> 회사는 파기 사유가 발생한 개인정보를 선정하고, 회사의 개인정보 보호 책임자의 승인을 받아 개인정보를 파기합니다.</li>
				<li><strong>파기 방법:</strong>
					<ul>
						<li><strong>전자적 파일 형태:</strong> 기록을 재생할 수 없는 기술적 방법(로우레벨 포맷 등)을 사용하여 영구 삭제합니다.</li>
						<li><strong>종이 문서:</strong> 파쇄하거나 소각하여 파기합니다.</li>
					</ul>
				</li>
			</ul>

			<h4 class="text-primary mt-5">제4조 (개인정보의 제3자 제공)</h4>
			<p>회사는 회원의 동의가 있거나, 법률의 특별한 규정이 있는 경우를 제외하고는 회원의 개인정보를 제1조에 명시된 목적 범위를 넘어 제3자에게 제공하지 않습니다.</p>

			<h4 class="text-primary mt-5">제5조 (개인정보처리 위탁)</h4>
			<p>회사는 원활한 서비스 제공을 위해 다음과 같이 개인정보 처리 업무를 외부 전문업체에 위탁하여 운영하고 있습니다. 위탁 계약 시 개인정보 보호법의 관련 규정을 준수합니다.</p>
			<ul>
				<li><strong>배송 서비스:</strong> 택배사 (예: CJ대한통운, 우체국 등)</li>
				<li><strong>결제 처리:</strong> PG(전자결제대행)사 (예: KG이니시스, NICE페이 등)</li>
			</ul>

			<h4 class="text-primary mt-5">제6조 (개인정보 보호 책임자 및 담당 부서)</h4>
			<p>회사는 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 회원의 불만 처리 및 피해 구제 등을 위하여 아래와 같이 개인정보 보호 책임자를 지정하고 있습니다.</p>
			<ul>
				<li><strong>개인정보 보호 책임자:</strong> [수박나라] 팀장</li>
				<li><strong>담당 부서:</strong> 고객지원팀</li>
				<li><strong>연락처:</strong> [이메일 주소], [전화번호]</li>
			</ul>

			<h4 class="text-primary mt-5">제7조 (회원의 권리 및 의무)</h4>
			<p>1. <strong>회원은 언제든지 자신의 개인정보를 조회하거나 수정할 수 있으며, 회원 탈퇴를 요청할 수 있습니다.</strong></p>
			<p>2. <strong>회원은 개인정보 보호 의무를 성실히 이행해야 합니다.</strong> 타인의 개인정보를 도용하거나 부정확한 정보를 입력할 경우 법적 책임을 질 수 있습니다.</p>
			
			<h4 class="text-primary mt-5">제8조 (개인정보처리방침 변경)</h4>
			<p>이 개인정보처리방침은 법령 및 방침에 따른 변경 내용의 추가, 삭제 및 정정이 있는 경우에는 변경사항의 시행 7일 전부터 웹사이트 공지사항을 통해 고지할 것입니다.</p>

			<h4 class="text-primary mt-5">부칙</h4>
			<p>이 개인정보처리방침은 2025년 8월 29일부터 시행됩니다.</p>
		</div>
	</div>

	<jsp:include page="../component/footer.jsp" />
</body>
</html>