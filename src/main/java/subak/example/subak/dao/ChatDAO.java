package subak.example.subak.dao;

import org.apache.ibatis.annotations.Mapper;

import subak.example.subak.domain.ChatRequestDTO;
import subak.example.subak.domain.ChatRoomDTO;

@Mapper
public interface ChatDAO {
	void saveChat(ChatRequestDTO requestDTO);
	void createChatRoom(ChatRoomDTO dto);
}
