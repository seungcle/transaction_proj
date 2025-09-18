package subak.example.subak.domain;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DmChatRoomInfoDTO {

	private Long roomId;
	private Long userId; // 채팅 상대방 id
	private String nickname;
	private String imageUrl;
	private String msg; // 마지막 메시지
	private Timestamp createdAt; // 마지막 메시지 생성시간
	
}
