package subak.example.subak.controller;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import subak.example.subak.dao.PaymentDAO;
import subak.example.subak.domain.PaymentDTO;
import subak.example.subak.domain.SessionUserVO;
import subak.example.subak.service.BidService;
import subak.example.subak.service.UserService;

@Controller
@RequestMapping("/payment")
public class PaymentController {
	
	 @Autowired
	 private BidService bidService;
	 @Autowired
	 private PaymentDAO paymentDAO;

	@GetMapping("/bid")
	public String bidPaymentPage(
            @RequestParam Integer price,
            HttpSession session,
            @RequestParam Long sellerId,
            @RequestParam Long itemId,
            Model model) {
			SessionUserVO sessionUser = (SessionUserVO) session.getAttribute("user");
			if (sessionUser == null) {
				return "redirect:/login"; 
			}

			model.addAttribute("userName", sessionUser.getUsername());
			model.addAttribute("price", price);
			model.addAttribute("sellerId", sellerId);
			model.addAttribute("itemId", itemId);
			
			PaymentDTO payment = new PaymentDTO();
			payment.setBidId(null); 
			payment.setItemId(itemId);
			payment.setTossOrderId(String.valueOf(itemId));
			payment.setTossPaymentStatus("READY");
			payment.setTotalAmount(price); 

			return "payment/paymentPage"; 
	}
	@GetMapping("/success")
	public String paymentSuccess(
	        @RequestParam Long sellerId,
	        @RequestParam Long itemId,
	        @RequestParam int amount,
	        Model model) {

	    // 입찰 기록 생성 (중복 가격 체크)
	    try {
	        boolean created = bidService.createBid(itemId, sellerId, amount); 
	        if (!created) {
	            model.addAttribute("errorMessage", "이미 동일 가격으로 입찰이 존재합니다.");
	            return "payment/fail"; 
	        }
	    } catch (Exception e) {
	        model.addAttribute("errorMessage", "입찰 생성 중 오류 발생");
	        return "payment/fail";
	    }

	    model.addAttribute("sellerId", sellerId);
	    model.addAttribute("itemId", itemId);
	    model.addAttribute("price", amount);

	    return "payment/success";
	}


	// 결제 실패 시 호출되는 URL 
	@GetMapping("/fail")
	public String paymentFail(
			@RequestParam String code,
			@RequestParam String message,
			@RequestParam String orderId,
			Model model) {
		
		// 결제 실패 정보 로깅 또는 저장
		System.out.println("결제 실패: " + message + " (Code: " + code + ")");

		// 실패 이유를 JSP로 전달
		model.addAttribute("code", code);
		model.addAttribute("message", message);
		model.addAttribute("orderId", orderId);

		return "payment/fail";
	}
	
	@PostMapping("/confirm")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> confirmPayment(@RequestBody Map<String, Object> requestData) {

	    Map<String, Object> response = new HashMap<>();
	    try {
	        // 요청 데이터
	        String paymentKey = (String) requestData.get("paymentKey");
	        int orderId = (Integer) requestData.get("orderId");
	        int amount = (Integer) requestData.get("amount");
	        Long itemId = Long.valueOf((Integer) requestData.get("itemId"));
	        Long sellerId = Long.valueOf((Integer) requestData.get("sellerId"));


	        // 입찰 생성
	        boolean bid = bidService.createBid(itemId, sellerId, amount);

	        if(bid == true) {
	        	// bid_id 업데이트
		        Long bidId = paymentDAO.getBidId(paymentKey);
		        bidService.setBid(bidId);
		        
		        response.put("status", 200);
		        response.put("message", "결제 승인 및 입찰 생성 성공");
		        response.put("paymentKey", paymentKey);
		        response.put("orderId", orderId);
		        response.put("totalAmount", amount);
		        return ResponseEntity.ok(response);
	        }
	        else {
	        	response.put("status", 404);
	        	return ResponseEntity.ok(response);
	        }
	    } catch (Exception e) {
	        response.put("status", 500);
	        response.put("message", "결제 처리 중 오류: " + e.getMessage());
	        return ResponseEntity.status(500).body(response);
	    }
	}

}
