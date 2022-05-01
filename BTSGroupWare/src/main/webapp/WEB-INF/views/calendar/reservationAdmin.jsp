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

	$(document).ready(function(){
		
	}); // end of $(document).ready(function(){}--------------------------------
			
			
</script>

<div id="reservationAdmin">
	<h4 style="margin: 0 80px">자산목록</h4>
		<div id="resourceList">
		<div style="width:95%; height: 2px;">
			<div style="float: right;"><button type="button" class="btn btn-secondary btn-sm" onclick="javascript:location.href='<%= ctxPath%>/reservation/resourceRegister.bts'">자산추가</button></div>
		</div>	
			<table class="table table-striped" style="width:90%; margin:50px auto; text-align: center;">
				<thead class="table-primary" style="color:white;">
					<tr>
						<th>자산명</th>
						<th>보유 수</th>
						<th>권한</th>
						<th>상태</th>
						<th>설정</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>차량 예약</td>
						<td>5</td>
						<td>전체 허용</td>
						<td>사용 가능</td>
						<td><button type="button" class="btn btn-secondary btn-sm" onclick="">설정</button></td>
					</tr>
					<tr>
						<td>차량 예약</td>
						<td>5</td>
						<td>전체 허용</td>
						<td>사용 가능</td>
						<td><button type="button" class="btn btn-secondary btn-sm" onclick=""></button></td>
					</tr>
					<tr>
						<td>차량 예약</td>
						<td>5</td>
						<td>전체 허용</td>
						<td>사용 가능</td>
						<td><button type="button" class="btn btn-secondary btn-sm" onclick=""></button></td>
					</tr>
				</tbody>
			</table>
		</div>
</div>