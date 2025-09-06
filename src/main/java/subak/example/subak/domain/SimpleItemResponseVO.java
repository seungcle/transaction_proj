package subak.example.subak.domain;

import lombok.Getter;

@Getter
public class SimpleItemResponseVO {

	private Long id;
    private String title;
    private String imageUrl;
    private String currentPrice;
    private String endTime;
    private String status;
    private String createdAt;
}
