package subak.example.subak.domain;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class TransactionDTO {
	private Long id;
    private Timestamp endTime;
    private Long itemId;
    private Long price;
    private Long userId;
}
