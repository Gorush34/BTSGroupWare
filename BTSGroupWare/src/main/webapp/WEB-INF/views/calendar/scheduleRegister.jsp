<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<style type="text/css">

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		// 캘린더 소분류 카테고리 숨기기
		$("select.calNo").hide();
		
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
		
		// '종일' 체크박스 클릭시
		$("input#allDay").click(function() {
			var bool = $('input#allDay').prop("checked");
			
			if(bool == true) {
				$("select#startHour").val("00");
				$("select#startMinute").val("00");
				$("select#endHour").val("23");
				$("select#endMinute").val("59");
				$("select#startHour").prop("disabled",true);
				$("select#startMinute").prop("disabled",true);
				$("select#endHour").prop("disabled",true);
				$("select#endMinute").prop("disabled",true);
			} 
			else {
				$("select#startHour").prop("disabled",false);
				$("select#startMinute").prop("disabled",false);
				$("select#endHour").prop("disabled",false);
				$("select#endMinute").prop("disabled",false);
			}
		});
		
		// 서브캘린더 가져오기 //
		$("select.calSelect").change(function(){
			var fk_lgcatgono = $("select.calSelect").val();
			var fk_emp_no = $("input[name=fk_emp_no]").val();
			
			if(fk_lgcatgono != "") { // 선택하세요 가 아니라면
				$.ajax({
						url: "<%= ctxPath%>/calendar/selectCalNo.bts",
						data: {"fk_lgcatgono":fk_lgcatgono, 
							   "fk_emp_no":fk_emp_no},
						dataType: "json",
						success:function(json){
							var html ="";
							if(json.length>0){
								
								$.each(json, function(index, item){
									html+="<option value='"+item.fk_calno+"'>"+item.fk_calno+"</option>"
								});
								$("select.calNo").html(html);
								$("select.calNo").show();
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
		
		
		
		
		// == 참석자 추가 하기 == //
		<%--$("input#joinUserName").bind("keyup", function(){
			var joinUserName = $(this).val();
			
			$.ajax({
				url:"<%= ctxPath%>/calendar/scheduleRegister/addJoinUser.bts",
				data:{"joinUserName":joinUserName},
				dataType:"json",
				success:function(json){
					var joinUserArr = [];
					
					if(json.length > 0){
						
					}
					
				}// end of success----------------------------------
			});
		});// end of $("input#joinUserName").bind("keyup", function(){}-----------------------------
		--%>
		
		// ====== >>> *** 일정등록하기 시작 *** <<< ====== //
		$("button#register").click(function(){
			
			// 일자 유효성 검사 (시작일자 > 종료일자 X)	
			var startDate = $("input#startDate").val();
			var startArr = startDate.split("-");
			startDate = "";
			for(var i = 0; i<startArr.length; i++){
				startDate += startArr[i];
			}
			
			var endDate = $("input#endDate").val();
			var endArr = endDate.split("-");
			endDate = "";
			for(var i = 0; i<endArr.length; i++){
				endDate += endArr[i];
			}
			
			var startHour= $("select#startHour").val();
	     	var endHour = $("select#endHour").val();
	     	var startMinute= $("select#startMinute").val();
	     	var endMinute= $("select#endMinute").val();
	     	
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
	     	
	     	// 제목 유효성 검사
	     	var subject = $("input#subject").val().trim();
	     	if(subject == ""){
	     		alert("제목을 입력하시오.")
	     		return;
	     	}
	     	
	     	// 캘린더 선택 유무 검사
	     	var calSelect = $("select.calSelect").val().trim();
	     	if(calSelect == ""){
	     		alert("캘린더를 선택하시오.")
	     		return;
	     	}
	     	
	     	// 시작일과 종료일, 오라클에 들어갈 date 형식으로  변경
	     	var sdate = startDate+$("select#startHour").val()+$("select#startMinute").val()+"00";
	     	var edate = endDate+$("select#endHour").val()+$("select#endMinute").val()+"00";
	     	
	     	$("input[name=startdate]").val(sdate);
	     	$("input[name=enddate]").val(edate);
	     	
	     	// 공유자 넣어주기 
	     	
	     	var frm = document.scheduleRegisterFrm;
	     	frm.action = "<%= ctxPath%>/calendar/scheduleRegisterInsert.bts";
	     	frm.method="POST";
	     	frm.submit();
	     	
		});//end of $("button#register").click(function(){}--------------------------------------
		// ====== >>> *** 일정등록하기 끝 *** <<< ====== //
		

		//button#$("input#estion').tooltip(options)

	// Collapse로 화면이 펼치기 전에 호출
/*	$('.collapse').on('show.bs.collapse', function () {
		// icon을 + 마크로 변경한다.
		var target = $("[href='#"+$(this).prop("id")+"']");
		target.removeClass("bi-caret-down-fill");
		target.addClass("fa-minus-square");
	});
	// Collapse로 화면이 펼친 후에 호출
	$('.collapse').on('shown.bs.collapse', function () {
		// icon을 + 마크로 변경한다.
		var target = $("[href='#"+$(this).prop("id")+"']");
		target.removeClass("bi-caret-down-fill");
		target.addClass("fa-minus-square");
	});
	// Collapse로 화면에 접기 전에 호출
	$('.collapse').on('hide.bs.collapse', function () {
		// icon을 - 마크로 변경한다.
		var target = $("[href='#"+$(this).prop("id")+"']");
		target.removeClass("fa-minus-square");
		target.addClass("bi-caret-down-fill");
	});
	// Collapse로 화면에 접고 난 후에 호출
	$('.collapse').on('hidden.bs.collapse', function () {
		// icon을 - 마크로 변경한다.
		var target = $("[href='#"+$(this).prop("id")+"']");
		target.removeClass("fa-minus-square");
		target.addClass("bi-caret-down-fill");
	});
*/
		
	});

</script>

<div id="scheduleRegister">
<h4 style="margin: 0 80px">일정등록</h4>
	<div id="srFrm" style="margin:50px 100px;">
		<form name="scheduleRegisterFrm">
			<div>
				<input type="text" id="subject" name="subject" size="50"/>&nbsp;&nbsp;
				<input type="checkbox" id="secret" name="secret"/><label for="secret">비공개</label> &nbsp;&nbsp;&nbsp;
				<span class="tooltip-right" data-tooltip="비공개 일정은 참석자만 확인가능합니다."><i class="bi bi-question-circle-fill"></i></span>
			</div>
			<table id="scheduleRegisterContent">
				<tr>
					<th>날짜</th>
					<td>
						<input type="date" id="startDate" value="${requestScope.chooseDate}" style="height: 30px;"/>&nbsp; 
						<select id="startHour" class="schedule"></select> 시
						<select id="startMinute" class="schedule"></select> 분
						- <input type="date" id="endDate" value="${requestScope.chooseDate}" style="height: 30px;"/>&nbsp;
						<select id="endHour" class="schedule"></select> 시
						<select id="endMinute" class="schedule"></select> 분&nbsp;
						<input type="checkbox" id="allDay" name="allDay"/><label for="allDay"> &nbsp;종일</label>&nbsp;&nbsp;&nbsp;
						
						<input type="hidden" name="startdate"/>
						<input type="hidden" name="enddate"/>
					</td>
				</tr>
				<tr>
					<th>내 캘린더</th>
					<td>
						<select class="calSelect" name="fk_lgcatgono">
						<c:choose>
							 <%-- 일정등록시 사내캘린더 등록은 oginuser.gradelevel =='10' 인 사용자만 등록이 가능하도록 한다. --%> 
							<c:when test="${loginuser.gradelevel =='1'}"> 
								<option value="">선택하세요</option>
								<option value="1">내 캘린더</option>
								<option value="2">사내 캘린더</option>
							</c:when>
							<%-- 일정등록시 내캘린더 등록은 로그인 된 사용자이라면 누구나 등록이 가능하다. --%> 	
							<c:otherwise>
								<option value="">선택하세요</option>
								<option value="1">내 캘린더</option>
							</c:otherwise >
						</c:choose>
						</select> &nbsp;
						<select class="calNo schedule" name="fk_calNo"></select>
					</td>
				</tr>
				<tr>
					<th>참석자</th>
					<td>
					<input type="text" id="joinUserName" class="form-control" placeholder="일정을 공유할 회원명을 입력하세요"/>
					<div class="displayUserList"></div>
					<input type="hidden" name="joinuser"/>
					</td>
				</tr>
				<tr>
					<th>색상</th>
					<td><input type="color" id="color" name="color" value="#0096c6"/></td>
				</tr>
				<tr>
					<th>장소</th>
					<td><input type="text" name="place" class="form-control"/></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea rows="10" cols="100" style="height: 200px;" name="content" id="content"  class="form-control"></textarea></td>
				</tr>
				<tr>
					<th>알람</th>
					<td><i class="bi bi-alarm"></i>&nbsp;&nbsp;알람 추가</td>
					<%--
					<td><input type="text"/></td>
					<td><select></select></td>
					<td><select></select></td>
					<td><i class="bi bi-x-circle"></i></td>
					 --%>
				</tr>
				<tr>
					<th rowspan="4" style="vertical-align: text-top;">예약하기</th>	
					
				<td>
					<!-- 그룹 태그로 role과 aria-multiselectable를 설정한다. -->
					<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
						<!-- 하나의 item입니다. data-parent 설청과 href 설정만 제대로 하면 문제없이 작동합니다. -->
						<div class="panel panel-default">
							<div class="panel-heading" role="tab">
								<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse1" aria-expanded="false" style="color:black; text-decoration:none ;">
								본사 6층 회의실
								</a>
							</div>
							<div id="collapse1" class="panel-collapse collapse" role="tabpanel">
								<div class="panel-body">
									<table class="table table-striped" id="reservationTable" style="margin-left: 10px;">
									<thead class="table-primary" style="color:white;">
										<tr>
											<th style="width:500px;">항목</th>
											<th style="width:300px;">예약</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>빔프로젝터</td>
											<td><button type="button" class="btn btn-outline-primary btn-sm">예약</button></td>
										</tr>
										<tr>
											<td>의자 10개</td>
											<td><button type="button" class="btn btn-outline-primary btn-sm">예약</button></td>
										</tr>
										<tr>
											<td>칠판</td>
											<td><button type="button" class="btn btn-outline-primary btn-sm">예약</button></td>
										</tr>
									</tbody>
								</table>
								</div>
							</div>
						</div>
						<!-- -->
						<div class="panel panel-default">
							<div class="panel-heading" role="tab">
								<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse2" aria-expanded="false" style="color:black; text-decoration:none ;">
								본사 6층 회의실
								</a>
							</div>
							<div id="collapse2" class="panel-collapse collapse" role="tabpanel">
								<div class="panel-body">
									<table class="table table-striped" id="reservationTable" style="margin-left: 10px;">
									<thead class="table-primary" style="color:white; ">
										<tr>
											<th style="width:500px;">항목</th>
											<th style="width:300px;">예약</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td colspan="2" style="heigth: 100px; text-align: center;">이용가능한 자산이 없습니다.</td>
										</tr>
									</tbody>
								</table>
								</div>
							</div>
						</div>
						<div class="panel panel-default">
							<div class="panel-heading" role="tab">
								<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse3" aria-expanded="false" style="color:black; text-decoration:none ;">
								본사 7층 회의실
								</a>
							</div>
							<div id="collapse3" class="panel-collapse collapse" role="tabpanel">
								<div class="panel-body">
									<table class="table table-striped" id="reservationTable" style="margin-left: 10px;">
									<thead class="table-primary" style="color:white; ">
										<tr>
											<th style="width:500px;">항목</th>
											<th style="width:300px;">예약</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>빔프로젝터</td>
											<td>22-05-01 09:00</td>
										</tr>
									</tbody>
								</table>
								</div>
							</div>
						</div>	
					</div>
				 </td>
			 </tr>
			 
				
			</table>
			<input type="text" value="${sessionScope.loginuser.pk_emp_no}" name="fk_emp_no"/>
			</form>
			
		<div style="text-align: center;">
		<button type="button" class="btn btn-primary btn-sm" id="register" >확인</button>
		<button type="button" class="btn btn-outline-primary btn-sm" onclick="javascript:location.href='<%= ctxPath%>/calendar/calendarMain.bts'">취소</button>
		</div>
	 </div>	
</div>