<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
 	String ctxPath = request.getContextPath();
%>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("tr.scheduleSearchResult").click(function(){
			//	console.log($(this).html());
				var pk_schno = $(this).children(".pk_schno").text();
				goDetail(pk_schno);
			});
			
		// 검색 할 때 엔터를 친 경우
	    $("input#searchWord").keyup(function(event){
		   if(event.keyCode == 13){ 
			  goSearch();
		   }
	    });
		
	    $.datepicker.setDefaults({
	         dateFormat: 'yy-mm-dd'  // Input Display Format 변경
	        ,showOtherMonths: true   // 빈 공간에 현재월의 앞뒤월의 날짜를 표시
	        ,showMonthAfterYear:true // 년도 먼저 나오고, 뒤에 월 표시
	        ,changeYear: true        // 콤보박스에서 년 선택 가능
	        ,changeMonth: true       // 콤보박스에서 월 선택 가능                
	        ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'] //달력의 월 부분 텍스트
	        ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
	        ,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트
	        ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'] //달력의 요일 부분 Tooltip 텍스트             
	    });
		
	    // input 을 datepicker로 선언
	    $("input#fromDate").datepicker();                    
	    $("input#toDate").datepicker();
	    	    
	    
		
	});// end of $(document).ready(function()----------------------

	
	// Function declaration
	
	// == 상세 보기 == //
	function goDetail(pk_schno){
		var frm = document.goDetailFrm;
		frm.pk_schno.value = pk_schno;
		
		frm.method="get";
		frm.action="<%= ctxPath%>/calendar/detailSchedule.bts";
		frm.submit();
	} // end of function goDetail(pk_schno){}-------------------------- 
			
	
	// === 검색 기능 === //
	function goSearch(){

		if( $("input#searchWord").val()=="" ) {
			alert("검색어를 입력하세요!!");
			return;
		}
		
		
	   	var frm = document.calendarSearchFrm;
	    frm.method="get";
	    frm.action="<%= ctxPath%>/calendar/calendarSearch.bts";
	    frm.submit();
		
	}// end of function goSearch(){}--------------------------
	
	function goSearch_1(){

		
		if( $("input.searchSubject").val()=="" && $("input.searchJoinuser").val()=="" && $("input.searchDate").val()=="" ) {
			alert("검색어를 입력하세요!!");
			return;
		}
		
		if( $("#fromDate").val() > $("#toDate").val() ) {
			alert("검색 시작날짜가 검색 종료날짜 보다 크므로 검색할 수 없습니다.");
			return;
		}
	
	
   	var frm = document.calendarSearchFrm_1;
    frm.method="get";
    frm.action="<%= ctxPath%>/calendar/calendarSearch.bts";
    frm.submit();
	}// end of function goSearch_1(){}--------------------------
	
	// == 상세 검색 모달창 띄우기 == //
	function goSearchDetailModal(){
		$("#searchDetailModal").modal('show');
	}// end of function goSearchDetailModal(){---------------------------
	
			
</script>



<div id="searchResult">
	<h4 style="margin: 0 80px">검색 목록</h4>
	<%-- 검색바를 보여주는 곳 --%>
		<div id="calendarSearch">
			<form name="calendarSearchFrm">
				<select id="searchType" name="searchType">
					<option value="calendar">캘린더</option>
				</select>
				<input type="text" id="searchWord" name="searchWord" style="align: right;"/>
				<span id="detailSearch" style="font-size: 8pt; color:#99ccff;" onclick="goSearchDetailModal()">상세 <i class="bi bi-caret-down-fill"></i></span>
				<input type="hidden" name="fk_emp_no" value="${sessionScope.loginuser.pk_emp_no}"/>
				<a id="goSearch" style="vertical-align: middle; margin-left: 5px; cursor: pointer;" onclick="goSearch()"><i class="bi bi-search"></i></a>
			</form>
		</div>
		<div id="searchList">
			<div id="searchWordList" style="border: solid 1px #00ace6; border-radius: 20px; background-color:#00ace6; color:white; margin: 30px 20px 0 20px; padding: 10px; width: 70%;">
				&nbsp;&nbsp;검색어&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;&nbsp;&nbsp;&nbsp;
				<c:if test="${not empty requestScope.paraMap.searchWord}">
				${requestScope.paraMap.searchWord}
				</c:if>
				<c:if test="${not empty requestScope.paraMap.searchSubject}">
				[일정명]&nbsp;&nbsp;${requestScope.paraMap.searchSubject}&nbsp;&nbsp;&nbsp;&nbsp;
				</c:if>
				<c:if test="${not empty requestScope.paraMap.searchJoinuser}">
				[참석자]&nbsp;&nbsp;${requestScope.paraMap.searchJoinuser}&nbsp;&nbsp;&nbsp;&nbsp;
				</c:if>
				<c:if test="${not empty requestScope.paraMap.startdate}">
				[기간]&nbsp;&nbsp;${requestScope.paraMap.startdate} ~ ${requestScope.paraMap.enddate} 
				</c:if>
			</div>
			
		<%-- 검색 결과 목록 --%>
		<div id="searchListContent" style="margin: 0 20px 0 20px;">
			<table id="searchListContentTable" class="table table-hover" style="margin: 50px 0 30px 0;">
				<thead>
					<tr>
						<th>날짜</th>
						<th>일정명</th>
						<th>내용</th>
						<th>장소</th>
						<th>참석자</th>
						<th>작성자</th>
					</tr>	
				</thead>
				
				<tbody>
				<c:if test="${empty requestScope.calendarSearchList}">
					<tr>
						<td colspan="6" style="text-align: center;">검색 결과가 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${not empty requestScope.calendarSearchList}">
					<c:forEach var="map" items="${requestScope.calendarSearchList}">
						<tr class="scheduleSearchResult">
							<td style="display: none;" class="pk_schno">${map.PK_SCHNO}</td>
							<td>${map.STARTDATE} - ${map.ENDDATE}</td>
							<td>${map.SUBJECT}</td>
							<td>${map.CONTENT}</td>
							<td>${map.PLACE}</td>
							<td>${map.JOINUSER}</td>
							<td>${map.EMP_NAME}</td>
						</tr>
					</c:forEach>
				</c:if>
				</tbody>
			</table>
			
			<div align="center" style="width: 70%; border: solid 0px gray; margin: 20px auto;">${requestScope.pageBar}</div> 
   		    <div style="margin-bottom: 20px;">&nbsp;</div>
		</div>
	</div>
</div>
<form name="goDetailFrm"> 
   <input type="hidden" name="pk_schno"/>
   <input type="hidden" name="listgobackURL_schedule" value="${requestScope.listgobackURL_schedule}"/>
</form>


<%-- === 상세 검색창 모달 === --%>
<div class="modal fade" id="searchDetailModal" role="dialog" data-backdrop="static">
  <div class="modal-dialog">
    <div class="modal-content">
    
      <!-- Modal header -->
      <div class="modal-header">
        <h5 class="modal-title">상세검색</h5>
        <button type="button" class="close modal_close" data-dismiss="modal">&times;</button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body">
      	<form name="calendarSearchFrm_1">
       	<table style="width: 100%;" class="table" id="calendarDetailSearch">
     			<tr>
     				<td style="text-align: left; padding:8px;">일정명</td>
     				<td><input type="text" class="searchSubject" name="searchSubject" /></td>
     			</tr>
     			<tr>
     				<td style="text-align: left;  padding:8px;">참석자</td>
     				<td><input type="text" class="searchJoinuser" name="searchJoinuser" /></td>
     			</tr>
     			<tr>
     				<td style="text-align: left;  padding:8px;">일자</td>
     				<td>
     				<input type="date" class="searchDate" id="fromDate" name="startdate" style="width: 130px;" readonly="readonly">&nbsp;&nbsp; 
	            -&nbsp;&nbsp; <input type="date" class="searchDate" id="toDate" name="enddate" style="width: 130px;" readonly="readonly">&nbsp;&nbsp;
					</td>
     			</tr>
     		</table>
     		<input type="hidden" name="fk_emp_no" value="${sessionScope.loginuser.pk_emp_no}"/>
       	</form>
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
      	<button type="button" id="searchDetailbtn" class="btn btn-primary btn-sm" onclick="goSearch_1()">검색</button>
          <button type="button" class="btn btn-outline-primary btn-sm modal_close" data-dismiss="modal">취소</button>
      </div>
      
    </div>
  </div>
</div>
