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
		
		$("button#btnDelete").click(function() {
	
				const frm = document.delFrm;
				frm.method = "POST";
				frm.action = "<%=ctxPath%>/edms/delEnd.bts";
				frm.submit();

		}); // end of $("button#btnDelete").click(function(){}) --------------------
		
	}); // end of $(document).ready(function(){}) --------------------
	
</script>



<div style="display: flex;">
<div style="margin: auto; padding-left: 3%;">

	<h2 style="margin-bottom: 30px;">글삭제</h2>

<form name="delFrm">
	<table style="width: 1024px" class="table table-bordered">
		<tr>
			<th style="width: 15%; background-color: #DDDDDD">
				<input type="text" class="form-control" value="삭제하시겠습니까?">
			</th>
			<td>
				<input type="hidden" name="fk_emp_no" id="fk_emp_no" />
				<input type="hidden" name="pk_appr_no" class="form-control" value="${requestScope.apprvo.pk_appr_no}" readonly />
				<input type="hidden" name="fk_emp_no2" class="form-control" value="${requestScope.apprvo.fk_emp_no}" readonly>
				<input type="hidden" name="emp_no" id="emp_no" value="${requestScope.apprvo.fk_emp_no}"/>
			</td>
		</tr>		
	</table>
	
	<div style="margin: 20px;">
		<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnDelete">완료</button>
		<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">취소</button>
	</div>
	
</form>
</div>
</div>