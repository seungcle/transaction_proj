package subak.example.subak.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import subak.example.subak.domain.LoginRequestDTO;
import subak.example.subak.domain.SessionUserVO;
import subak.example.subak.service.UserService;

@Controller
public class LoginController {
	
	@Autowired
	private UserService userService;

	@GetMapping("/login")
	public String loginPage() {
		
		return "mainpage/login";
	}
	
	@PostMapping("/login")
	public String login(LoginRequestDTO dto, HttpSession session, Model model) {
		
		SessionUserVO user = userService.login(dto);
        if (user != null) {
            session.setAttribute("user", user); // 세션에 사용자 저장
            return "redirect:/main"; // 로그인 성공 시 메인 페이지
        } else {
            model.addAttribute("error", "아이디 또는 비밀번호가 올바르지 않습니다.");
            return "mainpage/login"; // 다시 로그인 페이지
        }
	}
	
	@GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate(); // 세션 초기화
        return "redirect:/main";
    }
}
