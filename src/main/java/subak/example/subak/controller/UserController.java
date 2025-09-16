package subak.example.subak.controller;



import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

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

}
