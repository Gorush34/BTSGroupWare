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
	
	$(document).ready(function(){
		
		<%-- === 스마트 에디터 구현 시작 === --%>
		//전역변수
		var obj = [];	
		
       //스마트에디터 프레임생성
		nhn.husky.EZCreator.createInIFrame({
			oAppRef: obj,
			elPlaceHolder: "contents",
			sSkinURI: "<%= ctxPath%>/resources/smarteditor/SmartEditor2Skin.html",
			htParams : {
				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseToolbar : true,
				// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseVerticalResizer : false,
				// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
				bUseModeChanger : false,
			}
		});
		<%-- === 스마트 에디터 구현 끝 === --%>
		
		
		
		// 글쓰기 버튼
		$("button#btnWrite").click(function() {
		
			<%-- === 스마트 에디터 구현 시작 === --%>
			//id가 contents인 textarea에 에디터에서 대입
			obj.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
			<%-- === 스마트 에디터 구현 끝 === --%>
			
			
			// 문서양식 선택여부 검사
			const docform = $("select#docform").val();
			console.log("양식선택 확인 : " + docform);
			
			// 카테고리를 선택하지 않은 경우 에러 메시지 출력
			if ($("select#docform option:selected").length == 0) {
				alert("글제목을 입력하세요!!");
				return;
			}
			
			
			// 긴급버튼 체크 시 값 전달
			$("input:checkbox[name=emergency]").each(function(index, item) {
				const emergency = $(item).is(":checked");
				
				if(emergency == true) { // 체크박스에 체크가 된 경우
					emergency = 1;
					return;
				}
			});
			
			// 제목 유효성 검사
			const subject = $("input#subject").val().trim();
			if(subject == "") {
				alert("글제목을 입력하세요!!");
				return;
			}
			
			// 내용 유효성 검사(스마트 에디터 사용 안 할 시)
			<%--
			const contents = $("textarea#contents").val().trim();
			if(contents == "") {
				alert("글내용을 입력하세요!!");
				return;
			}
			--%>
			
			<%-- === 스마트에디터 구현 시작 === --%>
			// 스마트에디터 사용시 무의미하게 생기는 p태그 제거
			var contentval = $("textarea#contents").val();
	              
			// === 확인용 ===
			// alert(contentval); // content에 내용을 아무것도 입력치 않고 쓰기할 경우 알아보는것.
			// "<p>&nbsp;</p>" 이라고 나온다.
	           
			// 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기전에 먼저 유효성 검사를 하도록 한다.
			// 글내용 유효성 검사 
			if(contentval == "" || contentval == "<p>&nbsp;</p>") {
				alert("내용을 입력하세요!!");
				return;
			}
	           
			// 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기
			contentval = $("textarea#contents").val().replace(/<p><br><\/p>/gi, "<br>"); //<p><br></p> -> <br>로 변환
			
			/*    
				대상문자열.replace(/찾을 문자열/gi, "변경할 문자열");
				==> 여기서 꼭 알아야 될 점은 나누기(/)표시안에 넣는 찾을 문자열의 따옴표는 없어야 한다는 점입니다. 
				그리고 뒤의 gi는 다음을 의미합니다.
				
				g : 전체 모든 문자열을 변경 global
				i : 영문 대소문자를 무시, 모두 일치하는 패턴 검색 ignore
			 */    

			contentval = contentval.replace(/<\/p><p>/gi, "<br>"); //</p><p> -> <br>로 변환  
			contentval = contentval.replace(/(<\/p><br>|<p><br>)/gi, "<br><br>"); //</p><br>, <p><br> -> <br><br>로 변환
			contentval = contentval.replace(/(<p>|<\/p>)/gi, ""); //<p> 또는 </p> 모두 제거시
	       
			$("textarea#contents").val(contentval);
	        
			// alert(contentval);
			<%-- === 스마트에디터 구현 끝 === --%>			
			
			
			
			
			// 폼(form)을 전송(submit)
			const frm = document.addFrm;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/edmsAddEnd.bts";
		//	frm.submit();
			
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
	<form name="addFrm" enctype="multipart/form-data">
	<div>
	
	<table style="width: 100%" class="table table-bordered">
		<tr>
			<th class="edmsView_th">문서양식</th>
          	<td colspan="4">
				<select name="docform" id="docform">
					<option value="">양식선택</option>
					<%-- ApprVO에서 가져오나 ApprSortVO에서 가져오나? --%>
					<c:forEach var="map" items="${requestScope.fk_appr_sortno}" var="form">
						<option value="${requestScope.fk_appr_sortno}">${requestScope.fk_appr_sortno}</option>
					</c:forEach>
				</select>
			</td>
		</tr>
		
		<tr>
			<th class="edmsView_th">작성자</th>
          	<td colspan="4">
          		<!-- EmployeeVO 가 아닌 ApprVO 에서 가져오는 것이다! 근데 왜 굳이 EmployeeVO를 놔두고? 모르겠음 -->
          		<%-- 이 view단은 어차피 로그인해야지만 볼 수 있는 곳이기 때문에 sessionScope을 사용한다 / 컨트롤러에서 loginuser에 userid라고 저장해줬으니까 이렇게?--%>
				<input type="text" name="fk_userid" value="${sessionScope.loginuser.userid}" />
				<input type="text" name="name" value="${sessionScope.loginuser.emp_name}" readonly />
				
			</td>
		</tr>
		<tr>
			<th class="edmsView_th">긴급</th>
			<td colspan="4">
				<label class="switch-button">
					<input type="checkbox" id="emergency" name="emergency" value="1" >&nbsp;긴급
					<%-- name 전달할 값의 이름, value 전달될 값 --%>
				</label>
			</td>
		</tr>
		
		<tr>
			<th class="edmsView_th" rowspan="2">
				<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnApprSelect" onclick="getAppr()">결재선 지정</button>
			</th>
			<td colspan="2" style="width: 30%;">부서1</td>
			<td style="width: 30%;">직급1 : ${requestScope.fk_mid_approver_no}</td>
			<td style="width: 30%;">이름1 : ${requestScope.fk_fin_approver_no}</td>
		</tr>
		
		<tr>
			<td colspan="2">부서1</td>
			<td>직급1</td>
			<td>이름1</td>
		</tr>
		
		<!--		
		<tr>
			<th class="edmsView_th">시행일자</th>
			<td colspan="4">
				<input type="text" id="datepicker" name="">
			</td>
		</tr>
		-->
		
		<tr>
			<th class="edmsView_th">제목</th>
			<td colspan="4">
				<input type="text" name="subject" id="subject" size="100" style="width: 100%;"/>
			</td>
		</tr>
		<tr>
			<th class="edmsView_th">내용</th>
			<td colspan="4">
				<textarea style="width: 100%; height: 612px;" name="contents" id="contents"></textarea>
			</td>
		</tr>
		
		<!-- <tr>
			<th class="edmsView_th">파일첨부</th>
			<td colspan="4">
				<input type="file" name="attach" id="attach" size="100" style="width: 100%;" />
			</td>
		</tr> -->
	</table>
	</div>

	<div>
		<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnWrite">결재요청</button>
		<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">작성취소</button>
	</div>
	</form>
	<!-- 문서작성 종료 -->
	
	
	
	
	