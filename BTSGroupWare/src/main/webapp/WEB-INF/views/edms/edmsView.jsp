<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>

<!-- style_edms.css 는 이미 layout-tiles_edms.jsp 에 선언되어 있으므로 쓸 필요 X! -->

<!-- datepicker를 사용하기 위한 링크 / 나중에 헤더에 추가되면 지우기 -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>

<style type="text/css">
</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		
		
	}); // end of $(document).ready(function(){}) --------------------
	
</script>


<style>
	/* 문서작성 페이지 테이블 th 부분 */
	.edmsView_th {
		width: 15%;
		background-color: #e8e8e8;
	}
	
</style>

<%-- layout-tiles_edms.jsp의 #mycontainer 과 동일하므로 굳이 만들 필요 X --%>

	<div class="edmsHomeTitle">
		<span class="edms_maintitle">문서보기</span>
		<p style="margin-bottom: 10px;"></p>
	</div>

	
	<div id="edms_view">
	
	<!-- ------------------------------------------------------------------------ -->

	<table style="width: 100%" class="table table-bordered">
		<colgroup>
		<col style="width: 16%; background-color: #e8e8e8;" />
		<col style="width: 24%;" />
		<col style="width: 32%;" />
		<col style="width: 4%; background-color: #e8e8e8;" />
		<col style="width: 8%;" />
		<col style="width: 4%; background-color: #e8e8e8;" />
		<col style="width: 8%;" />
		</colgroup>
		
		<tr>
			<th>문서양식</th>
          	<td style="background-color: #F7F7F7;">
				업무기안	
			</td>
             
          	<td rowspan="4" style="border-top: solid 1px #F2F2F2; border-bottom: solid 1px #F2F2F2;">
          		&nbsp; <%-- 큰구분선1 --%>
          	</td>
          	
          	<td rowspan="4" style="valign: center;">승인</td>
          	<td style="background-color: #F7F7F7;">부장</td>
             
			<td rowspan="4" style="valign: center;">승인</td>
          	<td style="background-color: #F7F7F7;">사장</td>
		</tr>
		<tr>
			<th>작성자</th>
          	<td style="background-color: #F7F7F7;">김다우</td>
          	<td rowspan="2" style="background-color: #F7F7F7;">부장님</td>
			<td rowspan="2" style="background-color: #F7F7F7;">사장님</td>
		</tr>
        <tr>
			<th>소속</th>
          	<td style="background-color: #F7F7F7;">IT팀</td>
		</tr>
		
		<tr>
			<th>작성일자</th>
          	<td style="background-color: #F7F7F7;">2022년 05월 03일</td>
          	<td style="background-color: #F7F7F7;">결재상태</td>
			<td style="background-color: #F7F7F7;">결재상태</td>
		</tr>
	</table>

	</div>
	
	<!-- 문서작성 종료 -->
	
	
	<span class="edms_title">상세정보</span>
	<form name="addFrm">
		<table style="width: 100%" class="table table-bordered">
			<colgroup>
				<col style="width: 16%; background-color: #e8e8e8;" />
			</colgroup>
			
			<!-- <tr> -->		
			<tr style="width: 16%;">
				<th class="edmsView_th">제목</th>
				<td style="width: 75%;">
					<!-- if문 -->
					<span style="color: red; font-weight: bold;">[긴급]</span>&nbsp;
					<span>제목어쩌고</span>
				</td>
			</tr>
			
			<tr>
				<th class="edmsView_th">시행일자</th>
				<td colspan="2">
					시행일자 어쩌고
				</td>
			</tr>
			
			<tr>
				<th class="edmsView_th">내용</th>
				<td colspan="2">
					내용어쩌고<br/>
					내용어쩌고<br/>
					내용어쩌고<br/>
					내용어쩌고<br/>
					내용어쩌고<br/>
				</td>
			</tr>	

			<tr>
				<th class="edmsView_th">파일첨부</th>
				<td>
					<input type="file" name="attach" id="attach" size="100" style="width: 100%;" />
				</td>
			</tr>
		</table>
	
	<div style="margin: 20px;">
		<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnWrite">결재요청</button>
		<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">취소</button>
	</div>
	
	</form>