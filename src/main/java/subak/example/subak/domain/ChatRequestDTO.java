package subak.example.subak.domain;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ChatRequestDTO {

	private Long id;
	private String message;
	private Long roomId;
	private Long userId;
	private String nickname;
	private Timestamp createdAt;
}
