<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>물품 단체 채팅</title>

    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/watermelon_icon.ico">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/global.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chat.css">

    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1.6.1/dist/sockjs.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>
</head>
<body>

    <div id="chat-data"
         data-room-id="${item.roomId}"
         data-id="${user.id}"
         data-nickname="${user.nickname}">
    </div>

    <div class="offcanvas offcanvas-end" tabindex="-1" id="chatOffcanvas" aria-labelledby="chatOffcanvasLabel">
        <div class="offcanvas-header">
            <h5 class="offcanvas-title" id="chatOffcanvasLabel">
                <i class="bi bi-chat-dots-fill"></i> 물품 단체 채팅방
            </h5>
            <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
        </div>

        <div class="offcanvas-body d-flex flex-column">
            <div id="chat-list" class="flex-grow-1 mb-3 chat-scroll"></div>

            <div class="input-group chat-input">
                <input type="text" id="chat-message-input" class="form-control" placeholder="메시지를 입력하세요...">
                <button id="send-button" class="btn btn-dark" type="button">
                    <i class="bi bi-send-fill"></i>
                </button>
            </div>
        </div>
    </div>

<script type="text/javascript">
    // 전역 변수
    let stompClient = null;
    const chatData = document.getElementById('chat-data');
    const roomId = chatData.dataset.roomId;
    const currentUserId = chatData.dataset.id;
    const currentUserNickname = chatData.dataset.nickname;

    const chatList = document.getElementById('chat-list');
    const messageInput = document.getElementById('chat-message-input');
    const sendButton = document.getElementById('send-button');

    document.addEventListener('DOMContentLoaded', function() {
        if (roomId && currentUserId) {
            connect();
        } else {
            console.error('채팅방 ID 또는 사용자 정보가 없습니다.');
        }

        // 메시지 전송 버튼
        sendButton.addEventListener('click', sendMessage);

        // 엔터로 전송
        messageInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                sendMessage();
            }
        });

        // ✅ 오프캔버스 열릴 때 이전 채팅 불러오기
        const chatOffcanvas = document.getElementById('chatOffcanvas');
        chatOffcanvas.addEventListener('shown.bs.offcanvas', function () {
            loadPreviousChats();
        });
    });

    // 1. 웹소켓 연결
    function connect() {
        const socket = new SockJS('${pageContext.request.contextPath}/ws');
        stompClient = Stomp.over(socket);
        stompClient.connect({}, onConnected, onError);
    }

    // 2. 연결 성공 시 구독
    function onConnected() {
        console.log('WebSocket Connected!');
        stompClient.subscribe('/topic/chat/' + roomId, onMessageReceived);
    }

    function onError(error) {
        console.error('웹소켓 연결 실패:', error);
    }

    // 3. 메시지 전송
    function sendMessage() {
        const messageContent = messageInput.value.trim();
        if (messageContent && stompClient) {
            const chatRequest = {
                userId: currentUserId,
                nickname: currentUserNickname,
                message: messageContent
            };
            stompClient.send('/app/chat/' + roomId, {}, JSON.stringify(chatRequest));
            messageInput.value = '';
        }
    }

    // 4. 메시지 수신
    function onMessageReceived(payload) {
        const chatResponse = JSON.parse(payload.body);
        addChatMessage(chatResponse);
    }

    // ✅ 5. 이전 채팅 불러오기
    function loadPreviousChats() {
        fetch(`${pageContext.request.contextPath}/\${roomId}/chat`)
            .then(response => response.json())
            .then(chatListData => {
                chatList.innerHTML = ''; // 기존 메시지 초기화
                chatListData.forEach(chat => addChatMessage(chat));
            })
            .catch(error => console.error('이전 채팅 불러오기 실패:', error));
    }

    // 메시지 DOM 생성
    function addChatMessage(message) {
        const isMe = message.nickname === currentUserNickname;

        const msgDiv = document.createElement('div');
        msgDiv.classList.add('msg', isMe ? 'me' : 'other');

        const nameDiv = document.createElement('div');
        nameDiv.classList.add('name');
        nameDiv.textContent = message.nickname;

        const bubbleDiv = document.createElement('div');
        bubbleDiv.classList.add('bubble');
        bubbleDiv.textContent = message.message;

        const timeDiv = document.createElement('div');
        timeDiv.classList.add('time');

        if (message.createdAt) {
            const messageTime = new Date(message.createdAt);

            const month = messageTime.getMonth() + 1; // 0부터 시작하므로 +1
            const day = messageTime.getDate();

            const timeString = messageTime.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });

            timeDiv.textContent = `\${month}월 \${day}일 \${timeString}`;
        }

        msgDiv.appendChild(nameDiv);
        msgDiv.appendChild(bubbleDiv);
        msgDiv.appendChild(timeDiv);

        chatList.appendChild(msgDiv);

        chatList.scrollTop = chatList.scrollHeight;
    }
</script>

</body>
</html>
