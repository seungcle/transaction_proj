package subak.example.subak.domain;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class FavoriteDTO {

	private Long id;
	private Timestamp createdAt;
	private Long userId;
	private Long itemId;
}
