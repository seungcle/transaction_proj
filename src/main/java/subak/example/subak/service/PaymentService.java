package subak.example.subak.service;

import org.springframework.stereotype.Service;
import org.springframework.beans.factory.annotation.Autowired;
import subak.example.subak.dao.PaymentDAO;
import subak.example.subak.domain.PaymentDTO;

import java.util.List;

@Service
public class PaymentService {

    private final PaymentDAO paymentDAO;

    @Autowired
    public PaymentService(PaymentDAO paymentDAO) {
        this.paymentDAO = paymentDAO;
    }

    // 결제 등록
    public int insertPayment(PaymentDTO payment) {
        return paymentDAO.insertPayment(payment);
    }

    // id로 결제 조회
    public PaymentDTO getPaymentById(int id) {
        return paymentDAO.selectPaymentById(id);
    }

    // bidId로 결제 조회
    public PaymentDTO getPaymentByBidId(int bidId) {
        return paymentDAO.selectPaymentByBidId(bidId);
    }

    // 전체 결제 내역 조회
    public List<PaymentDTO> getAllPayments() {
        return paymentDAO.selectAllPayments();
    }

    // 결제 상태 업데이트
    public int updatePaymentStatus(int id, String tossPaymentStatus) {
        return paymentDAO.updatePaymentStatus(id, tossPaymentStatus);
    }

    // 결제 삭제
    public int deletePayment(int id) {
        return paymentDAO.deletePayment(id);
    }
}
