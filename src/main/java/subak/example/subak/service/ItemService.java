package subak.example.subak.service;

import java.io.File;
import java.io.IOException;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;

import subak.example.subak.dao.ItemDAO;
import subak.example.subak.domain.BidDTO;
import subak.example.subak.domain.ItemImageDTO;
import subak.example.subak.domain.ItemRequestDTO;
import subak.example.subak.domain.ItemResponseDTO;
import subak.example.subak.domain.NotificationDTO;
import subak.example.subak.domain.SessionUserVO;
import subak.example.subak.domain.SimpleItemResponseVO;

@Service
public class ItemService {

	@Autowired
	ItemDAO itemDAO;
	
	@Autowired
	private NotificationService notificationService;

	public ItemResponseDTO getItem(Long itemId) {
		
		ItemResponseDTO dto = itemDAO.findItemById(itemId);
		if (dto != null && dto.getEndTime() != null) {
            LocalDateTime now = LocalDateTime.now();
            LocalDateTime endTime = dto.getEndTime().toLocalDateTime();

            Duration duration = Duration.between(now, endTime);

            if (duration.isNegative()) {
                dto.setRemainingTimeInSeconds(0L);
            } else {
                long totalSeconds = duration.toMillis() / 1000;
                dto.setRemainingTimeInSeconds(totalSeconds);
            }
        }
		return dto;
	}

	@Transactional
	public boolean insertItem(ItemRequestDTO dto, List<MultipartFile> images, HttpSession session) throws IOException {
		
		String startPrice = dto.getStartPrice().replaceAll(",", "");
		Object userObj = session.getAttribute("user");
		
		if (userObj == null) {
	        return false; 
	    }
		
		SessionUserVO loginUser = (SessionUserVO) userObj;
		dto.setSellerId(loginUser.getId());
		dto.setStartPrice(startPrice);
		dto.setCurrentPrice(Long.parseLong(startPrice));
		dto.setStatus("OPEN");
		
		//등록시 bid 자동 생성 후 insert
		BidDTO bid = new BidDTO();
		bid.setBidPrice(Long.parseLong(startPrice));
		bid.setBidUserId(loginUser.getId());
		
		if(!itemDAO.insertItem(dto))
			return false;
		
		// 이미지 저장
		bid.setBidItemId(dto.getId());
		if(!itemDAO.insertBid(bid))
			return false;
	    String uploadFolder = "C:/upload/";
	    File dir = new File(uploadFolder);

	    if (!dir.exists()) {
	        dir.mkdirs(); 
	    }
	    
	    for (MultipartFile file : images) {
	        if (!file.isEmpty()) {
	            String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
	            File destinationFile = new File(uploadFolder + fileName);
	            file.transferTo(destinationFile);
	            ItemImageDTO img = new ItemImageDTO();
	            img.setImageUrl("/upload/" + fileName); // 웹에서 접근할 URL 경로
	            img.setItemId(dto.getId());
	            itemDAO.insertItemImage(img);
	        }
	    }
	    
	    return true;
	}

	public List<SimpleItemResponseVO> getItemByCategory(String category, int page, int pageSize) {
		
		int offset = (page - 1) * pageSize;

	    Map<String, Object> params = new HashMap<>();
	    params.put("category", category);
	    params.put("offset", offset);
	    params.put("pageSize", pageSize);
		List<SimpleItemResponseVO> list = itemDAO.findByCategory(params);
		
		return list;
	}

	public List<SimpleItemResponseVO> findAll(int page, int pageSize) {
		
		int offset = (page - 1) * pageSize;
		
		Map<String, Integer> params = new HashMap<>();
		params.put("offset", offset);
		params.put("pageSize", pageSize);
		List<SimpleItemResponseVO> list = itemDAO.findAll(params);
		
		return list;
	}

	public List<SimpleItemResponseVO> searchItemByTitle(String title, int page, int pageSize) {
		
		int offset = (page - 1) * pageSize;
		
		Map<String, Object> params = new HashMap<>();
		params.put("search", title);
		params.put("offset", offset);
	    params.put("pageSize", pageSize);
	    List<SimpleItemResponseVO> list = itemDAO.findByTitleContainingIgnoreCase(params);
	    
	    return list;
	}

	public List<SimpleItemResponseVO> searchItemByTitleWithPrice(String title, String category, int minPrice, int maxPrice, boolean excludeEnded, int page,
			int pageSize) {
		
		int offset = (page - 1) * pageSize;
		
		Map<String, Object> params = new HashMap<>();
		params.put("search", title);
		params.put("category", category);
		params.put("offset", offset);
	    params.put("pageSize", pageSize);
	    params.put("minPrice", minPrice);
	    params.put("maxPrice", maxPrice);
	    params.put("excludeEnded", excludeEnded);
	    List<SimpleItemResponseVO> list = itemDAO.findByTitleContainingIgnoreCaseWithPrice(params);
	    
		return list;
	}

	public List<SimpleItemResponseVO> searchItemOrderByPriceAsc(String title, String category, int minPrice, int maxPrice, boolean excludeEnded, int page,
			int pageSize) {
		
		int offset = (page - 1) * pageSize;
		
		Map<String, Object> params = new HashMap<>();
		params.put("search", title);
		params.put("category", category);
		params.put("offset", offset);
	    params.put("pageSize", pageSize);
	    params.put("minPrice", minPrice);
	    params.put("maxPrice", maxPrice);
	    params.put("excludeEnded", excludeEnded);
	    List<SimpleItemResponseVO> list = itemDAO.findOrderByPriceAsc(params);
		return list;
	}

	public List<SimpleItemResponseVO> searchItemOrderByIdDesc(String title, String category, int minPrice, int maxPrice, boolean excludeEnded, int page,
			int pageSize) {
		
		int offset = (page - 1) * pageSize;
		
		Map<String, Object> params = new HashMap<>();
		params.put("search", title);
		params.put("category", category);
		params.put("offset", offset);
	    params.put("pageSize", pageSize);
	    params.put("minPrice", minPrice);
	    params.put("maxPrice", maxPrice);
	    params.put("excludeEnded", excludeEnded);
	    List<SimpleItemResponseVO> list = itemDAO.findOrderByIdDesc(params);
	    
		return list;
	}

	public List<SimpleItemResponseVO> searchItemOrderByPriceDesc(String title, String category, int minPrice, int maxPrice, boolean excludeEnded, int page,
			int pageSize) {
		
		int offset = (page - 1) * pageSize;
		
		Map<String, Object> params = new HashMap<>();
		params.put("search", title);
		params.put("category", category);
		params.put("offset", offset);
	    params.put("pageSize", pageSize);
	    params.put("minPrice", minPrice);
	    params.put("maxPrice", maxPrice);
	    params.put("excludeEnded", excludeEnded);
	    List<SimpleItemResponseVO> list = itemDAO.findOrderByPriceDesc(params);
	    
		return list;
	}

	public List<SimpleItemResponseVO> searchItemOrderByFavoriteDesc(String title, String category, int minPrice, int maxPrice, boolean excludeEnded, int page,
			int pageSize) {
		
		int offset = (page - 1) * pageSize;
		
		Map<String, Object> params = new HashMap<>();
		params.put("search", title);
		params.put("category", category);
		params.put("offset", offset);
	    params.put("pageSize", pageSize);
	    params.put("minPrice", minPrice);
	    params.put("maxPrice", maxPrice);
	    params.put("excludeEnded", excludeEnded);
	    List<SimpleItemResponseVO> list = itemDAO.findOrderByFavoriteDesc(params);
	    
		return list;
	}

	 public void pushBid(Long price, Long itemId, HttpSession session) {
	        SessionUserVO user = (SessionUserVO) session.getAttribute("user");
	        if (user == null) {
	            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "로그인이 필요합니다.");
	        }
	        BidDTO dto = new BidDTO();
	        dto.setBidItemId(itemId);
	        dto.setBidUserId(user.getId());
	        dto.setBidPrice(price);

	        itemDAO.insertBid(dto);
	        Map<String, Long> m = new HashMap<>();
	        m.put("id", itemId);
	        m.put("price", price);
	        itemDAO.updateItem(m);

	        Long sellerId = itemDAO.getSellerIdByItemId(itemId); 

	        if (sellerId != null) {
	            NotificationDTO notification = new NotificationDTO();
	            notification.setUserId(sellerId);
	            notification.setItemId(itemId);
	            String url = "/item/" + itemId;
	            notification.setUrl(url);
	            notification.setContent("새로운 입찰이 등록되었습니다! 현재 입찰가: " + price + "원");
	            notificationService.sendNotification(notification);
	        }
	    }

	public List<SimpleItemResponseVO> userAllItem(Long userId, int page, int pageSize) {
		
		int offset = (page - 1) * pageSize;
		
		Map<String, Object> params = new HashMap<>();
		params.put("offset", offset);
		params.put("pageSize", pageSize);
		params.put("userId", userId);
		List<SimpleItemResponseVO> list = itemDAO.findByUserId(params);
		
		return list;
	}

	public List<SimpleItemResponseVO> userSaleItem(Long userId, int page, int pageSize) {
		
		int offset = (page - 1) * pageSize;
		
		Map<String, Object> params = new HashMap<>();
		params.put("offset", offset);
		params.put("pageSize", pageSize);
		params.put("userId", userId);
		List<SimpleItemResponseVO> list = itemDAO.findByUserIdAndStatusOpen(params);
		
		return list;
	}

	public List<SimpleItemResponseVO> userSaleCompleteItem(Long userId, int page, int pageSize) {
		
		int offset = (page - 1) * pageSize;
		
		Map<String, Object> params = new HashMap<>();
		params.put("offset", offset);
		params.put("pageSize", pageSize);
		params.put("userId", userId);
		List<SimpleItemResponseVO> list = itemDAO.findSaleCompleteByUserId(params);
		
		return list;
	}

	public List<SimpleItemResponseVO> userPurchaseCompleteItem(Long userId, int page, int pageSize) {
		
		int offset = (page - 1) * pageSize;
		
		Map<String, Object> params = new HashMap<>();
		params.put("offset", offset);
		params.put("pageSize", pageSize);
		params.put("userId", userId);
		List<SimpleItemResponseVO> list = itemDAO.findPurchaseCompleteByUserId(params);
		
		return list;
	}

	public List<SimpleItemResponseVO> userFavoriteItem(Long userId, int page, int pageSize) {

		int offset = (page - 1) * pageSize;
		
		Map<String, Object> params = new HashMap<>();
		params.put("offset", offset);
		params.put("pageSize", pageSize);
		params.put("userId", userId);
		List<SimpleItemResponseVO> list = itemDAO.findFavoriteItemByUserId(params);
		
		return list;
	}

	public List<SimpleItemResponseVO> userBidItem(Long userId, int page, int pageSize) {
		
		int offset = (page - 1) * pageSize;
		
		Map<String, Object> params = new HashMap<>();
		params.put("offset", offset);
		params.put("pageSize", pageSize);
		params.put("userId", userId);
		List<SimpleItemResponseVO> list = itemDAO.findBiddedItemsByUserId(params);
		
		return list;
	}

}
