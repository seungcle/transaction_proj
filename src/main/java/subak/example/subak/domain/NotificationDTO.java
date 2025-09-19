package subak.example.subak.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class NotificationDTO {
	private Long id;
	private String content;
	private String url;
	private char isRead;
	private Long UserId;
	private Long itemId;
}
