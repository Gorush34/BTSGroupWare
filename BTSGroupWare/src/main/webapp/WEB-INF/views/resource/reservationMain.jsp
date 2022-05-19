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

    var calendar;
	// 처음 초기값은 1 => 회의실1 정보를 불러옴
	var do_pk_rno = 1;
	//전체 모달 닫기(전역함수인듯)
	window.closeModal = function(){
	    $('.modal').modal('hide');
	    //javascript:history.go(0);
	};
	
	$(document).ready(function(){
		
		$("#resRegisterbtn").hide();
		if(${sessionScope.loginuser.gradelevel} =='1'){
			$("#resRegisterbtn").show();
		}
		
	  // 사이드바의 자원명을 선택했을 시 선택한 텍스트의 색을 변경
	    $(".pk_rnoT").click(function() {
	       $(".pk_rnoT").removeClass("clickside");
	       $(this).addClass("clickside");
	    });

		
		// 서브캘린더 select로 가져오기 //
		$("select.calpk_classno").change(function(){
			var pk_classno = $("select.calpk_classno").val();
			
			if(pk_classno != "") { // 선택하세요 가 아니라면
				$.ajax({
						url: "<%= ctxPath%>/resource/resourceSelect.bts",
						data: {"pk_classno":pk_classno},
						dataType: "json",
						success:function(json){
							var html ="";
							if(json.length>0){
								
								$.each(json, function(index, item){
									html+="<option name='pk_rno' value='"+item.pk_rno+"'>"+item.rname+"</option>"
								});
								$("select.calpk_rno").html(html);
								$("select.calpk_rno").show();
							}
						},
						error: function(request, status, error){
				            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
						}
				});
			}
			
			else {
				// 선택하세요 이라면
				$("select.calNo").hide();
			}
			
		});
		
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
		
	 // === *** 달력(type="date") 관련 시작 *** === //
		// 시작시간, 종료시간		
		var html="";
		for(var i=0; i<24; i++){
			if(i<10){
				html+="<option value='0"+i+"'>0"+i+"</option>";
			}
			else{
				html+="<option value="+i+">"+i+"</option>";
			}
		}// end of for----------------------
		
		$("select#startHour").html(html);
		$("select#endHour").html(html);
		
		// 시작분, 종료분 
		html="";
		for(var i=0; i<60; i=i+5){
			if(i<10){
				html+="<option value='0"+i+"'>0"+i+"</option>";
			}
			else {
				html+="<option value="+i+">"+i+"</option>";
			}
		}// end of for--------------------
		html+="<option value="+59+">"+59+"</option>"
		
		$("select#startMinute").html(html);
		$("select#endMinute").html(html);
		// === *** 달력(type="date") 관련 끝 *** === //
		
		
	    // input 을 datepicker로 선언
	 //   $("input#startdate").datepicker();                    
	 //   $("input#enddate").datepicker();
	    	    
		
	 });// end of $(document).ready(function(){}------------------------------------
		
	
	    
	    document.addEventListener('DOMContentLoaded', function() {	
		// === 캘린더 보여주기 (기본 틀) === //
	    var calendarEl = document.getElementById('calendar');

	    calendar = new FullCalendar.Calendar(calendarEl, {
	      timeZone: 'local',
	      initialView: 'timeGridWeek',
	      headerToolbar: {
	        left: 'prev,next today',
	        center: 'title',
	        right: 'timeGridWeek,timeGridDay'
	      },
	      events: function(info, successCallback, failureCallback){
	    	     $.ajax({
	                 url: '<%= ctxPath%>/reservation/resourceSpecialReservation.bts',
	                 data:{"pk_rno":do_pk_rno},
	                 dataType: "json",
	                 success:function(json) {
	                	// alert("달력pk_rno:"+do_pk_rno);
	                	 var events = [];
	                	 
	                	 if(json.length > 0){
		                	 $.each(json, function(index, item){
		                		 
		                            events.push({
		                            	title: item.EMP_NAME,
		                            	start: item.RSERSTARTDATE,
		                            	end: item.RSERENDDATE,
		                            	color: item.COLOR,
		                            	id: item.PK_RSERNO
		                            });
		                	 });      
		       
	                     }
	                     else{
	                    	 // 검색된 결과가 없을 때
	                     }
	                	// console.log(events); 
	                     successCallback(events);                                        
	                 },
					  error: function(request, status, error){
				            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				      }	
	                                           
	            }); // end of $.ajax()--------------------------------
	         
	                	 
	      },
	      dateClick: function(info) {
	           
	            // 이전날짜에 예약 불가
	            var sysdate = new Date();
	            sysdate = moment(sysdate).format("YYYY-MM-DD HH:mm:ss");
	            
	            var date = moment(info.dateStr).format("YYYY-MM-DD");
	            var dateHour = moment(info.dateStr).format("YYYY-MM-DD HH:mm:ss");
	            
	            // 오늘만 시간이 지났어도 예약 가능하게 함
	            if (sysdate > date + 1) {
	            alert("지난 시간은 예약할 수 없습니다.");
	            }else{
	            addRs();   // 모달을 초기화하고 자원명을 불러오는 함수
	            
	            // 클릭한 시각으로 모달의 datepicker를 변경시킴
	              $("input[name=startDate]").val(date);   
	              $("input[name=endDate]").val(date);
	              
	             var hh = moment(info.dateStr).format("HH");
	              $("select#startHour").val(hh).change();
	              $("select#endHour").val(hh).change();
	              
	              var mm = moment(info.dateStr).format("mm");
	              $("select#startMinute").val(mm).change();
	              $("select#endMinute").val(mm).change();
	         }
	            
	         
	      },
	      eventClick: function(info) {
	              reservationDetail(info.event.id); // 예약상세보기 모달창 함수 
	      },
	      selectable: true,
	      navLinks: false,             // 달력의 날짜 텍스트를 선택할 수 있는지 유무
	      editable: false,
	      eventLimit: true,            // 셀에 너무 많은 일정이 들어갔을 시 more로 처리
	      allDaySlot: false
	   <%--
	        eventClick: function(event, element) {
	            // Display the modal and set the values to the event values.
	            $('.modal').modal('show');
	            $('.modal').find('#title').val(event.title);
	            $('.modal').find('#starts-at').val(event.start);
	            $('.modal').find('#ends-at').val(event.end);

	        },
	      dateClick: function(info) {
		      	//  alert('클릭한 Date: ' + info.dateStr); 
		      	    $(".fc-day").css('background','none'); // 현재 날짜 배경색 없애기
		      	    info.dayEl.style.backgroundColor = '#b1b8cd'; // 클릭한 날짜의 배경색 지정하기
		      	    $("#reservateModal").modal('show');
		      	    $("form > input[name=chooseDate]").val(info.dateStr);
		      	    
		      	   // var frm = document.dateFrm;
		      	   // frm.method="POST";
		      	    frm.action="<%= ctxPath%>/calendar/scheduleRegister.bts"; 
		      	   // frm.submit();
		      	  }--%>
	    });

	    calendar.render();
	    
	 });
	 

	 // 자원을 변경했을 시 자원 변수값을 변경해주는 함수	  
	  function goResourceReservation(pk_rno) {
		  do_pk_rno = pk_rno;
		//  alert("클릭pk_rno :" + do_pk_rno);
		  calendar.refetchEvents(); // calendar가 $(document).ready 안에만 있으면 지역변수 문제로 오류가 뜰 수 있음! 참고할 것!
	}				  
	
			
		
	
	// 예약하기 모달 보이기
	  function addRs(){
	     
	     // 모달 form에 입력돼있는 정보를 모두 삭제하고 모달을 보이게 함(모달 초기화)
	     $('#reservateModal').find('form')[0].reset();
	     $('#reservateModal').modal('show');
	       
	}    
	    
	   
	// 예약하기 버튼
	function goReservation(){
		
		// 일자 유효성 검사 (시작일자 > 종료일자 X)	
		var startDate = $("input[name=startDate]").val();
		var startArr = startDate.split("-");
		startDate = "";
		for(var i = 0; i<startArr.length; i++){
			startDate += startArr[i];
		}
		
		var endDate = $("input[name=endDate]").val();
		var endArr = endDate.split("-");
		endDate = "";
		for(var i = 0; i<endArr.length; i++){
			endDate += endArr[i];
		}
		
		var startHour= $("select#startHour").val();
     	var endHour = $("select#endHour").val();
     	var startMinute= $("select#startMinute").val();
     	var endMinute= $("select#endMinute").val();
     	
     	
       // 시작일자가 1950년 이전일 경우
     	if(Number(startDate) - 19500101 < 0){
     		alert("해당날짜는 지정이 불가합니다.")
     		return;
     	}
        // 종료일자가 2999년 이후일 경우
     	if(Number(endDate) - 29991231 > 0){
     		alert("해당날짜는 지정이 불가합니다.")
     		return;
     	}
     	// 시작일자 > 종료일자 : 경고
     	if(Number(endDate) - Number(startDate) <0){
     		alert("종료일이 시작일 보다 빠릅니다.")
     		return;
     	}
     	else if(Number(endDate) == Number(startDate)){
     		
     		if(Number(startHour) > Number(endHour)){
     			alert("종료일이 시작일 보다 빠릅니다.")
	     		return;
     		}
     		else if(Number(startHour) == Number(endHour)){
     			if(Number(startMinute) > Number(endMinute)){
	     			alert("종료일이 시작일 보다 빠릅니다.")
		     		return;
	     		}
     			else if(Number(startMinute) == Number(endMinute)){
        			alert("시작일과 종료일이 동일합니다."); 
        			return;
        		}
     		}
     	}// end of else if----------------------------------------
     	
		
		// 시작일과 종료일, 오라클에 들어갈 date 형식으로  변경
     	var sdate = startDate+$("select#startHour").val()+$("select#startMinute").val()+"00";
     	var edate = endDate+$("select#endHour").val()+$("select#endMinute").val()+"00";
     	
     	$("input[name=startdate]").val(sdate);
     	$("input[name=enddate]").val(edate);
    
     	// 자원 select 유효성 검사
     	var calpk_rno = $("select[name=pk_rno]").val();
        if (calpk_rno == "") {
           alert("자원을 선택해주세요.");
           return false;
        }
        
        // 이용용도 유효성 검사
     	var rserusecase = $("textarea#rserusecase").val();
        if (rserusecase.trim() == "" || rserusecase == "<p>&nbsp;</p>") {
           alert("이용용도를 기입해주세요.");
           return false;
        }
        
        rserusecase = $("textarea#rserusecase").val().replace(/<p><br><\/p>/gi, "<br>");
        rserusecase = rserusecase.replace(/<\/p><p>/gi, "<br>"); //</p><p> -> <br>로 변환  
        rserusecase = rserusecase.replace(/(<\/p><br>|<p><br>)/gi, "<br><br>"); //</p><br>, <p><br> -> <br><br>로 변환
        rserusecase = rserusecase.replace(/(<p>|<\/p>)/gi, ""); //<p> 또는 </p> 모두 제거시
      
        $("textarea#rserusecase").val(rserusecase);
     	
        // db에 넣기
        $.ajax({
           url:"<%= request.getContextPath() %>/reservation/addReservation.bts",
           data:{"rserstartdate":$('input[name=startdate]').val(),
        	   	 "rserenddate":$('input[name=enddate]').val(), 
        	   	 "fk_emp_no":$('input#fk_emp_no').val(),
        	   	 "pk_classno":$('select.calpk_classno').val(),
        	   	 "rserusecase":$('textarea#rserusecase').val(),
        	   	 "color":$('input#color').val(),
        	   	 "pk_rno":calpk_rno},
           type:"POST",
           dataType:"JSON",
           success:function(json){
              
              // 예약일로 입력한 값이 db에서 중복되는지 안되는지로 나눔
              if (json.n == 1) {
                 // 에약이 정상적으로 등록됐을 때
                 window.closeModal();
                 calendar.refetchEvents();
                 
              }else{
                 // 중복된 예약(시간)으로 예약에 실패했을 때
                 alert("해당 시간에는 이미 예약이 되어있어 예약할 수 없습니다.");
              }
              
              
           },
           error: function(request, status, error){
              alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
            }
	  
        });
   
     	
	}
	
	// == 예약 상세보기
	function reservationDetail(PK_RSERNO){
		  $.ajax({
		         url:"<%= request.getContextPath() %>/reservation/reservationDetail.bts",
		         type:"get",
		         data: {"pk_rserno":PK_RSERNO},
		         dataType:"JSON",
		         success:function(json){
		            var html = "";
		        //    alert(PK_RSERNO);
		            if(json.length > 0){
	                	 $.each(json, function(index, item){
	                		 
				            html += "<tr>";
				               html += "<th>자원명</th>";
				               html += "<td>" + item.RNAME + "<input type='hidden' class='pk_rserno' value='"+PK_RSERNO+"' ></td>";
				            html += "</tr>";
				            html += "<tr>";
				               html += "<th>자원정보</th>";
				               html += "<td>" + item.RINFO + "</td>";
				            html += "</tr>";
				            html += "<tr>";
				               html += "<th>시작시간</th>";
				               html += "<td>" + item.RSERSTARTDATE + "</td>";
				            html += "</tr>";
				            html += "<tr>";
				               html += "<th>종료시간</th>";
				               html += "<td>" + item.RSERENDDATE + "</td>";
				            html += "</tr>";
				            html += "<tr>";
				               html += "<th>등록자</th>";
				               html += "<td>" + item.EMP_NAME + "</td>";
				            html += "</tr>";
				            html += "<tr>";
				               html += "<th>사용용도</th>";
				               html += "<td>" + item.RSERUSECASE+ "</td>";
				            html += "</tr>";
			                	 
				            
				            $(".cancelBtn").hide();
				            if (item.FK_EMP_NO == "${sessionScope.loginuser.pk_emp_no}") {
				               $(".cancelBtn").show();
				            }
	                	 });
	                	 
	                	 $("tbody.detailTbody").html(html);
		            }
		         },
		         error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		          }
		      });
		     
		     $("#reservationDetailModal").modal('show');
	}
	
	 // 예약취소 버튼 클릭시 예약 취소하는 함수
	  function cancelReservation() {
	     var pk_rserno = $("input.pk_rserno").val();
	      
	      $.ajax({
	         url:"<%= request.getContextPath() %>/reservation/cancelReservation.bts",
	         type:"get",
	         data: {pk_rserno:pk_rserno},
	         dataType:"JSON",
	         success:function(json){
	            
	            if (json.n == 1) {
	               window.closeModal();
	               calendar.refetchEvents(); // 모든 소스의 이벤트를 다시 가져와 화면에 다시 표시합니다.
	            }else{
	               alert("DB오류");
	            }
	            
	         },
	         error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	          }
	      });
	  }
	
</script>

<div id="resourceSide" style=" min-height:1200px; position: fixed; top:60px; padding-top: 40px; float:left; width:250px;">
	<h4>자원관리</h4>
	<button type="button" class="btn btn-outline-primary btn-lg"  id="resRegisterbtn" style="margin: 15px auto; width:200px; display:block;" onclick="javascript:location.href='<%= ctxPath%>/reservation/reservationAdmin.bts'">자원등록</button>
	<ul style="list-style-type: none; padding: 10px;">
	 <c:if test="${not empty requestScope.classList}">
	 <c:forEach var="map" items="${requestScope.classList}" varStatus="status">
		<li style="margin-bottom: 15px;">
			<div id="resourceClass" class="resourceClass" style="font-weight: bold; color:#00ace6;"><input type="hidden" value="${map.PK_CLASSNO}">${map.CLASSNAME}</div>
				<div id="slideTogglebox1"  class="slideTogglebox" style="margin: 5px 0 5px 10px; font-size: 11pt;">
					<table>
						<c:if test="${not empty requestScope.resourceList}">
							<c:forEach var="map2" items="${requestScope.resourceList}">
							<c:if test="${map.PK_CLASSNO eq map2.PK_CLASSNO}">
							<tr>
								<td class="pk_rnoT" id="resource_T'+${map2.PK_RNO}+'" style="padding: 3px; cursor: pointer;" onclick="goResourceReservation('${map2.PK_RNO}')"><input type="hidden" id="resource_'+${map2.PK_RNO}+'" name="pk_rno" value="${map2.PK_RNO}">${map2.RNAME}</td>
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
	<div class="d-flex align-items-center p-3 my-3 text-white bg-purple shadow-sm" style="background-color: #6F42C1;">
    <div class="lh-1" style="text-align: center; width: 100%;">
      <h1 class="h6 mb-0 text-white lh-1" style="font-size:22px; font-weight: bold; ">예약하기</h1>
    </div>
  </div>
	
	<%-- 캘린더를 보여주는 곳 --%>
	<input type="hidden" value="${sessionScope.loginuser.pk_emp_no}" id="fk_emp_no"/>
	
	<input type="hidden" value="${sessionScope.loginuser.emp_name}" id="emp_name"/>
	<div id="calendar" style="margin: 60px 30px 50px 30px;"></div>

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
     				<td>
     					 <input type="date" class="datepicker" id="startdate" name="startDate">
	                      <select id="startHour" class="schedule"></select> 시
							<select id="startMinute" class="schedule"></select> 분
					
                  ~
                  <input type="date" class="datepicker" id="enddate" name="endDate">
                      <select id="endHour" class="schedule"></select> 시
					<select id="endMinute" class="schedule"></select> 분&nbsp;
						<input type="hidden" name="startdate"/>
						<input type="hidden" name="enddate"/>
     				</td>
     			</tr>
     			<tr>
     				<td style="text-align: left;">예약자</td>
     				<td>${sessionScope.loginuser.emp_name}</td>
     			</tr>
     			<tr>
                   <th>자원선택</th>
                   <td>
	                   <select class="calpk_classno" name="calpk_classno"> 
	                   	 <option value="">선택하세요</option>
						 <option value="1">3층 회의실</option>
						 <option value="2">자동차</option>
						 <option value="3">빔프로젝터</option>
					   </select>
					   <%--
					   <select class="calpk_classno" name="calpk_classno">
	                   <c:if test="${not empty requestScope.classList}">
						 <c:forEach var="map" items="${requestScope.classList}">
						 <option class="pk_classno" value="${map.PK_CLASSNO}">${map.CLASSNAME}</option>
						 </c:forEach>
						 </c:if>
						 </select>
						 <select class="calpk_rno"></select> --%>
						 <select class="calpk_rno" name="pk_rno"></select>
                   </td>
                 </tr>
                 <tr>
                   <th>사용용도</th>
                   <td><textarea rows="4" cols="100" style="height: 200px;" name="rserusecase" id="rserusecase"  class="form-control"></textarea></td>
                 </tr>
                 <tr>
                   <th>색상</th>
                   <td><input type="color" id="color" value="#0096c6"></td>
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

<%-- 예약 상세정보 보여주기 모달 --%>
   <div id="reservationDetailModal" class="modal fade" role="dialog" data-keyboard="false" data-backdrop="static">
    <div class="modal-dialog">
      <div class="modal-content">
      
       <!-- Modal header -->
      <div class="modal-header">
        <h5 class="modal-title">예약정보</h5>
        <button type="button" class="close modal_close" data-dismiss="modal">&times;</button>
      </div>
        <div class="modal-body">
          <div class="container">
               <form>
             <table class="table table-borderless">
               <tbody class="detailTbody">
                 
               </tbody>
             </table>
         
            <button class="btn btn-outline-primary btn-sm cancelBtn" style="float: right; margin-left: 5px;" type="button" onclick="cancelReservation()">예약취소</button>
            <button class="btn btn-primary btn-sm" style="float: right;" type="button" onclick="window.closeModal()">확인</button>
            </form>
         </div>
        </div>
      </div>
    </div>
   </div>
   
<%-- === 마우스로 클릭한 날짜의 일정 등록을 위한 폼 ===    
<form name="dateFrm">
	<input type="hidden" name="chooseDate" />	
</form>	--%>  