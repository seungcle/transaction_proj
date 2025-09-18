package subak.example.subak.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import subak.example.subak.domain.LoginRequestDTO;
import subak.example.subak.domain.SessionUserVO;
import subak.example.subak.domain.UserDTO;
import subak.example.subak.domain.UserInfoVO;

@Mapper
public interface UserDAO {

	void insertUser(UserDTO user);
	
	int checkUsername(String username);
	
	int checkNickname(String nickname);
	
	SessionUserVO login(LoginRequestDTO dto);

	UserInfoVO findById(Long id);

	UserDTO findUserByEmail(@Param("email") String email);

}
