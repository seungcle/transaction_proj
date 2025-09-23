package subak.example.subak.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.Map;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import subak.example.subak.domain.UserDTO;
import subak.example.subak.service.UserService;

@Controller
@RequestMapping("/ajax")
public class AuthController {

    @Autowired
    private UserService userService;

    // 공통 메서드
    private Session createMailSession(Properties mailProps) {
        return Session.getInstance(mailProps, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(
                        mailProps.getProperty("mail.smtp.user"),
                        mailProps.getProperty("mail.smtp.password")
                );
            }
        });
    }

    private boolean sendEmail(String toEmail, String subject, String content, Properties mailProps) {
        try {
            Session mailSession = createMailSession(mailProps);

            MimeMessage message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(mailProps.getProperty("mail.smtp.user")));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            message.setSubject(subject, "UTF-8");
            message.setText(content, "UTF-8");

            Transport.send(message);
            return true;
        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Properties loadMailProperties() {
        Properties mailProps = new Properties();
        try (InputStream input = getClass().getClassLoader().getResourceAsStream("email.properties")) {
            if (input == null) {
                System.err.println("email.properties 파일을 찾을 수 없습니다!");
                return null;
            }
            mailProps.load(input);
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
        return mailProps;
    }

    private String generateAuthCode() {
        return String.valueOf((int)(Math.random() * 899999) + 100000);
    }

    // 회원가입 인증 메일 발송
    @PostMapping("/sendSignupEmail")
    @ResponseBody
    public String sendSignupEmail(HttpServletRequest request, HttpSession session) {
        String email = request.getParameter("email");
        if (email == null || email.isEmpty()) return "fail";

        String authCode = generateAuthCode();
        Properties mailProps = loadMailProperties();
        if (mailProps == null) return "fail";

        String subject = "회원가입 인증번호입니다.";
        String content = "회원가입 인증번호는 " + authCode + " 입니다.";

        if (sendEmail(email, subject, content, mailProps)) {
            session.setAttribute("signupAuthCode", authCode);
            session.setAttribute("signupEmail", email);
            return "success";
        } else {
            return "fail";
        }
    }

    // 아이디 찾기 인증 메일 발송
    @PostMapping("/sendFindIdEmail")
    @ResponseBody
    public String sendFindIdEmail(HttpServletRequest request, HttpSession session) {
        String email = request.getParameter("email");
        if (email == null || email.isEmpty()) return "fail";

        String authCode = generateAuthCode();
        Properties mailProps = loadMailProperties();
        if (mailProps == null) return "fail";

        String subject = "회원님의 아이디 찾기 인증번호입니다.";
        String content = "회원님의 아이디 찾기 인증번호는 " + authCode + " 입니다.";

        if (sendEmail(email, subject, content, mailProps)) {
            session.setAttribute("findIdAuthCode", authCode);
            session.setAttribute("findIdEmail", email);
            return "success";
        } else {
            return "fail";
        }
    }

    // 인증번호 확인
    @PostMapping("/verifyAuthCode")
    @ResponseBody
    public String verifyAuthCode(HttpServletRequest request, HttpSession session) {
        String inputAuthCode = request.getParameter("authCode");
        String type = request.getParameter("type"); // "signup" 또는 "findId"

        String sessionCode = null;
        if ("signup".equals(type)) {
            sessionCode = (String) session.getAttribute("signupAuthCode");
        } else if ("findId".equals(type)) {
            sessionCode = (String) session.getAttribute("findIdAuthCode");
        }

        if (sessionCode != null && sessionCode.equals(inputAuthCode)) {
            return "success";
        } else {
            return "fail";
        }
    }

    // 아이디 찾기
    @PostMapping("/findId")
    @ResponseBody
    public String findId(HttpServletRequest request, HttpSession session) {
        String inputCode = request.getParameter("code");
        String email = request.getParameter("email");

        String sessionCode = (String) session.getAttribute("findIdAuthCode");
        String sessionEmail = (String) session.getAttribute("findIdEmail");

        if (sessionCode == null || sessionEmail == null) return "fail";

        if (sessionCode.equals(inputCode) && sessionEmail.equals(email)) {
            UserDTO user = userService.findUserByEmail(email);
            if (user != null) {
                session.removeAttribute("findIdAuthCode");
                session.removeAttribute("findIdEmail");
                return user.getUsername();
            } else {
                return "fail";
            }
        } else {
            return "fail";
        }
    }
    @PostMapping("/user/check-user-and-send-email")
    @ResponseBody
    public String checkUserAndSendEmail(@RequestBody Map<String, String> requestMap, HttpSession session) {
        String username = requestMap.get("username");
        String email = requestMap.get("email");

        // 아이디와 이메일로 사용자 존재 여부 확인
        boolean userExists = userService.existsByUsernameAndEmail(username, email);
        if (!userExists) {
            return "{\"success\": false, \"message\": \"입력하신 정보와 일치하는 회원이 없습니다.\"}";
        }

        String authCode = generateAuthCode();
        Properties mailProps = loadMailProperties();
        if (mailProps == null) {
            return "{\"success\": false, \"message\": \"메일 설정 오류.\"}";
        }

        String subject = "비밀번호 찾기 인증번호입니다.";
        String content = "비밀번호 찾기 인증번호는 " + authCode + " 입니다.";
        
        if (sendEmail(email, subject, content, mailProps)) {
            session.setAttribute("passwordAuthCode", authCode);
            session.setAttribute("passwordAuthUsername", username);
            session.setAttribute("passwordAuthEmail", email);
            return "{\"success\": true, \"message\": \"이메일로 인증 코드가 발송되었습니다.\"}";
        } else {
            return "{\"success\": false, \"message\": \"이메일 발송에 실패했습니다. 다시 시도해주세요.\"}";
        }
    }

    // 2. 인증 코드 검증
    @PostMapping("/user/verify-auth-code")
    @ResponseBody
    public String verifyAuthCodeForPassword(@RequestBody Map<String, String> requestMap, HttpSession session) {
        String inputAuthCode = requestMap.get("authCode");
        String sessionCode = (String) session.getAttribute("passwordAuthCode");

        if (sessionCode != null && sessionCode.equals(inputAuthCode)) {
            return "{\"success\": true, \"message\": \"인증이 완료되었습니다.\"}";
        } else {
            return "{\"success\": false, \"message\": \"인증 코드가 일치하지 않습니다.\"}";
        }
    }
    
    // 3. 비밀번호 재설정
    @PostMapping("/user/reset-password")
    @ResponseBody
    public String resetPassword(@RequestBody Map<String, String> requestMap, HttpSession session) {
        String newPassword = requestMap.get("newPassword");
        String username = (String) session.getAttribute("passwordAuthUsername");
        
        if (username == null) {
            return "{\"success\": false, \"message\": \"유효하지 않은 접근입니다. 처음부터 다시 시도해주세요.\"}";
        }

        boolean resetSuccess = userService.updatePassword(username, newPassword);
        
        if (resetSuccess) {
            session.removeAttribute("passwordAuthCode");
            session.removeAttribute("passwordAuthUsername");
            session.removeAttribute("passwordAuthEmail");
            return "{\"success\": true, \"message\": \"비밀번호가 성공적으로 재설정되었습니다.\"}";
        } else {
            return "{\"success\": false, \"message\": \"비밀번호 재설정에 실패했습니다. 잠시 후 다시 시도해주세요.\"}";
        }
    }
}
