package subak.example.subak.domain;

import java.security.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChatRoomDTO {
	private Long id;
	private Long itemId;
	private Timestamp createdAt;
}
