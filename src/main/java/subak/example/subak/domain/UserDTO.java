package subak.example.subak.domain;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserDTO {

	private Long id;
	private String username;
	private String password;
	private String email;
	private String nickname;
	private Timestamp createdAt;
	private String bio;
	private String image_url;
}
