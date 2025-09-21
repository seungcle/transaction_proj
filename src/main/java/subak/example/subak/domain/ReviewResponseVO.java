package subak.example.subak.domain;

import java.util.List;

import lombok.Getter;

@Getter
public class ReviewResponseVO {

	private Long id;
	private String nickname;
	private String title;
	private double rating;
	private List<String> label;
	private String reviewComment;
	private String createdAt;
}
