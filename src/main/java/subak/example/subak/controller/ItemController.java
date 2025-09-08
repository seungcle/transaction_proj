package subak.example.subak.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import subak.example.subak.domain.ItemRequestDTO;
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
	
	// 상품 등록
	@PostMapping("/enroll")
	public String enrollPage(ItemRequestDTO dto, @RequestParam("images") List<MultipartFile> images, 
							 HttpSession session) throws IOException {
		
		System.out.println(dto.getCategoryId());
		//boolean isSuccess = itemService.insertItem(dto, images, session);
		return "redirect:/main";
	}
	
}
