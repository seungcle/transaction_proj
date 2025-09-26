package subak.example.subak.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import subak.example.subak.dao.NotificationDAO;
import subak.example.subak.domain.NotificationDTO;
import subak.example.subak.domain.NotificationResponseVO;

@Service
public class NotificationService {
    
    @Autowired
    private NotificationDAO notificationDAO;
    
    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    public void sendNotification(NotificationDTO notification) {
        notificationDAO.insertNotification(notification);다.
        // DTO에서 유저 ID와 내용을 가져옵니다.
        String userId = String.valueOf(notification.getUserId());
        String message = notification.getContent();
        

        messagingTemplate.convertAndSend("/topic/notifications", message);
    }

	public List<NotificationResponseVO> getNotification(Long userId) {
		
		return notificationDAO.getNotificationsByUserId(userId);
	}

	public void readNotification(Long id) {
		
		notificationDAO.updateIsRead(id);
	}
}