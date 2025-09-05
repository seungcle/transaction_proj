package subak.example.subak.domain;

import java.time.LocalDateTime;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ItemDTO {

	private Long id;
    private String title;
    private String text;
    private Long startPrice;
    private Long currentPrice;
    private LocalDateTime endTime;
    private String status;
    private LocalDateTime createdAt;
    private String sellerNickname; // User Entity에서 가져온 정보
    private String categoryName;   // Category Entity에서 가져온 정보 
}
