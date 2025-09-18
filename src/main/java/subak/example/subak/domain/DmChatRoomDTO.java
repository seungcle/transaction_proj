package subak.example.subak.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DmChatRoomDTO {

	private Long id;
	private Long userId1; // 물건주인
	private Long userId2; // 나
}
