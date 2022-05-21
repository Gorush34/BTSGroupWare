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
		
	//반려의견 담는 곳
	let opinion = "";
	
	$(document).ready(function() {
		
		// 검색타입 및 검색어 유지시키기
		if(${searchWord != null}) {
			// 넘어온 paraMap 이 null 이 아닐 때 (값이 존재할 때)
			$("select#searchType").val("${searchType}");
			$("input#searchWord").val("${searchWord}");
		}
		
		if(${searchWord != null}) {
			$("select#searchType").val("subject");
			$("input#searchWord").val("");
		}
		
		$("span.view").click(function(){
			
			var pk_att_num = $(this).parent().parent().find("span#num").text();
			console.log(pk_att_num);
			
			viewReport(pk_att_num);
		})
		
		
		$("button#showOpinion").click(function(){
			opinion = $(this).parent().find("input#fin_app_opinion").val();
			 $("input#opinion").val(opinion);
			
			$('#modal_app_opinion').modal('show'); // 모달창 보여주기	
		})
		
	});
	
	// Function Declaration
	function viewReport(pk_att_num) {
		
		location.href="<%= ctxPath%>/att/viewReport.bts?pk_att_num="+pk_att_num; 
		
	} // end of function viewReport(pk_att_num)-----------------------
	
	// 검색 버튼 클릭시 동작하는 함수
	function goSearch() {
		const frm = document.allAttListSelectFrm;
		frm.method = "GET";
		frm.action = "<%= ctxPath%>/att/viewAllReport.bts";
		frm.submit();	
	}// end of function goMailSearch(){}-------------------------
	
</script>

<div class="container_myAtt">
    
    
    <%-- 공가/경조신청내역 시작 --%>
    <div class="row" style="padding-left:15px;">
        <div class="col-xs-12" style="width:90%;">
        	<div id="title" style="margin-bottom: 20px;">
        		<span style="font-size: 24px; margin-bottom: 20px; font-weight: bold;">전체 공가 / 경조신청내역</span>
        		<br>
        		<span style="margin-bottom: 20px; "> ※ 현재 시스템에 표기된 연자일수는 관리의 편의상 <b>회계연도</b> 기준으로 계산되었으며, <b>퇴사 시</b> 입사일 기준으로 <b>재정산</b> 합니다.</span>
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
			      		  	  <span style="text-align: center;">결재대기</span>
			      		  </c:if>
			      		  <c:if test="${myAtt.approval_status eq 1}">
				      		  <span style="text-align: center; color:red;">반려</span>
				      		  <button type="button" class="btn btn-secondary btn-sm mr-3" id="showOpinion"  style="margin-left: 15px; margin-top: 10px; width:80px; height:30px;">의견보기</button>
			      		  </c:if>
			      		  <c:if test="${myAtt.approval_status eq 2}">
			      		  	<span style="text-align: center; color:blue;">결재완료</span>
			      		  	<button type="button" class="btn btn-secondary btn-sm mr-3" id="showOpinion"  style="margin-left: 15px; margin-top: 10px; width:80px; height:30px;">의견보기</button>
			      		  </c:if>
			      		  <input type="hidden" id="fin_app_opinion" name="fin_app_opinion" value="${myAtt.fin_app_opinion}" />
				      </td>
				    </tr>
				    </c:forEach>
				    </c:if>
				    
				    <c:if test="${ empty requestScope.myAttList }">
				    <tr>
				    	<td colspan="9" style="text-align: center; height: 100px; font-size: 20px;" >신청한 공가/경조내역이 없습니다.</td>
				    </tr>
				  	</c:if>
				  </tbody>
				  
			</table>
			<div style="width: 90%;" >
			    <form name="allAttListSelectFrm" style="display: inline;">
					<select class="form-control" id="searchType" name="searchType" style="width:100px;">
						<option value="ko_depname" selected="selected">부서</option>
						<option value="fk_emp_no">상신자 사번</option>
						<option value="emp_name">상신자</option>
					</select>
					<input id="searchWord" name="searchWord" type="text" class="form-control" style="width:250px;" placeholder="내용을 입력하세요.">
					<button type="button" style="margin-bottom: 5px" id="btnSearch" class="btn btn-secondary" onclick="goSearch();">
						<i class="fa fa-search" aria-hidden="true" style="font-size:15px;"></i>
					</button>
				</form>		
		    </div>
			<%-- === #122. 페이지바 보여주기 === --%>
			<c:if test="${not empty requestScope.myAttList }">
		    <div align="center" style="border: solid 0px gray; width: 70%; margin: 20px auto;">
			  ${requestScope.pageBar}
		    </div>
		    </c:if>
		    
        </div>
    </div>
    <%-- 공가/경조신청내역 끝 --%>
    
    <%-- === 의견보기 모달 === --%>
	<div class="modal fade" id="modal_app_opinion" role="dialog" data-backdrop="static">
	  <div class="modal-dialog">
	    <div class="modal-content">
	    
	      <!-- Modal header -->
	      <div class="modal-header">
	        <h4 class="modal-title">결재자 의견</h4>
	        <button type="button" class="close modal_close" data-dismiss="modal">&times;</button>
	      </div>
	      
	      <!-- Modal body -->
	      <div class="modal-body">
	       	<form name="modal_frm">
	       	<table style="width: 100%;" class="table table-bordered">
	     			<tr>
	     				<td style="text-align: center; padding-top: 48px;">의견</td>
	     				<td style="text-align: left; padding-left: 5px;">
	     					<input type="text" name="opinion" id="opinion" style="width:100%; height: 100px; word-break: break-all;"  readonly />
	     				</td>
	     			</tr>
	     		</table>
	       	</form>	
	      </div>
	      
	      <!-- Modal footer -->
	      <div class="modal-footer">
	          <button type="button" class="btn btn-danger btn-sm modal_close" data-dismiss="modal">닫기</button>
	      </div>
	      
	    </div>
	  </div>
	</div>
    
</div>