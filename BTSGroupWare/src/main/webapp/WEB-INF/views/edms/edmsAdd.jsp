<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	String ctxPath = request.getContextPath();
%>

<!-- style_edms.css 는 이미 layout-tiles_edms.jsp 에 선언되어 있으므로 쓸 필요 X! -->

<!-- datepicker를 사용하기 위한 링크 / 나중에 헤더에 추가되면 지우기 -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>

<!-- 긴급버튼 토글을 사용하기 위한 링크 -->
<!-- <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.3/jquery.min.js"></script> -->

<script type="text/javascript">
	
	
	/* 할 것: 문서양식 선택 안했을 때 alert 띄우기! */
	
	
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
		
		
		// 긴급버튼
		/* var check = $("input[type='checkbox']");
		check.click(function() {
			$("p").toggle();
		}); */

		// datepicker
		$("#datepicker").datepicker({
			showOn : "button",
			buttonImage : "<%= ctxPath%>/resources/images/calendar.gif",
			buttonImageOnly: true,
			buttonText: "Select date"
		});
		
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

	<!-- 문서작성 시작 -->
	<form name="addFrm">
	<div>
	
	<table style="width: 100%" class="table table-bordered">
		<tr>
			<th class="edmsView_th">문서양식</th>
          	<td colspan="4">
				<select name="emdsDocFormSelect">
					<!-- <optgroup label="일반"> -->
					<option value="">양식선택</option>
					<%--
					<c:forEach items="${docFormList}" var="form">
						<option value="${어쩌고.어쩌고no}">${어쩌고.어쩌고name}</option>
					</c:forEach>
					--%>
					<option value="edmsDocForm1">업무기안</option>
					<option value="edmsDocForm2">업무품의서</option>
					<option value="edmsDocForm3">증명서신청</option>
					<!-- </optgroup> -->
				</select>
			</td>
		</tr>
		
		<tr>
			<th class="edmsView_th">작성자</th>
          	<td colspan="4">김다우</td>
		</tr>
		<tr>
			<th class="edmsView_th">긴급</th>
			<td colspan="4">
				<label class="switch-button">
					<input type="checkbox" name="emergency" value="1" >&nbsp;긴급
					<%-- name 전달할 값의 이름, value 전달될 값 --%>
				</label>
			</td>
		</tr>
		
		<tr>
			<th class="edmsView_th" rowspan="2">
				<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnApprSelect" onclick="getAppr()">결재선 지정</button>
			</th>
			<td colspan="2" style="width: 30%;">부서1</td>
			<td style="width: 30%;">직급1</td>
			<td style="width: 30%;">이름1</td>
		</tr>
		
		<tr>
			<td colspan="2">부서1</td>
			<td>직급1</td>
			<td>이름1</td>
		</tr>
				
		<tr>
			<th class="edmsView_th">시행일자</th>
			<td colspan="4">
				<input type="text" id="datepicker">
			</td>
		</tr>
		<tr>
			<th class="edmsView_th">제목</th>
			<td colspan="4">
				<input type="text" name="subject" id="subject" size="100" style="width: 100%;"/>
			</td>
		</tr>
		<tr>
			<th class="edmsView_th">내용</th>
			<td colspan="4">
				<textarea style="width: 100%; height: 612px;" name="content" id="content"></textarea>
			</td>
		</tr>
		
		<tr>
			<th class="edmsView_th">파일첨부</th>
			<td colspan="4">
				<input type="file" name="attach" id="attach" size="100" style="width: 100%;" />
			</td>
		</tr>
	</table>
	</div>

	<div>
		<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnWrite">결재요청</button>
		<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">작성취소</button>
	</div>
	</form>
	<!-- 문서작성 종료 -->
	
	
	
	
	