package subak.example.subak.domain;

import java.sql.Timestamp;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReviewDTO {

	private Long id;
    private double rating;
    private Long itemId;
    private String reviewComment;
    private Timestamp createdAt;
    private Long userId1; // 리뷰 작성자
    private Long userId2; // 리뷰 대상자

    // 폼에서 체크박스로 선택된 태그 ID 목록
    private List<Long> tagIds;
}
