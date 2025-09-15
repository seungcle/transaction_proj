package subak.example.subak.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import subak.example.subak.service.UserService;
import subak.example.subak.domain.UserDTO;

@Controller
public class FindController {

    @Autowired
    private UserService userService; // UserService를 주입받아 사용

    @GetMapping("/find")
    public String findPage() {
        return "login/find";
    }

    @GetMapping("/find/username")
    public String findUsernamePage() {
        return "login/findUserName";
    }

    @GetMapping("/find/password")
    public String findPasswordPage() {
        return "login/findPassword";
    }

    @PostMapping("/find/username")
    public String findUsername(@RequestParam("name") String name, @RequestParam("email") String email, Model model) {
        
        // 서비스 계층의 메서드를 호출하여 이름과 이메일로 사용자 정보 조회
        UserDTO foundUser = userService.findUserByNameAndEmail(name, email);
        
        if (foundUser != null) {
            model.addAttribute("foundUsername", foundUser.getUsername());
            return "login/findUsernameResult";
        } else {
            model.addAttribute("message", "입력하신 정보와 일치하는 아이디가 없습니다.");
            return "login/findUserName";
        }
    }
}