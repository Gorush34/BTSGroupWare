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
	   <div id="sidebar" style="font-size: 11pt; padding-left: 24px;">
		 <h4>사내 메일함</h4>
		 	<ul style="list-style-type: none; padding: 5px;">
				<li style="margin-bottom: 15px;">
					<div id="mailBtn1" class="mailBtn"><a href="<%= ctxPath%>/mail/mailWrite.bts"><i class="fa fa-pencil-square-o" aria-hidden="true"></i>&nbsp;&nbsp;메일쓰기</a></div>
				</li>
				<li style="margin-bottom: 15px;">
					<div id="mailBtn1" class="mailBtn"><a href="<%= ctxPath%>/mail/mailReceiveList.bts"><i class="fa fa-envelope" aria-hidden="true"></i>&nbsp;&nbsp;받은메일함</a></div>
				</li>
				<li style="margin-bottom: 15px;">
					<div id="mailBtn1" class="mailBtn"><a href="<%= ctxPath%>/mail/mailSendList.bts"><i class="fa fa-paper-plane" aria-hidden="true"></i>&nbsp;&nbsp;보낸메일함</a></div>
				</li>
				<li style="margin-bottom: 15px;">
					<div id="mailBtn1" class="mailBtn"><a href="<%= ctxPath%>/mail/mailWrite.bts"><i class="fa fa-star" aria-hidden="true"></i>&nbsp;&nbsp;중요메일함</a></div>
				</li>
				<li style="margin-bottom: 15px;">
					<div id="mailBtn1" class="mailBtn"><a href="<%= ctxPath%>/mail/mailWrite.bts"><i class="fa fa-folder" aria-hidden="true"></i>&nbsp;&nbsp;임시보관함</a></div>
				</li>		
				<li style="margin-bottom: 15px;">
					<div id="mailBtn1" class="mailBtn"><a href="<%= ctxPath%>/mail/mailWrite.bts"><i class="fa fa-clock-o" aria-hidden="true"></i>&nbsp;&nbsp;예약메일함</a></div>
				</li>												
				<li style="margin-bottom: 15px;">
					<div id="mailBtn1" class="mailBtn"><a href="<%= ctxPath%>/mail/mailWrite.bts"><i class="fa fa-file-text" aria-hidden="true"></i>&nbsp;&nbsp;내게쓴메일함</a></div>
				</li>	
				<li style="margin-bottom: 15px;">
					<div id="mailBtn1" class="mailBtn"><a href="<%= ctxPath%>/mail/mailRecyclebinList.bts"><i class="fa fa-trash" aria-hidden="true"></i>&nbsp;&nbsp;휴지통</a></div>
				</li>															
			</ul>
			
		</div>
	</div>
	
<%-- 사이드바 부분 끝 --%>