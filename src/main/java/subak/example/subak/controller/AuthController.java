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

    @PostMapping("/sendAuthEmail")
    @ResponseBody
    public String sendAuthEmail(HttpServletRequest request, HttpSession session) {
        String email = request.getParameter("email");
        if (email == null || email.isEmpty()) {
            return "fail";
        }

        // 6자리 랜덤 인증번호 생성
        String authCode = String.valueOf((int) (Math.random() * 899999) + 100000);

        // Properties 로드
        Properties mailProps = new Properties();
        try (InputStream input = getClass().getClassLoader().getResourceAsStream("email.properties")) {
            if (input == null) {
                System.err.println("email.properties 파일을 찾을 수 없습니다!");
                return "fail";
            }
            mailProps.load(input);
        } catch (IOException ex) {
            ex.printStackTrace();
            return "fail";
        }

        // 필수 값 가져오기 및 null 체크
        String host = mailProps.getProperty("mail.host");
        String user = mailProps.getProperty("mail.username");
        String password = mailProps.getProperty("mail.password");
        String portStr = mailProps.getProperty("mail.port");
        String trust = mailProps.getProperty("mail.trust");

        if (host == null || user == null || password == null || portStr == null || trust == null) {
            System.err.println("email.properties에 필수 설정값이 누락되었습니다!");
            return "fail";
        }

        int port;
        try {
            port = Integer.parseInt(portStr);
        } catch (NumberFormatException e) {
            System.err.println("mail.port 값이 숫자가 아닙니다!");
            return "fail";
        }

        // SMTP 설정
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", String.valueOf(port));
        props.put("mail.smtp.trust", trust);

        Session mailSession = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password);
            }
        });

        try {
            MimeMessage message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(user));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
            message.setSubject("회원가입 인증번호입니다.");
            message.setText("회원가입 인증번호는 " + authCode + " 입니다.");
            Transport.send(message);

            // 세션에 인증번호와 이메일 저장
            session.setAttribute("authCode", authCode);
            session.setAttribute("authEmail", email);

            return "success";
        } catch (MessagingException mex) {
            mex.printStackTrace();
            return "fail";
        }
    }

    @PostMapping("/verifyAuthCode")
    @ResponseBody
    public String verifyAuthCode(HttpServletRequest request, HttpSession session) {
        String inputAuthCode = request.getParameter("authCode");
        String sessionAuthCode = (String) session.getAttribute("authCode");

        if (sessionAuthCode != null && sessionAuthCode.equals(inputAuthCode)) {
            // 인증 성공 시 세션에서 제거
            session.removeAttribute("authCode");
            session.removeAttribute("authEmail");
            return "success";
        } else {
            return "fail";
        }
    }
}
