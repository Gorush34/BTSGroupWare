<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
    
<%
    String ctxPath = request.getContextPath();
    //    /bts
%>

<style type="text/css">

/* 테이블 */
  table, th, td, input, textarea {border: solid #a0a0a0 0px;}
  
  #table {border-collapse: collapse;
          width: 1175px;         
          }
          
  #table th, #table td{padding: 5px;}
  #table th{ 
  		color: ;
  }

/*버튼 */   
  .buttonList {
  		display: inline-block;
  		list-style-type: none; 		
  }
 
  #buttonGroup {
  		padding: 0px;
  		margin-top: 5px;
  }
  
    button {
  		border-radius: 3px !important;
  } 
  
    ul#mailReservationDetailGroup, .detailList {
  	 list-style-type: none;
  }

</style>

<script src="<%= request.getContextPath()%>/resources/plugins/bower_components/jquery/dist/jquery.min.js"></script>

<script type="text/javascript">

$(document).ready(function (){
	// 문서가 준비되면 매개변수로 넣은 콜백함수 실행하기
	
	
});

</script>

<div class="container" style="width: 100%; margin: 50px;">
		<div class="row bg-title" style="border-bottom: solid 1.5px #e6e6e6;">	
			<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12" style="padding: 0px;">
				<h4 class="page-title" style="color: black;">예약 메일함</h4>
			</div>	
			<div id="goList">
				<button type="button" id="btnGoList" class="btn btn-secondary btn-sm" onclick="location.href='<%= ctxPath%>/mail/mailReservationList.bts'" style="margin-left: 1070px; margin-bottom:10px ">
				<i class="fa fa-reorder"></i>
				목록
				</button>
			</div>	
		</div>	
	
	<div class="mailDetailWrap" style="width: 100%;">
		<div class="" style="margin-left: -50px">
			<ul class="mailReservationDetailGroup">
				<li id="title" class="detailList">
					<h5 style="font-weight: bold; padding:10px 0 20px 0">${requestScope.mailvo.subject}</h5>
				</li>
				<li id="sender" class="detailList">
					<span>보낸 사람 : </span>
					<span>${requestScope.mailvo.sendempname} < ${requestScope.mailvo.sendemail} > </span>
				</li>
				<li id="receiver" class="detailList">
					<span>받는 사람 : </span>
					<span>${requestScope.mailvo.recempname} < ${requestScope.mailvo.recemail} > </span>
				</li>
				<li id="sendDate" class="detailList">
					<span>발송 날짜 : </span>
					<span>${requestScope.mailvo.reservation_date}</span>
				</li>	
				<li id="attachFile" class="detailList">
					<span>첨부 파일 : </span>
					<span><a href="<%= request.getContextPath()%>/mail/download.bts?pk_mail_num=${requestScope.mailvo.pk_mail_num}">${requestScope.mailvo.orgfilename}</a></span>
					<br>
				</li>													
			</ul>
		</div>
		<div>
			<div style="margin-left: -10px; margin-top: 5px; border-top: solid 1.5px #e6e6e6;">
				<p style="word-break: break-all;">${requestScope.mailvo.content}</p>
			</div>
		</div>	


	<%-- 이전글, 다음글 영역 --%>
		<div style="margin-top: 500px;">
			<span class="move" onclick="''"><i class="fa fa-sort-desc" aria-hidden="true"></i>&nbsp;&nbsp;이전글제목 : 구매품의서</span>
			<hr>
			<span class="move" onclick="''"><i class="fa fa-sort-asc" aria-hidden="true"></i>&nbsp;&nbsp;다음글제목 : 안녕하세요 과장님.</span>			
			<br/>
		</div>
	</div>
</div>