package subak.example.subak.service;

import java.sql.Timestamp;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import subak.example.subak.dao.ChatDAO;
import subak.example.subak.domain.ChatRequestDTO;
import subak.example.subak.domain.ChatResponseDTO;
import subak.example.subak.domain.DmChatRoomDTO;

@Service
public class ChatService {
	
	@Autowired
	private ChatDAO chatDAO;

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
		
		chatDAO.createDmChatRoom(dto);
		
	}

}
