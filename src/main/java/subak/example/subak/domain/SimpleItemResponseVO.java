package subak.example.subak.domain;

import java.sql.Timestamp;

import lombok.Getter;

@Getter
public class SimpleItemResponseVO {

	private Long id;
    private String title;
    private String imageUrl;
    private String currentPrice;
    private Timestamp endTime;
    private String status;
    private Timestamp createdAt;
}
