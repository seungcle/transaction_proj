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
         data-room-id="${roomId}" 
         data-user-id="${user.id}" 
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
            <div id="chat-list" class="flex-grow-1 mb-3 chat-scroll">
                </div>

            <div class="input-group chat-input">
                <input type="text" id="chat-message-input" class="form-control" placeholder="메시지를 입력하세요...">
                <button id="send-button" class="btn btn-dark" type="button">
                    <i class="bi bi-send-fill"></i>
                </button>
            </div>
        </div>
    </div>

<script type="text/javascript">
    // 전역 변수 선언
    let stompClient = null;
    const chatData = document.getElementById('chat-data');
    const roomId = chatData.dataset.roomId;
    const currentUserId = chatData.dataset.userId;
    const currentUserNickname = chatData.dataset.nickname;

    const chatList = document.getElementById('chat-list');
    const messageInput = document.getElementById('chat-message-input');
    const sendButton = document.getElementById('send-button');

    // 페이지 로드 시 웹소켓 연결
    document.addEventListener('DOMContentLoaded', function() {
        if (roomId && currentUserId) {
            connect();
        } else {
            console.error('채팅방 ID 또는 사용자 정보가 없습니다.');
        }
        
        // 전송 버튼 클릭 이벤트
        sendButton.addEventListener('click', sendMessage);
        
        // 엔터 키로 메시지 전송
        messageInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                sendMessage();
            }
        });
    });

    // 1. 웹소켓 연결
    function connect() {
        const socket = new SockJS('/ws'); // 백엔드 STOMP 엔드포인트
        stompClient = Stomp.over(socket);
        stompClient.connect({}, onConnected, onError);
    }
    
    // 2. 연결 성공 시 채팅방 구독
    function onConnected() {
        console.log('WebSocket Connected!');
        stompClient.subscribe('/topic/chat/' + roomId, onMessageReceived);
    }
    
    function onError(error) {
        console.error('Could not connect to WebSocket server. Please refresh this page to try again!', error);
    }
    
    // 3. 메시지 전송
    function sendMessage() {
        const messageContent = messageInput.value.trim();
        if (messageContent && stompClient) {
            const chatRequest = {
                userId: currentUserId,
                nickname: currentUserNickname,
                message: messageContent
                // roomId는 DTO에 포함시키지 않고 경로로 전달합니다.
            };
            
            stompClient.send('/app/chat/' + roomId, {}, JSON.stringify(chatRequest));
            messageInput.value = ''; // 입력창 비우기
        }
    }
    
    // 4. 메시지 수신 시 화면에 표시
    function onMessageReceived(payload) {
        const chatResponse = JSON.parse(payload.body);
        addChatMessage(chatResponse);
    }
    
    // 5. HTML 요소를 동적으로 생성하여 채팅 목록에 추가
    function addChatMessage(message) {
        const isMe = message.nickname === currentUserNickname;
        
        const msgDiv = document.createElement('div');
        msgDiv.classList.add('msg', isMe ? 'me' : 'other');

        const nameDiv = document.createElement('div');
        nameDiv.classList.add('name');
        nameDiv.textContent = message.nickname + ':';

        const bubbleDiv = document.createElement('div');
        bubbleDiv.classList.add('bubble');
        bubbleDiv.textContent = message.message;

        const timeDiv = document.createElement('div');
        timeDiv.classList.add('time');
        // 서버에서 받은 createdAt 값을 원하는 형식으로 포맷팅
        const messageTime = new Date(message.createdAt);
        timeDiv.textContent = messageTime.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });

        msgDiv.appendChild(nameDiv);
        msgDiv.appendChild(bubbleDiv);
        msgDiv.appendChild(timeDiv);
        
        chatList.appendChild(msgDiv);
        
        // 스크롤을 맨 아래로 이동
        chatList.scrollTop = chatList.scrollHeight;
    }

</script>
</body>
</html>