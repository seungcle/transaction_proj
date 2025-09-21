package subak.example.subak.domain;

import lombok.Getter;

@Getter
public class BidResponseVO {

	private Long id;
	private Long bidItemId;
	private Long bidPrice;
	private String createdAt;
	private String nickname;
	private String imageUrl;
}
