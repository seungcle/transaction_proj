<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 - 채팅</title>
<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/watermelon_icon.ico">
<%-- Bootstrap 5 CSS & Icons --%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<%-- jQuery Library (Ajax 사용을 위해 추가) --%>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<%-- Websocket Libraries --%>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1.6.1/dist/sockjs.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>

<style>
    /* ... (스타일 코드는 기존과 동일) ... */
    .chat-list-item img { width: 50px; height: 50px; object-fit: cover; }
    .chat-list-item .last-message { display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis; font-size: 0.9em; color: #6c757d; }
    .chat-list-item:hover { background-color: #f8f9fa; }
    .chat-scroll { overflow-y: auto; padding: 10px; display: flex; flex-direction: column; }
    .msg { display: flex; flex-direction: column; margin-bottom: 15px; max-width: 70%; }
    .msg .name { font-size: 0.8rem; color: #666; margin-bottom: 4px; }
    .msg .bubble { padding: 10px 15px; border-radius: 1.2rem; line-height: 1.4; }
    .msg .time { font-size: 0.75rem; color: #999; margin-top: 4px; }
    .msg.me { align-self: flex-end; align-items: flex-end; }
    .msg.me .bubble { background-color: #0d6efd; color: white; }
    .msg.other { align-self: flex-start; align-items: flex-start; }
    .msg.other .bubble { background-color: #e9ecef; color: #212529; }
</style>
</head>
<body>

<%-- ✅ 현재 로그인한 사용자 정보를 담는 부분 --%>
<div id="user-data" data-id="${user.id}" data-nickname="${user.nickname}"></div>

<div class="offcanvas offcanvas-end" tabindex="-1" id="myChatOffcanvas" aria-labelledby="myChatOffcanvasLabel">
    <div class="offcanvas-header border-bottom">
        <h5 class="offcanvas-title w-100 text-center" id="myChatOffcanvasLabel">
            <i class="bi bi-chat-dots-fill"></i> 채팅
        </h5>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <div class="offcanvas-body p-0">
        <div class="list-group list-group-flush" id="chat-room-list"></div>
    </div>
</div>


<div class="offcanvas offcanvas-end" tabindex="-1" id="chatDetailOffcanvas" aria-labelledby="chatDetailOffcanvasLabel">
    <div class="offcanvas-header border-bottom">
        <button class="btn" type="button" data-bs-toggle="offcanvas" data-bs-target="#myChatOffcanvas" aria-label="뒤로가기">
            <i class="bi bi-arrow-left"></i>
        </button>
        <h5 class="offcanvas-title mx-auto text-center w-100" id="chatDetailOffcanvasLabel">채팅방 이름</h5>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>
    <div class="offcanvas-body d-flex flex-column p-0">
        <%-- 채팅 내용이 표시될 영역 --%>
        <div id="chat-list" class="flex-grow-1 mb-3 chat-scroll"></div>
        <div class="input-group p-3 border-top">
            <input type="text" id="chat-message-input" class="form-control" placeholder="메시지를 입력하세요...">
            <button id="send-button" class="btn btn-dark" type="button">
                <i class="bi bi-send-fill"></i>
            </button>
        </div>
    </div>
</div>


<script type="text/javascript">
$(document).ready(function() {
    var contextPath = "${pageContext.request.contextPath}";
    var currentUserId = $('#user-data').data('id');
    var currentUserNickname = $('#user-data').data('nickname');

    // ✅ 웹소켓 관련 전역 변수
    var stompClient = null;
    var currentRoomId = null;

    // 채팅 목록 Offcanvas가 열릴 때마다 목록을 새로고침
    var myChatOffcanvas = document.getElementById('myChatOffcanvas');
    myChatOffcanvas.addEventListener('show.bs.offcanvas', function () {
        loadChatList();
    });

    // 채팅 상세 Offcanvas가 열릴 때 이벤트
    var chatDetailOffcanvas = document.getElementById('chatDetailOffcanvas');
    chatDetailOffcanvas.addEventListener('show.bs.offcanvas', function (event) {
        var button = event.relatedTarget;
        var roomName = $(button).data('room-name');
        var roomId = $(button).data('room-id');

        currentRoomId = roomId; // ✅ 현재 접속한 채팅방 ID 저장
        $('#chatDetailOffcanvasLabel').text(roomName);
        
        loadChatMessages(roomId); // 기존 대화 내용 불러오기
        connect(roomId);          // ✅ 웹소켓 연결
    });
    
    // ✅ 채팅 상세 Offcanvas가 닫힐 때 이벤트
    chatDetailOffcanvas.addEventListener('hide.bs.offcanvas', function (event) {
        disconnect(); // ✅ 웹소켓 연결 해제
        $('#chat-list').empty(); // 채팅 내용 비우기
    });
    
    // ✅ 전송 버튼 클릭 이벤트
    $('#send-button').on('click', function() {
        sendMessage();
    });

    // ✅ 메시지 입력 후 Enter 키 입력 이벤트
    $('#chat-message-input').on('keypress', function(e) {
        if (e.which == 13) { // Enter key
            sendMessage();
        }
    });

    /**
     * ✅ 지정된 채팅방에 웹소켓을 연결하는 함수
     * @param {number} roomId
     */
    function connect(roomId) {
        // 이미 연결된 상태면 중복 연결 방지
        if (stompClient) {
            console.log("이미 연결되어 있습니다.");
            return;
        }

        // 1. SockJS를 사용한 웹소켓 클라이언트 생성
        var socket = new SockJS(contextPath + '/ws'); // 서버의 웹소켓 엔드포인트
        
        // 2. STOMP 클라이언트 생성
        stompClient = Stomp.over(socket);

        // 3. STOMP 클라이언트로 서버에 연결
        stompClient.connect({}, function (frame) {
            console.log('STOMP Connected: ' + frame);

            // 4. 특정 채팅방 주제(topic)를 구독
            // 서버에서 "/topic/chat/dm/{roomId}"로 메시지를 보내면 이 곳에서 수신
            stompClient.subscribe('/topic/chat/dm/' + roomId, function (chatResponse) {
                var message = JSON.parse(chatResponse.body);
                displayMessage(message); // 받은 메시지를 화면에 표시
            });
        }, function(error) {
            console.error('STOMP 연결 실패:', error);
            alert("채팅 서버에 연결할 수 없습니다. 잠시 후 다시 시도해주세요.");
        });
    }

    /**
     * ✅ 현재 연결된 웹소켓을 해제하는 함수
     */
    function disconnect() {
        if (stompClient !== null) {
            stompClient.disconnect(function() {
                console.log("STOMP Disconnected");
            });
            stompClient = null;
        }
    }

    /**
     * ✅ 입력된 메시지를 STOMP를 통해 서버로 전송하는 함수
     */
    function sendMessage() {
        var messageInput = $('#chat-message-input');
        var message = messageInput.val().trim();

        if (message && stompClient) {
            var chatRequest = {
            	userId: currentUserId,
                nickname: currentUserNickname,
                message: message
            };
            
            // @MessageMapping("/chat/dm/{roomId}") 컨트롤러로 메시지 전송
            stompClient.send("/app/chat/dm/" + currentRoomId, {}, JSON.stringify(chatRequest));
            
            messageInput.val(''); // 입력창 비우기
        }
    }
    
    /**
     * ✅ 메시지 객체를 받아 화면에 채팅 버블로 표시하는 함수
     * @param {object} msg - {nickname, message, createdAt}
     */
    function displayMessage(msg) {
        var chatContainer = $('#chat-list');
        var msgClass = msg.nickname == currentUserNickname ? 'me' : 'other';
        var formattedTime = formatMessageTime(msg.createdAt);

        var messageHtml = 
            '<div class="msg ' + msgClass + '">' +
                '<div class="name">' + msg.nickname + '</div>' +
                '<div class="bubble">' + msg.message.replace(/\n/g, "<br>") + '</div>' + // 줄바꿈 처리
                '<div class="time">' + formattedTime + '</div>' +
            '</div>';
        
        chatContainer.append(messageHtml);
        chatContainer.scrollTop(chatContainer[0].scrollHeight); // 스크롤을 맨 아래로 이동
    }

    /**
     * 서버에서 채팅방 목록을 가져와 화면에 렌더링하는 함수
     */
    function loadChatList() {
        $.ajax({
            url: contextPath + '/chat/list',
            type: 'GET',
            dataType: 'json',
            success: function(chatList) {
                var chatListContainer = $('#chat-room-list');
                chatListContainer.empty();
                if (chatList && chatList.length > 0) {
                    $.each(chatList, function(index, chatRoom) {
                        var formattedTime = formatRelativeTime(chatRoom.createdAt);
                        var chatItemHtml =
                            '<a href="#" class="list-group-item list-group-item-action chat-list-item p-3" ' +
                            'data-bs-toggle="offcanvas" data-bs-target="#chatDetailOffcanvas" ' +
                            'data-room-id="' + chatRoom.roomId + '" data-room-name="' + chatRoom.nickname + '">' +
                                '<div class="d-flex w-100 align-items-center">' +
                                    '<img src="' + contextPath + chatRoom.imageUrl + '" class="rounded-circle me-3" alt="User profile">' +
                                    '<div class="flex-grow-1">' +
                                        '<div class="d-flex justify-content-between">' +
                                            '<h6 class="mb-1 fw-bold">' + chatRoom.nickname + '</h6>' +
                                            '<small class="text-muted">' + formattedTime + '</small>' +
                                        '</div>' +
                                        '<p class="mb-0 last-message">' + (chatRoom.msg || '') + '</p>' +
                                    '</div>' +
                                '</div>' +
                            '</a>';
                        chatListContainer.append(chatItemHtml);
                    });
                } else {
                    chatListContainer.html('<p class="text-center p-3">채팅 기록이 없습니다.</p>');
                }
            },
            error: function(xhr, status, error) {
                console.error("채팅 목록을 불러오는데 실패했습니다.", error);
                $('#chat-room-list').html('<p class="text-center p-3 text-danger">오류가 발생했습니다.</p>');
            }
        });
    }
    
    /**
     * 특정 채팅방의 메시지 내역을 불러와 화면에 표시하는 함수
     * @param {number} roomId - 채팅방 ID
     */
    function loadChatMessages(roomId) {
        var chatContainer = $('#chat-list');
        chatContainer.empty().html('<p class="text-center p-3">메시지를 불러오는 중...</p>');

        $.ajax({
            url: contextPath + '/chat/dm/' + roomId,
            type: 'GET',
            dataType: 'json',
            success: function(messages) {
                chatContainer.empty();
                if (messages && messages.length > 0) {
                    $.each(messages, function(index, msg) {
                        displayMessage(msg); // ✅ 메시지 표시 함수 호출로 변경
                    });
                } else {
                    chatContainer.html('<p class="text-center text-muted p-3">아직 대화 내용이 없습니다.</p>');
                }
            },
            error: function(xhr, status, error) {
                console.error("채팅 내용을 불러오는데 실패했습니다.", error);
                chatContainer.html('<p class="text-center text-danger p-3">대화 내용을 불러오는 중 오류가 발생했습니다.</p>');
            }
        });
    }

    /**
     * 타임스탬프를 '오전/오후 HH:MM' 형식으로 변환하는 함수
     */
    function formatMessageTime(timestamp) {
        if (!timestamp) return '';
        var date = new Date(timestamp);
        return date.toLocaleTimeString('ko-KR', {
            hour: '2-digit',
            minute: '2-digit',
            hour12: true
        });
    }

    /**
     * 타임스탬프를 상대 시간으로 변환하는 함수
     */
    function formatRelativeTime(timestamp) {
        if (!timestamp) return '';
        var now = new Date();
        var past = new Date(timestamp);
        var diffInSeconds = Math.floor((now - past) / 1000);
        var intervals = { '년': 31536000, '개월': 2592000, '일': 86400, '시간': 3600, '분': 60 };
        if (diffInSeconds < 60) return '방금 전';
        for (var unit in intervals) {
            var value = Math.floor(diffInSeconds / intervals[unit]);
            if (value >= 1) return value + unit + ' 전';
        }
        return '방금 전';
    }
});
</script>

</body>
</html>