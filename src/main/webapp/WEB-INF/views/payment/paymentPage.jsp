<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <title>입찰 결제 페이지</title>
    <script src="https://js.tosspayments.com/v2/standard"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/payment.css">
</head>
<body>
    <div class="wrapper">
        <div class="box_section">
            <h1 class="title">입찰 결제</h1>
            <p class="p">유저 이름: <strong class="color--grey800">${userName}</strong></p>
            <p class="p">입찰 금액: <strong class="color--blue500" id="display-price"></strong></p>

            <div id="payment-method"></div>
            <div id="agreement"></div>
            
            <div class="payment-button-area">
                <button class="button" id="payment-button">결제하기</button>
            </div>
        </div>
    </div>
    
    <script>
        main();

        async function main() {
            const button = document.getElementById("payment-button");

            // ------ 금액 표시 형식 설정 ------
            const price = parseInt("${price}", 10);
            const formattedPrice = new Intl.NumberFormat('ko-KR').format(price);
            document.getElementById('display-price').textContent = formattedPrice + '원';

            // ------ Toss Payments 초기화 ------
            const clientKey = "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm";
            const tossPayments = TossPayments(clientKey);

            // 회원 결제용 customerKey 
            const customerKey = "${userName}";
            const widgets = tossPayments.widgets({ customerKey: customerKey });

            // ------ 주문 금액 설정 ------
            await widgets.setAmount({
                currency: "KRW",
                value: price
            });

            // ------ 결제/약관 UI 렌더링 ------
            await Promise.all([
                widgets.renderPaymentMethods({ selector: "#payment-method", variantKey: "DEFAULT" }),
                widgets.renderAgreement({ selector: "#agreement", variantKey: "AGREEMENT" })
            ]);

            // ------ 결제 버튼 클릭 ------
            button.addEventListener("click", async function () {
                await widgets.requestPayment({
                    orderId: 'BID-${pageContext.session.id}-<%= System.currentTimeMillis() %>',
                    orderName: '${userName}님의 입찰 결제',
                    successUrl: window.location.origin + "/subak/payment/success?itemId=${itemId}&sellerId=${sellerId}",
                    failUrl: window.location.origin + "/subak/payment/fail",
                    customerName: '${userName}',
                });
            });
        }
    </script>
</body>
</html>
