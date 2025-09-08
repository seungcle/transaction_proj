package subak.example.subak.domain;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ItemImageDTO {

	private Long id;
    private String imageUrl;
    private Timestamp createdAt;
    private Long itemId;
}
