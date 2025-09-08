<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="${pageContext.request.contextPath}/join" method="post">
    <input type="text" name="username" placeholder="아이디" required>
    <input type="password" name="password" placeholder="비밀번호" required>
    <input type="email" name="email" placeholder="이메일" required>
    <input type="text" name="nickname" placeholder="닉네임" required>
    <button type="submit">회원가입</button>
    <c:if test="${not empty error}">
        <p style="color:red">${error}</p>
    </c:if>
</form>
</body>
</html>