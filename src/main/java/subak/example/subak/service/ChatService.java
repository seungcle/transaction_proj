package subak.example.subak.service;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import subak.example.subak.dao.ChatDAO;
import subak.example.subak.domain.ChatRequestDTO;
import subak.example.subak.domain.ChatResponseDTO;
import subak.example.subak.domain.DmChatRoomDTO;
import subak.example.subak.domain.DmChatRoomInfoDTO;
import subak.example.subak.domain.NotificationDTO;

@Service
public class ChatService {
	
	@Autowired
	private ChatDAO chatDAO;
	
	@Autowired
    private NotificationService notificationService;

	public ChatResponseDTO processMessage(Long roomId, ChatRequestDTO requestDTO) {
		
		requestDTO.setRoomId(roomId);
		chatDAO.saveChat(requestDTO);
		
		ChatResponseDTO dto = new ChatResponseDTO();
		dto.setId(requestDTO.getId());
		dto.setMessage(requestDTO.getMessage());
		dto.setNickname(requestDTO.getNickname());
		dto.setCreatedAt(new Timestamp(System.currentTimeMillis()));

		return dto;
	}

	public List<ChatResponseDTO> getAllChats(Long roomId) {
		
		return chatDAO.findMessagesByRoomId(roomId);
	}

	// userId1 -> 물건주인, userId2 -> 본인
	public void makeChatRoom(Long userId1, Long userId2) {
		
		DmChatRoomDTO dto = new DmChatRoomDTO();
		dto.setUserId1(userId1);
		dto.setUserId2(userId2);
		
		// 기존에 생성된 채팅방이 있는지 확인
	    Long roomId = chatDAO.findDmChatRoomByUsers(dto);
		
	    if(roomId == null) {
            // 새 채팅방 생성
	    	chatDAO.createDmChatRoom(dto);

            // 알림 생성 로직
            NotificationDTO notification = new NotificationDTO();
            // 알림을 받는 사람 (채팅방 상대)
            notification.setUserId(userId1); 
            // 알림 내용
            notification.setContent(userId2 + "님이 1:1 채팅을 시작했습니다.");
            // 알림 클릭 시 이동할 URL
            notification.setUrl("/chat/dm/" + roomId);
            notification.setItemId(Long.parseLong("0"));
            // NotificationService를 통해 알림 전송 (DB 저장 및 웹소켓)
            notificationService.sendNotification(notification);
        }
	}

	public List<DmChatRoomInfoDTO> getMyChatList(Long myUserId) {
		
		return chatDAO.findMyChatRooms(myUserId);
	}

	public List<ChatResponseDTO> getAllDm(Long roomId) {
		
		return chatDAO.findDmsByRoomId(roomId);
	}

	public ChatResponseDTO processDm(Long roomId, ChatRequestDTO requestDTO) {
		
		requestDTO.setRoomId(roomId);
		chatDAO.saveDm(requestDTO);
		
		ChatResponseDTO dto = new ChatResponseDTO();
		dto.setId(requestDTO.getId());
		dto.setMessage(requestDTO.getMessage());
		dto.setNickname(requestDTO.getNickname());
		dto.setCreatedAt(new Timestamp(System.currentTimeMillis()));

		return dto;
	}

}
