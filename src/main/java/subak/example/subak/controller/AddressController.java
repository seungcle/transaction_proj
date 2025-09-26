package subak.example.subak.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.ui.Model;

import subak.example.subak.dao.AddressDAO;
import subak.example.subak.domain.AddressDTO;
import subak.example.subak.domain.SessionUserVO;

@Controller
@RequestMapping("/mypage/address")
public class AddressController {

    @Autowired
    private AddressDAO addressDAO;

    // 로그인 사용자 주소 조회 (주소 목록)
    @GetMapping
    public String myAddress(Model model, HttpSession session) {

        SessionUserVO user = (SessionUserVO) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        List<AddressDTO> addressList = new ArrayList<>();
        try {
            AddressDTO dto = new AddressDTO();
            dto.setUserId(user.getId());
            addressList = addressDAO.findByUser(dto);
        } catch (Exception e) {
            e.printStackTrace();
        }

        model.addAttribute("addressList", addressList);
        return "mypage/myAddress";
    }

    // 새 주소 추가
    @PostMapping("/add")
    @ResponseBody
    public ResponseEntity<String> addAddress(@RequestBody AddressDTO dto, HttpSession session) {
        SessionUserVO user = (SessionUserVO) session.getAttribute("user");
        if (user == null) return ResponseEntity.status(401).body("login_required");

        dto.setUserId(user.getId());

        // 대표 배송지 체크 여부 처리
        if ("Y".equalsIgnoreCase(dto.getDefaultAddress())) {
            dto.setDefaultAddress("Y");
            addressDAO.resetDefault(user.getId());
        }
        else {
            dto.setDefaultAddress("N");
        }

        try {
            addressDAO.insert(dto);
            return ResponseEntity.ok("success");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("error");
        }
    }

    // 주소 수정
    @PostMapping("/update")
    @ResponseBody
    public ResponseEntity<String> updateAddress(@RequestBody AddressDTO dto, HttpSession session) {
        SessionUserVO user = (SessionUserVO) session.getAttribute("user");
        if (user == null) return ResponseEntity.status(401).body("login_required");

        dto.setUserId(user.getId());

        if ("true".equalsIgnoreCase(dto.getDefaultAddress()) || "Y".equalsIgnoreCase(dto.getDefaultAddress())) {
            dto.setDefaultAddress("Y");
            addressDAO.resetDefault(user.getId());
        }
        else {
            dto.setDefaultAddress("N");
        }

        try {
            addressDAO.update(dto);
            return ResponseEntity.ok("success");
        }
        catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("error");
        }
    }

    // 주소 삭제
    @PostMapping("/delete/{id}")
    @ResponseBody
    public ResponseEntity<String> deleteAddress(@PathVariable Long id, HttpSession session) {
        SessionUserVO user = (SessionUserVO) session.getAttribute("user");
        if (user == null) return ResponseEntity.status(401).body("login_required");

        try {
            addressDAO.delete(id);
            return ResponseEntity.ok("success");
        }
        catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("error");
        }
    }
}