package subak.example.subak.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import subak.example.subak.dao.FavoriteDAO;
import subak.example.subak.domain.FavoriteDTO;
import subak.example.subak.domain.SessionUserVO;

@Service
public class FavoriteService {

	@Autowired
	private FavoriteDAO favoriteDAO;

	public void pushFavorite(Long itemId, HttpSession session) {
		
		SessionUserVO user = (SessionUserVO)session.getAttribute("user");
		if(user == null)
			throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "로그인이 필요합니다.");
		FavoriteDTO dto = new FavoriteDTO();
		dto.setItemId(itemId);
		dto.setUserId(user.getId());
		
		int count = favoriteDAO.checkFavoriteExists(dto);
		if(count > 0)
			favoriteDAO.deleteFavorite(dto);
		else
			favoriteDAO.insertFavorite(dto);
	}
}
