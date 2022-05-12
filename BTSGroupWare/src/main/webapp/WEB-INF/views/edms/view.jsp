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
		frm.method = "POST";
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
<!-- <form name="viewfrm"> -->
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
          	<td style="background-color: #F7F7F7;">중간결재자 사번&nbsp;[${requestScope.apprvo.fk_mid_empno}]</td>
             
			<td rowspan="4" style="valign: center;">승인</td>
          	<td style="background-color: #F7F7F7;">최종결재자 사번&nbsp;[${requestScope.apprvo.fk_fin_empno}]</td>
		</tr>
		
		<tr>
			<th>작성자 <input type="text" value="${requestScope.apprvo.fk_emp_no}"></th> 
          	<td style="background-color: #F7F7F7;">${requestScope.apprvo.emp_name}&nbsp;[${requestScope.apprvo.ko_rankname}]</td>
          	<td rowspan="2" style="background-color: #F7F7F7;">중간결재자이름</td>
			<td rowspan="2" style="background-color: #F7F7F7;">최종결재자이름</td>
		</tr>
		
        <tr>
			<th>소속</th>
          	<td style="background-color: #F7F7F7;">${requestScope.apprvo.ko_depname}</td>
		</tr>
		
		<tr>
			<th>작성일자</th>
          	<td style="background-color: #F7F7F7;">${requestScope.apprvo.writeday}</td>
          	<td style="background-color: #F7F7F7;">결재상태</td>
			<td style="background-color: #F7F7F7;">결재상태</td>
		</tr>
	</table>
</form>
	</div>

	
	<span class="edms_title">상세정보</span>
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
				<th class="edmsView_th">내용</th>
				<td colspan="2">
					<p style="word-break: break-all;">
						${requestScope.apprvo.contents}
					<br/>
				</td>
			</tr>

			<tr>
				<th class="edmsView_th">첨부파일</th>
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
			</tr>
			<tr>
					<th>파일크기(bytes)</th>
					<td>
						<fmt:formatNumber value="${requestScope.apprvo.fileSize}" pattern="#,###" />
					</td>
			</tr>
		</table>
	
		<c:set var="v_gobackURL" value='${ fn:replace(requestScope.gobackURL, "&", " ") }' />
		
		<div style="margin-bottom: 1%;">
				이전글제목&nbsp;&nbsp;
				<span class="move" onclick="javascript:location.href='/bts/edms/view_2.bts?pk_appr_no=${requestScope.apprvo.previousseq}&searchType=${requestScope.paraMap.searchType}&searchWord=${requestScope.paraMap.searchWord}&gobackURL=${v_gobackURL}'">${requestScope.apprvo.previoussubject}</span>
			</div>
			<div style="margin-bottom: 1%;">
				다음글제목&nbsp;&nbsp;
				<span class="move" onclick="javascript:location.href='/bts/edms/view_2.bts?pk_appr_no=${requestScope.apprvo.nextseq}&searchType=${requestScope.paraMap.searchType}&searchWord=${requestScope.paraMap.searchWord}&gobackURL=${v_gobackURL}'">${requestScope.apprvo.nextsubject}</span>
			</div>
			
			<br />
			
			<button type="button" class="btn btn-secondary btn-sm mr-3" onclick="javascript:location.href='<%= request.getContextPath()%>/edms/list.bts'">전체목록보기</button>

			<%-- ====		페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
							사용자가 목록보기 버튼을 클릭했을 때 돌아갈 페이지를 알려주기 위해
							현재 페이지 주소를 뷰단으로 넘겨준다.
			--%>
			
			<%-- [오류]! 슬래쉬 들어가서 틀림
			<button type="button" class="btn btn-secondary btn-sm mr-3" onclick="javascript:location.href='<%= request.getContextPath()%>/${requestScope.goBackURL}'">검색된결과목록보기</button> 
			--%>
			
			<button type="button" class="btn btn-secondary btn-sm mr-3" onclick="javascript:location.href='<%= request.getContextPath()%>${requestScope.gobackURL}'">검색된결과목록보기</button>
			<button type="button" class="btn btn-secondary btn-sm mr-3" onclick="javascript:location.href='<%= request.getContextPath()%>/edms/edit.bts?pk_appr_no=${requestScope.apprvo.pk_appr_no}'">글수정하기</button>
			<button type="button" class="btn btn-secondary btn-sm mr-3" onclick="javascript:location.href='<%= request.getContextPath()%>/edms/del.bts?pk_appr_no=${requestScope.apprvo.pk_appr_no}'">글삭제하기</button>
			
<%--
	 <div style="margin: 20px;">
		<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnApprWrite">결재요청</button>
		<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnApprCancel">상신취소</button>
		상신취소는 문서삭제의 기능을 한다 !
		<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnAppredit">문서수정</button>
		<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnApprCancel">문서삭제</button>
	</div>
--%>
	
	
</c:if>