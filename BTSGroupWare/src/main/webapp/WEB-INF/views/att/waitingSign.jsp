<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
 	String ctxPath = request.getContextPath();
	//     /board
%>

<style type="text/css">

	span.view:hover {
		cursor: pointer;
	}

</style>

<script type="text/javascript">
	
	$(document).ready(function() {
		
		$("span.view").click(function(){
			
			var pk_att_num = $(this).parent().parent().find("span#num").text();
			console.log(pk_att_num);
			
			viewReport(pk_att_num);
		})
		
	}); // end of $(document).ready(function() {})-----------------------------
	
	// Function Declaration
	function viewReport(pk_att_num) {
		
		location.href="<%= ctxPath%>/att/viewReport.bts?pk_att_num="+pk_att_num; 
		
	} // end of function viewReport(pk_att_num)-----------------------
	
	
</script>

<div class="container_myAtt">
    
    <%-- 결재대기문서 시작 --%>
    <div class="row" style="padding-left:15px;">
        <div class="col-xs-12" style="width:90%;">
        	<div id="title" style="margin-bottom: 20px;">
        		<span style="font-size: 24px; margin-bottom: 20px; font-weight: bold;">공가/경조신청 결재대기문서 목록</span>
        		<br>
        		<span style="margin-bottom: 20px; "> ※ 로그인되어진 사원이 최종결재권자인 공가/경조신청 내역들을 표시합니다.</span>
        	</div>
        	
        	<table class="table" id="tbl_vacList">
				  <thead class="thead-light">
				    <tr style="text-align: center;">
				      <th style="width:7%; text-align: center;">순번</th>
				      <th style="width:10%; text-align: center;">부서</th>
				      <th style="width:10%; text-align: center;">상신자사번</th>
				      <th style="width:7%; text-align: center;">상신자</th>
				      <th style="width:10%; text-align: center;">공가명</th>
				      <th style="width:10%; text-align: center;">일수</th>
				      <th style="width:18%; text-align: center;">휴가기간</th>
				      <th style="width:18%; text-align: center;">결재상황</th>
				      <th style="width:10%; text-align: center;">최종상태</th>
				    </tr>
				  </thead>
				  <tbody>
				  <c:if test="${ not empty requestScope.myAttList}">
				  <c:forEach var="myAtt" items="${requestScope.myAttList}" >
					<tr style="text-align: center;">
						
				      <td style="width:7%; text-align: center;"><span class="view" id="num" >${myAtt.pk_att_num}</span></td>
				      <td style="width:10%; text-align: center;"><span class="view">${myAtt.ko_depname}</span></td>
				      <td style="width:10%; text-align: center;"><span class="view">${myAtt.fk_emp_no}</span></td>
				      <td style="width:7%; text-align: center;"><span class="view">${myAtt.emp_name}</span></td>
				      <td style="width:14%; text-align: center;"><span class="view">${myAtt.att_sort_korname}</span></td>
				      <td style="width:10%; text-align: center;"><span class="view">${myAtt.vacation_days}일</span></td>
				      <td style="width:16%; text-align: center;"><span class="view">${myAtt.leave_start}&nbsp;~&nbsp;${myAtt.leave_end}</span></td>
				      <td style="width:16%; text-align: center;">
				      	<div id="dms_status" style="width: 80%; text-align: center; margin: 0 auto;">
					      	<table id="vac_dms" style="width: 100%;">
					      		<thead>
						      		<tr>
							      		<th>최종결재자</th>
						      		</tr>
					      		</thead>
					      		<tbody>
						      		<tr>
							      		<td>${myAtt.managername}(${myAtt.manager})</td>
						      		</tr>
						      		<tr>
							      		<td>
							      		<c:if test="${myAtt.approval_status eq 0}">
							      		결재대기
							      		</c:if>
							      		<c:if test="${myAtt.approval_status eq 1}">
							      		<span style="color:red;">반려</span>
							      		</c:if>
							      		<c:if test="${myAtt.approval_status eq 2}">
							      		<span style="color:blue;">결재완료</span>
							      		</c:if>							      		
							      		</td>
						      		</tr>
						      	</tbody>
					      	</table>
				      	</div>
				      </td>
				      <td style="width:10%; text-align: center;">
					      <c:if test="${myAtt.approval_status eq 0}">
			      		    결재대기
			      		  </c:if>
			      		  <c:if test="${myAtt.approval_status eq 1}">
			      		  <span style="color:red;">반려</span>
			      		  </c:if>
			      		  <c:if test="${myAtt.approval_status eq 2}">
			      		  <span style="color:blue;">결재완료</span>
			      		  </c:if>
				      </td>
				    </tr style="text-align: center;">
				    </c:forEach>
				    </c:if>
				    
				    <c:if test="${ empty requestScope.myAttList }">
				    <tr>
				    	<td colspan="9" style="text-align: center; height: 100px; font-size: 20px;" >결재대기중인 공가/경조내역이 없습니다.</td>
				    </tr>
				  	</c:if>
				  
				  </tbody>
				  
			</table>
			
			<%-- === #122. 페이지바 보여주기 === --%>
			<c:if test="${not empty requestScope.myAttList }">
		    <div align="center" style="border: solid 0px gray; width: 70%; margin: 20px auto;">
			  ${requestScope.pageBar}
		    </div>
		    </c:if>
        </div>
    </div>
    <%-- 공가/경조신청내역 끝 --%>
    
</div>