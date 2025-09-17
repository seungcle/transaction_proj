package subak.example.subak.service;

import java.sql.Timestamp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import subak.example.subak.dao.ChatDAO;
import subak.example.subak.domain.ChatRequestDTO;
import subak.example.subak.domain.ChatResponseDTO;

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
}
