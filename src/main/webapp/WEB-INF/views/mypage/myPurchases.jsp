<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="userId" value="${sessionScope.user.id}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매 내역</title>
<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/watermelon_icon.ico">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage-components.css">
</head>
<body>
    <div class="offcanvas offcanvas-end" tabindex="-1"
        id="myPurchasesOffcanvas" aria-labelledby="myPurchasesOffcanvasLabel" data-user-id="${userId}">
        <div class="offcanvas-header">
            <h5 class="offcanvas-title w-100 text-center" id="offcanvasLabel">구매 내역</h5>
            <button type="button" class="btn-close" data-bs-dismiss="offcanvas"
                aria-label="Close"></button>
        </div>

        <div class="p-3" id="purchaseCompleteListContainer">
            </div>

    </div>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    
    <script>
        $(document).ready(function() {
        	var contextPath = "${pageContext.request.contextPath}";
            // Offcanvas 요소 가져오기
            var myPurchasesOffcanvas = document.getElementById('myPurchasesOffcanvas');
            
            // Offcanvas가 열릴 때 이벤트를 감지 (show.bs.offcanvas는 Bootstrap 5 이벤트)
            myPurchasesOffcanvas.addEventListener('show.bs.offcanvas', function () {
                
                // 컨테이너를 비워서 중복 로딩 방지
                $('#purchaseCompleteListContainer').empty();

                // data-user-id 속성에서 userId 가져오기
                var userId = $(this).data('user-id');
                var page = 1; // 첫 페이지 로드
                
                // AJAX 요청 URL 생성
                var requestUrl = "${pageContext.request.contextPath}/item/" + userId + "/purchase/end?page=" + page;
                
                console.log("Requesting URL: " + requestUrl); // 디버깅용 로그

                $.ajax({
                    url: requestUrl,
                    type: 'GET',
                    dataType: 'json',
                    success: function(list) {
                        if (list && list.length > 0) {
                            // 응답받은 리스트를 순회하며 HTML 생성
                            $.each(list, function(index, item) {
                                // + 연산자를 사용하여 HTML 문자열 조합
                                var html = '<div class="product-item position-relative">'
                                         + '    <img src="' + contextPath + item.imageUrl + '" alt="상품 이미지">'
                                         + '    <div class="product-item-info">'
                                         + '        <h6 class="text-dark">' + item.title + '</h6>'
                                         + '        <p class="price text-dark">' + item.currentPrice + '</p>'
                                         + '        <p class="time">판매완료</p>'
                                         + '    </div>'
                                         // SimpleItemResponseVO에 itemId가 있다면 아래 링크를 동적으로 생성 가능
                                         + '    <a href="${pageContext.request.contextPath}/item/' + item.id + '" class="stretched-link"></a>'
                                         + '</div>';
                                
                                // 생성된 HTML을 컨테이너에 추가
                                $('#purchaseCompleteListContainer').append(html);
                            });
                        } else {
                            // 데이터가 없을 경우 메시지 표시
                            var noDataHtml = '<div class="text-center p-5 text-secondary">구매 완료 내역이 없습니다.</div>';
                            $('#purchaseCompleteListContainer').append(noDataHtml);
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("AJAX Error: ", status, error);
                        var errorHtml = '<div class="text-center p-5 text-danger">데이터를 불러오는 중 오류가 발생했습니다.</div>';
                        $('#purchaseCompleteListContainer').append(errorHtml);
                    }
                });
            });
        });
    </script>
</body>
</html>