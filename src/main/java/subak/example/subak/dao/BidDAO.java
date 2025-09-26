package subak.example.subak.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import subak.example.subak.domain.BidResponseVO;

@Mapper
public interface BidDAO {

	List<BidResponseVO> findBidsByItemId(@Param("itemId") Long itemId);
	
	int countBidsByItemId(long itemId);
	
	boolean insert(Long itemId,Long sellerId,int amount);

	void setBid(Long itemId);
}
