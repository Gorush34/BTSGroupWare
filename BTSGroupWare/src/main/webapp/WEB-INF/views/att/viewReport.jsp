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
		
		// 로그인유저가 관리자인지 확인용 변수
		var isManager = $("input#isManager").val();
		// 해당 보고서가 결재완료 / 반려처리가 되었는지 확인용 변수
		var isDecided = $("input#isDecided").val();
		// 혹시 모를 연락처
		var uq_phone = $("input#uq_phone").val();
		// 반려버튼을 클릭했는지 확인용 변수
		var isRejected = 0;
		// 연차나 대체휴가의 경우 차감값 넣어주기
		var cnt = 0;
		// 대체휴가일 경우 휴가일수 넣어줌.
		var instead_vac_days = 0;
		// 로그인유저 번호
		var pk_emp_no = $("input#pk_emp_no").val();
		
		console.log("isManager : " + isManager);
		console.log("isDecided : " + isManager);
		console.log("매니저값 : " + $("input#manager").val());
		console.log("사원번호 : " + $("input#fk_emp_no").val());
		
		$("button#btnSignOff").hide();
		$("button#btnReject").hide();
		$("tr.managerOnly").hide();
		
		
		if( ( isManager == 1 && isDecided == 0
			&& $("input#manager").val() == $("input#fk_emp_no").val() )
			|| ( $("input#pk_emp_no").val() == "80000001" && $("input#approval_status").val() !=2 ) ) {
			
			$("button#btnSignOff").show();
			$("button#btnReject").show();
			$("tr.managerOnly").show();
		}
		
		
		// 연차나 대체휴가일 떄 차감개수 넣어주기
		if( $("input#minus_cnt").val() == "0.0" ) {
			cnt = $("input#vacation_days").val();
			$("input#minus_cnt").val(cnt);
		}
		
		// 결재 버튼 클릭시
		$("button#btnSignOff").click(function(){
			goSign();
		}) // end of $("button#btnSignOff").click(function(){})------------
		
		// 반려 버튼 클릭시
		$("button#btnReject").click(function(){
			
			if( $("input#fin_app_opinion").val().trim() == "" ) {
				alert("반려사유는 필수 입력사항입니다.");
				return;
			}
			else{
				isRejected = 1; // 반려사용시 값 지정
				$("input#isRejected").val(isRejected);
				
				var fin_app_opinion = $("input#fin_app_opinion").val().trim();
				
				fin_app_opinion = fin_app_opinion.replace(/<p><br><\/p>/gi, "<br>"); //<p><br></p> -> <br>로 변환
				fin_app_opinion = fin_app_opinion.replace(/<\/p><p>/gi, "<br>"); //</p><p> -> <br>로 변환  
				fin_app_opinion = fin_app_opinion.replace(/(<\/p><br>|<p><br>)/gi, "<br><br>"); //</p><br>, <p><br> -> <br><br>로 변환
				fin_app_opinion = fin_app_opinion.replace(/(<p>|<\/p>)/gi, ""); //<p> 또는 </p> 모두 제거시
				
				fin_app_opinion = fin_app_opinion.replaceAll("<", "&lt;");
				fin_app_opinion = fin_app_opinion.replaceAll(">", "&gt;");
				fin_app_opinion = fin_app_opinion.replaceAll("&", "&amp;");
				fin_app_opinion = fin_app_opinion.replaceAll("\\", "&quot;");
				
				$("input#fin_app_opinion").val(fin_app_opinion);
				
				goSign();
			}
		}) // end of $("button#btnSignOff").click(function(){})------------
		
	}); // end of $(document).ready(function() {})-----------------------------
	
	// Function Declaration
	
	// 결재완료 혹은 반려
	function goSign() {
		
		/*
		if( $("input#att_sort_korname").val().indexOf("대체") != "-1" ) {
			instead_vac_days = $("input#vacation_days").val();
		}
		else {
			instead_vac_days = $("input#vacation_days").val("0");
		}
		*/
		
		instead_vac_days = $("input#instead_vac_days").val();
		const frm = document.goSignFrm;
		frm.action = "<%= ctxPath%>/att/goSign.bts";
		frm.method = "POST";
		frm.submit();
	}
	
	function goList() {
		
		const frm = document.goSignFrm;
		frm.action = "<%= ctxPath%>/att/myAtt.bts";
		frm.method = "GET";
		frm.submit();
	}
	
	function goWaitingSign() {
		
		const frm = document.goSignFrm;
		frm.action = "<%= ctxPath%>/att/waitingSign.bts";
		frm.method = "GET";
		frm.submit();
	}
	
	function goDelete() {
		
		const frm = document.goSignFrm;
		frm.action = "<%= ctxPath%>/att/deleteReport.bts";
		frm.method = "POST";
		frm.submit();
	}
	
</script>
		
<div class="container_myAtt">
    <%-- 공가/경조신청서 상세 시작 --%>
    <div class="row" style="padding-left:15px;">
        <div class="col-xs-12" style="width:90%;">
        <form name="goSignFrm" enctype="multipart/form-data">
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
				      <td style="width:35%; text-align: left;">
							<span><a href="<%= ctxPath%>/att/download.bts?pk_att_num=${vac.pk_att_num}">${vac.orgfilename}</a></span>
					  </td>
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
			    <c:if test="${vac.approval_status eq 0}">
			    <tr style="text-align: center; " class="managerOnly" id="bold_hr">
			      <th class="th_title" style="text-align: center;">의견작성란</th>
			      <td colspan="3" style="text-align: left;"><input type="text" id="fin_app_opinion" name="fin_app_opinion" style="width: 80%; height: 100px;"/>			    
			      </td>
			    </tr>
			    </c:if>
			    <c:if test="${vac.approval_status ne 0}">
			    <tr style="text-align: center; " id="bold_hr">
			      <th class="th_title" style="text-align: center;">결재자의견</th>
			      <td colspan="3" style="text-align: left;"><input type="text" id="app_opinion" name="app_opinion" style="width: 80%; height: 100px; word-break: break-all;" value="${vac.fin_app_opinion}" readonly />			    
			      </td>
			    </tr>
			    </c:if>	
		</table>
			
		<div id="vac_button" style="text-align: center;">
			<button type="button" class="btn btn-primary btn-sm mr-3" id="btnSignOff" style="margin-right: 20px; width:80px; height:30px;">승인</button>
			<button type="button" class="btn btn-danger btn-sm mr-3" id="btnReject" style="margin-right: 20px; width:80px; height:30px;">반려</button>
			<c:if test="${sessionScope.loginuser.pk_emp_no != 80000001 }">
			<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnReportVacation" onclick="goList();" style="margin-right: 20px; width:80px; height:30px;">목록</button>
			</c:if>
			<c:if test="${requestScope.isManager eq 1}">
			<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnReportVacation" onclick="goWaitingSign();" style="margin-right: 20px; width:120px; height:30px;">결재대기목록</button>
			</c:if>
			<!-- <button type="button" class="btn btn-secondary btn-sm mr-3" id="btn_vac_certification" style="margin-right: 20px; width:80px; height:30px;">목록보기</button>  -->
			<c:if test="${sessionScope.loginuser.pk_emp_no == 80000001 }">
				<button type="button" class="btn btn-warning btn-sm mr-3" id="btnDelete" onclick="goDelete()" style="margin-right: 20px; width:80px; height:30px;">삭제</button>
				<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnAll" onclick="javascript:location.href='<%= ctxPath%>/att/viewAllReport.bts'" style="margin-right: 20px; width:120px; height:30px;">전체신청목록</button>
			</c:if>	      	
		</div>	
		<input type="hidden" id="minus_cnt" name="minus_cnt"  value="${vac.minus_cnt}"/>
		<input type="hidden" id="instead_vac_days" name="instead_vac_days" />
		<input type="hidden" id="vacation_days" name="vacation_days" value="${vac.vacation_days}" />
		<input type="hidden" id="report_emp_no" name="report_emp_no" value="${vac.fk_emp_no}" />
		<input type="hidden" id="manager" name="manager" value="${vac.manager}" />
		<input type="hidden" id="pk_emp_no" name="pk_emp_no" value="${sessionScope.loginuser.pk_emp_no}" />
		<input type="hidden" id="fk_emp_no" name="fk_emp_no" value="${requestScope.fk_emp_no}" />
		<input type="hidden" id="pk_att_num" name="pk_att_num" value="${vac.pk_att_num}" />
		<input type="hidden" id="approval_status" name="approval_status" value="${vac.approval_status}" />
		<input type="hidden" id="isManager" name="isManager" value="${requestScope.isManager}" />
		<input type="hidden" id="isDecided" name="isDecided" value="${requestScope.isDecided}" />
		<input type="hidden" id="uq_phone" name="uq_phone" value="${requestScope.uq_phone}" />
		<input type="hidden" id="isRejected" name="isRejected" />
        </form>
        </div>
    </div>
    <%-- 공가/경조신청서 작성 끝 --%>
    
</div>