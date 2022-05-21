<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
 
<%
	String ctxPath = request.getContextPath();
%>

<!-- style_edms.css 는 이미 layout-tiles_edms.jsp 에 선언되어 있으므로 쓸 필요 X! -->
<style type="text/css">
	.edmsviewtbl {
		vertical-align : middle;
		text-align: center;
	}
</style>

<!-- datepicker를 사용하기 위한 링크 / 나중에 헤더에 추가되면 지우기 -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>

<style type="text/css">
</style>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		// 글삭제
		$("button#btnDelete").click(function(){
		/* $("button#btnDelete").on("click", function(e) { */
			// 폼(form)을 전송(submit)
			const frm = document.delFrm;
			frm.method = "post";
			frm.action = "<%= ctxPath%>/edms/delEnd.bts";
			frm.submit();
		}); // end of $("button#btnDelete").click(function()) --------------------
		
		
	}); // end of $(document).ready(function(){}) --------------------

	
</script>


<style>
	/* 문서보기 페이지 테이블 th 부분 */
	.edmsView_th {
		width: 15%;
		background-color: #F7F7F7;
	}
	
</style>

<%-- layout-tiles_edms.jsp의 #mycontainer 과 동일하므로 굳이 만들 필요 X --%>
<div class="edmsDiv">
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

	<table style="width: 100%" class="table">
		<colgroup>
		<col style="width: 16%; background-color: #F7F7F7; border: solid 1px #F7F7F7;" />
		<col style="width: 24%; border: solid 1px #F7F7F7;" />
		<col style="width: 32%; border: solid 1px #F7F7F7;" />
		<col style="width: 4%; background-color: #F7F7F7; border: solid 1px #F7F7F7;" />
		<col style="width: 8%; border: solid 1px #F7F7F7;" />
		<col style="width: 4%; background-color: #F7F7F7; border: solid 1px #F7F7F7;" />
		<col style="width: 8%; border: solid 1px #F7F7F7;" />
		</colgroup>
		
		<tr>
			<th>문서양식</th>
          	<td>
				<c:if test="${requestScope.apprvo.fk_appr_sortno == 1}">업무기안서</c:if>
				<c:if test="${requestScope.apprvo.fk_appr_sortno == 2}">증명서신청</c:if>
				<c:if test="${requestScope.apprvo.fk_appr_sortno == 3}">사유서</c:if>
			</td>
             
          	<td rowspan="4" style="border-top: solid 1px #F2F2F2; border-bottom: solid 1px #F2F2F2;">
          		&nbsp; <%-- 큰구분선1 --%>
          	</td>
          	
          	<td rowspan="4" class="edmsviewtbl">중<br/>간<br/>결<br/>재<br/>자</td>
          	<td class="edmsviewtbl">${requestScope.apprvo.ko_depname}</td>
             
			<td rowspan="4" class="edmsviewtbl">최<br/>종<br/>결<br/>재<br/>자</td>
          	<td class="edmsviewtbl">${requestScope.apprvo.ko_depname}</td>
		</tr>
		
		<tr>
			<th>작성자 <input type="hidden" value="${requestScope.apprvo.fk_emp_no}"></th>
          	<td>${requestScope.apprvo.emp_name}&nbsp;[${requestScope.apprvo.ko_rankname}]</td>
          	<td rowspan="2" class="edmsviewtbl">${requestScope.apprname.fk_mid_empname}<br/>[${requestScope.apprvo.fk_mid_empno}]</td>
			<td rowspan="2" class="edmsviewtbl">${requestScope.apprname.fk_fin_empname}<br/>[${requestScope.apprvo.fk_fin_empno}]</td>
		</tr>
		
        <tr>
			<th>소속</th>
          	<td>${requestScope.apprvo.ko_depname}</td>
		</tr>
		
		<tr>
			<th>작성일자</th>
          	<td>${requestScope.apprvo.writeday}</td>
          	<td class="edmsviewtbl">
          		<c:if test="${requestScope.apprvo.mid_accept eq 0}">대기중</c:if>
          		<c:if test="${requestScope.apprvo.mid_accept eq 1}"><span style="color:blue;">결재완료</span></c:if>
          		<c:if test="${requestScope.apprvo.mid_accept eq 2}"><span style="color:red;">반려</span></c:if>
          	</td>
			<td class="edmsviewtbl">
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
				<col style="width: 16%; background-color: #F7F7F7;" />
			</colgroup>
			
			<tr>
				<th style="vertical-align: middle; text-align: left;">제목</th>
				<td style="vertical-align: middle; text-align: left;">
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
				<th style="vertical-align: middle; text-align: left;">내용</th>
				<td colspan="2">
					<p style="word-break: break-all; vertical-align: middle; text-align: left; margin-bottom: none;" class="form-control-plaintext" >${requestScope.apprvo.contents}</p>
				</td>
			</tr>
			
			<tr>
				<th>첨부파일</th>
				<!-- 첨부파일이 있는 경우 시작 -->
				<c:if test="${requestScope.apprvo.filename ne '' || requestScope.apprvo.filename ne null }"> 
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
				<th style="word-break: break-all; vertical-align: middle; text-align: left;">중간결재자 의견</th>
				<td>
					<c:if test="${requestScope.apprvo.mid_opinion ne null or requestScope.apprvo.mid_opinion ne ''}">
						<input type="text" id="mid_opinion_readonly" name="mid_opinion_readonly" class="form-control-plaintext" value="${requestScope.apprvo.mid_opinion}" readonly/>
					</c:if>
				</td>
			</tr>
			<tr>
				<th style="word-break: break-all; vertical-align: middle; text-align: left;">최종결재자 의견</th>
				<td>
					<input type="text" id="fin_opinion" name="fin_opinion" class="form-control-plaintext" value="${requestScope.apprvo.fin_opinion}" readonly/>
				</td>
			</tr>
			
			
		</table>
	
		<c:set var="v_gobackURL" value='${ fn:replace(requestScope.gobackURL, "&", " ") }' />
		
		<br/>
		
	<div class="edmsViewBtnArea">
	
	<%-- ************************************************** 목록으로 버튼 영역 시작 ************************************************** --%>
	
		<%-- 1. loginuser != null && 글쓴 사람이 아니고 승인자도 아닌 경우" --%>
		<%-- 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후 사용자가 목록보기 버튼을 클릭했을 때 돌아갈 페이지를 알려주기 위해 현재 페이지 주소를 뷰단으로 넘겨준다. --%>
		<div style="float: left;">
		<button type="button" class="btn btn-dark btn-sm mr-3" onclick="javascript:location.href='<%= request.getContextPath()%>${requestScope.gobackURL}'">목록으로</button>
		</div>
		
		<div style="float: left;">
		<button type="button" class="btn btn-dark btn-sm mr-3" onclick="javascript:location.href='<%= request.getContextPath()%>${requestScope.gobackURL}'">뒤로가기</button>
		</div>
		
		<div class="divclear" style="margin-top: 16px;"></div>

	<%-- ************************************************** 수정 버튼 영역 시작 ************************************************** --%>
		
		<%-- 2. 로그인한유저=글쓴이사번 && 중간결재전이면 수정/삭제 버튼 보이도록 --%>
		
		<div style="float: left;">
			<%-- 수정버튼 --%>
			<c:if test="${sessionScope.loginuser.pk_emp_no eq apprvo.getFk_emp_no() and requestScope.apprvo.mid_accept eq 0}">
				<button type="button" class="btn btn-dark btn-sm mr-3" onclick="javascript:location.href='<%= request.getContextPath()%>/edms/edit.bts?pk_appr_no=${requestScope.apprvo.pk_appr_no}'">수정하기</button>
			</c:if>
		</div>
		
		<div style="float: left;">
			<%-- 삭제버튼 --%>
			<form name="delFrm">
				<input type="hidden" name="pk_appr_no" value="${requestScope.apprvo.pk_appr_no}">
				<input type="hidden" name="fk_emp_no" value="${requestScope.apprvo.fk_emp_no}">
				<c:if test="${sessionScope.loginuser.pk_emp_no eq apprvo.getFk_emp_no() and requestScope.apprvo.mid_accept eq 0}">
					<button type="button" class="btn btn-primary btn-sm" id="btnDelete">삭제하기</button>
				</c:if>
			</form>			
		</div>
		
		
		<input type="hidden" value="${requestScope.apprvo.mid_accept}">
		<input type="hidden" value="${requestScope.apprvo.fin_accept}">
		
		<div class="divclear" style="margin-top: 16px;"></div>
		
	<%-- ************************************************** 결재/반려 버튼 영역 시작 ************************************************** --%>
	
		<%-- 3. 중간결재자가 로그인 한 경우 - 중간버튼만 보인다. --%>
		<c:if test="${ requestScope.apprvo.fk_mid_empno eq sessionScope.loginuser.pk_emp_no and requestScope.apprvo.mid_accept eq 0 and requestScope.apprvo.fin_accept eq 0 }">
			<button type="button" class="btn btn-success btn-sm mr-3" onclick="javascript:location.href='<%= request.getContextPath()%>/edms/appr/accept.bts?pk_appr_no=${requestScope.apprvo.pk_appr_no}'">중간결재</button>
			<button type="button" class="btn btn-danger btn-sm mr-3" onclick="javascript:location.href='<%= request.getContextPath()%>/edms/appr/reject.bts?pk_appr_no=${requestScope.apprvo.pk_appr_no}'">중간반려</button>
		</c:if>
		
		<div class="divclear"></div>
		
		<%-- 4. 최종결재자가 로그인 한 경우 - 최종버튼만 보인다. --%>
		<c:if test="${ requestScope.apprvo.fk_fin_empno eq sessionScope.loginuser.pk_emp_no and requestScope.apprvo.mid_accept ne 0 and requestScope.apprvo.fin_accept eq 0 }">
			<button type="button" class="btn btn-success btn-sm mr-3" onclick="javascript:location.href='<%= request.getContextPath()%>/edms/appr/accept.bts?pk_appr_no=${requestScope.apprvo.pk_appr_no}'">최종결재</button>
			<button type="button" class="btn btn-danger btn-sm mr-3" onclick="javascript:location.href='<%= request.getContextPath()%>/edms/appr/reject.bts?pk_appr_no=${requestScope.apprvo.pk_appr_no}'">최종반려</button>
		</c:if>
		
		<div class="divclear"></div>		
	</div>
	<%-- ************************************************** 수정 버튼 영역 종료 ************************************************** --%>
	
	
	
	
	<%-- ************************************************** 삭제 버튼 모달 시작 ************************************************** --%>
	
	<%--
	<div class="modal fade" id="myModal" role="dialog"> 
	<div class="modal-dialog"> 
	<div class="modal-content"> 
		<div class="modal-header"> 
		
		<h2 class="modal-title">삭제하시겠습니까?</h2> 
		
		<button type="button" class="close" data-dismiss="modal">
		×
		</button> 
		
		</div> 
		<div class="modal-body">
		<div style="display: flex;">
		
		<div style="margin: auto; padding-left: 3%;">
		<form name="delFrm">
			<table style="width: 455px" class="table table-bordered">
				<tr>
					<td>
						<input type="hidden" name="pk_appr_no" value="${apprvo.pk_appr_no}" readonly />
						<input type="hidden" name="filename" value="${apprvo.filename}" readonly />
						<input type="hidden" name="fk_emp_no" value="${apprvo.fk_emp_no}" readonly />
					</td>
				</tr>
			</table>
			
			<div style="margin: 20px;">
				<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnDelete">삭제하기</button>
				<button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">취소하기</button>
			</div>
		</form>   
		</div>
	</div>    
	</div> 
	</div> 
	</div> 
	</div>
	--%>
	
	<%-- ************************************************** 삭제 버튼 모달 종료 ************************************************** --%>
	
	
	
	
</c:if>

</div>