<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
    
<%
    String ctxPath = request.getContextPath();
    //    /bts
%>

<script type="text/javascript">

// function declaration 

// 검색 버튼 클릭시 동작하는 함수
	function gomailSearch() {
		const frm = document.goReceiveListSelectFrm;
		frm.method = "GET";
		frm.action = "<%= ctxPath%>/mail/mailReceiveList.bts";
		frm.submit();	
	}// end of function goMailSearch(){}-------------------------

</script>

<%-- 받은 메일함 목록 보여주기 --%>	
<div class="container" style="width: 100%; margin: 50px;">
	<div class="row bg-title" style="border-bottom: solid 1.5px #e6e6e6;">	
		<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
			<h4 class="page-title" style="color: black;">받은 메일함</h4>
		</div>
		
		<form name="goReceiveListSelectFrm" style="display: inline-block; padding-left: 470px;">		
			<div id="mail_searchType">
				<select class="form-control" id="searchType" name="searchType" style="">
					<option value="subject" selected="selected">제목</option>
					<option value="receiveuser_name">사원명</option>
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
							<button type="button" id="delTrash" onclick="goMailDelTrash()">
							<i class="fa fa-trash-o fa-fw"></i>
								삭제
							</button>
						</li>
						<li class="secondHeaderList">
							<button type="button" id=readReceive onclick="goReadReceive()">
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
								<th style="width: 10%;" class="text-center">사원명</th>
								<th style="width: 70%;">제목</th>
								<th style="width: 20%;" class="text-left">날짜</th>
							</tr>
						</thead>
						
						<tbody>
						<c:forEach items="${requestScope.receiveMailList}" var="receiveMailList">
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
								<td class="text-center">${receiveMailList.receiveuser_name}</td>
								<td>
								<a href="<%= ctxPath%>/mail/mailReceiveDetail.bts">${receiveMailList.subject}</a>
								</td>
								<td class="text-left">${receiveMailList.reg_date}</td>
							</tr>	
						</c:forEach>																				
						</tbody>
					</table>
				</div>	
				
				<%-- 페이징 처리하기 --%>
				<div align="center" style="border: solid 1px gray; width: 70%; margin: 20px auto;" >
					${requestScope.pageBar}
				</div>							
			</div>
		</div>	
	</div>
</div>