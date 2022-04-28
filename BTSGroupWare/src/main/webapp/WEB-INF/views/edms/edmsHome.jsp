<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String ctxPath = request.getContextPath();
%>

<title>전자결재 홈</title>

<!-- 폰트를 쓰기 위한 링크 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo&family=Noto+Sans+KR&display=swap" rel="stylesheet">

<!-- style_edms.css 는 이미 layout-tiles_edms.jsp 에 선언되어 있으므로 쓸 필요 X! -->

<script type="text/javascript">
	$(document).ready(function() {
		
	});
</script>


<%-- layout-tiles_edms.jsp의 #mycontainer 과 동일하므로 굳이 만들 필요 X --%>
	<!-- 나의 현황(최근문서) 시작 -->
	<div id="edms_current">
		<span class="title">김한조 님의 현황</span>
		<div class="divClear"></div>
		<!-- 나의현황 카드 시작 -->
		<div class="row">
			<%-- 나중에 c:forEach 으로 여러 개 불러오기 --%>
			<c:forEach var="i" begin="1" end="4">
				<div class="col-3">
				<div class="card">
					<div class="card-body">
						<p><c:out value="${i}" /></p>
						<h5 class="card-title">기안서 제목 </h5>
						<h6 class="card-subtitle mb-2 text-muted">진행상태</h6>
						<hr>
						<a href="/bts/edms/edmsMydoc.bts" class="stretched-link btn btn-sm text-primary" class="card-link">자세히 보기</a>
					</div>
				</div>
				</div>
			</c:forEach>
		</div>
		<!-- 나의현황 카드 종료 -->
		
		<div class="more">
			<span class="more">전체보기</span>
		</div>
	</div>
	<!-- 나의 현황 종료 -->
	
	<div class="divClear"></div>

	<!-- 결재진행 문서목록 시작 -->
	<div id="edms_accepted">
		<span class="title">결재완료 목록보기</span>
		<table class="table table-sm">
			<thead>
				<tr>
					<th scope="col">#</th>
					<th scope="col">기안일</th>
					<th scope="col">결재양식</th>
					<th scope="col">긴급</th>
					<th scope="col">제목</th>
					<th scope="col">첨부</th>
					<th scope="col">문서번호</th>
				</tr>
			</thead>
			<tbody>
				<%-- 나중에 forEach문 사용해서 뿌려주기 --%>
				<c:forEach var="i" begin="1" end="5">
				<tr>
					<th scope="row"><p><c:out value="${i}" /></p></th>
					<td>2022.02.02</td>
					<td>업무기안</td>
					<td></td>
					<td>(신규)휴가신청-연차관리연동</td>
					<td>있음</td>
					<td>20220428-000001</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<div class="divClear"></div>
		
		<div class="more">
			<span class="more">전체보기</span>
		</div>
	</div>
	<!-- 결재진행 문서목록 종료 -->
	
	<div class="divClear"></div>

	<!-- 결재진행 문서목록 시작 -->
	<div id="edms_rejected">
		<span class="title">결재반려 목록보기</span>
		<table class="table table-sm">
			<thead>
				<tr>
					<th scope="col">#</th>
					<th scope="col">기안일</th>
					<th scope="col">결재양식</th>
					<th scope="col">긴급</th>
					<th scope="col">제목</th>
					<th scope="col">첨부</th>
					<th scope="col">문서번호</th>
				</tr>
			</thead>
			<tbody>
				<%-- 나중에 forEach문 사용해서 뿌려주기 --%>
				<c:forEach var="i" begin="1" end="5">
				<tr>
					<th scope="row"><p><c:out value="${i}" /></p></th>
					<td>2022.02.02</td>
					<td>업무기안</td>
					<td></td>
					<td>(신규)휴가신청-연차관리연동</td>
					<td>있음</td>
					<td>20220428-000001</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<div class="divClear"></div>
		
		<div class="more">
			<span class="more">전체보기</span>
		</div>
	</div>
	<!-- 결재진행 문서목록 종료 -->
	
	<div class="divClear"></div>
