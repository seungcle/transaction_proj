<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>물품 단체 채팅</title>

    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/watermelon_icon.ico">
    <%-- Bootstrap CSS --%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chat.css">

    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1.6.1/dist/sockjs.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>


    <style>
        #bidHistoryOffcanvas {
            width: 700px;
            max-width: 100%;
        }
        .bid-entry {
            display: flex;
            align-items: center;
            padding: 10px;
            border-bottom: 1px solid #eee;
            border-radius: 8px;
            margin-bottom: 5px;
        }
        .bid-entry:last-child {
            border-bottom: none;
        }

        .seller-entry {
            background-color: #f8f9fa; /* 연한 회색 배경 */
            border: 1px solid #dee2e6; /* 옅은 테두리 */
        }
        .seller-entry .nickname {
            color: #0d6efd; /* 부트스트랩 primary 색상 */
        }

        .bid-entry img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-right: 15px;
        }
        .bid-info {
            flex-grow: 1;
        }
        .bid-info .nickname {
            font-weight: bold;
            display: block;
        }
        .bid-info .price {
            color: #555;
        }
        .bid-entry .timestamp {
            font-size: 0.8em;
            color: #888;
        }
    </style>
</head>
<body>

    <div id="chat-data"
         data-room-id="${item.id}"
         data-context-path="${pageContext.request.contextPath}"> <%-- ContextPath를 data 속성으로 추가 --%>
    </div>

    <div class="offcanvas offcanvas-end" tabindex="-1" id="bidHistoryOffcanvas" aria-labelledby="bidHistoryOffcanvasLabel">
        <div class="offcanvas-header">
            <h5 class="offcanvas-title" id="bidHistoryOffcanvasLabel">
                <i class="bi bi-hammer"></i> 입찰 내역
            </h5>
            <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
        </div>
        <div class="offcanvas-body" id="bidHistoryBody">

        </div>
    </div>

    <script>
        $(function() {
            const bidHistoryOffcanvas = document.getElementById('bidHistoryOffcanvas');
            
            bidHistoryOffcanvas.addEventListener('show.bs.offcanvas', function () {
                const itemId = $('#chat-data').data('roomId');
                const $bidHistoryBody = $('#bidHistoryBody');
                
                $bidHistoryBody.html('<p class="text-center">입찰 내역을 불러오는 중...</p>');

                $.ajax({
                    url: `${pageContext.request.contextPath}/bid/${itemId}`,
                    type: 'GET',
                    dataType: 'json',
                    success: function(bidList) {
                        $bidHistoryBody.empty();
                        
                        if (bidList && bidList.length > 0) {
                            const lastIndex = bidList.length - 1; // 마지막 인덱스 계산

                            bidList.forEach(function(bid, index) { 
                                const formattedPrice = bid.bidPrice.toLocaleString();
                                let bidEntryHtml = '';

                                if (index === lastIndex) {
                                    // 마지막 데이터 (판매자)인 경우
                                    bidEntryHtml = `
                                        <div class="bid-entry seller-entry">
                                            <img src="${pageContext.request.contextPath}/\${bid.imageUrl}" alt="프로필 이미지">
                                            <div class="bid-info">
                                                <span class="nickname">
                                                    <i class="bi bi-crown-fill"></i> \${bid.nickname}
                                                    <span class="badge bg-primary ms-1">경매 시작</span>
                                                </span>
                                                <span class="price">\${formattedPrice}원</span>
                                            </div>
                                            <span class="timestamp">\${bid.createdAt}</span>
                                        </div>
                                    `;
                                } else {
                                    // 그 외 입찰자들의 경우
                                    bidEntryHtml = `
                                        <div class="bid-entry">
                                            <img src="${pageContext.request.contextPath}/\${bid.imageUrl}" alt="프로필 이미지">
                                            <div class="bid-info">
                                                <span class="nickname">\${bid.nickname}</span>
                                                <span class="price">\${formattedPrice}원</span>
                                            </div>
                                            <span class="timestamp">\${bid.createdAt}</span>
                                        </div>
                                    `;
                                }
                                
                                $bidHistoryBody.append(bidEntryHtml);
                            });
                        } else {
                            $bidHistoryBody.html('<p class="text-center">아직 입찰 내역이 없습니다.</p>');
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error("입찰 내역 조회 실패:", error);
                        $bidHistoryBody.html('<p class="text-center text-danger">입찰 내역을 불러오는 데 실패했습니다.</p>');
                    }
                });
            });
        });
    </script>
</body>
</html>