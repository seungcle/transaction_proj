package subak.example.subak.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import subak.example.subak.dao.ItemDAO;
import subak.example.subak.domain.ItemDTO;

@Controller
public class MainController {

	@Autowired
	ItemDAO dao;
	
	@GetMapping("/main")
	public String mainPage(Model model) {
		List<ItemDTO> list = dao.findAll();
		model.addAttribute("list", list);
		return "mainpage/main";
	}
}
