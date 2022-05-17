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
	
	
	// Function Declaration
	function goView(pk_appr_no) {
	// 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후 사용자가 목록보기 버튼을 클릭했을 때 돌아갈 페이지를 알려주기 위해 현재 페이지 주소를 뷰단으로 넘겨준다.
		const gobackURL = "${requestScope.gobackURL}"; // 자꾸 빨간줄 뜸
		
		alert("list 단에서 확인용 gobackURL : " + gobackURL);
		
		if(gobackURL == "") {
			location.href = "<%= ctxPath%>/edms/view.bts?pk_appr_no="+pk_appr_no+"&gobackURL="+gobackURL;
		}
		else {
			location.href = "<%= ctxPath%>/edms/view.bts?pk_appr_no="+pk_appr_no+"&gobackURL="+gobackURL;
		}
		
				
	} // end of function goView(pk_appr_no)

	
	
	
	
</script>

<%-- layout-tiles_edms.jsp의 #mycontainer 과 동일하므로 굳이 만들 필요 X --%>
	
	
	<div class="edmsHome">
	
	<div class="edmsHomeTitle">
		<span class="edms_maintitle">${sessionScope.loginuser.emp_name}님의 현황</span>
		<p style="margin-bottom: 10px;"></p>
	</div>
	
	<!-- 모든문서 시작 -->
	<span class="edms_title"> 
		<input type="hidden" name="fk_emp_no" value="${sessionScope.loginuser.pk_emp_no}" />
		<input type="hidden" class="form-control-plaintext" type="text" name="name" value="${sessionScope.loginuser.emp_name}" readonly />
	</span>
		
	<div class="divClear"></div>
	
	<div id="edms_all">
		<span class="edms_title">모든문서 목록보기</span>
		
		<%-- 모든문서 목록이 있을 때 시작 --%>
		<div class="divClear"></div>
		<c:if test="${not empty requestScope.all}">
		<table class="table table-sm table-hover table-light edmsTable">
			<thead class="thead-light">
				<tr>
					<th scope="col" width="4%">#</th>
					<th scope="col" width="13%">기안일</th>
					<th scope="col" width="10%">결재양식</th>
					<th scope="col" width="9%">긴급</th>
					<th scope="col" width="30%">제목</th>
					<th scope="col" width="6%">첨부</th>
					<th scope="col" width="20%">문서번호</th>
					<th scope="col" width="8%">상태</th>
				</tr>
			</thead>
			<tbody>
				<%-- forEach문 사용해서 뿌려주기 시작 --%>
 				<c:forEach var="all" items="${requestScope.all}" begin="0" end="4" step="1" varStatus="status">
				<tr onclick="goView('${all.pk_appr_no}')" style="cursor: pointer;">
					<th scope="row" style="vertical-align: middle;"><p><c:out value="${status.count}" /></p></th>
					
					<td>${all.writeday}</td>
					
					<td>${all.appr_name}</td>
					
					<td>
						<c:if test="${all.emergency ne 0}">
							<button id="btn_emergency" class="btn btn-danger edmsBtn">긴급</button>
						</c:if>
					</td>
					
					<td>
						<span class="title">${all.title}</span>
					</td>
					
					<td>
						<c:if test="${all.filename ne null}">
						<img src="<%= ctxPath%>/resources/images/disk.gif" style="height: 16px; width: 16px;">
						</c:if>
					</td>
					
					<td>${all.pk_appr_no}</td>
					
					<td>
						<c:if test="${all.mid_accept eq 0 and all.fin_accept eq 0}">
							<button class="btn btn-secondary edmsBtn">대기중</button>
						</c:if>
						<c:if test="${all.mid_accept eq 1 and all.fin_accept eq 0}">
							<button class="btn btn-warning edmsBtn">진행중</button>
						</c:if>
						<c:if test="${all.mid_accept eq 1 and all.fin_accept eq 1}">
							<button class="btn btn-info edmsBtn">승인됨</button>
						</c:if>
						<c:if test="${all.mid_accept eq 2}">
							<button class="btn btn-dark edmsBtn">반려됨</button>
						</c:if>
						<c:if test="${all.mid_accept eq 1 and all.fin_accept eq 2}">
							<button class="btn btn-dark edmsBtn">반려됨</button>
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
		<%-- 모든문서 목록이 있을 때 종료 --%>
		
		<c:if test="${empty requestScope.all}">
		<%-- 모든문서 목록이 없을 때 시작 --%>
		<div class="divClear"></div>
		<table class="table table-sm table-light">
			<tr>
				<td style="border-top: solid 1px #D3D3D3;">&nbsp;</td>
			</tr>
			<tr>
				<td class="edmsListNone">결재대기 문서가 없습니다.</td>
			</tr>
			<tr>
				<td style="border-bottom: solid 1px #D3D3D3;">&nbsp;</td>
			</tr>
		</table>
		</c:if>
		<%-- 모든문서 목록이 없을 때 종료 --%>
		
	</div>
	</div>
	<!-- 모든문서 종료 -->
	
	
	
	<div class="divClear"></div>

	<!-- 결재승인 목록 시작 -->
	<div id="edms_accept">
		<span class="edms_title">결재승인 목록보기</span>
		
		<%-- 결재승인 목록이 있을 때 시작 --%>
		<div class="divClear"></div>
		<c:if test="${not empty requestScope.accept}">
		<table class="table table-sm table-hover table-light edmsTable">
			<thead class="thead-light">
				<tr>
					<th scope="col" width="4%">#</th>
					<th scope="col" width="13%">기안일</th>
					<th scope="col" width="10%">결재양식</th>
					<th scope="col" width="9%">긴급</th>
					<th scope="col" width="30%">제목</th>
					<th scope="col" width="6%">첨부</th>
					<th scope="col" width="20%">문서번호</th>
					<th scope="col" width="8%">상태</th>
				</tr>
			</thead>
			<%-- forEach문 사용해서 뿌려주기 시작 --%>
			<tbody>
 				<c:forEach var="accept" items="${requestScope.accept}" begin="0" end="4" step="1" varStatus="status">
				<tr onclick="goView('${accept.pk_appr_no}')" style="cursor: pointer;">
					<th scope="row"><p><c:out value="${status.count}" /></p></th>
					<td>${accept.writeday}</td>
					<td>${accept.appr_name}</td>
					<td>
						<c:if test="${accept.emergency ne 0}">
						<button id="btn_emergency" class="btn btn-danger edmsBtn">긴급</button>
						</c:if>
					</td>
					
					<td>
						<span class="title" onclick="goView('${accept.pk_appr_no}')" style="cursor: pointer;">${accept.title}</span>
					</td>
					
					<td>
						<c:if test="${accept.filename ne null}">
						<img src="<%= ctxPath%>/resources/images/disk.gif" style="height: 16px; width: 16px;">
						</c:if>
					</td>
					
					<td>${accept.pk_appr_no}</td>

					<td>
						<c:if test="${accept.mid_accept eq 1 and accept.fin_accept eq 0}">
							<button class="btn btn-warning edmsBtn">진행중</button>
						</c:if>
						<c:if test="${accept.fin_accept eq 1 and accept.fin_accept eq 1}">
							<button class="btn btn-info edmsBtn">승인됨</button>
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
		
		
		<%-- 결재승인 목록이 없을 때 시작 --%>
		<c:if test="${ empty requestScope.accept}">
		<div class="divClear"></div>
		<table class="table table-sm table-light">
			<tr>
				<td style="border-top: solid 1px #D3D3D3;">&nbsp;</td>
			</tr>
			<tr>
				<td class="edmsListNone">결재승인 문서가 없습니다.</td>
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
		<table class="table table-sm table-hover table-light edmsTable">
			<thead class="thead-light">
				<tr>
					<th scope="col" width="4%">#</th>
					<th scope="col" width="13%">기안일</th>
					<th scope="col" width="10%">결재양식</th>
					<th scope="col" width="9%">긴급</th>
					<th scope="col" width="30%">제목</th>
					<th scope="col" width="6%">첨부</th>
					<th scope="col" width="20%">문서번호</th>
					<th scope="col" width="8%">상태</th>
				</tr>
			</thead>
			<tbody>
				<%-- forEach문 사용해서 뿌려주기 시작 --%>
 				<c:forEach var="reject" items="${requestScope.reject}" begin="0" end="4" step="1" varStatus="status">
				<tr onclick="goView('${reject.pk_appr_no}')" style="cursor: pointer;">
					<th scope="row"><p><c:out value="${status.count}" /></p></th>
					<td>${reject.writeday}</td>
					<td>${reject.appr_name}</td>
					<td>
						<c:if test="${reject.emergency ne 0}">
						<button id="btn_emergency" class="btn btn-danger edmsBtn">긴급</button>
						</c:if>
					</td>
					<td>
						<span class="title" onclick="goView('${reject.pk_appr_no}')" style="cursor: pointer;">${reject.title}</span>
					</td>
					<td>
						<c:if test="${reject.filename ne null}">
						<img src="<%= ctxPath%>/resources/images/disk.gif" style="height: 16px; width: 16px;">
						</c:if>
					</td>
					<td>${reject.pk_appr_no}</td>
					<td>
						<button class="btn btn-dark edmsBtn">반려됨</button>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		</c:if>
		<div class="divClear"></div>
		
		
		
		<div class="divClear"></div>
		<%-- 결재반려 목록이 있을 때 종료 --%>
		<c:if test="${empty requestScope.reject}">
		<%-- 결재반려 목록이 없을 때 시작 --%>
		<div class="divClear"></div>
		<table class="table table-sm table-light">
			<tr>
				<td style="border-top: solid 1px #D3D3D3;">&nbsp;</td>
			</tr>
			<tr>
				<td class="edmsListNone">결재반려 문서가 없습니다.</td>
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