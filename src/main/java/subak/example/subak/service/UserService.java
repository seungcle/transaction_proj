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

	public SessionUserVO login(LoginRequestDTO dto) {
		
		return userDAO.login(dto);
	}

	public UserInfoVO getMyInfo(HttpSession session) {
		
		SessionUserVO user = (SessionUserVO)session.getAttribute("user");
		UserInfoVO vo = userDAO.findById(user.getId());
				
		return vo;
	}
	
	public UserDTO findUserByEmail(String email) {
	    return userDAO.findUserByEmail(email);
	}

}
