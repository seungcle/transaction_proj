package subak.example.subak.domain;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ChatResponseDTO {

	private Long id;
	private String message;
	private String nickname;
	private Timestamp createdAt;
}
