package subak.example.subak.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import subak.example.subak.domain.NotificationDTO;

@Mapper
public interface NotificationDAO {
	 // 알림 데이터를 DB에 삽입하는 메서드
    int insertNotification(NotificationDTO notification);

    // 특정 사용자의 모든 알림을 조회하는 메서드
    List<NotificationDTO> getNotificationsByUserId(Long userId);

    // 알림의 읽음 상태를 업데이트하는 메서드
    int updateIsRead(Long notificationId);
}
