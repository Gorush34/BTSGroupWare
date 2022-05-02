<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>

<!-- style_edms.css 는 이미 layout-tiles_edms.jsp 에 선언되어 있으므로 쓸 필요 X! -->

<script type="text/javascript">
	
	$(document).ready(function(){
		
		// 글쓰기 버튼
		$("button#btnWrite").click(function() {
			
			// 글제목 유효성 검사
			const subject = $("input#subject").val().trim();
			if(subject == "") {
				alert("글제목을 입력하세요!!");
				return;
			}
			
			// 글내용 유효성 검사
			const content = $("textarea#content").val().trim();
			if(content == "") {
				alert("글내용을 입력하세요!!");
				return;
			}
			
			// 글암호 유효성 검사
			const pw = $("input#pw").val();
			if(pw == "") {
				alert("글암호를 입력하세요!!");
				return;
			}
			
			// 폼(form)을 전송(submit)
			const frm = document.addFrm;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/edmsAddEnd.bts";
			frm.submit();
			
		}); // end of $("button#btnWrite").click(function(){}) --------------------
		
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
		<span class="edms_maintitle">문서작성</span>
		<p style="margin-bottom: 10px;"></p>
	</div>

	<form name="addFrm">
	<!-- 문서작성 시작 -->
	<div id="edms_view_auto">
	
	<span class="edms_title">기본정보</span>
	
		<table style="width: 100%" class="table table-bordered">
			<colgroup>
				<col style="width: 15%; background-color: #e8e8e8;">
				<col style="width: 30%;" />
				<col style="width: 15%; background-color: #e8e8e8;">
				<col />
			</colgroup>
			
			<tr>
				<th class="edmsView_th">문서양식</th>
				<td>
					<select>
						<optgroup label="일반">
							<option value="edmsGen1">업무기안</option>
							<option value="edmsGen2">업무협조</option>
							<option value="edmsGen3">업무품의서</option>
							<option value="edmsGen4">회계품의서</option>
						</optgroup>
						
						<optgroup label="지원">
							<option value="edmsSupp1">헤외출장신청</option>
							<option value="edmsSupp2">경조화신청</option>
							<option value="edmsSupp3">차량사고보고</option>
							<option value="edmsSupp4">하도급계약요청서</option>
							<option value="edmsSupp4">증명서신청(개인)</option>
							<option value="edmsSupp4">증명서신청(회사)</option>
						</optgroup>		
					</select>
				</td>
				
				<td colspan="3" rowspan="4">
					<span>결재선 지정</span>&nbsp;<button type="button" class="btn btn-outline-dark">조직도 검색</button>
				</td>
				<td colspan="4">중간</td>
				<td colspan="2">최종</td>
			</tr>
					
			
			<tr>
				<th class="edmsView_th">작성자 [소속]</th>
				<td>
					<input type="hidden" name="fk_userid" value="${sessionScope.loginuser.userid}" readonly="readonly"/>
					<span>김다우</span>
				</td>
				<td colspan="4">대리</td>
				<td colspan="4">비비빅</td>
				<td colspan="4">도장꽝</td>
			</tr>
			
			<tr>
				<th class="edmsView_th">소속</th>
				<td>
					<input type="hidden" name="fk_userid" value="${sessionScope.loginuser.userid}" readonly="readonly"/>
					<span>IT팀</span>
				</td>
				<td colspan="4">본부장</td>
				<td colspan="4">수박바</td>
				<td colspan="4">도장꽝</td>
			</tr>

			<tr>
				<th class="edmsView_th">작성일자</th>
				<td>2022년 05월 02일</td>
				<td>-</td>
			</tr>
			
		</table>
	</div>
	</form>
	
	<!-- 문서작성 종료 -->
	
	
	<span class="edms_title">상세정보</span>
	<form name="addFrm">
	<table style="width: 1024px" class="table table-bordered">
		<tr>
			<th style="width: 15%; background-color: #DDDDDD">성명</th>
			<td>
				<%-- BoardVO(이것도 그대로?) 에서 가져오는 것이다! MemberVO 가 아님을 유의하자! --%>
				<%-- 이 view단은 어차피 로그인해야지만 볼 수 있는 곳이기 때문에 sessionScope을 사용한다 --%>
				<%-- readonly 변경불가! --%>
				<input type="hidden" name="fk_userid" value="${sessionScope.loginuser.userid}" />
				<input type="text" name="name" value="${sessionScope.loginuser.name}" readonly />
			</td>
		</tr>
		
		<tr>
			<th style="width: 15%; background-color: #DDDDDD">제목</th>
			<td>
				<input type="text" name="subject" id="subject" size="100" />
			</td>
		</tr>
		
		<tr>
			<th style="width: 15%; background-color: #DDDDDD">글내용</th>
			<td>
				<textarea style="width: 100%; height: 612px;" name="content" id="content"></textarea>
				<%-- 15% 쓰고 남은 85%의 100%를 쓰겠다는 뜻! --%>
			</td>
		</tr>
		
		<tr>
			<th style="width: 15%; background-color: #DDDDDD">글암호</th>
			<td>
				<input type="password" name="pw" id="pw" size="100" />
			</td>
		</tr>
		
	</table>
	
	<div style="margin: 20px;">
		<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnWrite">글쓰기</button>
		<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">취소</button>
	</div>
	
	</form>
	</div>
</div>