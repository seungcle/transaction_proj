package subak.example.subak.controller;



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

import subak.example.subak.domain.SessionUserVO;
import subak.example.subak.domain.UserInfoVO;
import subak.example.subak.service.UserService;

@Controller
public class UserController {

	@Autowired
	private UserService userService;
	
	// 마이페이지 이동
	@GetMapping("/mypage")
	public String mypage(HttpSession session, Model model) {
		
		if(session.getAttribute("user") == null)
			return "redirect:/login";
		UserInfoVO vo = userService.getMyInfo(session);
		model.addAttribute("user", vo);
		return "mypage/mypage";
	}
	
	// 비밀번호 업데이트
	@PostMapping("/update-password")
	public ResponseEntity<Map<String, Object>> updatePassword(@RequestBody Map<String, String> payload, HttpSession session) {
	    String currentPassword = payload.get("currentPassword");
	    String newPassword = payload.get("newPassword");
	    SessionUserVO sessionUser = (SessionUserVO) session.getAttribute("user");
	    
	    if (sessionUser == null) {
	        return ResponseEntity.status(401).build(); // 비로그인 상태
	    }
	    
	    // 서비스 호출: 현재 비밀번호 확인 및 새 비밀번호로 업데이트
	    boolean success = userService.updatePasswordById(sessionUser.getId(), currentPassword, newPassword);
	    
	    Map<String, Object> response = new HashMap<>();
	    if (success) {
	        response.put("success", true);
	        response.put("message", "비밀번호가 성공적으로 변경되었습니다.");
	        return ResponseEntity.ok(response);
	    } else {
	        response.put("success", false);
	        response.put("message", "현재 비밀번호가 일치하지 않습니다.");
	        return ResponseEntity.badRequest().body(response);
	    }
	}
	
	// 닉네임 업데이트 
	 @PostMapping("/update-nickname")
	    public ResponseEntity<Map<String, Object>> updateNickname(@RequestBody Map<String, String> payload, HttpSession session) {
	        SessionUserVO sessionUser = (SessionUserVO) session.getAttribute("user");
	        if (sessionUser == null) {
	            return ResponseEntity.status(401).build(); // 비로그인
	        }
	        
	        String newNickname = payload.get("newNickname");
	        Map<String, Object> response = new HashMap<>();
	        
	        // 서비스 호출: 닉네임 변경
	        boolean success = userService.updateNickname(sessionUser.getId(), newNickname);
	        
	        if (success) {
	            response.put("success", true);
	            response.put("message", "닉네임이 성공적으로 변경되었습니다.");
	            return ResponseEntity.ok(response);
	        } else {
	            response.put("success", false);
	            response.put("message", "이미 사용 중인 닉네임입니다.");
	            return ResponseEntity.badRequest().body(response);
	        }
	    }
	 
	 // 자기소개 업데이트 
	 @PostMapping("/update-bio")
	    public ResponseEntity<Map<String, Object>> updateBio(@RequestBody Map<String, String> payload, HttpSession session) {
	        SessionUserVO sessionUser = (SessionUserVO) session.getAttribute("user");
	        if (sessionUser == null) {
	            return ResponseEntity.status(401).build(); // 비로그인
	        }
	        
	        String newBio = payload.get("newBio");
	        Map<String, Object> response = new HashMap<>();

	        try {
	            userService.updateBio(sessionUser.getId(), newBio);
	            response.put("success", true);
	            response.put("message", "자기소개가 성공적으로 변경되었습니다.");
	            return ResponseEntity.ok(response);
	        } catch (Exception e) {
	            response.put("success", false);
	            response.put("message", "자기소개 변경에 실패했습니다.");
	            return ResponseEntity.status(500).body(response);
	        }
	    }

}
