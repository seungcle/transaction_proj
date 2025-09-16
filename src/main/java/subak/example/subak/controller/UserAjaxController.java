package subak.example.subak.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import subak.example.subak.service.UserService;

@RestController
@RequestMapping("/ajax")
public class UserAjaxController {

    @Autowired
    private UserService userService;

    // 아이디 중복 확인
    @PostMapping("/checkUsername")
    public String checkUsername(@RequestParam String username) {
        return userService.isUsernameExists(username) ? "exists" : "available";
    }

    // 닉네임 중복 확인
    @PostMapping("/checkNickname")
    public String checkNickname(@RequestParam String nickname) {
        return userService.isNicknameExists(nickname) ? "exists" : "available";
    }

}
