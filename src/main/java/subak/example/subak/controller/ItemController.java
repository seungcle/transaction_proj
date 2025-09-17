package subak.example.subak.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import subak.example.subak.dao.FavoriteDAO;
import subak.example.subak.domain.BidDTO;
import subak.example.subak.domain.FavoriteDTO;
import subak.example.subak.domain.ItemRequestDTO;
import subak.example.subak.domain.ItemResponseDTO;
import subak.example.subak.domain.SessionUserVO;
import subak.example.subak.domain.SimpleItemResponseVO;
import subak.example.subak.service.ItemService;

@Controller
@RequestMapping("/item")
public class ItemController {

	@Autowired
	private ItemService itemService;
	@Autowired
	private FavoriteDAO favoriteDAO;
	
	// 상품 상세페이지
	@GetMapping("/{itemId}")
	public String getItem(@PathVariable Long itemId, HttpSession session, Model model) {
		
		ItemResponseDTO itemResponseDTO = itemService.getItem(itemId);
		model.addAttribute("item", itemResponseDTO);
		SessionUserVO user = (SessionUserVO)session.getAttribute("user");
		if(user != null) {
			FavoriteDTO dto = new FavoriteDTO();
			dto.setItemId(itemId);
			dto.setUserId(user.getId());
			int count = favoriteDAO.checkFavoriteExists(dto);
			if(count > 0)
				model.addAttribute("isFavorited", true);
			else
				model.addAttribute("isFavorited", false);
		}
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
	
	// 최신순
	@GetMapping("/search/latest")
	public String latestPage(@RequestParam(required = false) String title,
				 			 @RequestParam(defaultValue = "0") int minPrice,
				 			 @RequestParam(defaultValue = "999999999") int maxPrice,
				 			 @RequestParam(defaultValue = "1") int page,
				 			 Model model) {

		int pageSize = 20;
		List<SimpleItemResponseVO> list = itemService.searchItemOrderByIdDesc(title, minPrice, maxPrice, page, pageSize);
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
	
	// 높은가격순
	@GetMapping("/search/high")
	public String higherPricePage(@RequestParam(required = false) String title,
			   					  @RequestParam(defaultValue = "0") int minPrice,
			   					  @RequestParam(defaultValue = "999999999") int maxPrice,
			   					  @RequestParam(defaultValue = "1") int page,
			   					  Model model) {
		
		int pageSize = 20;
		List<SimpleItemResponseVO> list = itemService.searchItemOrderByPriceDesc(title, minPrice, maxPrice, page, pageSize);
		model.addAttribute("list", list);
		
		return "mainpage/search";
	}
	
	// 추천순
	@GetMapping("/search/favorite")
	public String favoritePage(@RequestParam(required = false) String title,
			   				   @RequestParam(defaultValue = "0") int minPrice,
			   				   @RequestParam(defaultValue = "999999999") int maxPrice,
			   				   @RequestParam(defaultValue = "1") int page,
			   				   Model model) {
		
		int pageSize = 20;
		List<SimpleItemResponseVO> list = itemService.searchItemOrderByFavoriteDesc(title, minPrice, maxPrice, page, pageSize);
		model.addAttribute("list", list);
		
		return "mainpage/search";
	}
	
	@PostMapping("/bid")
	@ResponseBody
	public void UpdateBidPrice(Long price, Long itemId, HttpSession session) {
		
		itemService.pushBid(price, itemId, session);
	}
	
	// 해당 유저 전체상품
	@GetMapping("/{userId}/all")
	@ResponseBody
	public List<SimpleItemResponseVO> allItem(@PathVariable Long userId, @RequestParam(defaultValue = "1") int page) {
		
		int pageSize = 20;
		List<SimpleItemResponseVO> list = itemService.userAllItem(userId, page, pageSize);
		
		return list;
	}
	
	// 해당 유저 판매중
	@GetMapping("/{userId}/sale")
	@ResponseBody
	public List<SimpleItemResponseVO> saleItem(@PathVariable Long userId, @RequestParam(defaultValue = "1") int page) {
		
		int pageSize = 20;
		List<SimpleItemResponseVO> list = itemService.userSaleItem(userId, page, pageSize);
		
		return list;
	}
	
	// 해당 유저 입찰중
	
	// 해당 유저 판매내역
	@GetMapping("/{userId}/sale/end")
	@ResponseBody
	public List<SimpleItemResponseVO> saleComplete(@PathVariable Long userId, @RequestParam(defaultValue = "1") int page) {
		
		int pageSize = 20;
		List<SimpleItemResponseVO> list = itemService.userSaleCompleteItem(userId, page, pageSize);
		
		return list;
	}
	
	// 해당 유저 구매내역
	@GetMapping("/{userId}/purchase/end")
	@ResponseBody
	public List<SimpleItemResponseVO> purchaseComplete(@PathVariable Long userId, @RequestParam(defaultValue = "1") int page) {
		
		int pageSize = 20;
		List<SimpleItemResponseVO> list = itemService.userPurchaseCompleteItem(userId, page, pageSize);
		
		return list;
	}
}
