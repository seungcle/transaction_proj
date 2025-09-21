package subak.example.subak.service;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import subak.example.subak.dao.ReviewDAO;
import subak.example.subak.domain.ReviewDTO;
import subak.example.subak.domain.ReviewResponseVO;
import subak.example.subak.domain.SessionUserVO;
import subak.example.subak.domain.TagDTO;

@Service
public class ReviewService {

	@Autowired
	private ReviewDAO reviewDAO;

	public boolean haveAuth(Long itemId, Long sellerId, HttpSession session) {
		
		SessionUserVO user = (SessionUserVO)session.getAttribute("user");
		if(user == null)
			return false;
		
		Map<String, Object> params = new HashMap<>();

        params.put("itemId", itemId);
        params.put("sellerId", sellerId);
        params.put("userId", user.getId());
        
		return reviewDAO.isSuccessfulBidder(params);
	}

	public List<TagDTO> getAllTags() {
		
		List<TagDTO> list = reviewDAO.allReviewTags();
		return list;
	}

	@Transactional
	public void reviewSubmit(ReviewDTO reviewDTO, HttpSession session) {
		
		SessionUserVO user = (SessionUserVO)session.getAttribute("user");
		reviewDTO.setUserId1(user.getId());
		reviewDAO.insertReview(reviewDTO);
		
		Long newReviewId = reviewDTO.getId();

        List<Long> tagIds = reviewDTO.getTagIds();

        // 선택된 태그가 있을 경우에만 태그 매핑 테이블에 저장
        if (tagIds != null && !tagIds.isEmpty()) {
        	Set<Long> uniqueTagIds = new HashSet<>(tagIds);
            Map<String, Object> params = new HashMap<>();
            params.put("reviewId", newReviewId);
            params.put("tagIds", uniqueTagIds);
            reviewDAO.insertReviewTags(params);
        }
	}

	public boolean checkDuplicate(Long itemId, HttpSession session) {
		
		SessionUserVO user = (SessionUserVO)session.getAttribute("user");
		if(user == null)
			return false;
		
		return reviewDAO.checkDuplicateReview(itemId, user.getId());
	}

	public double getRatingAvg(Long userId) {
		
		return reviewDAO.getAverageRatingByUserId(userId);
	}

	public List<ReviewResponseVO> getReceiveReview(Long userId) {
		
		return reviewDAO.findReviewsByUserId(userId);
	}

	public List<ReviewResponseVO> getWriteReview(Long userId) {

		return reviewDAO.findWriteReviewsByUserId(userId);
	}
}
