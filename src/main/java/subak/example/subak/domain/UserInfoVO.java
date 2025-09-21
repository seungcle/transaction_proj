package subak.example.subak.domain;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class UserInfoVO {

	private Long id;
	private String nickname;
	private String bio;
	private String imageUrl;
	private String password;

}
