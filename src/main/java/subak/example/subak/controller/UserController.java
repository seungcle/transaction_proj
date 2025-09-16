package subak.example.subak.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import subak.example.subak.domain.UserInfoVO;
import subak.example.subak.service.UserService;

@Controller
public class UserController {

	@Autowired
	private UserService userService;
	
	@GetMapping("/mypage")
	public String mypage(HttpSession session, Model model) {
		
		if(session.getAttribute("user") == null)
			return "redirect:/login";
		UserInfoVO vo = userService.getMyInfo(session);
		model.addAttribute("user", vo);
		return "mypage/mypage";
	}
	
	@PostMapping("user/verify-password")
	@ResponseBody
	public Map<String, Object> verifyPassword(@RequestBody Map<String, String> payload, HttpSession session) {
	    Map<String, Object> response = new HashMap<>();
	    String enteredPassword = payload.get("password");
	    Long userId =(Long) session.getAttribute("usrId");
	    
	    if(userId == null) {
	    	response.put("success", false);
	    	response.put("message", "로그인 상태가 아닙니다. 로그인 해주세요.");
	    	return response;
	    }
	    
		return response;
	}
	
	
	
}
