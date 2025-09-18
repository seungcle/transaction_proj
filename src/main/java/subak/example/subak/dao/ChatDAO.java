package subak.example.subak.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import subak.example.subak.domain.ChatRequestDTO;
import subak.example.subak.domain.ChatResponseDTO;
import subak.example.subak.domain.ChatRoomDTO;
import subak.example.subak.domain.DmChatRoomDTO;
import subak.example.subak.domain.DmChatRoomInfoDTO;

@Mapper
public interface ChatDAO {
	void saveChat(ChatRequestDTO requestDTO);	
	List<ChatResponseDTO> findMessagesByRoomId(Long roomId);
	void createChatRoom(ChatRoomDTO dto);
	void createDmChatRoom(DmChatRoomDTO dto);
	Long findDmChatRoomByUsers(DmChatRoomDTO dto);
	List<DmChatRoomInfoDTO> findMyChatRooms(Long myUserId);
	List<ChatResponseDTO> findDmsByRoomId(Long roomId);
}
