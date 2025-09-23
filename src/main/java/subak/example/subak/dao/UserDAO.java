package subak.example.subak.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import subak.example.subak.domain.LoginRequestDTO;
import subak.example.subak.domain.SessionUserVO;
import subak.example.subak.domain.UserDTO;
import subak.example.subak.domain.UserInfoVO;


@Mapper
public interface UserDAO {
	
	//회원가입
	void insertUser(UserDTO user);
	
	// 아이디, 닉네임 중복 체크
	int checkUsername(String username);
	int checkNickname(String nickname);
	
	
	SessionUserVO login(LoginRequestDTO dto);

	UserInfoVO findById(Long id);

	UserDTO findUserByEmail( String email);
	
	UserDTO findUserByUsernameAndEmail( String username, String email);
	
	int existsByUsernameAndEmail(@Param("username") String username, @Param("email") String email);
	
	int updatePassword(@Param("username") String username, @Param("newPassword") String newPassword);
	
	//---------- 개인정보 수정-----------
	// 닉네임
	void updateNickname(@Param("id") Long id,@Param("nickname")String nickname);
	// 자기소개
	void updateBio(@Param("id")Long id, @Param("bio")String bio);
	// 비밀 번호 업데이트
	void updatePasswordById(@Param("id") Long id, @Param("password") String newPassword);
	// 프로필 업데이트
	void updateImageUrl(@Param("id") Long id, @Param("imageUrl") String imageUrl);
}
