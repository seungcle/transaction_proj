package subak.example.subak.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import subak.example.subak.domain.UserDTO;
import subak.example.subak.service.UserService;

@Controller
public class FindController {

    @Autowired
    private UserService userService;

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
    public String findUsername(@RequestParam("email") String email, Model model) {

        // 이메일로 조회
        UserDTO foundUser = userService.findUserByEmail(email);

        if (foundUser != null) {
            model.addAttribute("foundUsername", foundUser.getUsername());
            return "login/findUsernameResult";
        }
        else {
            model.addAttribute("message", "입력하신 정보와 일치하는 아이디가 없습니다.");
            return "login/findUserName";
        }
    }
}
