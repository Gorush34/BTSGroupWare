<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String ctxPath = request.getContextPath();
%>

<!-- style_edms.css 는 이미 layout-tiles_edms.jsp 에 선언되어 있으므로 쓸 필요 X! -->


<script type="text/javascript">
	$(document).ready(function() {
		
		/* 차트보기 버튼 클릭 시 모달창 띄우기 */		
		
	});
</script>

<%-- layout-tiles_edms.jsp의 #mycontainer 과 동일하므로 굳이 만들 필요 X --%>
	
	<div class="edmsHome">
	
	<div class="edmsHomeTitle">
		<span class="edms_maintitle">전자결재 홈</span>
		<p style="margin-bottom: 10px;"></p>
	</div>
	
	<!-- 결재대기문서 시작 -->
	<span class="edms_title"> 
		<input type="hidden" name="fk_emp_no" value="${sessionScope.loginuser.pk_emp_no}" />
		<input type="hidden" class="form-control-plaintext" type="text" name="name" value="${sessionScope.loginuser.emp_name}" readonly />${sessionScope.loginuser.emp_name}님의 현황
	</span>
		
	<div class="divClear"></div>
				
	<%-- 결재대기 문서가 없는 경우 시작 --%>
	<c:if test="${empty requestScope.edmsList}">
		<div class="card"><span>결재 대기 문서가 없습니다.</span></div>
	</c:if>
	<%-- 결재대기 문서가 없는 경우 종료 --%>
		
	<%-- 결재대기 문서가 있는 경우 시작 --%>
	<c:if test="${not empty requestScope.edmsList}">
		<%-- 반응형 웹(카드) 시작 --%>
		<div class="row">
			<%-- 반복문 시작 --%>
			<c:forEach var="apprvo" items="${requestScope.edmsList}" >
			<div class="col-2">
				<div class="card-body">
					<p style="display: none;"><c:out value="${i}" /></p>
					<span style="border: none; background-color: #A6C76C; width: 32px; color: #fff;">${apprvo.status}</span>&nbsp;<span><c:out value="${i}" />&nbsp;(나중에 hidden 처리하기)</span>
					<h5 class="card-title">${apprvo.title}</h5>
					<h6 class="card-subtitle mb-2 text-muted">
						기안자 : ${apprvo.pk_appr_no}
					</h6>
					<hr>
					<!-- <a href="/bts/edms/edmsMydoc.bts" class="stretched-link btn btn-sm text-primary" class="card-link">자세히 보기</a> -->
					<span onclick="javascript:location.href='<%= request.getContextPath()%>/edms/view.bts'" class="stretched-link btn btn-sm text-primary" class="card-link">자세히 보기</span>
				</div>
			</div>
			</c:forEach>
		</div>
		<%-- 반응형 웹(카드) 종료 --%>
	</c:if>
	<%-- 결재대기 문서가 있는 경우 종료 --%>
		
		<!-- 결재대기 문서 종료 -->
	
	<!-- 반응형 웹 종료 -->
		
		<div class="divClear"></div>
		
		<div class="more">
			<span class="more" onclick="javascript:location.href='<%= request.getContextPath()%>/edms/list.bts'">전체보기</span>
		</div>
		
		<div class="divClear"></div>
		<%-- 결재 대기 중인 문서가 있을 때 종료 --%>
		<!-- 나의현황 카드 종료 -->

		<%-- 결재 대기 중인 문서가 없을 때 시작 --%>
 		<div class="divClear"></div>
		<table class="table table-sm table-light">
			<tr>
				<td style="border-top: solid 1px #D3D3D3;">&nbsp;</td>
			</tr>
			<tr>
				<td style="text-align: center; font-size: 12pt;">결재대기 문서가 없습니다.</td>
			</tr>
			<tr>
				<td style="border-bottom: solid 1px #D3D3D3;">&nbsp;</td>
			</tr>
		</table>
		<%-- 결재 대기 중인 문서가 없을 때 종료 --%>
	</div>
	<!-- 나의 현황 종료 -->
	
	
	
	<div class="divClear"></div>

	<!-- 결재승인 문서목록 시작 -->
	<div id="edms_accepted">
		<span class="edms_title">결재승인 목록보기</span>
		
		<%-- 결재승인 목록이 있을 때 시작 --%>
		<div class="divClear"></div>
		
		<table class="table table-sm table-hover table-light">
		<!-- <table class="table table-sm table-hover tbl_edms_list" style="background-color: #fff"> -->
			<thead class="thead-light">
				<tr>
					<th scope="col" width="3%">#</th>
					<th scope="col" width="13%">기안일</th>
					<th scope="col" width="10%">결재양식</th>
					<th scope="col" width="9%">긴급</th>
					<th scope="col" width="31%">제목</th>
					<th scope="col" width="6%">첨부</th>
					<th scope="col" width="20%">문서번호</th>
					<th scope="col" width="8%">상태</th>
				</tr>
			</thead>
			<tbody>
				<%-- 나중에 forEach문 사용해서 뿌려주기 시작 --%>
 				<c:forEach var="i" begin="1" end="5">
				<tr>
					<th scope="row"><p><c:out value="${i}" /></p></th>
					<td>2022.02.02</td>
					<td>업무기안</td>
					<td><button id="btn_emergency" class="btn btn-outline-danger" style="height: 100%; line-height: 9pt; font-size: 9pt;">긴급</button></td>
					<td>(신규)휴가신청-연차관리연동</td>
					<td><img src="<%= ctxPath%>/resources/images/disk.gif" style="height: 16px; width: 16px;"></td>
					<td>20220428-000001</td>
					<td>승인됨</td>
				</tr>
				</c:forEach>
				<%-- 나중에 forEach문 사용해서 뿌려주기 시작 --%>
			</tbody>
		</table>
		
		<div class="divClear"></div>
		
		<div class="more">
			<span class="more" onclick="javascript:location.href='<%= request.getContextPath()%>/edms/edmsMydoc_accepted.bts'">전체보기</span>
		</div>
		
		<div class="divClear"></div>
		<%-- 결재승인 목록이 있을 때 종료 --%>
		
		<%-- 결재승인 목록이 없을 때 시작 --%>
		<div class="divClear"></div>
		<table class="table table-sm table-light">
			<tr>
				<td style="border-top: solid 1px #D3D3D3;">&nbsp;</td>
			</tr>
			<tr>
				<td style="text-align: center; font-size: 12pt;">결재승인 문서가 없습니다.</td>
			</tr>
			<tr>
				<td style="border-bottom: solid 1px #D3D3D3;">&nbsp;</td>
			</tr>
		</table>
		<%-- 결재승인 목록이 없을 때 종료 --%>
		
	</div>
	<!-- 결재승인 문서목록 종료 -->
	
	<div class="divClear"></div>

	<!-- 결재반려 문서목록 시작 -->
	<div id="edms_rejected">
		<span class="edms_title">결재반려 목록보기</span>
		
		<%-- 결재반려 목록이 있을 때 시작 --%>
		<div class="divClear"></div>
		
		<table class="table table-sm table-hover table-light">
			<thead class="thead-light">
				<tr>
					<th scope="col" width="3%">#</th>
					<th scope="col" width="13%">기안일</th>
					<th scope="col" width="10%">결재양식</th>
					<th scope="col" width="9%">긴급</th>
					<th scope="col" width="31%">제목</th>
					<th scope="col" width="6%">첨부</th>
					<th scope="col" width="20%">문서번호</th>
					<th scope="col" width="8%">상태</th>
				</tr>
			</thead>
			<tbody>
				<%-- 나중에 forEach문 사용해서 뿌려주기 시작 --%>
 				<c:forEach var="i" begin="1" end="5">
				<tr>
					<th scope="row"><p><c:out value="${i}" /></p></th>
					<td>2022.02.02</td>
					<td>업무기안</td>
					<td>&nbsp;</td>
					<td>(신규)휴가신청-연차관리연동</td>
					<td><img src="<%= ctxPath%>/resources/images/disk.gif" style="height: 16px; width: 16px;"></td>
					<td>20220428-000001</td>
					<td>반려됨</td>
				</tr>
				</c:forEach>
				<%-- 나중에 forEach문 사용해서 뿌려주기 시작 --%>
			</tbody>
		</table>
		
		<div class="divClear"></div>
		
		<div class="more">
			<span class="more" onclick="javascript:location.href='<%= request.getContextPath()%>/edms/edmsMydoc_rejected.bts'">전체보기</span>
		</div>
		
		<div class="divClear"></div>
		<%-- 결재반려 목록이 있을 때 종료 --%>
		
		<%-- 결재반려 목록이 없을 때 시작 --%>
 		<div class="divClear"></div>
		<table class="table table-sm table-light">
			<tr>
				<td style="border-top: solid 1px #D3D3D3;">&nbsp;</td>
			</tr>
			<tr>
				<td style="text-align: center; font-size: 12pt;">결재반려 문서가 없습니다.</td>
			</tr>
			<tr>
				<td style="border-bottom: solid 1px #D3D3D3;">&nbsp;</td>
			</tr>
		</table>
		<%-- 결재반려 목록이 없을 때 종료 --%>
		
	</div>
	<!-- 결재반려 문서목록 종료 -->
	</div>
	<div class="divClear"></div>