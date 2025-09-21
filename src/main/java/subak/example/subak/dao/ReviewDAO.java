package subak.example.subak.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import subak.example.subak.domain.ReviewDTO;
import subak.example.subak.domain.ReviewResponseVO;
import subak.example.subak.domain.TagDTO;

@Mapper
public interface ReviewDAO {

	boolean isSuccessfulBidder(Map<String, Object> params);
	
	boolean insertReview(ReviewDTO review);
	
	boolean insertReviewTags(Map<String, Object> params);
	
	List<TagDTO> allReviewTags();
	
	boolean checkDuplicateReview(@Param("itemId") Long itemId, @Param("userId1") Long userId1);
	
	double getAverageRatingByUserId(long userId2);
	
	List<ReviewResponseVO> findReviewsByUserId(Long userId);
	
	List<ReviewResponseVO> findWriteReviewsByUserId(Long userId);
}
