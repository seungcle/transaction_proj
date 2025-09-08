package subak.example.subak.service;

import java.io.File;
import java.io.IOException;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import subak.example.subak.dao.ItemDAO;
import subak.example.subak.domain.ItemImageDTO;
import subak.example.subak.domain.ItemRequestDTO;
import subak.example.subak.domain.ItemResponseDTO;
import subak.example.subak.domain.UserDTO;

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

	public boolean insertItem(ItemRequestDTO dto, List<MultipartFile> images, HttpSession session) throws IOException {
		
		String startPrice = dto.getStartPrice().replaceAll(",", "");
		Object userObj = session.getAttribute("user");
		
		if (userObj == null) {
	        return false; 
	    }
		
		UserDTO loginUser = (UserDTO) userObj;
		dto.setSellerId(loginUser.getId());
		dto.setStartPrice(startPrice);
		dto.setCurrentPrice(Long.parseLong(startPrice));
		dto.setStatus("OPEN");
		
		if(!itemDAO.insertItem(dto))
			return false;
		
		for (MultipartFile file : images) {
            if (!file.isEmpty()) {
                String fileName = UUID.randomUUID() + "_" + file.getOriginalFilename();
                String uploadPath = "C:/upload/" + fileName;

                file.transferTo(new File(uploadPath));

                ItemImageDTO img = new ItemImageDTO();
                img.setImageUrl("/upload/" + fileName);
                img.setItemId(dto.getId());
                itemDAO.insertItemImage(img);
            }
        }
		
		return true;
	}
}
