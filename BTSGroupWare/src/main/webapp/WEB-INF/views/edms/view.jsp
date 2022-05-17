<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<%
	String ctxPath = request.getContextPath();
%>

<!-- style_edms.css 는 이미 layout-tiles_edms.jsp 에 선언되어 있으므로 쓸 필요 X! -->

<!-- datepicker를 사용하기 위한 링크 / 나중에 헤더에 추가되면 지우기 -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>

<style type="text/css">
</style>

<script type="text/javascript">
	
	$(document).ready(function(){	
		
		const frm = document.viewfrm;
		frm.method = "post";
		frm.action = "<%= ctxPath%>/edms/view.bts";
		frm.submit();
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

 	<span class="edms_title">기본정보</span>
	
	<c:if test="${empty requestScope.apprvo}">
		<table class="table table-sm table-light">
			<tr>
				<td style="border-top: solid 1px #D3D3D3;">&nbsp;</td>
			</tr>
			<tr>
				<td style="text-align: center; font-size: 12pt;">글이 존재하지 않습니다.</td>
			</tr>
			<tr>
				<td style="border-bottom: solid 1px #D3D3D3;">&nbsp;</td>
			</tr>
		</table>
	</c:if>
	
	<c:if test="${not empty requestScope.apprvo}">

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
          	
          	<td rowspan="4" style="vertical-align : center;">#</td>
          	<td style="background-color: #F7F7F7;">중간결재자</td>
             
			<td rowspan="4" style="vertical-align: center;">#</td>
          	<td style="background-color: #F7F7F7;">최종결재자</td>
		</tr>
		
		<tr>
			<th>작성자 <input type="hidden" value="${requestScope.apprvo.fk_emp_no}"></th>
          	<td style="background-color: #F7F7F7;">${requestScope.apprvo.emp_name}&nbsp;[${requestScope.apprvo.ko_rankname}]</td>
          	<td rowspan="2" style="background-color: #F7F7F7; vertical-align: middle; text-align: center;">${requestScope.apprname.fk_mid_empname}<br/>[${requestScope.apprvo.fk_mid_empno}]</td>
			<td rowspan="2" style="background-color: #F7F7F7; vertical-align: middle; text-align: center;">${requestScope.apprname.fk_fin_empname}<br/>[${requestScope.apprvo.fk_fin_empno}]</td>
		</tr>
		
        <tr>
			<th>소속</th>
          	<td style="background-color: #F7F7F7;">${requestScope.apprvo.ko_depname}</td>
		</tr>
		
		<tr>
			<th>작성일자</th>
          	<td style="background-color: #F7F7F7;">${requestScope.apprvo.writeday}</td>
          	<td style="background-color: #F7F7F7; text-align: center;">
          		<c:if test="${requestScope.apprvo.mid_accept eq 0}">대기중</c:if>
          		<c:if test="${requestScope.apprvo.mid_accept eq 1}"><span style="color:blue;">결재완료</span></c:if>
          		<c:if test="${requestScope.apprvo.mid_accept eq 2}"><span style="color:red;">반려</span><</c:if>
          	</td>
			<td style="background-color: #F7F7F7; text-align: center;">
          		<c:if test="${requestScope.apprvo.mid_accept ne 2 and requestScope.apprvo.fin_accept eq 0}">대기중</c:if>
          		<c:if test="${requestScope.apprvo.fin_accept eq 1}"><span style="color:blue;">결재완료</span></c:if>
          		<c:if test="${requestScope.apprvo.mid_accept eq 2 or requestScope.apprvo.fin_accept eq 2}"><span style="color:red;">반려</span></c:if>
          	</td>
		</tr>
	</table>
<!-- </form> 오류 폼으로 감싸면 view.bts? 뒤에 URL ? 이 안 온 다-->
	</div>

	
	<span class="edms_title">상세정보</span>
		<table style="width: 100%" class="table table-bordered">
			<colgroup>
				<col style="width: 16%; background-color: #e8e8e8;" />
			</colgroup>
			
			<tr>
				<th>제목</th>
				<td>
					<c:if test="${requestScope.apprvo.emergency == 1}">
						<span style="color: red; font-weight: bold;">[긴급]</span>&nbsp;
					</c:if>
					<span>${requestScope.apprvo.title}</span>
				</td>
			</tr>
			
<!-- 			<tr>
				<th class="edmsView_th">시행일자</th>
				<td colspan="2">
					2022년 05월 07일
				</td>
			</tr> -->
			
			<tr>
				<th>내용</th>
				<td colspan="2">
					<p style="word-break: break-all;">${requestScope.apprvo.contents}</p>
				</td>
			</tr>
			
			<tr>
				<th>첨부파일</th>
				<!-- 첨부파일이 있는 경우 시작 -->
				<c:if test="${requestScope.filename ne '' || requestScope.filename ne null }"> 
					<td>
						<%-- 로그인을 한 경우 --%>
						<c:if test="${sessionScope.loginuser != null}">
							<a href="<%= request.getContextPath()%>/edms/download.bts?pk_appr_no=${requestScope.apprvo.pk_appr_no}">${requestScope.apprvo.orgfilename}</a>
						</c:if>
						<%-- 로그인을 한 경우 --%>
						
						<%-- 로그인을 안 한 경우 --%>
						<c:if test="${sessionScope.loginuser == null}">
							${requestScope.apprvo.orgfilename}		<%-- 로그인을 안 했을 때는 진짜 파일명만 보여준다. --%>
						</c:if>
						<%-- 로그인을 안 한 경우 --%>
					</td>
				</c:if>				
			</tr>
			
			<tr>
				<th>파일크기(bytes)</th>
				<td>
					<fmt:formatNumber value="${requestScope.apprvo.fileSize}" pattern="#,###" />
				</td>
			</tr>
			<tr>
				<th>중간결재자 의견</th>
				<td>
					<input type="text" id="mid_opinion" name="mid_opinion" class="form-control-plaintext" value="${requestScope.apprvo.mid_opinion}" readonly/>
				</td>
			</tr>
			<tr>
				<th>최종결재자 의견</th>
				<td>
					<input type="text" id="fin_opinion" name="fin_opinion" class="form-control-plaintext" value="${requestScope.apprvo.fin_opinion}" readonly/>
				</td>
			</tr>
			
			
		</table>
	
		<c:set var="v_gobackURL" value='${ fn:replace(requestScope.gobackURL, "&", " ") }' />
		
		<div style="margin-bottom: 1%;">
			<span style="font-size: 11pt;">이전글</span>&nbsp;&nbsp;
			<span class="move" style="cursor: pointer;" onclick="javascript:location.href='/bts/edms/view.bts?pk_appr_no=${requestScope.apprvo.previousseq}&searchType=${requestScope.paraMap.searchType}&searchWord=${requestScope.paraMap.searchWord}&gobackURL=${v_gobackURL}'">${requestScope.apprvo.previoussubject}</span>
		</div>
		<div style="margin-bottom: 1%;">
			<span style="font-size: 11pt;">다음글</span>&nbsp;&nbsp;
			<span class="move" style="cursor: pointer; font-size: 12pt;" onclick="javascript:location.href='/bts/edms/view.bts?pk_appr_no=${requestScope.apprvo.nextseq}&searchType=${requestScope.paraMap.searchType}&searchWord=${requestScope.paraMap.searchWord}&gobackURL=${v_gobackURL}'">${requestScope.apprvo.nextsubject}</span>
		</div>
		
			
		<br/>
		
		<!-- 1. loginuser != null && 글쓴 사람이 아니고 승인자도 아닌 경우" -->
		<%-- 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후 사용자가 목록보기 버튼을 클릭했을 때 돌아갈 페이지를 알려주기 위해 현재 페이지 주소를 뷰단으로 넘겨준다. --%>
		
		<%-- 원래 있던 곳이 wait.bts인 경우 어떻게 받아오는지? --%>
		<c:if test="">
		</c:if>
		
		<button type="button" class="btn btn-dark btn-sm mr-3" onclick="javascript:location.href='<%= request.getContextPath()%>${requestScope.gobackURL}'">목록으로 돌아가기</button>
		
		
		<button type="button" class="btn btn-dark btn-sm mr-3" onclick="javascript:location.href='<%= request.getContextPath()%>${requestScope.gobackURL}'">검색결과 목록으로</button>
		<br/>
		
		<c:if test="${sessionScope.loginuser != null and sessionScope.loginuser.pk_emp_no eq apprvo.getFk_emp_no() and requestScope.apprvo.mid_accept eq 0}">
		<button type="button" class="btn btn-dark btn-sm mr-3" onclick="javascript:location.href='<%= request.getContextPath()%>/edms/edit.bts?pk_appr_no=${requestScope.apprvo.pk_appr_no}'">글수정하기</button>
		<button type="button" class="btn btn-dark btn-sm mr-3" onclick="javascript:location.href='<%= request.getContextPath()%>/edms/del.bts?pk_appr_no=${requestScope.apprvo.pk_appr_no}'">글삭제하기</button>
		</c:if>
		<br/>
		
<%-- 			<input type="text" class="form-control" value="1. sqlsession의 empno = 원글의 mid_emp_no인 경우 && mid_accept 0인 경우 && status = 1/ 2. sqlsession의 empno = 원글의 fin_emp_no인 경우 && mid_accept 1인 경우" readonly ><br/>
			<c:if test="${ requestScope.apprvo.fk_mid_empno eq sessionScope.loginuser.pk_emp_no
					   and requestScope.apprvo.mid_accept == 0
					   and requestScope.apprvo.status == 1 || requestScope.apprvo.fk_fin_empno eq sessionScope.loginuser.pk_emp_no and requestScope.apprvo.mid_accept eq 0 }">
				<button type="button" class="btn btn-success btn-sm mr-3" onclick="javascript:location.href='<%= request.getContextPath()%>/edms/appr/accept.bts?pk_appr_no=${requestScope.apprvo.pk_appr_no}'">문서승인</button>
				<button type="button" class="btn btn-danger btn-sm mr-3" onclick="javascript:location.href='<%= request.getContextPath()%>/edms/appr/reject.bts?pk_appr_no=${requestScope.apprvo.pk_appr_no}'">문서반려</button>
			</c:if> --%>
		
		
		<input type="hidden" value="${requestScope.apprvo.mid_accept }">
		<input type="hidden" value="${requestScope.apprvo.fin_accept }">
		
		<%-- 1. 중간결재자가 로그인 한 경우 - 중간버튼만 보인다. --%>
		<c:if test="${ requestScope.apprvo.fk_mid_empno eq sessionScope.loginuser.pk_emp_no and requestScope.apprvo.mid_accept eq 0 and requestScope.apprvo.fin_accept eq 0 }">
			<%-- 중간결재자 버튼 시작 --%>
			<button type="button" class="btn btn-success btn-sm mr-3" onclick="javascript:location.href='<%= request.getContextPath()%>/edms/appr/accept.bts?pk_appr_no=${requestScope.apprvo.pk_appr_no}'">중간결재1</button>
			<button type="button" class="btn btn-success btn-sm mr-3" onclick="javascript:location.href='<%= request.getContextPath()%>/edms/appr/reject.bts?pk_appr_no=${requestScope.apprvo.pk_appr_no}'">중간반려</button>
			<%-- 중간결재자 버튼 종료 --%>
			
			<%-- 중간결재자 의견 시작 --%>
			
			<%-- 중간결재자 의견 종료 --%>
		</c:if>
		
		<%-- 2.최종결재자가 로그인 한 경우 - 최종버튼만 보인다. --%>
		<c:if test="${ requestScope.apprvo.fk_fin_empno eq sessionScope.loginuser.pk_emp_no and requestScope.apprvo.mid_accept ne 0 and requestScope.apprvo.fin_accept eq 0 }">
			<button type="button" class="btn btn-danger btn-sm mr-3" onclick="javascript:location.href='<%= request.getContextPath()%>/edms/appr/accept.bts?pk_appr_no=${requestScope.apprvo.pk_appr_no}'">최종결재</button>
			<button type="button" class="btn btn-danger btn-sm mr-3" onclick="javascript:location.href='<%= request.getContextPath()%>/edms/appr/reject.bts?pk_appr_no=${requestScope.apprvo.pk_appr_no}'">최종반려</button>
		</c:if>
		
		<br/>
	
	<!-- 중간/최종 결재 승인을 텍스트보다는 색깔로 구분 -->
	
</c:if>