package subak.example.subak.service;

import java.time.Duration;
import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import subak.example.subak.dao.ItemDAO;
import subak.example.subak.domain.ItemResponseDTO;

@Service
public class ItemService {

	@Autowired
	ItemDAO itemDAO;

	public ItemResponseDTO getItem(Long itemId) {
		
		ItemResponseDTO dto = itemDAO.findItemById(itemId);
		if (dto != null && dto.getEndTime() != null) {
            LocalDateTime now = LocalDateTime.now();
            LocalDateTime endTime = dto.getEndTime().toLocalDateTime();

            Duration duration = Duration.between(now, endTime);

            if (duration.isNegative()) {
                dto.setRemainingTimeInSeconds(0L);
            } else {
                long totalSeconds = duration.toMillis() / 1000;
                dto.setRemainingTimeInSeconds(totalSeconds);
            }
        }
		return dto;
	}
}
