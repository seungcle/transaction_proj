<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%
// 실제로는 DB에서 사용자의 배송지 목록을 가져와야 합니다.
// 여기서는 동적 구현을 보여주기 위해 임시 데이터를 생성합니다.
List<Map<String, Object>> addressList = new ArrayList<>();

Map<String, Object> addr1 = new HashMap<>();
addr1.put("id", 1);
addr1.put("nickname", "집");
addr1.put("isDefault", true);
addr1.put("recipient", "이혜성");
addr1.put("phone", "010-6345-4720");
addr1.put("postcode", "01053");
addr1.put("address", "서울 강북구 한천로150길 12-16");
addr1.put("addressDetail", "502호");
addressList.add(addr1);

Map<String, Object> addr2 = new HashMap<>();
addr2.put("id", 2);
addr2.put("nickname", "회사");
addr2.put("isDefault", false);
addr2.put("recipient", "이혜성");
addr2.put("phone", "010-1234-5678");
addr2.put("postcode", "04538");
addr2.put("address", "서울 중구 세종대로 110");
addr2.put("addressDetail", "서울시청");
addressList.add(addr2);
%>
<!DOCTYPE html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1">
<head>
<meta charset="UTF-8">
<title>배송지 관리</title>
<link rel="icon" type="image/png" href="../images/watermelon_icon.ico">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/mypage-components.css">
</head>
<body>

	<div class="offcanvas offcanvas-end" tabindex="-1"
		id="myAddressOffcanvas" aria-labelledby="myAddressOffcanvasLabel">
		<div class="offcanvas-header">
			<button id="back-button" type="button"
				class="btn btn-link text-dark me-2 d-none">
				<i class="bi bi-arrow-left fs-4"></i>
			</button>

			<h5 class="offcanvas-title flex-grow-1 text-center"
				id="addressOffcanvasLabel">배송지 관리</h5>

			<button type="button" class="btn-close" data-bs-dismiss="offcanvas"
				aria-label="Close"></button>
		</div>

		<div class="offcanvas-body">
			<div id="address-list-view">
				<div class="d-flex justify-content-end mb-2">
					<a href="javascript:void(0);" id="edit-btn"
						onclick="toggleEditMode()" class="text-decoration-none text-dark">
						<i class="bi bi-pencil-square"></i> 편집
					</a>
				</div>

				<div id="address-list-container">
					<%-- JSTL 대신 스크립트릿 for문 사용 --%>
					<%
					for (Map<String, Object> addr : addressList) {
					%>
					<%
					boolean isDefault = (Boolean) addr.get("isDefault");
					%>
					<div
						class="address-item position-relative <%=isDefault ? "is-default" : ""%>"
						data-address-id="<%=addr.get("id")%>">
						<button class="btn-delete d-none"
							onclick="deleteAddress(this, <%=addr.get("id")%>)">&times;</button>
						<div class="d-flex align-items-center mb-2">
							<strong class="fs-5 me-2"><%=addr.get("nickname")%></strong>
							<%-- JSTL <c:if> 대신 스크립트릿 if문 사용 --%>
							<%
							if (isDefault) {
							%>
							<span
								class="badge bg-primary-subtle text-primary-emphasis rounded-pill">대표
								배송지</span>
							<%
							}
							%>
						</div>
						<p class="mb-1"><%=addr.get("recipient")%></p>
						<p class="mb-1"><%=addr.get("phone")%></p>
						<p class="mb-0">
							[<%=addr.get("postcode")%>]
							<%=addr.get("address")%>,
							<%=addr.get("addressDetail")%></p>
					</div>
					<%
					}
					%>
				</div>

				<button class="btn btn-outline-secondary w-100"
					onclick="showView('form')">+ 배송지 추가</button>
			</div>

			<div id="address-form-view" class="d-none">
				<form onsubmit="return false;">
					<div class="mb-3">
						<input type="text" class="form-control"
							placeholder="배송지명 (최대 10글자)">
					</div>
					<div class="mb-3">
						<input type="text" class="form-control" placeholder="받는 분"
							value="이혜성">
					</div>
					<div class="mb-3">
						<input type="tel" class="form-control" placeholder="연락처"
							value="01063454720">
					</div>
					<div class="d-flex mb-2">
						<input type="text" class="form-control" id="postcode"
							placeholder="우편번호" readonly>
						<button type="button" class="btn btn-secondary ms-2 flex-shrink-0"
							onclick="showView('search')">주소 검색</button>
					</div>
					<div class="mb-3">
						<input type="text" class="form-control" id="address"
							placeholder="주소" readonly>
					</div>
					<div class="mb-3">
						<input type="text" class="form-control" id="addressDetail"
							placeholder="상세주소 (예: 101동 101호)">
					</div>
					<div class="form-check">
						<input class="form-check-input" type="checkbox"
							id="isDefaultCheck" checked> <label
							class="form-check-label" for="isDefaultCheck">대표 배송지로 설정</label>
					</div>
					<div class="bottom-fixed-btn">
						<button type="submit" class="btn btn-dark w-100 btn-lg">완료</button>
					</div>
				</form>
			</div>

			<div id="address-search-view" class="d-none" style="height: 100%;">
			</div>
		</div>

		<div class="offcanvas-footer">
			<i class="bi bi-info-circle"></i> 최대 5개까지 등록 가능
		</div>
	</div>


	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

	<script>
    // JavaScript 코드는 JSTL과 무관하므로 변경 없음
    const views = { list: document.getElementById('address-list-view'), form: document.getElementById('address-form-view'), search: document.getElementById('address-search-view') };
    const offcanvasTitle = document.getElementById('addressOffcanvasLabel');
    const backButton = document.getElementById('back-button');
    let currentView = 'list';
    let postcodeApi = null;

    function showView(viewName) {
        for (const key in views) { views[key].classList.add('d-none'); }
        views[viewName].classList.remove('d-none');
        if (viewName === 'list') { backButton.classList.add('d-none'); offcanvasTitle.textContent = '배송지 관리'; backButton.onclick = null; } 
        else if (viewName === 'form') { backButton.classList.remove('d-none'); offcanvasTitle.textContent = '배송지 추가'; backButton.onclick = () => showView('list'); } 
        else if (viewName === 'search') { backButton.classList.remove('d-none'); offcanvasTitle.textContent = '주소 검색'; backButton.onclick = () => showView('form'); openDaumPostcodeEmbed(); }
        currentView = viewName;
    }

    function openDaumPostcodeEmbed() {
        if (!postcodeApi) {
            postcodeApi = new daum.Postcode({
                oncomplete: function(data) {
                    document.getElementById('postcode').value = data.zonecode;
                    document.getElementById("address").value = data.roadAddress || data.jibunAddress;
                    document.getElementById("addressDetail").focus();
                    showView('form');
                },
                theme: { searchBgColor: "#FFFFFF", queryTextColor: "#000000" },
                width: '100%', height: '100%'
            });
        }
        postcodeApi.embed(views.search);
    }

    function toggleEditMode() {
        const container = document.getElementById('address-list-container');
        const editBtn = document.getElementById('edit-btn');
        const isEditing = container.classList.toggle('edit-mode');
        container.querySelectorAll('.btn-delete').forEach(btn => { btn.classList.toggle('d-none', !isEditing); });
        editBtn.innerHTML = isEditing ? '<i class="bi bi-check-circle"></i> 완료' : '<i class="bi bi-pencil-square"></i> 편집';
    }
    
    function deleteAddress(buttonElement, addressId) {
        if (confirm("정말로 이 배송지를 삭제하시겠습니까?")) {
            const addressItem = buttonElement.closest('.address-item');
            addressItem.style.transition = 'opacity 0.3s ease, transform 0.3s ease';
            addressItem.style.opacity = '0';
            addressItem.style.transform = 'translateX(50px)';
            setTimeout(() => { addressItem.remove(); }, 300);
        }
    }
</script>
</body>
</html>