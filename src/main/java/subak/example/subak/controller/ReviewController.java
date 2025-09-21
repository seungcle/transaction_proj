package subak.example.subak.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import subak.example.subak.domain.ReviewDTO;
import subak.example.subak.domain.ReviewResponseVO;
import subak.example.subak.domain.TagDTO;
import subak.example.subak.service.ReviewService;

@Controller
@RequestMapping("/review")
public class ReviewController {

	@Autowired
	private ReviewService reviewService;
	
	@GetMapping("/auth")
	@ResponseBody
	public boolean haveReviewAuth(@RequestParam Long itemId, @RequestParam Long sellerId, HttpSession session) {
		
		if(itemId == null || sellerId == null)
			return false;
		
		boolean haveAuth = reviewService.haveAuth(itemId, sellerId, session);
		
		return haveAuth;
	}
	
	// 리뷰페이지 이동
	@GetMapping("/enroll")
	public String reviewPage(@RequestParam Long itemId, 
							 @RequestParam Long sellerId, 
							 HttpSession session, 
							 Model model) {
		
		if(!reviewService.haveAuth(itemId, sellerId, session))
			return "redirect:/main";
		List<TagDTO> allTags = reviewService.getAllTags();
		model.addAttribute("allTags", allTags);
		
		return "item/review";
	}
	
	// 리뷰 등록
	@PostMapping("/submit")
	public String reviewSubmit(ReviewDTO reviewDTO, HttpSession session) {
		
		reviewService.reviewSubmit(reviewDTO, session);
		return "redirect:/main";
	}
	
	// 중복 리뷰 확인
	@GetMapping("/check")
	@ResponseBody
	public boolean checkDuplicate(@RequestParam Long itemId, HttpSession session) {
		
		return reviewService.checkDuplicate(itemId, session);
	}
	
	// 해당 유저 평점
	@GetMapping("/rating/average/{userId}")
	@ResponseBody
	public double getRatingAvg(@PathVariable Long userId) {
		
		return reviewService.getRatingAvg(userId);
	}
	
	// 해당 유저 받은리뷰
	@GetMapping("/receive/{userId}")
	@ResponseBody
	public List<ReviewResponseVO> receiveReviewList(@PathVariable Long userId){
		
		return reviewService.getReceiveReview(userId);
	}
	
	// 해당 유저 작성한 리뷰
	@GetMapping("/write/{userId}")
	@ResponseBody
	public List<ReviewResponseVO> writeReviewList(@PathVariable Long userId){
		
		return reviewService.getWriteReview(userId);
	}
	
}
