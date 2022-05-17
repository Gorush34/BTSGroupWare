<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String ctxPath = request.getContextPath(); %>

<style>
	a {
	color: gray;
	font-size: 12px;
	}
</style> 
    
<div class="container" style="text-align: center;">

	<div>메일이 휴지통으로 이동되었습니다.</div>
	<div><img src="<%= ctxPath%>/resources/images/mail/SendMailSuccess.png"></div>
	
	
	<a href="<%= ctxPath%>/mail/mailRecyclebinList.bts">휴지통으로 이동하기&nbsp;|</a>
	<a href="<%= ctxPath%>/mail/mailWrite.bts">메일쓰기</a>

</div>    