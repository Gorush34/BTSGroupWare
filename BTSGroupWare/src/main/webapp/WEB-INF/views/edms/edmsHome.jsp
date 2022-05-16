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
	<!-- 결재대기 목록 시작 -->
	<div id="edms_all">
		<span class="edms_title">결재대기 목록보기</span>
		
		<%-- 결재대기 목록이 있을 때 시작 --%>
		<div class="divClear"></div>
		<c:if test="${ not empty requestScope.all}">
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
 				<c:forEach var="all" items="${requestScope.all}" begin="0" end="4" step="1">
				<tr>
					<th scope="row"><p><c:out value="1" /></p></th>
					<td>${all.writeday}</td>
					<td>${all.appr_name}</td>
					<td>
						<c:if test="${all.emergency ne 0}">
						<button id="btn_emergency" class="btn btn-outline-danger" style="height: 100%; line-height: 9pt; font-size: 9pt;">긴급</button>
						</c:if>
					</td>
					<td>${all.title}</td>
					<td>
						<c:if test="${all.filename ne null}">
						<img src="<%= ctxPath%>/resources/images/disk.gif" style="height: 16px; width: 16px;">
						</c:if>
					</td>
					<td>알아서 넣어라</td>
					<td>
						<c:if test="${reject.mid_accept eq 0 and reject.fin_accept eq 0}">
							대기중
						</c:if>
						<c:if test="${reject.mid_accept eq 1 and reject.fin_accept eq 0}">
							대기중
						</c:if>
						<c:if test="${reject.fin_accept eq 1}">
							승인됨
						</c:if>
						<c:if test="${reject.mid_accept eq 2 and reject.fin_accept eq 0}">
							반려됨
						</c:if>
						<c:if test="${reject.mid_accept eq 1 and reject.fin_accept eq 2}">
							반려됨
						</c:if>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		</c:if>
		<div class="divClear"></div>
		
		<div class="more">
			<span class="more" onclick="javascript:location.href='<%= request.getContextPath()%>/edms/list.bts'">전체보기</span>
		</div>
		
		<div class="divClear"></div>
		<%-- 결재대기 목록이 있을 때 종료 --%>
		<c:if test="${ empty requestScope.all}">
		<%-- 결재대기 목록이 없을 때 시작 --%>
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
		</c:if>
		<%-- 결재대기 목록이 없을 때 종료 --%>
		
	</div>
	<!-- 결재대기 문서목록 종료 -->
	</div>
	<!-- 나의 현황 종료 -->
	
	
	
	<div class="divClear"></div>

	<!-- 결재승인 목록 시작 -->
	<div id="edms_accept">
		<span class="edms_title">결재승인 목록보기</span>
		
		<%-- 결재승인 목록이 있을 때 시작 --%>
		<div class="divClear"></div>
		<c:if test="${ not empty requestScope.accept}">
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
 				<c:forEach var="accept" items="${requestScope.accept}" begin="0" end="4" step="1">
				<tr>
					<th scope="row"><p><c:out value="1" /></p></th>
					<td>${accept.writeday}</td>
					<td>${accept.appr_name}</td>
					<td>
						<c:if test="${accept.emergency ne 0}">
						<button id="btn_emergency" class="btn btn-outline-danger" style="height: 100%; line-height: 9pt; font-size: 9pt;">긴급</button>
						</c:if>
					</td>
					<td>${accept.title}</td>
					<td>
						<c:if test="${accept.filename ne null}">
						<img src="<%= ctxPath%>/resources/images/disk.gif" style="height: 16px; width: 16px;">
						</c:if>
					</td>
					<td>알아서 넣어라</td>
					<td>
						<c:if test="${reject.mid_accept eq 0 and reject.fin_accept eq 0}">
							대기중
						</c:if>
						<c:if test="${reject.mid_accept eq 1 and reject.fin_accept eq 0}">
							대기중
						</c:if>
						<c:if test="${reject.fin_accept eq 1}">
							승인됨
						</c:if>
						<c:if test="${reject.mid_accept eq 2 and reject.fin_accept eq 0}">
							반려됨
						</c:if>
						<c:if test="${reject.mid_accept eq 1 and reject.fin_accept eq 2}">
							반려됨
						</c:if>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		</c:if>
		<div class="divClear"></div>
		
		<div class="more">
			<span class="more" onclick="javascript:location.href='<%= request.getContextPath()%>/edms/accept/list.bts'">전체보기</span>
		</div>
		
		<div class="divClear"></div>
		<%-- 결재승인 목록이 있을 때 종료 --%>
		<c:if test="${ empty requestScope.accept}">
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
		</c:if>
		<%-- 결재승인 목록이 없을 때 종료 --%>
		
	</div>
	<!-- 결재승인 문서목록 종료 -->
	
	<div class="divClear"></div>
	

	<!-- 결재반려 목록 시작 -->
	<div id="edms_all">
		<span class="edms_title">결재반려 목록보기</span>
		
		<%-- 결재반려 목록이 있을 때 시작 --%>
		<div class="divClear"></div>
		<c:if test="${ not empty requestScope.reject}">
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
 				<c:forEach var="reject" items="${requestScope.reject}" begin="0" end="4" step="1">
				<tr>
					<th scope="row"><p><c:out value="1" /></p></th>
					<td>${reject.writeday}</td>
					<td>${reject.appr_name}</td>
					<td>
						<c:if test="${reject.emergency ne 0}">
						<button id="btn_emergency" class="btn btn-outline-danger" style="height: 100%; line-height: 9pt; font-size: 9pt;">긴급</button>
						</c:if>
					</td>
					<td>${reject.title}</td>
					<td>
						<c:if test="${reject.filename ne null}">
						<img src="<%= ctxPath%>/resources/images/disk.gif" style="height: 16px; width: 16px;">
						</c:if>
					</td>
					<td>알아서 넣어라</td>
					<td>
						<c:if test="${reject.mid_accept eq 0 and reject.fin_accept eq 0}">
							대기중
						</c:if>
						<c:if test="${reject.mid_accept eq 1 and reject.fin_accept eq 0}">
							대기중
						</c:if>
						<c:if test="${reject.fin_accept eq 1}">
							승인됨
						</c:if>
						<c:if test="${reject.mid_accept eq 2 and reject.fin_accept eq 0}">
							반려됨
						</c:if>
						<c:if test="${reject.mid_accept eq 1 and reject.fin_accept eq 2}">
							반려됨
						</c:if>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		</c:if>
		<div class="divClear"></div>
		
		
		
		<div class="divClear"></div>
		<%-- 결재반려 목록이 있을 때 종료 --%>
		<c:if test="${ empty requestScope.reject}">
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
		</c:if>
		<%-- 결재반려 목록이 없을 때 종료 --%>
		<div class="more">
			<span class="more" onclick="javascript:location.href='<%= request.getContextPath()%>/edms/reject/list.bts'">전체보기</span>
		</div>
	</div>
	<!-- 결재반려 문서목록 종료 -->