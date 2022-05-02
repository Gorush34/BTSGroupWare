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
		
		// 모든 datepicker에 대한 공통 옵션 설정
	/*    $.datepicker.setDefaults({
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
	    	    
	    // From의 초기값을 한달전 날짜로 설정
	    $('input#fromDate').datepicker('setDate', '-1M'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)
	    
	    // To의 초기값을 오늘 날짜로 설정
	//  $('input#toDate').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)	
		
	    // To의 초기값을 한달후 날짜로 설정
	    $('input#toDate').datepicker('setDate', '+1M'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, +1M:한달후, +1Y:일년후)	
		
	*/	
		// === 캘린더 보여주기 (기본 틀) === //
		var calendarEl = document.getElementById('calendar');
		
		var calendar = new FullCalendar.Calendar(calendarEl, {
			initialView: 'dayGridMonth',
			locale: 'ko',
			selectable: true,
			editable: true,
			themeSystem: 'bootstrap',
			headerToolbar:{
				left: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth',
			    center: 'title',
			    right: 'today prevYear,prev,next,nextYear'
			},
			events: 'https://fullcalendar.io/api/demo-feeds/events.json?overload-day',
			dayMaxEventRows: true, // for all non-TimeGrid views
		    views: {
		      timeGrid: {
		        dayMaxEventRows: 3 // adjust to 6 only for timeGridWeek/timeGridDay
		      }
		    },
		    events:function(){
		    	
		    }, // end of events:function(info, successCallback, failureCallback) {}---------------
		
		    // 풀캘린더에서 날짜 클릭할 때 발생하는 이벤트(일정 등록창으로 넘어간다)
	       dateClick: function(info) {
	      	 // alert('클릭한 Date: ' + info.dateStr); // 클릭한 Date: 2021-11-20
	      	    $(".fc-day").css('background','none'); // 현재 날짜 배경색 없애기
	      	    info.dayEl.style.backgroundColor = '#b1b8cd'; // 클릭한 날짜의 배경색 지정하기
	      	    $("form > input[name=chooseDate]").val(info.dateStr);
	      	    
	      	    var frm = document.dateFrm;
	      	    frm.method="POST";
	      	    frm.action="<%= ctxPath%>/calendar/schedualRegister.bts";
	      	    frm.submit();
	      	  }, 
		    eventDidMount: function(arg){
		    	
		    }
			
			
			
			
		}); // end of var calendar = = new FullCalendar.Calendar(calendarEl, {}--------------------------------------
		
		calendar.render(); // 캘린더 보여주기
	});// end of $(document).ready(function(){}------------------------------------

</script>

<div>
	<h4 style="margin: 0 80px">일정관리</h4>
	<%-- 검색바를 보여주는 곳 --%>
	<div id="search">
		<select id="searchType" name="searchType">
			<option>캘린더</option>
			<option>통합검색</option>
		</select>
		<input type="text" id="searchWord" name="searchWord" style="align: right;"/>
		<span id="detailSearch" style="font-size: 8pt; color:#99ccff;">상세 <i class="bi bi-caret-down-fill"></i></span>
		<button type="button" id="goSearch"><i class="bi bi-search"></i></button>
	</div>
	
	<%-- 캘린더를 보여주는 곳 --%>
	<div id="calendar" style="margin: 60px 30px 50px 60px;"></div>

</div>