<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
	// 	/bts
%>

<%-- ======= #28. tile2 중 sideinfo 페이지 만들기  ======= --%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 사이드바 부분 시작 --%>

<style type="text/css">

#mailBtn1 > a {
  color : black;
}

</style>

<script type="text/javascript">

			
</script>

	<div>
	   <div id="sidebar" style="font-size: 11pt;">
		 <h4>받은 메일함</h4>
		 	<ul style="list-style-type: none; padding: 10px;">
				<li style="margin-bottom: 15px;">
					<div id="mailBtn1" class="mailBtn"><a href="<%= ctxPath%>/mail/mailWrite.bts">메일쓰기</a></div>
				</li>
				<li style="margin-bottom: 15px;">
					<div id="mailBtn1" class="mailBtn"><a href="<%= ctxPath%>/mail/mailReceiveList.bts">받은메일함</a></div>
				</li>
				<li style="margin-bottom: 15px;">
					<div id="mailBtn1" class="mailBtn"><a href="<%= ctxPath%>/mail/mailSendList.bts">보낸메일함</a></div>
				</li>
				<li style="margin-bottom: 15px;">
					<div id="mailBtn1" class="mailBtn"><a href="<%= ctxPath%>/mail/mailWrite.bts">중요메일함</a></div>
				</li>
				<li style="margin-bottom: 15px;">
					<div id="mailBtn1" class="mailBtn"><a href="<%= ctxPath%>/mail/mailWrite.bts">임시보관함</a></div>
				</li>		
				<li style="margin-bottom: 15px;">
					<div id="mailBtn1" class="mailBtn"><a href="<%= ctxPath%>/mail/mailWrite.bts">예약메일함</a></div>
				</li>												
				<li style="margin-bottom: 15px;">
					<div id="mailBtn1" class="mailBtn"><a href="<%= ctxPath%>/mail/mailWrite.bts">휴지통</a></div>
				</li>															
			</ul>
			
		</div>
	</div>
	
<%-- 사이드바 부분 끝 --%>