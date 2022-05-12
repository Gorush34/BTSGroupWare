<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<%
 	String ctxPath = request.getContextPath();
%>
    
<%-- 예약 캘린더 소스 --%>    
<link href="<%=ctxPath %>/resources/reservationcalendarcss/mobiscroll.javascript.min.css" rel="stylesheet" />

<!-- 예약 calendar에 관련된 script -->
<script src="https://code.highcharts.com/gantt/highcharts-gantt.js"></script>
<script src="https://code.highcharts.com/gantt/modules/exporting.js"></script>
<script src="https://code.highcharts.com/gantt/modules/accessibility.js"></script>



<script type="text/javascript">

	$(document).ready(function(){
		

		
		
	});// end of $(document).ready(function(){}----------------------------
	
	// function declaration
	

		
	// == 예약하기 == //
	function goReservate(pk_rno){


		
	}// end of function goReservation(){}-----------------------------
		
		
</script>

<div id="reservationMain" >
<h4 style="margin: 0 80px">예약하기</h4>
	<div class="scrolling-container">
		<div id="container" style="margin: 30px auto;"></div>
	</div>
	
	<div>
		<h5 style="margin: 30px 0 30px 80px">자산별 상세 정보</h5>
		<div style="margin: 0 20px 0 20px;">
		<table id="resourceListContentTable" class="table table-hover" style="margin: 50px 0 30px 0;">
			<thead>
				<tr>
					<th>항목</th>
					<th>유의점</th>
					<th style="text-align: center;">예약</th>
				</tr>
			</thead>
			<tbody>
				<c:if test="${not empty requestScope.resourceList}">
					<c:forEach var="map" items="${requestScope.resourceList}">
						<tr class="resourceList">
							<td><input type="hidden" name="pk_rno" value="${map.PK_RNO}"/></td>
							<td>${map.RNAME}</td>
							<td>${map.RINFO}</td>
							<td style="text-align: center;"><button type="button" class="btn btn-outline-primary btn-sm" onclick="goReservate('${map.PK_RNO}')">예약</button></td>
						</tr>
					</c:forEach>
				</c:if>
			</tbody>
		</table>
		</div>
	</div>

</div>


<%-- === 예약창 모달 === 
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
     				<td><input type="text" class="reservate_emp_name" name="reservate_emp_name" style="margin-right: 2px;"/>${sessionScope.loginuser.emp_name}</td>
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
--%>
<!--  
<div id="reservationPopup" >
    <div class="mbsc-form-group">
        <table>
        	<tr>
        		<th>예약일</th>
        		<td>
        			<input type="date" id="startDate" value="${requestScope.chooseDate}" style="height: 30px;"/>&nbsp; 
					<select id="startHour" class="schedule"></select> 시
					<select id="startMinute" class="schedule"></select> 분
					- <input type="date" id="endDate" value="${requestScope.chooseDate}" style="height: 30px;"/>&nbsp;
					<select id="endHour" class="schedule"></select> 시
					<select id="endMinute" class="schedule"></select> 분&nbsp;
					<input type="checkbox" id="allday" name="allday"/><label for="allday"> &nbsp;종일</label>&nbsp;&nbsp;&nbsp;
					<input type="checkbox" id="repeat" name="repeat"/><label for="repeat">&nbsp;반복</label>
					
					<input type="hidden" name="startdate"/>
					<input type="hidden" name="enddate"/>
				</td>
        	</tr>
        	<tr>
        		<th>예약자</th>
        		<td></td>
        	</tr>
        	<tr>
        		<th>목적</th>
        		<td><textarea name="res_content" id="res_content"></textarea></td>
        	</tr>
        </table>
    </div>
</div>
-->
<%-- 
<div id="demo-add-popup">
    <div class="mbsc-form-group">
        <label>
            Title
            <input mbsc-input id="event-title">
        </label>
        <label>
            Description
            <textarea mbsc-textarea id="event-desc"></textarea>
        </label>
    </div>
    <div class="mbsc-form-group">
        <label>
            All-day
            <input mbsc-switch id="event-all-day" type="checkbox" />
        </label>
        <label>
            Starts
            <input mbsc-input id="start-input" />
        </label>
        <label>
            Ends
            <input mbsc-input id="end-input" />
        </label>
        <div id="event-date"></div>
        <div id="event-color-picker" class="event-color-c">
            <div class="event-color-label">Color</div>
            <div id="event-color-cont">
                <div id="event-color" class="event-color"></div>
            </div>
        </div>
        <label>
            Show as busy
            <input id="event-status-busy" mbsc-segmented type="radio" name="event-status" value="busy">
        </label>
        <label>
            Show as free
            <input id="event-status-free" mbsc-segmented type="radio" name="event-status" value="free">
        </label>
        <div class="mbsc-button-group">
            <button class="mbsc-button-block" id="event-delete" mbsc-button data-color="danger" data-variant="outline">Delete event</button>
        </div>
    </div>
</div>

<div id="demo-event-color">
    <div class="crud-color-row">
        <div class="crud-color-c" data-value="#ffeb3c">
            <div class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check" style="background:#ffeb3c"></div>
        </div>
        <div class="crud-color-c" data-value="#ff9900">
            <div class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check" style="background:#ff9900"></div>
        </div>
        <div class="crud-color-c" data-value="#f44437">
            <div class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check" style="background:#f44437"></div>
        </div>
        <div class="crud-color-c" data-value="#ea1e63">
            <div class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check" style="background:#ea1e63"></div>
        </div>
        <div class="crud-color-c" data-value="#9c26b0">
            <div class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check" style="background:#9c26b0"></div>
        </div>
    </div>
    <div class="crud-color-row">
        <div class="crud-color-c" data-value="#3f51b5">
            <div class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check" style="background:#3f51b5"></div>
        </div>
        <div class="crud-color-c" data-value="">
            <div class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check"></div>
        </div>
        <div class="crud-color-c" data-value="#009788">
            <div class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check" style="background:#009788"></div>
        </div>
        <div class="crud-color-c" data-value="#4baf4f">
            <div class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check" style="background:#4baf4f"></div>
        </div>
        <div class="crud-color-c" data-value="#7e5d4e">
            <div class="crud-color mbsc-icon mbsc-font-icon mbsc-icon-material-check" style="background:#7e5d4e"></div>
        </div>
    </div>
</div>
--%>