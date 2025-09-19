package subak.example.subak.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AddressDTO {
	private Long id;
	private String address;
	private String detailAddress;
	private Long userId;
	private String defaultAddress;
	private String addressName;
	private String postalCode;
}
