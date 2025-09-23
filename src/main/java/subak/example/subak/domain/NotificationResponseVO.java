package subak.example.subak.domain;

import lombok.Getter;

@Getter
public class NotificationResponseVO {
	private Long id;
	private String content;
	private char isRead;
	private String nickname;
	private Long itemId;
	private String title;
	private String imageUrl;
}
