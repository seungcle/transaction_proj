<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <title>결제 실패</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/payment.css">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
</head>

<body>
    <div class="wrapper">
        <div class="box_section" style="width: 450px; padding: 40px;">
            <img width="100px" src="https://static.toss.im/lotties/error-spot-no-loop-space-apng.png" />
            <h2 class="title" style="font-size: 1.8em; margin-bottom: 20px;">결제에 실패했어요</h2>
            
            <div class="p-grid typography--p" style="margin-top: 30px">
                <div class="p-grid-col text--left"><b>에러메시지</b></div>
                <div class="p-grid-col text--right" id="message">${message}</div>
            </div>
            <div class="p-grid typography--p" style="margin-top: 10px">
                <div class="p-grid-col text--left"><b>에러코드</b></div>
                <div class="p-grid-col text--right" id="code">${code}</div>
            </div>
            
            <button class="button" onclick="window.close()" style="margin-top: 30px;">결제창 닫기</button>
        </div>
    </div>
</body>
</html>
