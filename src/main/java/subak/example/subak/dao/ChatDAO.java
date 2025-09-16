package subak.example.subak.dao;

import org.apache.ibatis.annotations.Mapper;

import subak.example.subak.domain.ChatRequestDTO;

@Mapper
public interface ChatDAO {

	void saveChat(ChatRequestDTO requestDTO);
	
}
