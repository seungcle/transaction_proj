package subak.example.subak.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import subak.example.subak.domain.BidDTO;
import subak.example.subak.domain.ItemImageDTO;
import subak.example.subak.domain.ItemRequestDTO;
import subak.example.subak.domain.ItemResponseDTO;
import subak.example.subak.domain.SimpleItemResponseVO;

@Mapper
public interface ItemDAO {

	List<SimpleItemResponseVO> findAll(Map<String, Integer> params);
	
	ItemResponseDTO findItemById(Long id);
	
	boolean insertItem(ItemRequestDTO dto);
	
	boolean insertBid(BidDTO dto);
	
	boolean insertItemImage(ItemImageDTO dto);
	
	//update item
	void updateItem(Map<String, Long> params);

	List<SimpleItemResponseVO> findByCategory(Map<String, Object> params);

	List<SimpleItemResponseVO> findByTitleContainingIgnoreCase(Map<String, Object> params);

	List<SimpleItemResponseVO> findByTitleContainingIgnoreCaseWithPrice(Map<String, Object> params);

	List<SimpleItemResponseVO> findOrderByPriceAsc(Map<String, Object> params);

	List<SimpleItemResponseVO> findOrderByIdDesc(Map<String, Object> params);

	List<SimpleItemResponseVO> findOrderByPriceDesc(Map<String, Object> params);

	List<SimpleItemResponseVO> findOrderByFavoriteDesc(Map<String, Object> params);

	List<SimpleItemResponseVO> findByUserId(Map<String, Object> params);

	List<SimpleItemResponseVO> findByUserIdAndStatusOpen(Map<String, Object> params);

	List<SimpleItemResponseVO> findSaleCompleteByUserId(Map<String, Object> params);

	List<SimpleItemResponseVO> findPurchaseCompleteByUserId(Map<String, Object> params);
}
