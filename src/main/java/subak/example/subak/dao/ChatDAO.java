package subak.example.subak.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import subak.example.subak.domain.ChatRequestDTO;
import subak.example.subak.domain.ChatResponseDTO;

@Mapper
public interface ChatDAO {

	void saveChat(ChatRequestDTO requestDTO);
	
	List<ChatResponseDTO> findMessagesByRoomId(Long roomId);
}
