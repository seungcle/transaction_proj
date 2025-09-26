<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="userId" value="${sessionScope.user.id}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>찜한 상품</title>
<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/watermelon_icon.ico">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage-components.css">
</head>
<body>
    <div class="offcanvas offcanvas-end" tabindex="-1"
        id="myInterestsOffcanvas" aria-labelledby="myInterestsOffcanvasLabel" data-user-id="${userId}">
        <div class="offcanvas-header">
            <h5 class="offcanvas-title w-100 text-center" id="offcanvasLabel">찜한 상품</h5>
            <button type="button" class="btn-close" data-bs-dismiss="offcanvas"
                aria-label="Close"></button>
        </div>

        <div class="offcanvas-body">
            <div class="p-3" id="favorite-items-container">
            </div>
        </div>
    </div>


    <script>
        $(function() {
            
            const myInterestsOffcanvas = document.getElementById('myInterestsOffcanvas');
            const container = $('#favorite-items-container');
            var contextPath = "${pageContext.request.contextPath}";
            let currentPage = 1;
            let isLoading = false;

            // Offcanvas가 열릴 때 이벤트 감지
            myInterestsOffcanvas.addEventListener('show.bs.offcanvas', function () {
                currentPage = 1; // 페이지 번호 초기화
                container.empty(); // 컨테이너 비우기
                container.html('<p class="text-center p-5">목록을 불러오는 중...</p>'); // 로딩 메시지 표시
                fetchFavoriteItems(currentPage);
            });
            
            // 찜 목록을 가져오는 AJAX 함수
            function fetchFavoriteItems(page) {
                if (isLoading) return;
                isLoading = true;
                
                const userId = $(myInterestsOffcanvas).data('user-id');
                if (!userId) {
                    container.html('<p class="text-center p-5">사용자 정보를 불러올 수 없습니다.</p>');
                    isLoading = false;
                    return;
                }
                
                $.ajax({
                    url: `${pageContext.request.contextPath}/item/` + userId + '/favorite',
                    type: 'GET',
                    data: { page: page },
                    dataType: 'json',
                    success: function(list) {
                        if (page === 1) {
                            container.empty();
                        }

                        if (list && list.length > 0) {
                            $.each(list, function(index, item) {
                                let statusClass = item.status === 'OPEN' ? 'text-success' : 'text-secondary';
                                
                                // ✅ 변경된 부분: + 연산자를 사용하여 HTML 문자열을 만듬
                                var itemHtml = 
                                    '<div class="product-item position-relative">' +
                                    '<img src="' + contextPath + item.imageUrl + '">' +
                                        '<div class="product-item-info">' +
                                            '<h6 class="text-dark">' + item.title + '</h6>' +
                                            '<p class="price text-dark">' + item.currentPrice + '</p>' +
                                            '<p class="time ' + statusClass + '">' + item.status + '</p>' +
                                        '</div>' +
                                        '<a href="${pageContext.request.contextPath}/item/' + item.id + '" class="stretched-link"></a>' +
                                    '</div>';

                                container.append(itemHtml);
                            });
                        } else {
                            if (page === 1) {
                                container.html('<p class="text-center p-5">찜한 상품이 없습니다.</p>');
                            }
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("찜 목록 로딩 실패:", error);
                        if (page === 1) {
                             container.html('<p class="text-center p-5 text-danger">목록을 불러오는 중 오류가 발생했습니다.</p>');
                        }
                    },
                    complete: function() {
                        isLoading = false;
                    }
                });
            }

            // 무한 스크롤 기능
            $('#myInterestsOffcanvas .offcanvas-body').on('scroll', function() {
                const body = $(this);
                if (body.scrollTop() + body.innerHeight() >= body[0].scrollHeight - 50) {
                    if (!isLoading) {
                        currentPage++;
                        fetchFavoriteItems(currentPage);
                    }
                }
            });
        });
    </script>
</body>
</html>