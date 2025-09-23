package subak.example.subak.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import subak.example.subak.dao.UserDAO;
import subak.example.subak.domain.LoginRequestDTO;
import subak.example.subak.domain.SessionUserVO;
import subak.example.subak.domain.UserDTO;
import subak.example.subak.domain.UserInfoVO;

@Service
public class UserService {

	@Autowired
	private UserDAO userDAO;

	public boolean join(UserDTO user) {
		
		//아이디 중복 체크
		if (userDAO.checkUsername(user.getUsername()) > 0) {
            return false;
        }
		 // 닉네임 중복 체크 
        if (userDAO.checkNickname(user.getNickname()) > 0) {
            return false;
        }
        userDAO.insertUser(user);
        return true;
	}
	
	 public boolean isUsernameExists(String username) {
	        return userDAO.checkUsername(username) > 0;
	    }

	    public boolean isNicknameExists(String nickname) {
	        return userDAO.checkNickname(nickname) > 0;
	    }
	    
	// 로그인 세션
	public SessionUserVO login(LoginRequestDTO dto) {
		return userDAO.login(dto);
	}

	public UserInfoVO getMyInfo(HttpSession session) {
		
		SessionUserVO user = (SessionUserVO)session.getAttribute("user");
		if(user == null) {
			return null;
		}
		UserInfoVO vo = userDAO.findById(user.getId());
				
		return vo;
	}
	
	public UserInfoVO getUserInfo(Long userId) {
		
		return userDAO.findById(userId);
	}
	
	// 개인정보 수정
	public boolean updateNickname(Long userId, String newNickname) {
		if (userDAO.checkNickname(newNickname) > 0) {
			return false;
		}
		else {
			userDAO.updateNickname(userId, newNickname);
			return true;
		}
	}
	
	// 자기 소개 수정
	public void updateBio(Long userId, String newBio) {
		userDAO.updateBio(userId, newBio);
	}
	
	// 개인정보 비밀번호 수정
	public boolean updatePasswordById(Long userId, String OldPassword, String newPassword) {
		UserInfoVO user = userDAO.findById(userId);
		if(user == null) {
			return false;
		}
		
		if(user.getPassword().equals(OldPassword)) {
			userDAO.updatePasswordById(userId, newPassword);
			return true;
		}
		else {
			return false;
		}
	}
	
	// 프로필 사진 수정
	public void updateImageUrl(Long userId, String imageUrl) {
        userDAO.updateImageUrl(userId, imageUrl);
    }
	
	// 이메일
	public UserDTO findUserByEmail(String email) {
	    return userDAO.findUserByEmail(email);
	}
	

}