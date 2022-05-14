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
	      timeZone: 'UTC',
	      initialView: 'timeGridWeek',
	      headerToolbar: {
	        left: 'prev,next today',
	        center: 'title',
	        right: 'timeGridWeek,timeGridDay'
	      },
	      events: function(info, successCallback, failureCallback){
	    	     $.ajax({
	                 url: '<%= ctxPath%>/resource/reservationView.bts',
	                 data:{"pk_rno":$('pk_rno').val()},
	                 dataType: "json",
	                 success:function(json) {
	                	 var events = [];
	                     if(json.length > 0){
	                         
	                             $.each(json, function(index, item) {
	                                    var startdate = moment(item.startdate).format('YYYY-MM-DD HH:mm:ss');
	                                    var enddate = moment(item.enddate).format('YYYY-MM-DD HH:mm:ss');
	                                    var emp_name = item.emp_name ;
	                                   // console.log("캘린더 소분류 번호 : " + $("input:checkbox[name=com_smcatgono]:checked").length);
	                                   // 사내 캘린더로 등록된 일정을 풀캘린더 달력에 보여주기 
	                                   // 일정등록시 사내 캘린더에서 선택한 소분류에 등록된 일정을 풀캘린더 달력 날짜에 나타내어지게 한다.
	                                   if( $("input:checkbox[name=com_smcatgono]:checked").length <= $("input:checkbox[name=com_smcatgono]").length ){
		                                   
		                                   for(var i=0; i<$("input:checkbox[name=com_smcatgono]:checked").length; i++){
		                                	  
		                                		   if($("input:checkbox[name=com_smcatgono]:checked").eq(i).val() == item.fk_smcatgono){
		   			                               //  alert("캘린더 소분류 번호 : " + $("input:checkbox[name=com_smcatgono]:checked").eq(i).val());
		                                			   events.push({
		   			                                	            id: item.scheduleno,
		   			                                                title: item.subject,
		   			                                                start: startdate,
		   			                                                end: enddate,
		   			                                        	    url: "<%= ctxPath%>/schedule/detailSchedule.action?scheduleno="+item.scheduleno,
		   			                                                color: item.color,
		   			                                                cid: item.fk_smcatgono  // 사내캘린더 내의 서브캘린더 체크박스의 value값과 일치하도록 만들어야 한다. 그래야만 서브캘린더의 체크박스와 cid 값이 연결되어 체크시 풀캘린더에서 일정이 보여지고 체크해제시 풀캘린더에서 일정이 숨겨져 안보이게 된다. 
		   			                                   }); // end of events.push({})---------
		   		                                   }
		                                	   
		                                   }// end of for-------------------------------------
		                                 
	                                 }// end of if-------------------------------------------
	                             });
	                     }
	                                                             
	                 },
					  error: function(request, status, error){
				            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				      }	
	                                           
	            }); // end of $.ajax()--------------------------------
	         
	                	 
	      },
	      selectable: true,
	        selectHelper: true,
	        select: function(start, end) {
	            // Display the modal.
	            // You could fill in the start and end fields based on the parameters
	            $('.modal').modal('show');

	        },
	        eventClick: function(event, element) {
	            // Display the modal and set the values to the event values.
	            $('.modal').modal('show');
	            $('.modal').find('#title').val(event.title);
	            $('.modal').find('#starts-at').val(event.start);
	            $('.modal').find('#ends-at').val(event.end);

	        }<%--,
	      dateClick: function(info) {
		      	//  alert('클릭한 Date: ' + info.dateStr); 
		      	    $(".fc-day").css('background','none'); // 현재 날짜 배경색 없애기
		      	    info.dayEl.style.backgroundColor = '#b1b8cd'; // 클릭한 날짜의 배경색 지정하기
		      	  $("#reservateModal").modal('show');
		      	    // $("form > input[name=chooseDate]").val(info.dateStr);
		      	    
		      	   // var frm = document.dateFrm;
		      	   // frm.method="POST";
		      	    frm.action="<%= ctxPath%>/calendar/scheduleRegister.bts"; 
		      	   // frm.submit();
		      	  }--%>
	    });

	    calendar.render();
	    
	  });// end of $(document).ready(function(){}------------------------------------

			
	function goResourceReservation(pk_rno){
		location.href="<%= ctxPath%>/reservation/reservationMain.bts?pk_rno="+pk_rno;
	  }
		
	

	
	// == 상세 검색 모달창 띄우기 == //
	function goSearchDetailModal(){
		$("#reservateModal").modal('show');
	}// end of function goSearchDetailModal(){
	
	
</script>

<div id="resourceSide" style=" min-height:1200px; position: fixed; top:60px; padding-top: 40px; float:left; width:250px;">
	<h4>자원관리</h4>
	<ul style="list-style-type: none; padding: 10px;">
	 <c:if test="${not empty requestScope.classList}">
	 <c:forEach var="map" items="${requestScope.classList}" varStatus="status">
		<li style="margin-bottom: 15px;">
			<div id="resourceClass" class="resourceClass" style="font-weight: bold; color:#00ace6;"><input type="hidden" value="${map.PK_CLASSNO}">${map.CLASSNAME}</div>
				<div id="slideTogglebox1"  class="slideTogglebox" style="margin: 5px 0 5px 10px;">
					<table>
						<c:if test="${not empty requestScope.resourceList}">
							<c:forEach var="map2" items="${requestScope.resourceList}">
							<c:if test="${map.PK_CLASSNO eq map2.PK_CLASSNO}">
							<tr>
								<td style="padding: 3px; cursor: pointer;" onclick="goResourceReservation('${map2.PK_RNO}')"><input type="hidden" id="resource" name="pk_rno" value="${map2.PK_RNO}">${map2.RNAME}</td>
							</tr>
							</c:if>
							</c:forEach>
							
						</c:if>
					</table>
				</div>
		</li>
		</c:forEach>
		</c:if>
	</ul>
	

</div>

<div id="reservateMain" style="margin-left:250px;">
	<h4 style="margin: 0 80px">예약하기</h4>
	
	<%-- 캘린더를 보여주는 곳 --%>
	<input type="hidden" value="${sessionScope.loginuser.pk_emp_no}" id="fk_emp_no"/>
	<input type="hidden" value="${sessionScope.loginuser.emp_name}" id="emp_name"/>
	<div id="calendar" style="margin: 60px 30px 50px 60px;"></div>

</div>


<%-- === 예약창 모달 === --%>
<div class="modal fade" id="reservateModal" role="dialog" data-backdrop="static">
  <div class="modal-dialog  modal-lg">
    <div class="modal-content">
    
      <!-- Modal header -->
      <div class="modal-header">
        <h5 class="modal-title">예약</h5>
        <button type="button" class="close modal_close" data-dismiss="modal">&times;</button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body">
      	<form name="reservateFrm">
       	<table style="width: 100%;" class="table  ">
     			<tr>
     				<td style="text-align: left; ">예약일</td>
     				<td><input type="datetime-local" id="fromDate" name="startdate" >&nbsp;&nbsp; 
	            ~&nbsp;&nbsp; <input type="datetime-local" id="toDate" name="enddate" >&nbsp;&nbsp;</td>
     			</tr>
     			<tr>
     				<td style="text-align: left;">예약자</td>
     				<td>${sessionScope.loginuser.emp_name}</td>
     			</tr>
     		</table>
     		<input type="hidden" name="fk_emp_no" value="${sessionScope.loginuser.pk_emp_no}"/>
       	</form>
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
      	<button type="button" id="searchDetailbtn" class="btn btn-primary btn-sm" onclick="goReservation()">예약</button>
          <button type="button" class="btn btn-outline-primary btn-sm modal_close" data-dismiss="modal">취소</button>
      </div>
      
    </div>
  </div>
</div>


<%-- === 마우스로 클릭한 날짜의 일정 등록을 위한 폼 ===    
<form name="dateFrm">
	<input type="hidden" name="chooseDate" />	
</form>	--%>  