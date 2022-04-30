<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
 	String ctxPath = request.getContextPath();
	//     /board
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
		    dateClick: function(info){
		    	
		    },
		    eventDidMount: function(arg){
		    	
		    }
			
			
			
			
		}); // end of var calendar = = new FullCalendar.Calendar(calendarEl, {}--------------------------------------
		
		calendar.render(); // 캘린더 보여주기
	});// end of $(document).ready(function(){}------------------------------------

</script>

<div>

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