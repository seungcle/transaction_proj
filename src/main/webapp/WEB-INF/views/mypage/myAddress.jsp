<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>배송지 관리</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage-components.css">
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

	<div class="offcanvas offcanvas-end" tabindex="-1" id="myAddressOffcanvas">
		<div class="offcanvas-header">
			<h5 class="offcanvas-title" id="addressOffcanvasLabel">배송지 관리</h5>
			<button type="button" class="btn-close" data-bs-dismiss="offcanvas"></button>
		</div>
		<div class="offcanvas-body">
			<div id="address-list-view">
				<div class="d-flex justify-content-end mb-2">
					<a href="javascript:void(0);" id="edit-btn" onclick="toggleEditMode()" class="text-decoration-none text-dark">
						<i class="bi bi-pencil-square"></i> 편집
					</a>
				</div>
				<div id="address-list-container">
	<c:forEach var="addr" items="${addressList}">
		<div class="address-item position-relative ${addr.defaultAddress eq 'Y' ? 'is-default' : ''}"
	data-address-id="${addr.id}"
	data-address-name="${addr.addressName}"
	data-address="${addr.address}"
	data-detail-address="${addr.detailAddress}"
	data-default-address="${addr.defaultAddress}"
	data-postal-code="${addr.postalCode}">
	
	<div class="mb-2">
		<strong class="fs-5 me-2">배송지명: ${addr.addressName}</strong>
		<c:if test="${addr.defaultAddress eq 'Y'}">
			<span class="badge bg-primary-subtle text-primary-emphasis rounded-pill">대표 배송지</span>
		</c:if>
	</div>
	<p class="mb-1">
		<span>우편번호: ${addr.postalCode}</span><br>
		<span>주소: ${addr.address}</span><br>
		<span>상세주소: ${addr.detailAddress}</span>
	</p>
	
	<div class="edit-buttons d-flex gap-2 position-absolute top-0 end-0 p-3 d-none">
		<button class="btn btn-outline-secondary btn-sm" onclick="editAddress(this)">수정</button>
		<button class="btn btn-outline-danger btn-sm" onclick="deleteAddress(this, ${addr.id})">삭제</button>
	</div>
</div>
	</c:forEach>
</div>
				<button class="btn btn-outline-secondary w-100 mt-4" onclick="showAddForm()">+ 배송지 추가</button>
			</div>

			<div id="address-form-view" class="d-none">
				<div class="d-flex justify-content-start mb-3">
					<a href="javascript:void(0);" onclick="showListView()" class="text-decoration-none text-dark">
						<i class="bi bi-arrow-left"></i> 뒤로
					</a>
				</div>
				<form id="address-form" onsubmit="return false;">
					<input type="hidden" class="form-address-id">
					<div class="mb-3">
						<input type="text" class="form-control form-nickname" placeholder="배송지명 (최대 10글자)" name="addressName">
					</div>
					<div class="d-flex mb-2">
						<input type="text" class="form-control form-postal-code" placeholder="우편번호"  name=" postalCode" readonly>
						<button type="button" class="btn btn-secondary ms-2 flex-shrink-0" onclick="openDaumPostcode()">주소 검색</button>
					</div>
					<div class="mb-3">
						<input type="text" class="form-control form-address" placeholder="주소"  name="address" readonly>
					</div>
					<div class="mb-3">
						<input type="text" class="form-control form-address-detail" placeholder="상세주소" name="detailAddress">
					</div>
					<div class="form-check mb-3">
						<input class="form-check-input form-is-default" type="checkbox">
						<label class="form-check-label">대표 배송지로 설정</label>
					</div>
					<div class="mt-3">
						<button type="submit" class="btn btn-dark w-100 btn-lg form-submit-btn">완료</button>
					</div>
				</form>
			</div>

			<div id="daum-postcode-container" style="display: none; height: 400px;"></div>
		</div>
		<div class="offcanvas-footer">
			<i class="bi bi-info-circle"></i> 최대 5개까지 등록 가능
		</div>
	</div>

	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	$(function() {
		const views = { list: $('#address-list-view'), form: $('#address-form-view') };
		const formId = $('.form-address-id');
		const formNickname = $('.form-nickname');
		const formPostalCode = $('.form-postal-code');
		const formAddress = $('.form-address');
		const formAddressDetail = $('.form-address-detail');
		const formIsDefault = $('.form-is-default');
		const formSubmitBtn = $('.form-submit-btn');
		const contextPath = '${pageContext.request.contextPath}';

		function loadAddressListAsHtml() {
			$.get(contextPath + '/mypage/address', function(html) {
				const tempDiv = $('<div>').html(html);
				const newContent = tempDiv.find('#address-list-container').html();
				if (newContent) {
					$('#address-list-container').html(newContent);
				} else {
					$('#address-list-container').html('<div class="text-center text-muted">로딩 실패</div>');
				}
				$('#address-list-container').removeClass('edit-mode');
				$('#address-list-container .edit-buttons').addClass('d-none');
				$('#edit-btn').html('<i class="bi bi-pencil-square"></i> 편집');
			}).fail(function(xhr, status, error) {
				alert('주소 목록을 불러오는데 실패했습니다.');
			});
		}

		window.showListView = function() {
			views.form.addClass('d-none');
			views.list.removeClass('d-none');
		};

		window.showAddForm = function() {
			formId.val('');
			formNickname.val('');
			formPostalCode.val('');
			formAddress.val('');
			formAddressDetail.val('');
			formIsDefault.prop('checked', false);
			formSubmitBtn.text('추가');
			views.list.addClass('d-none');
			views.form.removeClass('d-none');
			$('#daum-postcode-container').hide();
		};
		
		// 주소 수정 버튼 클릭 시 호출되는 함수
		window.editAddress = function(button) {
			const item = $(button).closest('.address-item');
			
			// 데이터를 입력 폼에 미리 채워넣음
			formId.val(item.data('addressId'));
			formNickname.val(item.data('addressName'));
			formPostalCode.val(item.data('postalCode'));
			formAddress.val(item.data('address'));
			formAddressDetail.val(item.data('detailAddress'));
			formIsDefault.prop('checked', item.data('defaultAddress') === 'Y');
			formSubmitBtn.text('저장');
			
			// 주소 입력 폼 뷰로 전환
			views.list.addClass('d-none');
			views.form.removeClass('d-none');
			$('#daum-postcode-container').hide();
		};

		window.toggleEditMode = function() {
			const container = $('#address-list-container');
			const editBtn = $('#edit-btn');
			container.toggleClass('edit-mode');
			container.find('.edit-buttons').toggleClass('d-none');
			editBtn.html(container.hasClass('edit-mode') ? '<i class="bi bi-check-circle"></i> 완료' : '<i class="bi bi-pencil-square"></i> 편집');
		};

		window.deleteAddress = function(button, id) {
			if(confirm('정말 삭제하시겠습니까?')) {
				$.post(contextPath + '/mypage/address/delete/' + id, function(res) {
					if(res === 'success') {
						loadAddressListAsHtml();
					} else if(res === 'login_required') {
						alert('로그인 후 이용 가능합니다.');
						location.reload();
					} else {
						alert('오류가 발생했습니다.');
					}
				}).fail(function() {
					alert('서버 오류 발생');
				});
			}
		};

		window.openDaumPostcode = function() {
			views.form.hide();
			$('#daum-postcode-container').show();
			new daum.Postcode({
				oncomplete: function(data) {
					formPostalCode.val(data.zonecode);
					formAddress.val(data.roadAddress || data.jibunAddress);
					$('#daum-postcode-container').hide();
					views.form.show();
					formAddressDetail.focus();
				},
				width: '100%',
				height: '100%'
			}).embed(document.getElementById('daum-postcode-container'));
		};

		formSubmitBtn.off('click').on('click', function() {
			if (!formNickname.val().trim() || !formPostalCode.val().trim() || !formAddress.val().trim()) {
				alert('배송지명, 우편번호, 주소는 필수 입력 항목입니다.');
				return;
			}
			formSubmitBtn.prop('disabled', true);
			
			const isUpdate = formId.val().trim() !== '';
			const url = isUpdate ? contextPath + '/mypage/address/update' : contextPath + '/mypage/address/add';
			
			const dto = {
				id: isUpdate ? formId.val() : null,
				addressName: formNickname.val().trim(),
				address: formAddress.val().trim(),
				detailAddress: formAddressDetail.val().trim(),
				defaultAddress: formIsDefault.prop('checked') ? 'Y' : 'N',
				postalCode: formPostalCode.val().trim()
			};
			
			$.ajax({
				url: url,
				type: 'POST',
				contentType: 'application/json',
				data: JSON.stringify(dto),
				success: function(res) {
					if (res === 'success') {
						loadAddressListAsHtml();
						showListView();
						formSubmitBtn.prop('disabled', false);
					} else if (res === 'login_required') {
						alert('로그인 후 이용 가능합니다.');
						location.reload();
					} else {
						alert('예상치 못한 응답: ' + res);
						formSubmitBtn.prop('disabled', false);
					}
				},
				error: function(xhr) {
					alert('오류가 발생했습니다: ' + xhr.status);
					formSubmitBtn.prop('disabled', false);
				}
			});
		});

		const offcanvasElement = document.getElementById('myAddressOffcanvas');
		if (offcanvasElement) {
			offcanvasElement.addEventListener('show.bs.offcanvas', function () {
				loadAddressListAsHtml();
			});
		}
	});
	</script>
</body>
</html>