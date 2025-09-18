package subak.example.subak.component;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import subak.example.subak.domain.ItemRequestDTO;
import subak.example.subak.domain.TransactionDTO;
import subak.example.subak.dao.ItemDAO;
import subak.example.subak.dao.TransactionDAO;

@Component
public class ItemScheduler {
    
    @Autowired
    TransactionDAO transactionDAO;
    ItemDAO itemDAO;
    
    @Scheduled(fixedDelay = 10000)
    public void processExpiredItems() {
        // 1. DAO를 통해 만료된 아이템 목록을 조회합니다.
        // 이 메서드는 SQL 쿼리 'SELECT * FROM items WHERE end_time < NOW()' 를 실행한다고 가정합니다.
        List<ItemRequestDTO> list = itemDAO.searchEndTime();

        // 2. 만료된 아이템이 있는지 확인합니다. 
        if (list.isEmpty()) {
            System.out.println("처리할 만료 아이템이 없습니다.");
            return;
        }

        // 3. 만료된 아이템 목록을 순회하며 비즈니스 로직을 수행합니다.
        System.out.println("총 " + list.size() + "개의 만료 아이템을 처리합니다.");
        
        for (ItemRequestDTO item : list) {
            System.out.println("아이템 ID: " + item.getId() + " 처리 중...");
            try {
            	TransactionDTO dto = new TransactionDTO();
            	dto.setItemId(item.getId());
            	dto.setPrice(item.getCurrentPrice());
            	dto.setUserId(item.getSellerId());
            	
            	transactionDAO.createTransaction(dto);
            	itemDAO.updateStatus(item.getId());
            	
            	
            } catch (Exception e) {
                
                System.err.println("아이템 ID " + item.getId() + " 처리 중 오류 발생: " + e.getMessage());
            }
        }
        
        System.out.println("만료 아이템 처리가 완료되었습니다.");
    }
}