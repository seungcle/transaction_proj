package subak.example.subak.domain;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ItemRequestDTO {

	private Long id;
	private String title;
	private String text;
	private String startPrice;
	private Long currentPrice;
	private Timestamp endTime;
	private String status;
	private Long duration;
	private Timestamp createdAt;
	private Long sellerId;
	private Long categoryId;
	private Long winnerId;
}
