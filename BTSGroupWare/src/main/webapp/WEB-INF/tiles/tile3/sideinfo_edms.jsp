<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%-- ======= 파이널 프로젝트 bts 사이드 인포  ======= --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	String ctxPath = request.getContextPath();
%>

<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<ul class="nav flex-column">
	<li class="nav-item"><span class="edms-title h2">전자결재</span></li>
	<li class="nav-item"><a class="nav-link active" href="<%=ctxPath%>/test/edmsHome.bts">전자결재 홈</a></li>
	<li class="nav-item"><a class="nav-link active" href="<%=ctxPath%>/test/edmsAdd.bts">문서작성</a></li>
	<li class="nav-item"><a class="nav-link" href="<%=ctxPath%>/test/edmsMydoc.bts">내문서함</a></li>
	<li class="nav-item"><a class="nav-link" href="<%=ctxPath%>/test/edmsApprove.bts">결재하기</a></li>
</ul>

</body>
</html>