package subak.example.subak.domain;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserCheckDTO {
    private String username;      // 아이디 체크용
    private String usernickname;  // 닉네임 체크용
    private String email;         // 이메일 인증용
    private String authCode;      // 이메일 인증번호 확인용
}
