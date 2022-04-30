<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
	// 	/bts
%>

<%-- ======= #28. tile2 중 sideinfo 페이지 만들기  ======= --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 사이드바 부분 시작 --%>
<div class="sidebar">
  <a class="active" href="<%= ctxPath%>/mail/mailList.bts">홈</a>
  <a href="<%= ctxPath%>/mail/mailWrite.bts">메일쓰기</a>
  <a href="<%= ctxPath%>/mail/mailList.bts">받은메일함</a>
  <a href="">보낸메일함</a>
  <a href="#importantMail">중요메일함</a>
  <a href="#temporaryMail">임시보관함</a>
  <a href="#reserveMail">예약메일함</a>
  <a href="#recyclebinMail">휴지통</a>  
</div>
<%-- 사이드바 부분 끝 --%>