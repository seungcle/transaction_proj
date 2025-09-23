package subak.example.subak.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import subak.example.subak.domain.SessionUserVO;

@Controller
@RequestMapping("/payment")
public class PaymentController {

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

			return "payment/paymentPage"; 
	}
	@GetMapping("/success")
	public String paymentSuccess(
			@RequestParam Long sellerId,
			@RequestParam Long itemId,
			@RequestParam int amount,
			Model model) {
		
		// 1. 토스페이먼츠 API를 이용한 결제 승인 로직 
		
		model.addAttribute("sellerId", sellerId);
		model.addAttribute("itemId", itemId);
		model.addAttribute("price", amount);
		
		return "payment/success";
	}

	// --- 결제 실패 시 호출되는 URL ---
	@GetMapping("/fail")
	public String paymentFail(
			@RequestParam String code,
			@RequestParam String message,
			@RequestParam String orderId,
			Model model) {
		
		// 1. 결제 실패 정보 로깅 또는 저장
		System.out.println("결제 실패: " + message + " (Code: " + code + ")");

		// 2. 실패 이유를 JSP로 전달
		model.addAttribute("code", code);
		model.addAttribute("message", message);
		model.addAttribute("orderId", orderId);

		// 결제 실패 페이지(fail.jsp)로 이동
		return "payment/fail";
	}
	
	//------key검증 로직------
	@PostMapping("/confirm")
	@ResponseBody
    public ResponseEntity<Map<String, Object>> confirmPayment(@RequestBody Map<String, Object> requestData) {
        // 테스트를 위해 결제 키 검증 없이 항상 성공 응답을 반환
        // 실제 운영 환경에서는 이 로직을 토스페이먼츠 API 호출로 대체해야 합니다.
        
        // 성공 응답 데이터 생성 (토스페이먼츠 API 응답과 유사한 형식)
        Map<String, Object> successResponse = new HashMap<>();
        successResponse.put("status", 200);
        successResponse.put("message", "결제 승인 테스트 성공");
        successResponse.put("paymentKey", requestData.get("paymentKey"));
        successResponse.put("orderId", requestData.get("orderId"));
        successResponse.put("totalAmount", requestData.get("amount"));
        
        return ResponseEntity.ok(successResponse);
    }
}
