package subak.example.subak.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import subak.example.subak.domain.ItemResponseDTO;
import subak.example.subak.service.ItemService;

@Controller
@RequestMapping("/item")
public class ItemController {

	@Autowired
	private ItemService itemService;
	
	// 상품 상세페이지
	@GetMapping("/{itemId}")
	public String getItem(@PathVariable Long itemId, Model model) {
		
		ItemResponseDTO itemResponseDTO = itemService.getItem(itemId);
		model.addAttribute("item", itemResponseDTO);
		
		return "item/item";
	}
	
	// 상품 등록 페이지 이동
	@GetMapping("/enroll")
	public String enrollPage() {
		
		return "mainpage/sale";
	}
	
}
