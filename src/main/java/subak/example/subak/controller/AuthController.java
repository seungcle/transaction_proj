package subak.example.subak.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/ajax")
public class AuthController {

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

    @PostMapping("/sendAuthEmail")
    @ResponseBody
    public String sendAuthEmail(HttpServletRequest request, HttpSession session) {
        String email = request.getParameter("email");
        if (email == null || email.isEmpty()) return "fail";

        // 인증 코드 생성
        String authCode = String.valueOf((int)(Math.random() * 899999) + 100000);

        // 프로퍼티 로드
        Properties mailProps = new Properties();
        try (InputStream input = getClass().getClassLoader().getResourceAsStream("email.properties")) {
            if (input == null) {
                System.err.println("email.properties 파일을 찾을 수 없습니다!");
                return "fail";
            }
            mailProps.load(input);
        } catch (IOException e) {
            e.printStackTrace();
            return "fail";
        }

        String subject = "아이디 찾기 인증번호입니다.";
        String content = "회원님의 아이디 찾기 인증번호는 " + authCode + " 입니다.";

        if (sendEmail(email, subject, content, mailProps)) {
            session.setAttribute("authCode", authCode);
            session.setAttribute("authEmail", email);
            return "success";
        } else {
            return "fail";
        }
    }

    @PostMapping("/sendCodeEmail")
    @ResponseBody
    public String sendCodeEmail(HttpServletRequest request, HttpSession session) {
        String email = request.getParameter("email");
        if (email == null || email.isEmpty()) return "fail";

        String authCode = String.valueOf((int)(Math.random() * 899999) + 100000);

        Properties mailProps = new Properties();
        try (InputStream input = getClass().getClassLoader().getResourceAsStream("email.properties")) {
            if (input == null) {
                System.err.println("email.properties 파일을 찾을 수 없습니다!");
                return "fail";
            }
            mailProps.load(input);
        } catch (IOException e) {
            e.printStackTrace();
            return "fail";
        }

        String subject = "회원가입 인증번호입니다.";
        String content = "회원가입 인증번호는 " + authCode + " 입니다.";

        if (sendEmail(email, subject, content, mailProps)) {
            session.setAttribute("authCode", authCode);
            session.setAttribute("authEmail", email);
            return "success";
        } else {
            return "fail";
        }
    }

    @PostMapping("/verifyAuthCode")
    @ResponseBody
    public String verifyAuthCode(HttpServletRequest request, HttpSession session) {
        String inputAuthCode = request.getParameter("authCode");
        String sessionAuthCode = (String) session.getAttribute("authCode");

        if (sessionAuthCode != null && sessionAuthCode.equals(inputAuthCode)) {
            session.removeAttribute("authCode");
            session.removeAttribute("authEmail");
            return "success";
        } else {
            return "fail";
        }
    }
}
