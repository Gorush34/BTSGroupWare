<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
    
<%
    String ctxPath = request.getContextPath();
    //    /bts
%>

<style type="text/css">

	span.subject
	{cursor: pointer;}
	
	a { text-decoration: none !important}

</style>

<script type="text/javascript">

// function declaration 

	// 검색 버튼 클릭시 동작하는 함수
	function gomailSearch() {
		const frm = document.goSendListSelectFrm;
		frm.method = "GET";
		frm.action = "<%= ctxPath%>/mail/mailSendList.bts";
		frm.submit();	
	}// end of function goMailSearch(){}-------------------------

	// 글제목 클릭 시 글내용 보여주기 (고유한 글번호인 pk_mail_num 를 넘겨준다.)
	function goSendMailView(pk_mail_num) {
		const searchType = $("select#searchType").val();
		const searchWord = $("input#searchWord").val();
		
		location.href = "<%= ctxPath%>/mail/mailSendDetail.bts?pk_mail_num="+pk_mail_num+"&searchType="+searchType+"&searchWord="+searchWord;
<%-- 	<a href="<%= ctxPath%>/mail/mailSendDetail.bts?searchType=${}&searchWord=${}&pk_mail_num=${}">${mailvo.subject}</a> --%>
	}
	
	
	
</script>

<%-- 보낸 메일함 목록 보여주기 --%>	
<div class="container" style="width: 100%; margin: 50px;">
	<div class="row bg-title" style="border-bottom: solid 1.5px #e6e6e6;">	
		<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
			<h4 class="page-title" style="color: black;">보낸 메일함</h4>
		</div>
		
		<form name="goSendListSelectFrm" style="display: inline-block; padding-left: 470px;">		
			<div id="mail_searchType">
				<select class="form-control" id="searchType" name="searchType" style="">
					<option value="subject" selected="selected">제목</option>
					<option value="empname">사원명</option>
				</select>
			</div>
			
			<div id="mail_serachWord">
				<input id="searchWord" name="searchWord" type="text" class="form-control" placeholder="내용을 입력하세요.">
			</div>
			
			<button type="button" style="margin-bottom: 5px" id="btnSearch" class="btn btn-secondary" onclick="gomailSearch()">
				<i class="fa fa-search" aria-hidden="true" style="font-size:15px;"></i>
			</button>
		</form>				
	</div>
	
	<div class="row">
		<div class="col-sm-12">
			<div class="white-box" style="padding-top: 5px;">
				<div id="secondHeader">
					<ul id="secondHeaderGroup" style="padding: 0px; margin-left: -10px;">
						<li class="secondHeaderList">
							<button type="button" id="delTrash" onclick="goMailDelRecyclebin()">
							<i class="fa fa-trash-o fa-fw"></i>
								삭제
							</button>
						</li>
						<li class="secondHeaderList">
							<button type="button" id=readSend onclick="goReadSend()">
							<i class="fa fa-envelope-o fa-fw"></i>
								읽음
							</button>
						</li>
					</ul>
				</div>
				
				<div class="table-responsive" style="color: black;">
					<table>
						<thead>
							<tr>
								<th style="width: 2%;">
									<input type="checkbox" id="checkAll" />
								</th>
								<th style="width: 2%;">
									<span class="fa fa-star-o"></span>
								</th>
								<th style="width: 2%;">
									<span class="fa fa-paperclip"></span>
								</th>
								<th style="width: 10%;" class="text-center">받는이</th>
								<th style="width: 70%;">제목</th>
								<th style="width: 20%;" class="text-left">날짜</th>
							</tr>
						</thead>
						
						<tbody>
						<c:forEach items="${requestScope.sendMailList}" var="sendMailList">
							<tr>
								<td style="width: 40px;">
									<input type="checkbox" id="checkAll" class="text-center"/>
								</td>
								<td style="width: 40px;">
									<span class="fa fa-star-o" class="text-center"></span>
								</td>
								<td style="width: 40px;">
									<span class="fa fa-paperclip" class="text-center"></span>
								</td>							
								<td class="text-center">${requestScope.empname}</td>
								<td>
								<%--
								<a href="<%= ctxPath%>/mail/mailSendDetail.bts?searchType=${}&searchWord=${}&pk_mail_num=${}">${sendMailList.subject}</a>
								--%>
								<span class="subject" onclick="goSendMailView('${sendMailList.pk_mail_num}')">${sendMailList.subject}</span>
								</td>
								<td class="text-left">${sendMailList.reg_date}</td>
							</tr>	
						</c:forEach>																				
						</tbody>
					</table>
				</div>	
				
				<%-- 페이징 처리하기 --%>
				<div align="center" style="border: solid 0px gray; width: 70%; margin: 20px auto;" >
					${requestScope.pageBar}
				</div>							
			</div>
		</div>	
	</div>
</div>