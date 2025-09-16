package subak.example.subak.domain;

import java.time.LocalDateTime;

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
	private LocalDateTime createdAt;
}
