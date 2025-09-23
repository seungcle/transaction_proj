package subak.example.subak.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import subak.example.subak.domain.NotificationDTO;
import subak.example.subak.domain.NotificationResponseVO;
import subak.example.subak.service.NotificationService;

@Controller
public class NotificationController {
	
	@Autowired
	NotificationService notificationService;

	@GetMapping("/notification/{userId}")
	@ResponseBody
	public List<NotificationResponseVO> getNotification(@PathVariable Long userId) {
		
		return notificationService.getNotification(userId);
	}
	
	@PostMapping("/notification/read/{id}")
	@ResponseBody
	public void readNotification(@PathVariable Long id) {
		notificationService.readNotification(id);
	}
}
