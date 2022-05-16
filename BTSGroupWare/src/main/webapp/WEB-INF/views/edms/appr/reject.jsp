<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>

<style type="text/css">

</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		
		var abc = $("input#emp_no").val();
		
		
		$("button#btnReject").click(function() {
			// 폼(form)을 전송(submit)
			const frm = document.rejectFrm;
			frm.method = "POST";
			frm.action = "<%=ctxPath%>/edms/appr/rejectEnd.bts";
			frm.submit();
		}); // end of $("button#btnDelete").click(function(){}) --------------------
		
	}); // end of $(document).ready(function(){}) --------------------
	
</script>



<div style="display: flex;">
<div style="margin: auto; padding-left: 3%;">

	<h2 style="margin-bottom: 30px;">문서 반려하기</h2>

<form name="rejectFrm">
	<table style="width: 100%;" class="table table-bordered">
		<tr>
			<th style="width: 80%; background-color: #DDDDDD">
				<input type="text" value="반려하시겠습니까?">
			</th>
			<td>
				<input type="hidden" value="${sessionScope.loginuser.pk_emp_no}" />
				<input type="hidden" value="${requestScope.apprvo.pk_appr_no}" readonly />
				<input type="hidden" name="fk_emp_no"	id="fk_emp_no"		value="${requestScope.apprvo.fk_emp_no}" />
				<input type="hidden" name="fk_mid_empno"id="fk_mid_empno"	value="${sessionScope.loginuser.pk_emp_no}" readonly>
				<input type="hidden" name="pk_appr_no"	id="pk_appr_no"		value="${requestScope.apprvo.pk_appr_no}" />
				<input type="hidden" name="mid_emp_no"	id="mid_emp_no"		value="${requestScope.apprvo.fk_fin_empno}"/>
				<input type="hidden" name="fin_emp_no"	id="fin_emp_no"		value="${requestScope.apprvo.fk_mid_empno}"/>
			</td>
		</tr>		
	</table>
	
	<div style="margin: 20px;">
		<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnReject">완료</button>
		<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">취소</button>
	</div>
	
</form>
</div>
</div>