package subak.example.subak.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import subak.example.subak.service.FavoriteService;

@Controller
@RequestMapping("/favorite")
public class FavoriteController {

	@Autowired
	private FavoriteService favoriteService;
	
	@PostMapping("/{itemId}")
	@ResponseBody
	public void pushFavorite(@PathVariable Long itemId, HttpSession session, Model model) {
		
		favoriteService.pushFavorite(itemId, session);
	}
}
