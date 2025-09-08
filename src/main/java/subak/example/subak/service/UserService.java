package subak.example.subak.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import subak.example.subak.dao.UserDAO;
import subak.example.subak.domain.LoginRequestDTO;
import subak.example.subak.domain.SessionUserVO;
import subak.example.subak.domain.UserDTO;

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
}
