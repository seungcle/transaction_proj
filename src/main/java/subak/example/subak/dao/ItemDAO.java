package subak.example.subak.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import subak.example.subak.domain.SimpleItemResponseVO;

@Mapper
public interface ItemDAO {

	public List<SimpleItemResponseVO> findAll();
}
