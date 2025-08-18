<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
    // 실제로는 DB에서 알림 목록을 가져와야 합니다.
    // 여기서는 동적 구현을 보여주기 위해 임시 데이터를 생성합니다.
    List<Map<String, Object>> notifications = new ArrayList<>();

    Map<String, Object> noti1 = new HashMap<>();
    noti1.put("id", 1);
    noti1.put("isNew", true);
    noti1.put("productName", "아이폰12 미니 팔아요");
    noti1.put("imageUrl", "https://img.khan.co.kr/news/2020/11/24/2020112501002740800239391.jpg");
    noti1.put("productUrl", "/product/detail?id=101");
    noti1.put("message", "상품이 상위 입찰 되었습니다.");
    notifications.add(noti1);

    Map<String, Object> noti2 = new HashMap<>();
    noti2.put("id", 2);
    noti2.put("isNew", false);
    noti2.put("productName", "에어팟 프로 팝니다");
    noti2.put("imageUrl", "https://thumbnail7.coupangcdn.com/thumbnails/remote/492x492ex/image/vendor_inventory/e191/98384687d5d12e3ea89d40aa5e2dbde706966b7e813caccd8e7d58a0f310.jpg");
    noti2.put("productUrl", "/product/detail?id=102");
    noti2.put("message", "상품 등록 시간이 5분 남았습니다.");
    notifications.add(noti2);
    
    Map<String, Object> noti3 = new HashMap<>();
    noti3.put("id", 3);
    noti3.put("isNew", true);
    noti3.put("productName", "고급스러운 빈티지 기계식 키보드");
    noti3.put("imageUrl", "http://gd3.alicdn.com/imgextra/i3/54410696/TB2vkTrbrMlyKJjSZFlXXbMoFXa_!!54410696.jpg_640x640.jpg");
    noti3.put("productUrl", "/product/detail?id=103");
    noti3.put("message", "새로운 메시지가 도착했습니다.");
    notifications.add(noti3);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>알림</title>
<link rel="stylesheet" href="/subak/css/notification.css">
</head>
<body>

    <div class="offcanvas offcanvas-end" tabindex="-1" id="notificationOffcanvas" aria-labelledby="notificationOffcanvasLabel">
		<div class="offcanvas-header">
		<button type="button" class="btn btn-link text-dark"
				data-bs-dismiss="offcanvas" aria-label="Close">
			<i class="bi bi-arrow-left fs-4"></i>
		</button>
			<h5 class="offcanvas-title w-100 text-center" id="offcanvasLabel">알림</h5>
		</div>

		<div class="offcanvas-body p-0">
            <% if (notifications == null || notifications.isEmpty()) { %>
                <div class="text-center p-5 text-muted">
                    새로운 알림이 없습니다.
                </div>
            <% } %>

            <% for (Map<String, Object> noti : notifications) { %>
                <div class="notification-item position-relative <%= ((Boolean)noti.get("isNew")) ? "is-new" : "" %>" id="notification-<%= noti.get("id") %>">
                    <img src="<%= noti.get("imageUrl") %>" alt="상품 이미지">
                    
                    <div class="notification-content">
                        <p>
                           <strong>[<%= noti.get("productName") %>]</strong> <%= noti.get("message") %>
                        </p>
                    </div>
                    
                    <button type="button" class="btn-close ms-2" aria-label="Close" onclick="dismissNotification(event, <%= noti.get("id") %>)"></button>
                    
                    <a href="<%= noti.get("productUrl") %>" class="stretched-link"></a>
                </div>
            <% } %>
		</div>
	</div>

<script>
    function dismissNotification(event, notificationId) {
        event.stopPropagation(); 
        const notificationElement = document.getElementById('notification-' + notificationId);
        if (notificationElement) {
            notificationElement.style.transition = 'opacity 0.5s ease';
            notificationElement.style.opacity = '0';
            setTimeout(() => {
                notificationElement.remove();
            }, 500);
        }
    }
</script>
</body>
</html>