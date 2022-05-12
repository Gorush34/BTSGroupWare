<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
 	String ctxPath = request.getContextPath();
	//     /board
%>

<style type="text/css">

</style>

<script type="text/javascript">
	
	$(document).ready(function() {
		
		
		
	}); // end of $(document).ready(function() {})-----------------------------
	
	// Function Declaration
	
</script>
		
<div class="container_myAtt">
    <%-- 공가/경조신청서 상세 시작 --%>
    <div class="row" style="padding-left:15px;">
        <div class="col-xs-12" style="width:90%;">
        <form name="reportVacationFrm" enctype="multipart/form-data">
        <c:set var="vac" value="${requestScope.vacReportList.get(0)}" />
        	<div id="title" style="margin-bottom: 20px;">
        		<span style="font-size: 24px; margin-bottom: 20px; margin-right:20px; font-weight: bold;">공가 /연가 신청서</span>
        	</div>
        	<table class="table" id="tbl_reportVacation">
				    <tr style="text-align: center;">
				      <th class="th_title" style="text-align: center;">상신자 사번</th>
				      <td style="text-align: left;">${vac.fk_emp_no}</td>
				      <th class="th_title" style="text-align: center;">상신자 성명</th>
				      <td style="text-align: left;">${vac.emp_name}</td>
				    </tr>
				    
				    <tr style="text-align: center;">
				      <th class="th_title" style="text-align: center;">소속</th>
				      <td style="width:35%; text-align: left;">${vac.ko_depname}</td>
				      <th class="th_title" style="text-align: center;">직급</th>
				      <td style="width:25%; text-align: left;">${vac.ko_rankname}</td>
				    </tr>
				    
				    <tr style="text-align: center;">
				      <th class="th_title" style="text-align: center;">휴가종류</th>
				      <td style="width:35%; text-align: left;">${vac.att_sort_korname}</td>
				      <th class="th_title" style="text-align: center;">휴가기간</th>
				      <td style="width:25%; text-align: left;">${vac.leave_start}&nbsp;~&nbsp;${vac.leave_end}(${vac.vacation_days}일)</td>
				    </tr>
				    <tr style="text-align: center; " id="bold_hr">
				      <th class="th_title" style="text-align: center;">증빙서류</th>
				      <td style="width:35%; text-align: left;">${vac.leave_start}</td>
				      <th class="th_title" style="text-align: center;">결재상태</th>
				      <td style="width:25%; text-align: left;">
					    <c:if test="${vac.approval_status eq 0}">
			      	        	결재대기
			      		</c:if>
			      		<c:if test="${vac.approval_status eq 1}">
			      			<span style="color:red;">반려</span>
			      		</c:if>
			      		<c:if test="${vac.approval_status eq 2}">
			      			<span style="color:blue;">결재완료</span>
			      		</c:if>	
					  </td>
				    </tr>
				    
				    <tr style="text-align: center; " id="bold_hr">
				      <th class="th_title" style="text-align: center;">휴가사유</th>
				      <td colspan="3" style="text-align: left;">
				      	<input type="text" id="att_content" name="att_content" style="width: 80%; height: 100px;" value="${vac.att_content}" readonly />			    
				      </td>
				    </tr>
				    	
			</table>
		
		<div id="title" style="margin-bottom: 20px;">
       		<span style="font-size: 24px; margin-bottom: 20px; margin-right:20px; font-weight: bold;">결재승인 / 반려</span>
       	</div>
		<table class="table" id="tbl_reportVacation">
			    <tr style="text-align: center;">
			      <th class="th_title" style="text-align: center;">결재자 사번</th>
			      <td style="width:35%; text-align: left;">${vac.manager}</td>
			      <th class="th_title" style="text-align: center;">결재자 성명</th>
			      <td style="width:25%; text-align: left;">${vac.managername}</td>
			    </tr>
			    <tr style="text-align: center; " id="bold_hr">
			      <th class="th_title" style="text-align: center;">결재자 직급</th>
			      <td colspan="3" style="text-align: left;">
			      	${vac.manager_rankname}
			      </td>
			    </tr>
			    
			    <tr style="text-align: center; " id="bold_hr">
			      <th class="th_title" style="text-align: center;">의견작성란</th>
			      <td colspan="3" style="text-align: left;"><input type="text" id="fin_app_opinion" name="fin_app_opinion" style="width: 80%; height: 100px;"/>			    
			      </td>
			    </tr>
			    	
		</table>
			
		<div id="vac_button" style="text-align: center;">
			<button type="button" class="btn btn-primary btn-sm mr-3" id="btnReportVacation" onclick="signOff();" style="margin-right: 20px; width:80px; height:30px;">승인</button>
			<button type="button" class="btn btn-danger btn-sm mr-3" id="btnReportVacation" onclick="reject();" style="margin-right: 20px; width:80px; height:30px;">반려</button>
			<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnReportVacation" onclick="goList();" style="margin-right: 20px; width:80px; height:30px;">목록</button>
			<!-- <button type="button" class="btn btn-secondary btn-sm mr-3" id="btn_vac_certification" style="margin-right: 20px; width:80px; height:30px;">목록보기</button>  -->
				      	
		</div>	
		<input type="hidden" id="isManager" name="isManager" value="${requestScope.isManager}" />
		<input type="hidden" id="isDecided" name="isDecided" value="${requestScope.isDecided}" />
		<input type="hidden" id="uq_phone" name="uq_phone" value="${requestScope.uq_phone}" />
        </form>
        </div>
    </div>
    <%-- 공가/경조신청서 작성 끝 --%>
    
</div>