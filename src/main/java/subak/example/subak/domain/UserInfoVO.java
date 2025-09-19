package subak.example.subak.domain;

import lombok.Getter;

@Getter
public class UserInfoVO {

	private Long id;
	private String nickname;
	private String bio;
	private String imageUrl;
	private String password;

	    public void setPassword(String password) {
	        this.password = password;
	    }
}
