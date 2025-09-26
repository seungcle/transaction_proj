package subak.example.subak.component;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import subak.example.subak.domain.ItemRequestDTO;
import subak.example.subak.domain.TransactionDTO;
import subak.example.subak.dao.ItemDAO;
import subak.example.subak.dao.TransactionDAO;
import subak.example.subak.service.NotificationService;
import subak.example.subak.domain.NotificationDTO;

@Component
public class ItemScheduler {

    @Autowired
    TransactionDAO transactionDAO;

    @Autowired
    ItemDAO itemDAO;

    @Autowired
    NotificationService notificationService;

    @Scheduled(fixedDelay = 10000)
    public void processExpiredItems() {
        List<ItemRequestDTO> list = itemDAO.searchEndTime();

        if (list.isEmpty()) {
            System.out.println("처리할 만료 아이템이 없습니다.");
            return;
        }

        System.out.println("총 " + list.size() + "개의 만료 아이템을 처리합니다.");

        for (ItemRequestDTO item : list) {
            System.out.println("아이템 ID: " + item.getId() + " 처리 중...");
            try {
                long startPrice = 0;
                String startPriceStr = item.getStartPrice();
                if (startPriceStr != null) {
                    startPrice = Long.parseLong(startPriceStr.replaceAll(",", ""));
                }
                
                // 알림 URL 생성 
                String itemUrl = "/subak/item/" + item.getId();

                // 만료 아이템 유찰 처리
                if (item.getCurrentPrice() == null || item.getCurrentPrice() == startPrice) {
                    itemDAO.updateStatus(item.getId(), "FAILED");
                    System.out.println("아이템 ID: " + item.getId() + " 유찰 처리 완료.");

                    //판매자 알림
                    NotificationDTO notification = new NotificationDTO();
                    notification.setUserId(item.getSellerId());
                    notification.setItemId(item.getId());
                    notification.setContent("회원님의 아이템이 유찰되었습니다.");
                    notification.setUrl(itemUrl);
                    notificationService.sendNotification(notification);
                    
                    continue;
                }

                // 정상 낙찰 처리
                TransactionDTO dto = new TransactionDTO();
                dto.setItemId(item.getId());
                dto.setPrice(item.getCurrentPrice());
                dto.setUserId(item.getWinnerId());

                transactionDAO.createTransaction(dto);
                itemDAO.updateStatus(item.getId(), "CLOSED");

                System.out.println("아이템 ID: " + item.getId() + " 정상 낙찰 처리 완료.");

                // 판매자 알림 
                NotificationDTO sellerNotification = new NotificationDTO();
                sellerNotification.setUserId(item.getSellerId());
                sellerNotification.setItemId(item.getId());
                sellerNotification.setContent("회원님의 아이템이 정상적으로 낙찰되었습니다.");
                sellerNotification.setUrl(itemUrl); 
                notificationService.sendNotification(sellerNotification);

                // 낙찰자 알림 로직
                NotificationDTO winnerNotification = new NotificationDTO();
                winnerNotification.setUserId(item.getWinnerId());
                winnerNotification.setItemId(item.getId());
                winnerNotification.setContent("회원님께서 입찰하신 아이템이 최종 낙찰되었습니다.");
                winnerNotification.setUrl(itemUrl); 
                notificationService.sendNotification(winnerNotification);

            } catch (Exception e) {
                System.err.println("아이템 ID " + item.getId() + " 처리 중 오류 발생: " + e.getMessage());
            }
        }

        System.out.println("만료 아이템 처리가 완료되었습니다.");
    }
}