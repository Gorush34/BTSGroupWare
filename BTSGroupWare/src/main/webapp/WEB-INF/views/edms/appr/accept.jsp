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
		
		
		$("button#btnAccpet").click(function() {
		
			console.log(abc);
			console.log($("input#fk_emp_no").val());
			
			
		//	alert("${requestScope.pw}");
			if( abc != $("input#fk_emp_no").val() ) {
				alert("사번이 일치하지 않습니다.");
				
				return;
			}
			else {
				// 폼(form)을 전송(submit)
				const frm = document.acceptFrm;
				frm.method = "POST";
				frm.action = "<%=ctxPath%>/edms/appr/acceptEnd.bts";
				frm.submit();
				
			}
			
			
		}); // end of $("button#btnDelete").click(function(){}) --------------------
		
	}); // end of $(document).ready(function(){}) --------------------
	
</script>



<div style="display: flex;">
<div style="margin: auto; padding-left: 3%;">

	<h2 style="margin-bottom: 30px;">문서승인하기</h2>

<form name="acceptFrm">
	<table style="width: 1024px" class="table table-bordered">
		<tr>
			<th style="width: 15%; background-color: #DDDDDD">
				<input type="text" class="form-control" value="승인하시겠습니가?">
			</th>
			<td>
				<input type="text" name="fk_emp_no" id="fk_emp_no" />
				<input type="text" name="pk_appr_no" class="form-control" value="${requestScope.apprvo.pk_appr_no}" readonly />
				<input type="text" name="fk_emp_no2" class="form-control" value="${requestScope.apprvo.fk_emp_no}" readonly>
				<input type="hidden" name="emp_no" id="emp_no" value="${requestScope.apprvo.fk_emp_no}"/>
				
			</td>
		</tr>		
	</table>
	
	<div style="margin: 20px;">
		<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnAccpet">완료</button>
		<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">취소</button>
	</div>
	
</form>
</div>
</div>