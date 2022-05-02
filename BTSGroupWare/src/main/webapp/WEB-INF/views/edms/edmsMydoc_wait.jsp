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
		<span class="edms_maintitle">대기문서함</span>
		<p style="margin-bottom: 10px;"></p>
	</div>


	<!-- 결재대기 문서목록 시작 -->
	<div id="edms_wait">
		<span class="edms_title">결재대기 목록보기</span>

		<div class="dropdown">
			<button class="btn btn-primart-outline dropdown-toggle" type="button" data-toggle="dropdown"
					aria-haspopup="true" aria-expanded="false">10개 보기</button>
			<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
				<a class="dropdown-item" href="#">10개 보기</a>
				<a class="dropdown-item" href="#">30개 보기</a>
				<a class="dropdown-item" href="#">50개 보기</a>
			</div>
		</div>
				
		<%-- 결재대기 목록이 있을 때 시작 --%>
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
 				<c:forEach var="i" begin="1" end="10">
				<tr>
					<th scope="row"><p><c:out value="${i}" /></p></th>
					<td>2022.02.02</td>
					<td>업무기안</td>
					<td>&nbsp;</td>
					<td>(신규)휴가신청-연차관리연동</td>
					<td><img src="<%= ctxPath%>/resources/images/disk.gif" style="height: 16px; width: 16px;"></td>
					<td>20220428-000001</td>
					<td>대기중</td>
				</tr>
				</c:forEach>
				<%-- 나중에 forEach문 사용해서 뿌려주기 시작 --%>
			</tbody>
		</table>
		
		<div class="divClear"></div>
		<%-- 결재대기 목록이 있을 때 종료 --%>
		
		<%-- 결재대기 목록이 없을 때 시작 --%>
		<div class="divClear"></div>
		<table class="table table-sm table-light">
			<tr>
				<td style="border-top: solid 1px #D3D3D3;">&nbsp;</td>
			</tr>
			<tr>
				<td style="text-align: center; font-size: 12pt;">대기 중인 문서가 없습니다.</td>
			</tr>
			<tr>
				<td style="border-bottom: solid 1px #D3D3D3;">&nbsp;</td>
			</tr>
		</table>
		<%-- 결재대기 목록이 없을 때 종료 --%>
		<div class="divClear"></div>	
	</div>
	<!-- 결재대기 문서목록 종료 -->
	
	<!-- 페이지바 -->
	<div class="pagination">
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


	<div class="pagination" style="display: inline-block; text-align: center; clear: both;">
		<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-center">
				<li class="page-item disabled">
					<a class="page-link" href="#" tabindex="-1">&laquo;</a>
				</li>
				<li class="page-item"><a class="page-link" href="#">1</a></li>
				<li class="page-item"><a class="page-link" href="#">2</a></li>
				<li class="page-item"><a class="page-link" href="#">3</a></li>
				<li class="page-item"><a class="page-link" href="#">4</a></li>
				<li class="page-item"><a class="page-link" href="#">5</a></li>
				<li class="page-item">
					<a class="page-link" href="#">&raquo;</a>
				</li>
			</ul>
		</nav>
	</div>

	<div class="divClear"></div>