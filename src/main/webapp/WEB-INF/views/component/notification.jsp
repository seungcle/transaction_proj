<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 
    [중요] 세션에 저장된 사용자 정보를 JSTL을 사용해 userId 변수로 설정합니다.
    sessionScope.user.id 부분은 실제 사용하는 세션 객체 구조에 맞게 수정해야 합니다.
    예: sessionScope.loginUser.userId, sessionScope.member.id 등
--%>
<c:set var="loggedInUserId" value="${sessionScope.user.id}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알림</title>
<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/watermelon_icon.ico">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/global.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/notification.css">

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>

	<div class="offcanvas offcanvas-end" tabindex="-1" id="notificationOffcanvas" aria-labelledby="notificationOffcanvasLabel">
		<div class="offcanvas-header">
			<button type="button" class="btn btn-link text-dark" data-bs-dismiss="offcanvas" aria-label="Close">
				<i class="bi bi-arrow-left fs-4"></i>
			</button>
			<h5 class="offcanvas-title w-100 text-center" id="offcanvasLabel">알림</h5>
			<button type="button" class="btn btn-link text-danger p-0" onclick="clearAllNotifications()" aria-label="Clear all notifications">
				<i class="bi bi-trash fs-4"></i>
			</button>
		</div>

		<%-- 알림 목록이 동적으로 채워질 영역 --%>
		<div class="offcanvas-body p-0">
			<div class="text-center p-5 text-muted">새로운 알림이 없습니다.</div>
		</div>
	</div>

<script>
const userId = "${loggedInUserId}";
const contextPath = "${pageContext.request.contextPath}";

$(document).ready(function() {
    const notificationOffcanvas = document.getElementById('notificationOffcanvas');
    const offcanvasBody = $('.offcanvas-body');

    notificationOffcanvas.addEventListener('show.bs.offcanvas', function () {
        if (!userId) {
            console.error("로그인된 사용자 ID를 찾을 수 없습니다.");
            offcanvasBody.html('<div class="text-center p-5 text-muted">로그인이 필요합니다.</div>');
            return;
        }
        
        $.ajax({
            url: `${pageContext.request.contextPath}/notification/\${userId}`, // 수정: Context Path 적용
            type: 'GET',
            dataType: 'json',
            success: function(notifications) {
                offcanvasBody.empty();

                if (notifications && notifications.length > 0) {
                    $.each(notifications, function(index, noti) {
                        // [수정] DTO 필드명(isRead)에 맞게 변경
                        const isNew = noti.isRead === 'N'; 
                        
                        const notificationHtml = `
                            <div class="notification-item position-relative ${isNew ? 'is-new' : ''}" id="notification-\${noti.id}">
                                <img src="${pageContext.request.contextPath}/\${noti.imageUrl}" alt="\${noti.title} 이미지">
                                
                                <div class="notification-content">
                                    <p>
                                        <strong>[\${noti.title}]</strong>
                                        \${noti.content}
                                    </p>
                                </div>
                                
                                <button type="button" class="btn-close ms-2" aria-label="Close" onclick="dismissNotification(event, \${noti.id})"></button>
                                
                                <a href="${pageContext.request.contextPath}/item/\${noti.itemId}" class="stretched-link"></a>
                            </div>
                        `;
                        offcanvasBody.append(notificationHtml);
                    });
                } else {
                    offcanvasBody.html('<div class="text-center p-5 text-muted">새로운 알림이 없습니다.</div>');
                }
            },
            error: function(xhr, status, error) {
                console.error("알림을 불러오는 데 실패했습니다:", error);
                offcanvasBody.html('<div class="text-center p-5 text-danger">알림을 불러오는 중 오류가 발생했습니다.</div>');
            }
        });
    });
});

function dismissNotification(event, notificationId) {
    event.stopPropagation();
    
    $.ajax({
        url: `${pageContext.request.contextPath}/notification/read/\${notificationId}`, // 수정: Context Path 적용
        type: 'POST',
        success: function() {
            console.log(`알림 ${notificationId} 읽음 처리 완료`);
            
            const notificationElement = $('#notification-' + notificationId);
            if (notificationElement.length) {
                notificationElement.css({
                    'transition': 'opacity 0.5s ease',
                    'opacity': '0'
                });
                setTimeout(() => {
                    notificationElement.remove();
                    if ($('.notification-item').length === 0) {
                        $('.offcanvas-body').html('<div class="text-center p-5 text-muted">새로운 알림이 없습니다.</div>');
                    }
                }, 500);
            }
        },
        error: function(xhr, status, error) {
            console.error(`알림 ${notificationId} 읽음 처리 실패:`, error);
            alert('알림을 삭제하는 중 오류가 발생했습니다.');
        }
    });
}

function clearAllNotifications() {
    $('.notification-item').each(function() {
        const notiId = $(this).attr('id').split('-')[1];
        dismissNotification(new Event('click'), notiId);
    });
}
</script>

</body>
</html>