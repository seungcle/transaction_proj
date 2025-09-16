package subak.example.subak.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import subak.example.subak.service.EmailService;

@Controller
public class MailController {

    @Resource(name = "emailService")
    private EmailService emailService;

    // 이메일로 인증번호 전송
    @RequestMapping(value="/sendAuthEmail.do", produces = "application/json; charset=utf8")
    @ResponseBody
    public String sendAuthEmail(String email, HttpSession session) {
        // 6자리 랜덤 인증번호 생성
        String authNumber = String.valueOf((int)(Math.random() * 900000) + 100000);

        // 세션에 인증번호 저장
        session.setAttribute("authNumber", authNumber);

        // 이메일 전송
        String subject = "인증번호";
        String content = "인증번호는 [" + authNumber + "] 입니다.";
        emailService.sendEmail(email, subject, content);

        return "{\"result\":\"success\"}";
    }

    // 입력받은 인증번호 검증
    @RequestMapping(value="/verifyAuthNumber.do", produces = "application/json; charset=utf8")
    @ResponseBody
    public String verifyAuthNumber(String inputAuthNumber, HttpSession session) {
        String storedAuthNumber = (String) session.getAttribute("authNumber");

        if (storedAuthNumber != null && storedAuthNumber.equals(inputAuthNumber)) {
            // 인증 성공 시 세션 정보 삭제
            session.removeAttribute("authNumber");
            return "{\"result\":\"success\"}";
        } else {
            return "{\"result\":\"fail\"}";
        }
    }
}