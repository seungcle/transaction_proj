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
		
		if (userDAO.checkUsername(user.getUsername()) > 0) {
            return false;
        }
        userDAO.insertUser(user);
        return true;
	}

	public SessionUserVO login(LoginRequestDTO dto) {
		
		return userDAO.login(dto);
	}

	public UserInfoVO getMyInfo(HttpSession session) {
		
		SessionUserVO user = (SessionUserVO)session.getAttribute("user");
		UserInfoVO vo = userDAO.findById(user.getId());
				
		return vo;
	}
}
