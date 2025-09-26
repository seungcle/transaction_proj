package subak.example.subak.domain;

import java.security.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PaymentDTO {
	private Long id;
    private Long bidId;
    private Long itemId;
    private String tossOrderId;
    private String tossPaymentKey;
    private String tossPaymentMethod;   
    private String tossPaymentStatus;   
    private int totalAmount;
    private Timestamp approvedAt;
    private Timestamp requestedAt;
}
