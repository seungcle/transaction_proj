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
import subak.example.subak.domain.SimpleItemResponseVO;
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
		
		boolean isSuccess = itemService.insertItem(dto, images, session);
		if(isSuccess)
			return "redirect:/main";
		else
			return "mainpage/sale";
	}
	
	// 카테고리
	@GetMapping("/category/{category}")
	public String categoryPage(@PathVariable String category,
							   @RequestParam(defaultValue = "1") int page,
							   Model model) {
		
		int pageSize = 20;
		List<SimpleItemResponseVO> list = itemService.getItemByCategory(category, page, pageSize);
		model.addAttribute("category", category);
		model.addAttribute("list", list);
		
		return "mainpage/search";
	}
	
	// 제목 검색
	@GetMapping("/search/title")
	public String searchPage(@RequestParam(required = false) String title,
							 @RequestParam(defaultValue = "1") int page,
							 Model model) {
		
		int pageSize = 20;
		List<SimpleItemResponseVO> list = itemService.searchItemByTitle(title, page, pageSize);
		model.addAttribute("list", list);
		
		return "mainpage/search";
	}
	
	// 가격 설정
	@GetMapping("/search/price")
	public String setPrice(@RequestParam(required = false) String title,
						   @RequestParam(defaultValue = "0") int minPrice,
						   @RequestParam(defaultValue = "999999999") int maxPrice,
						   @RequestParam(defaultValue = "1") int page,
						   Model model) {
		
		int pageSize = 20;
		List<SimpleItemResponseVO> list = itemService.searchItemByTitleWithPrice(title, minPrice, maxPrice, page, pageSize);
		model.addAttribute("list", list);
		
		return "mainpage/search";
	}
	
	// 낮은가격순
	@GetMapping("/search/low")
	public String lowerPricePage(@RequestParam(required = false) String title,
			   					 @RequestParam(defaultValue = "0") int minPrice,
			   					 @RequestParam(defaultValue = "999999999") int maxPrice,
			   					 @RequestParam(defaultValue = "1") int page,
			   					 Model model) {
		
		int pageSize = 20;
		List<SimpleItemResponseVO> list = itemService.searchItemOrderByPriceAsc(title, minPrice, maxPrice, page, pageSize);
		model.addAttribute("list", list);
		
		return "mainpage/search";
	}
	
}
