package subak.example.subak.domain;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BidDTO {
	 private Long id; 
	 private Long bidItemId; 
	 private Long bidPrice; 
	 private Timestamp createdAt;
	 private Long bidUserId;
}
