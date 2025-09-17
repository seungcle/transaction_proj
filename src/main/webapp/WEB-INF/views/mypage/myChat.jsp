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
<%-- Websocket Libraries --%>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1.6.1/dist/sockjs.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>

<style>
    /* 채팅 목록 커스텀 CSS */
    .chat-list-item img {
        width: 50px;
        height: 50px;
        object-fit: cover;
    }
    .chat-list-item .last-message {
        display: -webkit-box;
        -webkit-line-clamp: 1;
        -webkit-box-orient: vertical;
        overflow: hidden;
        text-overflow: ellipsis;
        font-size: 0.9em;
        color: #6c757d;
    }
    .chat-list-item:hover {
        background-color: #f8f9fa;
    }

    /* 채팅 상세 화면 CSS (chat.css 내용이라 가정) */
    .chat-scroll {
        overflow-y: auto;
        padding: 10px;
        display: flex;
        flex-direction: column;
    }
    .msg {
        display: flex;
        flex-direction: column;
        margin-bottom: 15px;
        max-width: 70%;
    }
    .msg .name {
        font-size: 0.8rem;
        color: #666;
        margin-bottom: 4px;
    }
    .msg .bubble {
        padding: 10px 15px;
        border-radius: 1.2rem;
        line-height: 1.4;
    }
    .msg .time {
        font-size: 0.75rem;
        color: #999;
        margin-top: 4px;
    }
    .msg.me {
        align-self: flex-end;
        align-items: flex-end;
    }
    .msg.me .bubble {
        background-color: #0d6efd; /* Bootstrap primary color */
        color: white;
    }
    .msg.other {
        align-self: flex-start;
        align-items: flex-start;
    }
    .msg.other .bubble {
        background-color: #e9ecef; /* Bootstrap light gray */
        color: #212529;
    }
</style>
</head>
<body>

<%-- 
    이 데이터는 실제로는 서버에서 동적으로 받아와야 합니다.
    예시에서는 현재 로그인한 사용자 정보를 'user' 객체에서 가져온다고 가정합니다.
--%>
<div id="user-data"
     data-id="${user.id}" 
     data-nickname="${user.nickname}">
</div>


<div class="offcanvas offcanvas-end" tabindex="-1" id="myChatOffcanvas" aria-labelledby="myChatOffcanvasLabel">
    <div class="offcanvas-header border-bottom">
        <%-- ✅ 1. 타이틀 가운데 정렬: w-100 text-center 클래스 추가 --%>
        <h5 class="offcanvas-title w-100 text-center" id="myChatOffcanvasLabel">
            <i class="bi bi-chat-dots-fill"></i> 채팅
        </h5>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>

    <div class="offcanvas-body p-0">
        <div class="list-group list-group-flush">
            <%-- 
                ✅ 2. 채팅방 상세화면 연결
                - data-bs-toggle="offcanvas" : Offcanvas를 열도록 지정
                - data-bs-target="#chatDetailOffcanvas" : 열릴 Offcanvas의 ID를 지정
                - data-room-id="1" : 채팅방의 고유 ID를 데이터로 저장
                - data-room-name="에어팟구매자" : 채팅방 이름을 데이터로 저장
            --%>
            <a href="#" class="list-group-item list-group-item-action chat-list-item p-3" 
               data-bs-toggle="offcanvas" data-bs-target="#chatDetailOffcanvas"
               data-room-id="1" data-room-name="에어팟구매자">
                <div class="d-flex w-100 align-items-center">
                    <img src="https://i.pravatar.cc/150?img=3" class="rounded-circle me-3" alt="User profile">
                    <div class="flex-grow-1">
                        <div class="d-flex justify-content-between">
                            <h6 class="mb-1 fw-bold">에어팟구매자</h6>
                            <small class="text-muted">3분 전</small>
                        </div>
                        <p class="mb-0 last-message">네, 구매 확정하겠습니다! 감사합니다.</p>
                    </div>
                </div>
            </a>
            
            <a href="#" class="list-group-item list-group-item-action chat-list-item p-3"
               data-bs-toggle="offcanvas" data-bs-target="#chatDetailOffcanvas"
               data-room-id="2" data-room-name="키보드문의">
                <div class="d-flex w-100 align-items-center">
                    <img src="https://i.pravatar.cc/150?img=5" class="rounded-circle me-3" alt="User profile">
                    <div class="flex-grow-1">
                        <div class="d-flex justify-content-between">
                            <h6 class="mb-1 fw-bold">키보드문의</h6>
                            <small class="text-muted">15분 전</small>
                        </div>
                        <div class="d-flex justify-content-between align-items-center">
                            <p class="mb-0 last-message fw-bold text-dark">혹시 직거래는 어디서 가능할까요?</p>
                            <span class="badge bg-danger rounded-pill">1</span>
                        </div>
                    </div>
                </div>
            </a>
        </div>
    </div>
</div>


<div class="offcanvas offcanvas-end" tabindex="-1" id="chatDetailOffcanvas" aria-labelledby="chatDetailOffcanvasLabel">
    
    <%-- ✅ 헤더 구조 변경 --%>
    <div class="offcanvas-header border-bottom">
        
        <button class="btn" type="button" 
                data-bs-toggle="offcanvas" 
                data-bs-target="#myChatOffcanvas" 
                aria-label="뒤로가기">
            <i class="bi bi-arrow-left"></i>
        </button>
        
        <h5 class="offcanvas-title mx-auto" id="chatDetailOffcanvasLabel">
            채팅방 이름
        </h5>

        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
    </div>

    <div class="offcanvas-body d-flex flex-column p-0">
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
    // 전역 변수
    let stompClient = null;
    let currentRoomId = null;
    
    // 현재 로그인한 사용자 정보 (페이지 로드 시 한 번만 가져옴)
    const userData = document.getElementById('user-data');
    const currentUserId = userData.dataset.id;
    const currentUserNickname = userData.dataset.nickname;

    // DOM 요소
    const chatDetailOffcanvasEl = document.getElementById('chatDetailOffcanvas');
    const chatList = document.getElementById('chat-list');
    const messageInput = document.getElementById('chat-message-input');
    const sendButton = document.getElementById('send-button');

    // 채팅 상세 Offcanvas가 열릴 때 발생하는 이벤트 리스너
    chatDetailOffcanvasEl.addEventListener('show.bs.offcanvas', function (event) {
        // 클릭된 채팅방 링크(<a> 태그) 정보 가져오기
        const button = event.relatedTarget;
        const roomId = button.dataset.roomId;
        const roomName = button.dataset.roomName;

        // 채팅방 정보가 다를 경우에만 새로 연결
        if (currentRoomId !== roomId) {
            currentRoomId = roomId;

            // 1. 채팅방 제목 업데이트
            const titleEl = chatDetailOffcanvasEl.querySelector('#chatDetailOffcanvasLabel');
            titleEl.textContent = roomName;

            // 2. 기존 메시지 비우기
            chatList.innerHTML = '';
            
            // 3. 웹소켓 연결 및 이전 대화 불러오기
            connectAndLoadChats();
        }
    });
    
    // 채팅 상세 Offcanvas가 닫힐 때 웹소켓 연결 해제
    chatDetailOffcanvasEl.addEventListener('hide.bs.offcanvas', function () {
        disconnect();
    });

    // 메시지 전송 버튼 클릭 이벤트
    sendButton.addEventListener('click', sendMessage);

    // 엔터 키로 메시지 전송
    messageInput.addEventListener('keypress', function(e) {
        if (e.key === 'Enter' && !e.shiftKey) {
            e.preventDefault(); // form 전송 방지
            sendMessage();
        }
    });

    // 1. 웹소켓 연결 및 채팅 불러오기 함수
    function connectAndLoadChats() {
        if (!currentRoomId || !currentUserId) {
            console.error('채팅방 ID 또는 사용자 정보가 없습니다.');
            return;
        }

        // 기존 연결이 있다면 해제
        if (stompClient !== null) {
            stompClient.disconnect(() => console.log('Previous connection disconnected.'));
        }

        const socket = new SockJS('${pageContext.request.contextPath}/ws');
        stompClient = Stomp.over(socket);
        stompClient.connect({}, onConnected, onError);
    }

    // 2. 연결 성공 시 처리
    function onConnected() {
        console.log('WebSocket Connected!');
        // 해당 채팅방 구독
        stompClient.subscribe('/topic/chat/' + currentRoomId, onMessageReceived);
        // 이전 대화 내용 불러오기
        loadPreviousChats();
    }
    
    // 3. 연결 실패 시 처리
    function onError(error) {
        console.error('웹소켓 연결 실패:', error);
    }
    
    // 4. 연결 해제
    function disconnect() {
        if (stompClient !== null) {
            stompClient.disconnect();
            stompClient = null;
            currentRoomId = null; // 현재 방 ID 초기화
            console.log("Disconnected");
        }
    }

    // 5. 메시지 전송
    function sendMessage() {
        const messageContent = messageInput.value.trim();
        if (messageContent && stompClient) {
            const chatRequest = {
                userId: currentUserId,
                nickname: currentUserNickname,
                message: messageContent
            };
            stompClient.send('/app/chat/' + currentRoomId, {}, JSON.stringify(chatRequest));
            messageInput.value = '';
        }
    }

    // 6. 메시지 수신
    function onMessageReceived(payload) {
        const chatResponse = JSON.parse(payload.body);
        addChatMessage(chatResponse);
    }

    // 7. 이전 채팅 불러오기 (Fetch API)
    function loadPreviousChats() {
        fetch(`\${currentRoomId}/chat`) // 실제 경로에 맞게 수정 필요: e.g. `${pageContext.request.contextPath}/chat/${currentRoomId}`
            .then(response => {
                if (!response.ok) throw new Error('Network response was not ok');
                return response.json();
            })
            .then(chatListData => {
                chatListData.forEach(chat => addChatMessage(chat));
            })
            .catch(error => console.error('이전 채팅 불러오기 실패:', error));
    }

    // 8. 수신된 메시지를 화면에 추가
    function addChatMessage(message) {
        const isMe = message.nickname === currentUserNickname;

        const msgDiv = document.createElement('div');
        msgDiv.classList.add('msg', isMe ? 'me' : 'other');

        // 내 메시지가 아닐 때만 이름 표시
        if (!isMe) {
            const nameDiv = document.createElement('div');
            nameDiv.classList.add('name');
            nameDiv.textContent = message.nickname;
            msgDiv.appendChild(nameDiv);
        }

        const bubbleDiv = document.createElement('div');
        bubbleDiv.classList.add('bubble');
        bubbleDiv.textContent = message.message;

        const timeDiv = document.createElement('div');
        timeDiv.classList.add('time');
        
        if (message.createdAt) {
            const messageTime = new Date(message.createdAt);
            timeDiv.textContent = messageTime.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
        }
        
        msgDiv.appendChild(bubbleDiv);
        msgDiv.appendChild(timeDiv);

        chatList.appendChild(msgDiv);
        // 항상 최신 메시지가 보이도록 스크롤을 맨 아래로 이동
        chatList.scrollTop = chatList.scrollHeight;
    }
</script>


</body>
</html>