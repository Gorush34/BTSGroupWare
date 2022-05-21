<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
 	String ctxPath = request.getContextPath();
%>

<style type="text/css">

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		// goRegisterResource
		$("button#goRegisterResource").click(function(){
			
			 location.href="<%= ctxPath%>/reservation/resourceRegister.bts";
			
		})// end of $("button#goRegisterResource").click(function(){}---------------------------
		
	}); // end of $(document).ready(function(){}--------------------------------
			
			
	// 자원 수정하기
	function editResource(pk_rno){
		var frm = document.editResourceFrm;
		frm.pk_rno.value = pk_rno;
		
		frm.action = "<%= ctxPath%>/resource/resourceEdit.bts";
		frm.method = "post";
		frm.submit();
	}			
			
</script>

<div id="reservationAdmin">
	<h4 style="margin: 0 80px">자산목록</h4>
		<div id="resourceList">
			
			<table class="table table-striped" style="width:90%; margin:50px auto; text-align: center;">
				<thead class="table-primary" style="color:white;">
					<tr>
						<th>자원명</th>
						<th>분류명</th>
						<th>자원정보</th>
						<th>설정</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${not empty requestScope.resourceList}">
					<c:forEach var="map" items="${requestScope.resourceList}">						
						<tr>
							<td>${map.RNAME}<input type="hidden" name="pk_rno" value="${map.PK_RNO}"></td>
							<td>${map.CLASSNAME}</td>
							<td>${map.RINFO}</td>
							<td><button type="button" class="btn btn-secondary btn-sm" onclick="editResource('${map.PK_RNO}')">설정</button></td>
						</tr>
					</c:forEach>
				</c:if>	
				</tbody>
			</table>
		</div>
</div>
<div style="width:95%; height: 2px;">
			<div style="float: right;"><button type="button" class="btn btn-secondary btn-sm" id="goRegisterResource">자산추가</button></div>
</div>
<form name="editResourceFrm">
<input type="hidden" name="pk_rno"/>
</form>