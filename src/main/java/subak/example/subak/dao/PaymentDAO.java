package subak.example.subak.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import subak.example.subak.domain.PaymentDTO;

import java.util.List;

@Mapper
public interface PaymentDAO {


    int insertPayment(PaymentDTO payment);

    // id로 결제 정보 조회
    PaymentDTO selectPaymentById(@Param("id") int id);

    // itemId 로 결제 정보 조회
    PaymentDTO selectPaymentByItemId(@Param("itemId") int itemId);

    // 전체 결제 내역 조회
    List<PaymentDTO> selectAllPayments();

    // 결제 상태 업데이트
    int updatePaymentStatus(
            @Param("id") int id,
            @Param("tossPaymentStatus") String tossPaymentStatus
    );

    // 결제 삭제
    int deletePayment(@Param("id") int id);

	Long getBidId(String paymentKey);
}
