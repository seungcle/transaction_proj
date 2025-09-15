package subak.example.subak.service;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
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
import subak.example.subak.domain.SessionUserVO;

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
		
		SessionUserVO loginUser = (SessionUserVO) userObj;
		dto.setSellerId(loginUser.getId());
		dto.setStartPrice(startPrice);
		dto.setCurrentPrice(Long.parseLong(startPrice));
		dto.setStatus("OPEN");
		
		if(!itemDAO.insertItem(dto))
			return false;
	    
	    // 1. 파일을 저장할 기본 경로를 변수로 지정합니다.
	    String uploadFolder = "C:/upload/";
	    
	    // 2. 해당 경로를 기반으로 File 객체를 생성합니다.
	    File dir = new File(uploadFolder);
	    
	    // 3. 폴더가 존재하지 않으면 폴더를 생성합니다.
	    if (!dir.exists()) {
	        dir.mkdirs(); // mkdirs()는 필요한 상위 폴더까지 모두 생성해줍니다.
	    }
	    
	    for (MultipartFile file : images) {
	        if (!file.isEmpty()) {
	            // 4. 고유한 파일 이름을 생성합니다.
	            String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
	            
	            // 5. 최종 저장될 파일 경로를 포함한 File 객체를 생성합니다.
	            File destinationFile = new File(uploadFolder + fileName);
	            
	            // 6. 파일을 지정된 경로로 저장합니다.
	            file.transferTo(destinationFile);
	            
	            // DB에 이미지 정보를 저장합니다.
	            ItemImageDTO img = new ItemImageDTO();
	            img.setImageUrl("/upload/" + fileName); // 웹에서 접근할 URL 경로
	            img.setItemId(dto.getId());
	            itemDAO.insertItemImage(img);
	        }
	    }
	    
	    return true;
	}
}
