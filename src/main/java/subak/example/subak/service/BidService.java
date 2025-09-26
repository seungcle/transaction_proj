package subak.example.subak.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

	@Transactional
    public boolean createBid(Long itemId, Long sellerId, int amount) {
        try {
            bidDAO.insert(itemId, sellerId, amount);
            return true;
        } catch (DataIntegrityViolationException e) {
            return false; 
        }
    }

	public Long getId() {
		
		return null;
	}

	public void setBid(Long itemId) {
		bidDAO.setBid(itemId);
	}
}
