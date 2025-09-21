package subak.example.subak.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import subak.example.subak.dao.BidDAO;
import subak.example.subak.domain.BidResponseVO;

@Service
public class BidService {

	@Autowired
	private BidDAO bidDAO;

	public List<BidResponseVO> getBidList(Long itemId) {
		
		return bidDAO.findBidsByItemId(itemId);
	}

	public int getBidCount(Long itemId) {
		
		return bidDAO.countBidsByItemId(itemId);
	}
}
