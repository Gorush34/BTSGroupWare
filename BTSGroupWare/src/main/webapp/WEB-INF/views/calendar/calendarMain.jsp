<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
 	String ctxPath = request.getContextPath();
%>

<%-- 캘린더 소스 --%>
<link href='<%=ctxPath %>/resources/fullcalendar_5.10.1/main.min.css' rel='stylesheet' />
    
<style type="text/css">

</style>

<!-- full calendar에 관련된 script -->
<script src='<%=ctxPath %>/resources/fullcalendar_5.10.1/main.min.js'></script>
<script src='<%=ctxPath %>/resources/fullcalendar_5.10.1/ko.js'></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>

<script type="text/javascript">

	

	$(document).ready(function(){
		
		
		$(document).on("click","input:checkbox[name=com_calno]",function(){	
			var com_smcatgonoArr = document.querySelectorAll("input.com_calno");
		    
			com_smcatgonoArr.forEach(function(item) {
		         item.addEventListener("change", function() {  // "change" 대신에 "click" 을 해도 무방함.
		         //	 console.log(item);
		        	 calendar.refetchEvents();  // 모든 소스의 이벤트를 다시 가져와 화면에 다시 표시합니다.
		         });
		    });// end of com_smcatgonoArr.forEach(function(item) {})---------------------
		  
		});// end of $(document).on("click","input:checkbox[name=com_smcatgono]",function(){})--------
		
		$(document).on("click","input:checkbox[name=my_calno]",function(){	
			var com_smcatgonoArr = document.querySelectorAll("input.my_calno");
		    
			com_smcatgonoArr.forEach(function(item) {
		         item.addEventListener("change", function() {  // "change" 대신에 "click" 을 해도 무방함.
		         //	 console.log(item);
		        	 calendar.refetchEvents();  // 모든 소스의 이벤트를 다시 가져와 화면에 다시 표시합니다.
		         });
		    });// end of com_smcatgonoArr.forEach(function(item) {})---------------------
		  
		});// end of $(document).on("click","input:checkbox[name=com_smcatgono]",function(){})--------
		
		
		// 모든 datepicker에 대한 공통 옵션 설정
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
	    	    
	    
		
		// === 캘린더 보여주기 (기본 틀) === //
		var calendarEl = document.getElementById('calendar');
		
		var calendar = new FullCalendar.Calendar(calendarEl, {
			initialView: 'dayGridMonth',
			locale: 'ko',
			selectable: true,
			editable: false,
			themeSystem: 'bootstrap',
			headerToolbar:{
				left: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth',
			    center: 'title',
			    right: 'today prevYear,prev,next,nextYear'
			},
			dayMaxEventRows: true, // for all non-TimeGrid views
		    views: {
		      timeGrid: {
		        dayMaxEventRows: 3 // adjust to 6 only for timeGridWeek/timeGridDay
		      }
		    },
		    // ===================== DB 와 연동 시작 ===================== //
		    events:function(info, successCallback, failureCallback){
		    	$.ajax({
	                 url: '<%= ctxPath%>/calendar/selectSchedule.bts',
	                 data:{"fk_emp_no":$('input#fk_emp_no').val(),
	                	  "emp_name":$('input#emp_name').val()},
	                 dataType: "json",
	                 success:function(json) {
	                	 
	                	 var events = [];
	                	 if(json.length > 0){
	                		 
	                		 $.each(json, function(index, item){
	                			var startdate = moment(item.startdate).format('YYYY-MM-DD HH:mm:ss');
	                			var enddate = moment(item.enddate).format('YYYY-MM-DD HH:mm:ss');
                                var subject = item.subject;
                 				
                                let str_checkbox_com_calno = sessionStorage.getItem('arr_checkbox_com_calno'); // 체크박스 값 가져오기 
                                let arr_checkbox_com_calno = str_checkbox_com_calno.split(",");
                                
                                let str_checkbox_com_calno_a = sessionStorage.getItem('arr_checkbox_com_calno_a'); // 체크박스 값 가져오기 
                                let arr_checkbox_com_calno_a = str_checkbox_com_calno_a.split(",");
                                
                                let str_checkbox_my_calno = sessionStorage.getItem('arr_checkbox_my_calno'); // 체크박스 값 가져오기 
                                let arr_checkbox_my_calno = "";
                                if(str_checkbox_my_calno != null && str_checkbox_my_calno != "" && str_checkbox_my_calno.length != 0){
                                	arr_checkbox_my_calno = str_checkbox_my_calno.split(",");
                                }
                                
                                let str_checkbox_my_calno_a = sessionStorage.getItem('arr_checkbox_my_calno_a'); // 체크박스 값 가져오기 
                                let arr_checkbox_my_calno_a = "";
                                if(str_checkbox_my_calno_a != null && str_checkbox_my_calno_a != "" && str_checkbox_my_calno_a.length != 0){
                                	arr_checkbox_my_calno_a = str_checkbox_my_calno_a.split(",");
                                }
                     
                                
                                //  console.log("캘린더 소분류 번호 1:"+arr_checkbox_com_calno);
                                //console.log("~~~~~~캘린더 소분류 번호 : " + $("input:checkbox[name=com_calno]:checked").length);
                                // 달력에 사내 캘린더 일정 보여주기
                                   if( arr_checkbox_com_calno.length <= arr_checkbox_com_calno_a.length ){
                                	
	                                   for(var i=0; i<arr_checkbox_com_calno.length; i++){
                                		
                                		   if(arr_checkbox_com_calno[i] == item.fk_calno){
                                		   // console.log("캘린더 소분류 번호 : " + arr_checkbox_com_calno[i]);
                                			events.push({
                                				id: item.pk_schno,
                                				title: item.subject,
                                				start: startdate,
                                				end: enddate,
                                				url : "<%= ctxPath%>/calendar/detailSchedule.bts?pk_schno="+item.pk_schno,
                                				color: item.color,
                                				cid: item.fk_calno // 사내캘린더 내의 서브캘린더 체크박스의 value값과 일치하도록 만들어야 한다. 그래야만 서브캘린더의 체크박스와 cid 값이 연결되어 체크시 풀캘린더에서 일정이 보여지고 체크해제시 풀캘린더에서 일정이 숨겨져 안보이게 된다.
                                			});// end of events.push({})---------
                                			
                                			//console.log("~~~~확인용 item.pk_schno : "+item.pk_schno)
                                			//console.log("~~~~확인용 event id : "+id)
                                		}
                                	}// end of for----------------------------------------
                                }// end of if---------------------------------------------
	                		
                                // 달력에 내 캘린더 일정 보여주기
                            //    console.log("~~~~~~캘린더 소분류 번호 : " + $("input:checkbox[name=my_calno]:checked").length);
                            //    if($("input:checkbox[name=my_calno]:checked").length <= $("input:checkbox[name=my_calno]").length)
                                  if( arr_checkbox_my_calno.length <= arr_checkbox_my_calno_a.length ){
                                	
                                
                                	for(var i = 0; i<arr_checkbox_my_calno.length; i++){
                                		
                                		if(arr_checkbox_my_calno[i] == item.fk_calno && item.fk_emp_no == "${sessionScope.loginuser.pk_emp_no}" ){
                                			events.push({
                                				id: item.pk_schno,
                                				title: item.subject,
                                				start: startdate,
                                				end: enddate,
                                				url : "<%= ctxPath%>/calendar/detailSchedule.bts?pk_schno="+item.pk_schno,
                                				color: item.color,
                                				cid: item.fk_calno
                                			}); // end of events.push({})---------
                                		}
                                	}// end of for------------------------------------------
                                }// end of if-----------------------------------------------
                                
                                // 공유 받은 캘린더
                                if (item.fk_lgcatgono==1 && item.fk_emp_no != "${sessionScope.loginuser.pk_emp_no}" && (item.joinuser).indexOf("${sessionScope.loginuser.emp_name}") != -1 ){  
                                    
                                   events.push({
                                	   			id: "0",  // "0" 인 이유는  배열 events 에 push 할때 id는 고유해야 하는데 위의 사내캘린더 및 내캘린더에서 push 할때 id값으로 item.pk_schno 을 사용하였다. item.pk_schno 값은 DB에서 1 부터 시작하는 시퀀스로 사용된 값이므로 0 값은 위의 사내캘린더나 내캘린더에서 사용되지 않으므로 여기서 고유한 값을 사용하기 위해 0 값을 준 것이다. 
                                                title: item.subject,
                                                start: startdate,
                                                end: enddate,
                                        	    url: "<%= ctxPath%>/calendar/detailSchedule.bts?pk_schno="+item.pk_schno,
                                                color: item.color,
                                                cid: "0"  // "0" 인 이유는  공유받은캘린더 에서의 체크박스의 value 를 "0" 으로 주었기 때문이다.
                                   }); // end of events.push({})--------- 
                                   
                           		}// end of if------------------------- 
                             
	                		 });// end of $.each(json, function(index, item) {})-----------------------
	                	 }
	                	 
	                	// console.log(events);    
	                	 successCallback(events);         
	                	 
	                 },
					  error: function(request, status, error){
				            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				      }	
	                                            
	            }); // end of $.ajax()--------------------------------
	        
		    }, // end of events:function(info, successCallback, failureCallback) {}---------------
		 // ===================== DB 와 연동 끝 ===================== //
		    
		 
		 // 풀캘린더에서 날짜 클릭할 때 발생하는 이벤트(일정 등록창으로 넘어간다)
	       dateClick: function(info) {
	      	//  alert('클릭한 Date: ' + info.dateStr); 
	      	    $(".fc-day").css('background','none'); // 현재 날짜 배경색 없애기
	      	    info.dayEl.style.backgroundColor = '#b1b8cd'; // 클릭한 날짜의 배경색 지정하기
	      	    $("form > input[name=chooseDate]").val(info.dateStr);
	      	    
	      	    var frm = document.dateFrm;
	      	    frm.action="<%= ctxPath%>/calendar/scheduleRegister.bts";
	      	    frm.method="POST";
	      	    frm.submit();
	      	  }, 
	      	// === 사내캘린더, 내캘린더, 공유받은캘린더의 체크박스에 체크유무에 따라 일정을 보여주거나 일정을 숨기게 하는 것이다. ===
		    eventDidMount: function (arg) {
		    	
		    	//let str_checkbox_calno = sessionStorage.getItem('arr_checkbox_calno'); // 체크박스 값 가져오기 
		    	//let arr_checkbox_calno = str_checkbox_calno.split(",");
		    	//console.log("확인용 :"+ arr_checkbox_calno);
	            var arr_calendar_checkbox = document.querySelectorAll("input.calendar_checkbox"); 
	            // 사내캘린더, 내캘린더, 공유받은캘린더 에서의 모든 체크박스임
	            //console.log("확인용 :"+ arr_calendar_checkbox);
	            arr_calendar_checkbox.forEach(function(item) { // item 이 사내캘린더, 내캘린더, 공유받은캘린더 에서의 모든 체크박스 중 하나인 체크박스임
		              if (item.checked) { 
		            	// 사내캘린더, 내캘린더, 공유받은캘린더 에서의 체크박스중 체크박스에 체크를 한 경우 라면
		                
		            	if (arg.event.extendedProps.cid === item.value) { // item.value 가 체크박스의 value 값이다.
		                	 //console.log("일정을 보여주는 cid : "  + arg.event.extendedProps.cid);
		                	 //console.log("일정을 보여주는 체크박스의 value값(item.value) : " + item.value);
		                    
		                	arg.el.style.display = "block"; // 풀캘린더에서 일정을 보여준다.
		                }
		              } 
		              
		              else { 
		            	// 사내캘린더, 내캘린더, 공유받은캘린더 에서의 체크박스중 체크박스에 체크를 해제한 경우 라면
		                
		            	if (arg.event.extendedProps.cid === item.value) {
		            		 //console.log("일정을 숨기는 cid : "  + arg.event.extendedProps.cid);
		                	 //console.log("일정을 숨기는 체크박스의 value값(item.value) : " + item.value);
		                	
		            		arg.el.style.display = "none"; // 풀캘린더에서 일정을  숨긴다.
		                }
		              }
	            });// end of arr_calendar_checkbox.forEach(function(item) {})------------
	      }
				
		}); // end of var calendar = = new FullCalendar.Calendar(calendarEl, {}--------------------------------------
		
		calendar.render(); // 캘린더 보여주기
		
		var arr_calendar_checkbox = document.querySelectorAll("input.calendar_checkbox"); 
		  // 사내캘린더, 내캘린더, 공유받은캘린더 에서의 체크박스임
		  
		  arr_calendar_checkbox.forEach(function(item) {
			  item.addEventListener("change", function () {
		      // console.log(item);
				 calendar.refetchEvents(); // 모든 소스의 이벤트를 다시 가져와 화면에 다시 표시합니다.
		    });
		  });
		  //==== 풀캘린더와 관련된 소스코드 끝(화면이 로드되면 캘린더 전체 화면 보이게 해줌) ==== //

		
		
		
		
		// 검색 할 때 엔터를 친 경우
		  $("input#searchWord").keyup(function(event){
			 if(event.keyCode == 13){ 
				 goSearch();
			 }
		  });
		
		
		
	});// end of $(document).ready(function(){}------------------------------------

			
	// Function declaration
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
		
	}// end of function goSearch(){}--------------------------
	
	// == 상세 검색 모달창 띄우기 == //
	function goSearchDetailModal(){
		$("#searchDetailModal").modal('show');
	}// end of function goSearchDetailModal(){
	
	
</script>

<div id="calendarMain">
<div class="d-flex align-items-center p-3 my-3 text-white bg-purple shadow-sm" style="background-color: #6F42C1;">
    <div class="lh-1" style="text-align: center; width: 100%;">
      <h1 class="h6 mb-0 text-white lh-1" style="font-size:22px; font-weight: bold; ">일정관리</h1>
    </div>
  </div>

	<%-- 검색바를 보여주는 곳 --%>
	<div id="calendarSearch" >
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
	
	<%-- 캘린더를 보여주는 곳 --%>
	<input type="hidden" value="${sessionScope.loginuser.pk_emp_no}" id="fk_emp_no"/>
	<input type="hidden" value="${sessionScope.loginuser.emp_name}" id="emp_name"/>
	<div id="calendar" style="margin: 60px 30px 50px 30px;"></div>

</div>



<%-- === 사내 캘린더 추가 Modal === --%>
<div class="modal fade" id="addComCalModal" role="dialog" data-backdrop="static">
  <div class="modal-dialog">
    <div class="modal-content">
    
      <!-- Modal header -->
      <div class="modal-header">
        <h4 class="modal-title">관심 캘린더 추가</h4>
        <button type="button" class="close modal_close" data-dismiss="modal">&times;</button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body">
       	<form name="modal_frm">
       	<table style="width: 100%;" class="table  ">
     			<tr>
     				<td style="text-align: left; ">소분류명</td>
     				<td><input type="text" class="addCom_calname"/></td>
     			</tr>
     			<tr>
     				<td style="text-align: left;">만든이</td>
     				<td style="text-align: left; padding-left: 5px;">${sessionScope.loginuser.emp_name}</td>
     			</tr>
     		</table>
       	</form>	
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
      	<button type="button" id="addCom" class="btn btn-primary btn-sm" onclick="goAddComCal()">추가</button>
        <button type="button" class="btn btn-outline-primary btn-sm modal_close" data-dismiss="modal">취소</button>
      </div>
      
    </div>
  </div>
</div>

<%-- === 사내 캘린더 수정 Modal === --%>
<div class="modal fade" id="editComCalModal" role="dialog" data-backdrop="static">
  <div class="modal-dialog">
    <div class="modal-content">
    
      <!-- Modal header -->
      <div class="modal-header">
        <h4 class="modal-title">사내 캘린더 수정</h4>
        <button type="button" class="close modal_close" data-dismiss="modal">&times;</button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body">
       	<form name="modal_frm">
       	<table style="width: 100%;" class="table">
     			<tr>
     				<td style="text-align: left; ">소분류명</td>
     				<td><input type="text" class="editCom_calname" /><input type="hidden" value="" class="editCom_pk_calno"></td>
     			</tr>
     			<tr>
     				<td style="text-align: left;">만든이</td>
     				<td style="text-align: left; padding-left: 5px;">${sessionScope.loginuser.emp_name}</td>
     			</tr>
     		</table>
       	</form>	
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
      	<button type="button" id="addCom" class="btn btn-primary btn-sm" onclick="goEditComCal()">수정</button>
          <button type="button" class="btn btn-outline-primary btn-sm modal_close" data-dismiss="modal">취소</button>
      </div>
      
    </div>
  </div>
</div>

<%-- === 내 캘린더 추가 Modal === --%>
<div class="modal fade" id="addMyCalModal" role="dialog" data-backdrop="static">
  <div class="modal-dialog">
    <div class="modal-content">
      
      <!-- Modal header -->
      <div class="modal-header">
        <h4 class="modal-title">내 캘린더 추가</h4>
        <button type="button" class="close modal_close" data-dismiss="modal">&times;</button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body">
          <form name="modal_frm">
       	<table style="width: 100%;" class="table">
     			<tr>
     				<td style="text-align: left; ">소분류명</td>
     				<td><input type="text" class="addMy_calname" /></td>
     			</tr>
     			<tr>
     				<td style="text-align: left;">만든이</td>
     				<td style="text-align: left; padding-left: 5px;">${sessionScope.loginuser.emp_name}</td> 
     			</tr>
     		</table>
     		</form>
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
      	<button type="button" id="addMy" class="btn btn-primary btn-sm" onclick="goAddMyCal()">추가</button>
          <button type="button" class="btn btn-outline-primary btn-sm modal_close" data-dismiss="modal">취소</button>
      </div>
      
    </div>
  </div>
</div>

<%-- === 내 캘린더 수정 Modal === --%>
<div class="modal fade" id="editMyCalModal" role="dialog" data-backdrop="static">
  <div class="modal-dialog">
    <div class="modal-content">
    
      <!-- Modal header -->
      <div class="modal-header">
        <h4 class="modal-title">내 캘린더 수정</h4>
        <button type="button" class="close modal_close" data-dismiss="modal">&times;</button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body">
      	<form name="modal_frm">
       	<table style="width: 100%;" class="table">
     			<tr>
     				<td style="text-align: left; ">소분류명</td>
     				<td><input type="text" class="editMy_calname"/><input type="hidden" value="" class="editMy_pk_calno"></td>
     			</tr>
     			<tr>
     				<td style="text-align: left;">만든이</td>
     				<td style="text-align: left; padding-left: 5px;">${sessionScope.loginuser.emp_name}</td>
     			</tr>
     		</table>
       	</form>
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
      	<button type="button" id="addCom" class="btn btn-primary btn-sm" onclick="goEditMyCal()">수정</button>
          <button type="button" class="btn btn-outline-primary btn-sm modal_close" data-dismiss="modal">취소</button>
      </div>
      
    </div>
  </div>
</div>

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
       	<table style="width: 100%;" class="table  ">
     			<tr>
     				<td style="text-align: left; ">일정명</td>
     				<td><input type="text" class="searchSubject" name="searchSubject" style="margin-right: 2px;"/></td>
     			</tr>
     			<tr>
     				<td style="text-align: left;">참석자</td>
     				<td><input type="text" class="searchJoinuser" name="searchJoinuser" style="margin-right: 2px;"/></td>
     			</tr>
     			<tr>
     				<td style="text-align: left;">일자</td>
     				<td>
     				<input type="date" class="searchDate" id="fromDate" name="startdate" style="width: 110px;" readonly="readonly">&nbsp;&nbsp; 
	            -&nbsp;&nbsp; <input type="date" class="searchDate" id="toDate" name="enddate" style="width: 110px;" readonly="readonly">&nbsp;&nbsp;
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


<%-- === 마우스로 클릭한 날짜의 일정 등록을 위한 폼 === --%>     
<form name="dateFrm">
	<input type="hidden" name="chooseDate" />	
</form>	