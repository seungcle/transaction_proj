<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <title>결제 완료</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/payment.css">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
</head>

<body>
    <div class="wrapper">
        <div class="box_section" style="width: 450px; padding: 40px;">
            <img width="100px" src="https://static.toss.im/illusts/check-blue-spot-ending-frame.png" />
            <h2 class="title" style="font-size: 1.8em; margin-bottom: 20px;">결제가 완료되었어요</h2>
            <p class="p" style="font-size: 1.0em;">서비스를 계속 이용해 주세요.</p>
            <button class="button" onclick="window.close()">결제창 닫기</button>
        </div>
    </div>

    <script>
        (function() {
            // 모델에서 넘어온 값
            const price = ${price};
            const itemId = ${itemId};
            const sellerId = ${sellerId};

            // 페이지 로드 시 바로 컨트롤러 호출
            fetch("${pageContext.request.contextPath}/item/bid", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: new URLSearchParams({
                    price: price,
                    itemId: itemId,
                    sellerId: sellerId
                })
            })
            .then(res => res.text())
            .then(msg => {
                console.log("입찰 결과:", msg);
                if (window.opener) {
                    window.opener.location.reload();
                }
            })
            .catch(err => console.error(err));
        })();
        
    </script>
</body>
</html>
