<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에러</title>
<link rel="icon" type="image/png" href="../images/watermelon_icon.ico">
</head>
<body style="text-align: center">
	<h2>오류 발생했음</h2>
	<h3>금방 고치겠습니다. 기다려주세요</h3>
	<img src="../images/error1.png">
	<%
	String msg = "오류 원인 : " + exception;
	System.out.println("----------------------------------------");
	System.out.println(msg);
	System.out.println("----------------------------------------");
	exception.printStackTrace();
	%>
</body>
</html>






