package subak.example.subak.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import subak.example.subak.domain.UserDTO;
import subak.example.subak.service.UserService;

@Controller
public class JoinController {
	
	@Autowired
	private UserService userService;

	// 회원가입 폼
    @GetMapping("/join")
    public String registerForm() {
    	
        return "mainpage/join";
    }
    
    // 회원가입 처리
    @PostMapping("/join")
    public String register(UserDTO user, Model model) {
        boolean result = userService.join(user);
        if (result) {
            return "redirect:/login";
        } else {
            model.addAttribute("error", "이미 존재하는 아이디입니다.");
            return "mainpage/join";
        }
    }
}
