package subak.example.subak.domain;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ChatResponseDTO {

	private Long id;
	private String message;
	private String nickname;
	private LocalDateTime createdAt;
}
