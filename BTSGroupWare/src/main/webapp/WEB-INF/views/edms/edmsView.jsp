<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String ctxPath = request.getContextPath();
%>

<!-- style_edms.css 는 이미 layout-tiles_edms.jsp 에 선언되어 있으므로 쓸 필요 X! -->

<style>

</style>

<script type="text/javascript">
	$(document).ready(function() {
		
	});
</script>

<%-- layout-tiles_edms.jsp의 #mycontainer 과 동일하므로 굳이 만들 필요 X --%>

	<div class="edmsHomeTitle">
		<span class="edms_maintitle">문서 상세보기</span>
		<p style="margin-bottom: 10px;"></p>
	</div>

	<!-- 문서 상세보기 시작 -->
	<div id="edms_view">
		
		<%-- 문서가 있을 때 시작 --%>
		<div class="divClear"></div>
		<table class="table table-sm table-light">
			<thead>
				<tr>
					<th><span class="edms_title">문서제목</span> <%-- 문서의 양식에 따라 제목이 달라지도록 --%></th>
					<td>문서번호 20220502190930-1</td>
					<td>기안일자 2022년 05월 02일 월요일</td>
				</tr>
			</thead>
			
			<tbody>
				<tr>
					<th>1</th>
					<th>2</th>
					<th>3</th>
				</tr>
			</tbody>
			<tfoot>
			</tfoot>
			<!-- <tr>
				<td style="border-top: solid 1px #D3D3D3;">&nbsp;</td>
			</tr>
			<tr>
				<td style="text-align: center; font-size: 12pt;">문서가 존재하지 않습니다.</td>
			</tr>
			<tr>
				<td style="border-bottom: solid 1px #D3D3D3;">&nbsp;</td>
			</tr> -->
		</table>
		
		
			
		<div class="divClear"></div>
		<%-- 문서가 있을 때 종료 --%>
		
		<%-- 문서가 없을 때 시작 --%>
		<div class="divClear"></div>
		<table class="table table-sm table-light">
			<tr>
				<td style="border-top: solid 1px #D3D3D3;">&nbsp;</td>
			</tr>
			<tr>
				<td style="text-align: center; font-size: 12pt;">문서가 존재하지 않습니다.</td>
			</tr>
			<tr>
				<td style="border-bottom: solid 1px #D3D3D3;">&nbsp;</td>
			</tr>
		</table>
		
		<div class="divClear"></div>
		<%-- 문서가 없을 때 종료 --%>
		
	</div>
	<!-- 문서 상세보기 종료 -->

	<div class="divClear"></div>