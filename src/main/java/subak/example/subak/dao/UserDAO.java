package subak.example.subak.dao;

import org.apache.ibatis.annotations.Mapper;

import subak.example.subak.domain.LoginRequestDTO;
import subak.example.subak.domain.SessionUserVO;
import subak.example.subak.domain.UserDTO;

@Mapper
public interface UserDAO {

	void insertUser(UserDTO user);
	
	int checkUsername(String username);
	
	SessionUserVO login(LoginRequestDTO dto);
}
