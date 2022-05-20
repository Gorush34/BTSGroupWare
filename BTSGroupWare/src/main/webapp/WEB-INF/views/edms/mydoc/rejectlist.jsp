<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String ctxPath = request.getContextPath();
%>

<!-- style_edms.css 는 이미 layout-tiles_edms.jsp 에 선언되어 있으므로 쓸 필요 X! -->

<script type="text/javascript">
	$(document).ready(function() {

		
		$("input#searchWord").keyup(function(event) {
			if(event.keyCode == 13) { // 엔터를 했을 경우
				goSearch();
			}
		});
		
		// 검색시 검색조건 및 검색어 값 유지시키기
		if( ${not empty requestScope.paraMap} ) {
			$("select#searchType").val("${requestScope.paraMap.searchType}");
			$("input#searchWord").val("${requestScope.paraMap.searchWord}");
		}
		
		/* ********** 자동글 완성하기 시작 ********** */
		$("div#searchAutoComplete").hide();
		
		$("input#searchWord").keyup(function() {
			const wordLength = $(this).val().trim().length;
			// 검색어의 길이를 알아온다.
			
			if(wordLength == 0) {
				$("div#searchAutoComplete").hide();
				// 검색어가 공백이거나 검색어 입력후 백스페이스키를 눌러서 검색어를 모두 지우면 검색된 내용이 안 나오도록 해야 한다.
			}
			else {
				$.ajax({
					url:"<%= ctxPath%>/edms/wordSearchShow.bts",
					type:"GET",
					data:{"searchType":$("select#searchType").val()
						 ,"searchWord":$("input#searchWord").val()},
					dataType:"JSON",
					success:function(json) {
						// json => [{"word":"Korea VS Japan 라이벌 축구대결"},{"word":"JSP 가 뭔가요?"},{"word":"프로그램은 JAVA 가 쉬운가요?"},{"word":"java가 재미 있나요?"}]
						
						<%-- === 검색어 입력시 자동글 완성하기 === --%>
						if(json.length > 0) {
							// 검색된 데이터가 있는 경우임
							let html = "";
							$.each(json, function(index, item) { // item ==> {"word":"프로그램은 JAVA 가 쉬운가요?"}, key값은 word
								const word = item.word;
								// word ==> 프로그램은 JAVA 가 쉬운가요?
								
								const idx = word.toLowerCase().indexOf($("input#searchWord").val().toLowerCase());
								// 			word ==> 프로그램은 java 가 쉬운가요?
								// 검색어(JaVa)가 나오는  idx는  6이 된다(0부터 세고 공백도 세니까)
								
								const len = $("input#searchWord").val().length;
																
								// substr은 오라클과 같고, substring은 java와 같다!
							
								const result = word.substring(0, idx) + "<span style='color: blue;'>" + word.substring(idx, idx+len) + "</span>" + word.substring(idx+len);
								
								html += "<span style='cursor: pointer;' class='result'>" +result + "</span><br>";
							});
							
							// 검색창 크기 바꾸기
							const input_width = $("input#searchWord").css("width"); // 검색창의 크기
							$("div#searchAutoComplete").css({"width":input_width}); // 검색결과 div의 width 크기를 검색어 입력 input 태그의 width와 일치시키기
							
							// 결과 보이기
							$("div#searchAutoComplete").html(html);
							$("div#searchAutoComplete").show();
						}
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
				});
			}
		}); // $("input#searchWord").keyup() --------------------
		
		// on 을 사용하면 변경 이후의 이벤트가 변경된다.
		$(document).on("click", "span.result", function() {
			const word = $(this).text();
			$("input#searchWord").val(word);		// 텍스트 박스에 검색된 결과의 문자열을 입력해준다.
			$("div#searchAutoComplete").hide();		// 선택한 것 외에는 숨기기
			goSearch();
		});
		/* ********** 자동글 완성하기 종료 ********** */
		
	});
	
	// Function Declaration
	function goView(pk_appr_no) {
	<%--			
		location.href = "<%= ctxPath%>/view.bts?pk_appr_no="+pk_appr_no;
	--%>

	// === 페이징 처리되어진 후 특정 글제목을 클릭하여 상세내용을 본 이후
	//	사용자가 목록보기 버튼을 클릭했을 때 돌아갈 페이지를 알려주기 위해	
	//	현재 페이지 주소를 뷰단으로 넘겨준다.
	
		const gobackURL = "${requestScope.gobackURL}"; // 자꾸 빨간줄 뜸
		
	//	alert("list 단에서 확인용 gobackURL : " + gobackURL);

		const searchType = $("select#searchType").val();	// form 태그의 select!
		const searchWord = $("input#searchWord").val();	
		
		location.href = "<%= ctxPath%>/edms/view.bts?pk_appr_no="+pk_appr_no+"&gobackURL="+gobackURL+"&searchType="+searchType+"&searchWord="+searchWord;
				
	} // end of function goView(pk_appr_no)

	function goSearch(){
		const frm = document.searchFrm;
		frm.method = "GET";
		frm.action = "<%= ctxPath%>/edms/mydoc/rejectlist.bts";
		frm.submit();
	} // end of function goSearch() --------------------
	
	
</script>

<%-- layout-tiles_edms.jsp의 #mycontainer 과 동일하므로 굳이 만들 필요 X --%>


<div class="edmsDiv">
	<div class="edmsHomeTitle">
		<span class="edms_maintitle">${sessionScope.loginuser.emp_name}님의 반려문서함</span>
		<p style="margin-bottom: 10px;"></p>
	</div>
	
	<!-- 모든문서 시작 -->
	<span class="edms_title"> 
		<input type="hidden" name="fk_emp_no" value="${sessionScope.loginuser.pk_emp_no}" />
		<input type="hidden" class="form-control-plaintext" type="text" name="name" value="${sessionScope.loginuser.emp_name}" readonly />
	</span>
		
	<div class="divClear"></div>

	<!-- 문서목록 시작 -->
	<div id="edmsList">
		<span class="edms_title">문서목록보기</span>
			
		<div class="divClear"></div>

		<%-- 결재반려 목록이 없을 때 시작 --%>
		<c:if test="${empty requestScope.myrejectlist}">
		<table class="table table-sm table-light">
			<tr>
				<td style="border-top: solid 1px #D3D3D3;">&nbsp;</td>
			</tr>
			<tr>
				<td style="text-align: center; font-size: 14pt;">문서가 없습니다.</td>
			</tr>
			<tr>
				<td style="border-bottom: solid 1px #D3D3D3;">&nbsp;</td>
			</tr>
		</table>
		</c:if>
		<%-- 결재반려 목록이 없을 때 종료 --%>
		
		<%-- 결재반려 목록이 있을 때 종료 --%>
		<c:if test="${not empty requestScope.myrejectlist}">
		<table class="table table-sm table-hover table-light edmsTable ellipsisTable">
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
				<c:forEach var="reject" items="${requestScope.myrejectlist}" varStatus="status">
				<tr onclick="goView('${reject.pk_appr_no}')" style="cursor: pointer;">
					<th scope="row" style="vertical-align: middle;"><c:out value="${status.count}" /></th>
					
					<td>${reject.writeday}</td>
					
					<td>${reject.appr_name}</td>
					
					<td>
					<c:if test="${reject.emergency == 1}">
						<button id="btn_emergency" class="btn btn-outline-danger disabled edmsBtn">긴급</button>
					</c:if>
					<c:if test="${reject.emergency == 0}">
						&nbsp;
					</c:if>
					</td>
					
					<td class="elltitle">
						<span class="title" onclick="goView('${reject.pk_appr_no}')" style="cursor: pointer;">${reject.title}</span>
					</td>
					
					<td>
						<%-- 첨부파일이 있는 경우 --%>
						<c:if test="${not empty reject.filename}">
							<img src="<%= ctxPath%>/resources/images/disk.gif" style="height: 16px; width: 16px;">
						</c:if>
						<%-- 첨부파일이 없는 경우 --%>
						<c:if test="${empty reject.filename}">&nbsp;</c:if>
					</td>
					
					<td>${reject.pk_appr_no}</td>
					
					<td>
						<c:if test="${reject.mid_accept eq 0 and reject.fin_accept eq 0}">
							<button class="btn btn-outline-dark disabled edmsBtn">대기중</button>
						</c:if>
						<c:if test="${reject.mid_accept eq 1 and reject.fin_accept eq 0}">
							<button class="btn btn-outline-info disabled edmsBtn">진행중</button>
						</c:if>
						<c:if test="${reject.mid_accept eq 1 and reject.fin_accept eq 1}">
							<button class="btn btn-info edmsBtn">승인됨</button>
						</c:if>
						<c:if test="${reject.mid_accept eq 2}">
							<button class="btn btn-dark edmsBtn">반려됨</button>
						</c:if>
						<c:if test="${reject.mid_accept eq 1 and reject.fin_accept eq 2}">
							<button class="btn btn-dark edmsBtn">반려됨</button>
						</c:if>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<div class="divClear"></div>
		</c:if>
		<%-- 결재반려 목록이 있을 때 종료 --%>
		
		<div class="divClear"></div>
		
		
		<%-- === 페이지바 보여주기 --%>
		<div align="center" style="border: solid 0px grey; width: 70%; margin: 20px auto;">
			${requestScope.pageBar}
		</div>
		
		<%-- === 글검색 폼 추가하기 : 글제목, 글쓴이로 검색을 하도록 한다. === --%>
		<form name="searchFrm" style="margin-top: 20px;">
			<select name="searchType" id="searchType" style="height: 26px; display: none;">
				<option value="title">&nbsp;</option>
				<!-- <option value="emp_name">글쓴이</option> -->
			</select>
			<input type="text" name="searchWord" id="searchWord" class="form-control" placeholder="제목을 입력하세요" style="width: 20%;" size="40" autocomplete="off" />
			<input type="text" style="display: none;" class="form-control"/>
			<%-- form 태그내에 input 태그가 오로지 1개일 경우에는 엔터를 했을 경우 검색이 되어지므로 이것을 방지하고자 만든것이다. hidden으로 해도 바로 submit되어버리므로 안된다! --%>
			<button type="button" class="btn btn-secondary btn-sm" onclick="goSearch()">검색</button>
		</form>
		
		<%-- === 검색어 입력 시  자동글 완성하기 === --%>
		<div id="searchAutoComplete" style="border:solid 1px gray; border-top:0px; height:100px; margin-left:75px; margin-top:-1px; overflow:auto;">
		</div>
		
	</div>
	<!-- 결재반려 문서목록 종료 -->
	
	
	<div class="divClear"></div>
</div>