package subak.example.subak.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import subak.example.subak.domain.SessionUserVO;
import subak.example.subak.domain.UserInfoVO;
import subak.example.subak.service.UserService;

@Controller
public class UserController {

    @Autowired
    private UserService userService;

    private final String UPLOAD_DIR = "C:/profile-uploads/";
    private final String DEFAULT_IMAGE = "/profile-images/default.jpg";

    // 마이페이지 이동
    @GetMapping("/mypage")
    public String mypage(HttpSession session, Model model) {
        SessionUserVO sessionUser = (SessionUserVO) session.getAttribute("user");
        if(sessionUser == null) return "redirect:/login";

        UserInfoVO vo = userService.getMyInfo(session);
        // 기본 이미지 처리
        if(vo.getImageUrl() == null || vo.getImageUrl().isEmpty()) {
            vo.setImageUrl(DEFAULT_IMAGE);
        }

        model.addAttribute("user", vo);
        return "mypage/mypage";
    }

    // 비밀번호 업데이트
    @PostMapping("/update-password")
    public ResponseEntity<Map<String, Object>> updatePassword(@RequestBody Map<String, String> payload, HttpSession session) {
        SessionUserVO sessionUser = (SessionUserVO) session.getAttribute("user");
        if (sessionUser == null) return ResponseEntity.status(401).build();

        String currentPassword = payload.get("currentPassword");
        String newPassword = payload.get("newPassword");
        boolean success = userService.updatePasswordById(sessionUser.getId(), currentPassword, newPassword);

        Map<String, Object> response = new HashMap<>();
        if(success) {
            response.put("success", true);
            response.put("message", "비밀번호가 성공적으로 변경되었습니다.");
            return ResponseEntity.ok(response);
        } else {
            response.put("success", false);
            response.put("message", "현재 비밀번호가 일치하지 않습니다.");
            return ResponseEntity.badRequest().body(response);
        }
    }

    // 닉네임 업데이트
    @PostMapping("/update-nickname")
    public ResponseEntity<Map<String, Object>> updateNickname(@RequestBody Map<String, String> payload, HttpSession session) {
        SessionUserVO sessionUser = (SessionUserVO) session.getAttribute("user");
        if(sessionUser == null) return ResponseEntity.status(401).build();

        String newNickname = payload.get("newNickname");
        boolean success = userService.updateNickname(sessionUser.getId(), newNickname);

        Map<String, Object> response = new HashMap<>();
        if(success) {
            response.put("success", true);
            response.put("message", "닉네임이 성공적으로 변경되었습니다.");
            return ResponseEntity.ok(response);
        } else {
            response.put("success", false);
            response.put("message", "이미 사용 중인 닉네임입니다.");
            return ResponseEntity.badRequest().body(response);
        }
    }

    // 자기소개 업데이트
    @PostMapping("/update-bio")
    public ResponseEntity<Map<String, Object>> updateBio(@RequestBody Map<String, String> payload, HttpSession session) {
        SessionUserVO sessionUser = (SessionUserVO) session.getAttribute("user");
        if(sessionUser == null) return ResponseEntity.status(401).build();

        String newBio = payload.get("newBio");
        Map<String, Object> response = new HashMap<>();
        try {
            userService.updateBio(sessionUser.getId(), newBio);
            response.put("success", true);
            response.put("message", "자기소개가 성공적으로 변경되었습니다.");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "자기소개 변경에 실패했습니다.");
            return ResponseEntity.status(500).body(response);
        }
    }

    // 프로필 이미지 업로드
    @PostMapping("/upload-profile-image")
    public ResponseEntity<Map<String, Object>> uploadProfileImage(
            @RequestParam("profileImage") MultipartFile file,
            HttpSession session) {

        SessionUserVO sessionUser = (SessionUserVO) session.getAttribute("user");
        Map<String, Object> response = new HashMap<>();
        if(sessionUser == null) return ResponseEntity.status(401).build();

        try {
            if(file.isEmpty() || !file.getContentType().startsWith("image/")) {
                response.put("success", false);
                response.put("message", "이미지 파일만 업로드 가능합니다.");
                return ResponseEntity.badRequest().body(response);
            }

            File dir = new File(UPLOAD_DIR);
            if(!dir.exists() && !dir.mkdirs()) {
                response.put("success", false);
                response.put("message", "업로드 폴더 생성 실패");
                return ResponseEntity.status(500).body(response);
            }

            String originalFilename = file.getOriginalFilename();
            String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
            String fileName = sessionUser.getId() + extension;

            File dest = new File(UPLOAD_DIR, fileName);
            file.transferTo(dest);

            String imageUrl = "/profile-images/" + fileName;
            userService.updateImageUrl(sessionUser.getId(), imageUrl);

            response.put("success", true);
            response.put("imageUrl", imageUrl);
            return ResponseEntity.ok(response);

        } catch(Exception e) {
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "이미지 업로드 실패");
            return ResponseEntity.status(500).body(response);
        }
    }

    // 프로필 이미지 제공
    @GetMapping("/profile-images/{fileName:.+}")
    public void getProfileImage(@PathVariable("fileName") String fileName, HttpServletResponse response) {
        File file = new File(UPLOAD_DIR + fileName);
        if(!file.exists()) {
            // 기본 이미지 제공
            file = new File("C:/profile-uploads/default.jpg");
            if(!file.exists()) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
        }

        response.setContentType("image/jpeg");
        try (FileInputStream fis = new FileInputStream(file);
             OutputStream os = response.getOutputStream()) {

            byte[] buffer = new byte[1024];
            int bytesRead;
            while((bytesRead = fis.read(buffer)) != -1) {
                os.write(buffer, 0, bytesRead);
            }
        } catch(IOException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
