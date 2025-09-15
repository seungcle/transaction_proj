package subak.example.subak.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import subak.example.subak.domain.SimpleItemResponseVO;
import subak.example.subak.service.ItemService;

@Controller
public class MainController {

	@Autowired
	private ItemService itemService;
	
	@GetMapping("/main")
	public String mainPage(@RequestParam(defaultValue = "1") int page, Model model) {
		int pageSize = 20;
		List<SimpleItemResponseVO> list = itemService.findAll(page, pageSize);
		model.addAttribute("list", list);
		return "mainpage/main";
	}
}
