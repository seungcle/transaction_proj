package subak.example.subak.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import subak.example.subak.dao.NotificationDAO;
import subak.example.subak.domain.NotificationDTO;

@Service
public class NotificationService {
    
    // DAO를 주입받아 DB에 알림을 저장합니다.
    @Autowired
    private NotificationDAO notificationDAO;
    
    // SimpMessagingTemplate을 주입받아 웹소켓 메시지를 전송합니다.
    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    public void sendNotification(NotificationDTO notification) {
        // 1. 알림을 DB에 저장합니다.
        // 이 과정이 성공해야만 알림 내역이 남게 됩니다.
        notificationDAO.insertNotification(notification);

        // 2. 웹소켓을 통해 실시간으로 알림을 보냅니다.
        // DTO에서 유저 ID와 내용을 가져옵니다.
        String userId = String.valueOf(notification.getUserId());
        String message = notification.getContent();
        
        // 특정 사용자에게 메시지를 보냅니다.
        // 클라이언트는 /user/topic/notifications 주소를 구독해야 합니다.
        //messagingTemplate.convertAndSendToUser(userId, "/topic/notifications", message);
    }
}