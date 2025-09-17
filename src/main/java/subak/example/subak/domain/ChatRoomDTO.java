package subak.example.subak.domain;

import java.security.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ChatRoomDTO {
	private Long id;
	private Long itemId;
	private Timestamp createdAt;
}
