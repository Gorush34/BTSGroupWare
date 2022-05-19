<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
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
	<c:set var="appr" value="${requestScope.apprvo}" />
	<table style="width: 100%;" class="table table-bordered">
		<tr>
			<th style="width: 80%; background-color: #DDDDDD">
				<input type="text" value="반려하시겠습니까?">
			</th>
			<td>
<%-- 				<input type="text" value="로그인 유저의 사번 : ${sessionScope.loginuser.pk_emp_no}" />
				<input type="text" class="form-control" value="문서번호 = ${requestScope.apprvo.pk_appr_no}" readonly />
				<input type="hidden" name="fk_emp_no" value="${requestScope.apprvo.fk_emp_no}" /> --%>
				<input type="text" name="pk_appr_no" class="form-control" value="${appr.pk_appr_no}" />
				<input type="text" name="mid_accept" class="mid_accept" value="${appr.mid_accept}" />
				<input type="text" name="fin_accept" class="fin_accept" value="${appr.fin_accept}" />
				<%-- <input type="hidden" name="fk_mid_empno" class="form-control" value="${sessionScope.loginuser.pk_emp_no}" readonly>
				<input type="hidden" name="mid_emp_no" id="mid_emp_no" value="${requestScope.apprvo.fk_fin_empno}"/>
				<input type="hidden" name="fin_emp_no" id="fin_emp_no" value="${requestScope.apprvo.fk_mid_empno}"/> --%>
			</td>
		</tr>		
	</table>
	
	<table id="opinion">
		<c:if test="${appr.mid_accept eq 0 and appr.fin_accept eq 0}"> <!-- 중간 0, 최종 0 => 대기중 -->
			<tr>
				<th>중간결재자의견</th>
				<td>
					<input type="text" id="mid_opinion" name="mid_opinion" />
				</td>
			</tr>
		</c:if>
		
		<c:if test="${appr.mid_accept eq 1 and appr.fin_accept eq 0}"> <!-- 중간 1, 최종 0 => 대기(진행)중 -->
			<tr>
				<th>중간결재자의견</th>
				<td>
					<input type="text" id="mid_opinion_readonly" name="mid_opinion_readonly" value="${appr.mid_opinion}" readonly/>
				</td>
			</tr>
			<tr>
				<th>최종결재자의견</th>
				<td>
					<input type="text" id="fin_opinion" name="fin_opinion" />
				</td>
			</tr>
		</c:if>
	</table>
	
	<div style="margin: 20px;">
		<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnReject">완료</button>
		<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">취소</button>
	</div>
</form>
</div>
</div>