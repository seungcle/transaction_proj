package subak.example.subak.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import subak.example.subak.domain.ItemResponseDTO;
import subak.example.subak.domain.SimpleItemResponseVO;

@Mapper
public interface ItemDAO {

	List<SimpleItemResponseVO> findAll();
	
	ItemResponseDTO findItemById(Long id);
}
