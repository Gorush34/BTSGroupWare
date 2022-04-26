<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/bts/test/test_insert.bts 페이지</title>
</head>
<body>
	<h2>/bts/test/test_insert.bts 페이지</h2>
	안녕하세요?<br><br>
	
	<c:if test="${requestScope.n eq 1}">
		<span style="color: blue; font-size: 16pt;">${requestScope.message}</span>
	</c:if>
	
	<c:if test="${requestScope.n ne 1}">
		<span style="color: red; font-size: 16pt;">${requestScope.message}</span>
	</c:if>
	
</body>
</html>