package subak.example.subak.domain;

import java.sql.Timestamp;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ItemResponseDTO {

	private Long id;
    private String title;
    private String text;
    private List<String> imageUrl;
    private String startPrice;
    private String currentPrice;
    private Timestamp endTime;
    private String status;
    private Timestamp createdAt;
    private String sellerNickname;
    private Long remainingTimeInSeconds;
}
