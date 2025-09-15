package subak.example.subak.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import subak.example.subak.domain.ItemImageDTO;
import subak.example.subak.domain.ItemRequestDTO;
import subak.example.subak.domain.ItemResponseDTO;
import subak.example.subak.domain.SimpleItemResponseVO;

@Mapper
public interface ItemDAO {

	List<SimpleItemResponseVO> findAll();
	
	ItemResponseDTO findItemById(Long id);
	
	boolean insertItem(ItemRequestDTO dto);
	
	boolean insertItemImage(ItemImageDTO dto);

	List<SimpleItemResponseVO> findByCategory(Map<String, Object> params);
}
