<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
    
<%
    String ctxPath = request.getContextPath();
    //    /bts
%>

<style type="text/css">
  
    ul#mailReceiveDetailGroup, .detailList {
  	 list-style-type: none;
  }
	
	#btnRecChk {
	border: 1px solid black; background-color: rgba(0,0,0,0); color: black; margin-left: 1px;
	}
   
	span.move{cursor: pointer; color: black;}

</style>

<script src="<%= request.getContextPath()%>/resources/plugins/bower_components/jquery/dist/jquery.min.js"></script>

<script type="text/javascript">

$(document).ready(function (){
	// 문서가 준비되면 매개변수로 넣은 콜백함수 실행하기
	
	
});

	// function declaration
	// '답장' 버튼 클릭 시 해당 글의 번호를 보내고, 그 글의 글제목, 내용을 가져와서 글 수정후 메일쓰기 가능하도록 하기. (+"&searchType="+searchType+"&searchWord="+searchWord)
	function btnGoReply(pk_mail_num) {		
		location.href="<%= ctxPath%>/mail/mailReply.bts?pk_mail_num="+pk_mail_num;
	}
	// '전달' 버튼 클릭 시 해당 글의 번호를 보내고, 그 글의 글제목, 내용을 가져와서 글 수정후 메일쓰기 가능하도록 하기. (+"&searchType="+searchType+"&searchWord="+searchWord)
	// /bts/mail/mailReceiveDetail.bts?pk_mail_num=141&searchType=subject&searchWord=
	function btnGoForward(pk_mail_num){		
		location.href="<%= ctxPath%>/mail/mailForward.bts?pk_mail_num="+pk_mail_num;
	}
	
	// 메일 상세내용에서 삭제버튼 클릭 시 휴지통으로 이동하기 (?pk_mail_num="+pk_mail_num;)
	function btnGodeleteOne(pk_mail_num) {
		location.href="<%= ctxPath%>/mail/mailMoveToRecyclebin_one.bts?pk_mail_num="+pk_mail_num;
	}
		
</script>

<div class="col-xs-10" id="mailListDetailCss">
		<div style="border-bottom: solid 1.5px #e6e6e6;">	
			<div>
				<h4 style="color: black;">받은 메일함</h4>
			</div>	
			<div id="goList">
				<%-- 답장 클릭 시, 보낸 사람 및 내용에 이전에 썼던 내용을 유지해야 함. --%>
				<button type="button" id="btnGoReply" class="btn btn-secondary btn-sm" style="margin-bottom: 5px;" onclick="btnGoReply('${requestScope.mailvo.pk_mail_num}')">
				답장
				</button>
				<%-- 전달 클릭 시, 이전에 썼던 내용을 유지해야 함. --%>
				<button type="button" id="btnGoForward" class="btn btn-secondary btn-sm" style="margin-bottom: 5px;" onclick="btnGoForward('${requestScope.mailvo.pk_mail_num}')">
				전달
				</button>	
				<%-- 글 1개 삭제하기 --%>	
				<button type="button" id="btnGodeleteOne" class="btn btn-secondary btn-sm" style="margin-bottom: 5px;" onclick="btnGodeleteOne('${requestScope.mailvo.pk_mail_num}')">
				삭제
				</button>					
				<button type="button" id="btnGoList" class="btn btn-secondary btn-sm" onclick="location.href='<%= ctxPath%>/mail/mailReceiveList.bts'" style="margin-left: 1260px; margin-bottom: 5px; ">
				목록
				</button>
			</div>	
		</div>	
	
	<div class="mailDetailWrap" style="width: 100%;">
		<div class="col-sm-12" style="margin-left: -60px">
			<ul class="mailReceiveDetailGroup">
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
					<span>보낸 날짜 :</span>
					<c:if test="${not empty requestScope.mailvo.reservation_date}">
							${requestScope.mailvo.reservation_date}
					</c:if>
					<c:if test="${empty requestScope.mailvo.reservation_date}">
							${requestScope.mailvo.reg_date}
					</c:if>
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
		<div style="margin-top: 400px;">
			<span class="move" onclick="javascript:location.href='mailReceiveDetail.bts?pk_mail_num=${requestScope.mailvo.prev_seq}&searchType=${requestScope.paraMap.searchType}&searchWord=${requestScope.paraMap.searchWord}'"><i class="fa fa-sort-desc" aria-hidden="true"></i>&nbsp;&nbsp;이전 메일 : ${requestScope.mailvo.prev_subject}</span>
			<hr>
			<span class="move" onclick="javascript:location.href='mailReceiveDetail.bts?pk_mail_num=${requestScope.mailvo.next_seq}&searchType=${requestScope.paraMap.searchType}&searchWord=${requestScope.paraMap.searchWord}'"><i class="fa fa-sort-desc" aria-hidden="true"></i>&nbsp;&nbsp;다음 메일 : ${requestScope.mailvo.next_subject}</span>
			<br/>
		</div>
	</div>
</div>