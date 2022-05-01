<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String ctxPath = request.getContextPath();
%>

<!-- style_edms.css 는 이미 layout-tiles_edms.jsp 에 선언되어 있으므로 쓸 필요 X! -->

<script type="text/javascript">
	$(document).ready(function() {
		
	});
</script>

<%-- layout-tiles_edms.jsp의 #mycontainer 과 동일하므로 굳이 만들 필요 X --%>

	<div class="edmsHomeTitle">
		<span class="edms_maintitle">전체문서함</span>
		<p style="margin-bottom: 10px;"></p>
	</div>

	
	<!-- 전체문서 문서목록 시작 -->
	<div id="edms_all">

		<div>
			<span class="edms_title">전체문서 목록보기</span>
		</div>
		
		<div class="dropdown">
			<button class="btn btn-primart-outline dropdown-toggle" type="button" data-toggle="dropdown"
					aria-haspopup="true" aria-expanded="false">10개 보기</button>
			<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
				<a class="dropdown-item" href="#">10개 보기</a>
				<a class="dropdown-item" href="#">30개 보기</a>
				<a class="dropdown-item" href="#">50개 보기</a>
			</div>
		</div>

		<div class="divClear"></div>
		
		<table class="table table-sm table-hover table-light">
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
				<c:forEach var="i" begin="1" end="10">
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
	</div>
	<!-- 전체문서 문서목록 종료 -->
	
	<!-- 페이지바 -->
	<div class="pagination" style="display: inline-block; text-align: center;">
		<nav aria-label="Page navigation">
			<ul class="pagination justify-content-center">
				<li class="page-item disabled">
					<a class="page-link" href="#" aria-label="Previous">
						<span aria-hidden="true">&laquo;</span>
						<span class="sr-only">Previous</span>
					</a>
				</li>
				<li class="page-item active"><a class="page-link" href="#">1</a></li>
				<li class="page-item"><a class="page-link" href="#">2</a></li>
				<li class="page-item"><a class="page-link" href="#">3</a></li>
				<li class="page-item">
					<a class="page-link" href="#" aria-label="Next">
						<span aria-hidden="true">&raquo;</span>
						<span class="sr-only">Next</span>
					</a>
				</li>
			</ul>
		</nav>
	</div>
	<!-- 페이지바 종료 -->
	
	<div class="divClear"></div>

	
	<div class="divClear"></div>