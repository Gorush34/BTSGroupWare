<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<style type="text/css">

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
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
		
		// 저장된 일정 서브캘린더 값 가져오기 //
		$("select.calSelect").val("${requestScope.map.FK_LGCATGONO}");

				$.ajax({
						url: "<%= ctxPath%>/calendar/selectCalNo.bts",
						data: {"fk_lgcatgono":"${requestScope.map.FK_LGCATGONO}", 
							   "fk_emp_no":"${requestScope.map.FK_EMP_NO}"},
						dataType: "json",
						async: false,  //동기방식
						success:function(json){
							var html ="";
							if(json.length>0){
								
								$.each(json, function(index, item){
									html+="<option value='"+item.pk_calno+"'>"+item.calname+"</option>"
								});
								$("select.calNo").html(html);
							}
						},
						error: function(request, status, error){
				            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
						}
				});
				
		$("select.calNo").val("${requestScope.map.FK_CALNO}");

		// 서브캘린더 select로 가져오기 //
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
									html+="<option value='"+item.pk_calno+"'>"+item.calname+"</option>"
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
	
		// **** 수정하기전 이미 저장되어있는 공유자 **** 
		var stored_joinuser = "${requestScope.map.JOINUSER}";
		if(stored_joinuser != "공유자가 없습니다."){
			var arr_stored_joinuser = stored_joinuser.split(",");
			var str_joinuser = "";
			for(var i=0; i<arr_stored_joinuser.length; i++){
				var user = arr_stored_joinuser[i];
			//	console.log(user);
				add_joinUser(user);
			}// end of for--------------------------
		}// end of if--------------------------------      

		
		
		// == 참석자 추가 하기 == //
		$("input#joinUserName").bind("keyup", function(){
			var joinUserName = $(this).val();
			
			$.ajax({
				url:"<%= ctxPath%>/calendar/scheduleRegister/searchJoinUser.bts",
				data:{"joinUserName":joinUserName},
				dataType:"json",
				success:function(json){
					var joinUserArr = [];
					
					if(json.length > 0){
						
						$.each(json, function(index,item){
							var name = item.name;
							if(name.includes(joinUserName)){ // name 문자열에 joinUserName 라는 문자열이 포함된 경우라면 true , 
							 //  joinUserArr.push(name+"("+item.email+")");
							   joinUserArr.push(name);
							}
						});
						
						$("input#joinUserName").autocomplete({  // 참조 https://jqueryui.com/autocomplete/#default
							source:joinUserArr,
							select: function(event, ui) {       // 자동완성 되어 나온 공유자이름을 마우스로 클릭할 경우 
								add_joinUser(ui.item.value);    // 아래에서 만들어 두었던 add_joinUser(value) 함수 호출하기 
								                                // ui.item.value 이  선택한이름 이다.
								return false;
					        },
					        focus: function(event, ui) {
					            return false;
					        }
						}); 
						
					}// end of if------------------------------------
					
				}// end of success----------------------------------
			});
		});// end of $("input#joinUserName").bind("keyup", function(){}-----------------------------
		
		// x아이콘 클릭시 공유자 제거하기
		$(document).on('click','div.displayUserList > span.plusUser > i',function(){
				var text = $(this).parent().text(); // 이순신(leess/leesunsin@naver.com)
				
				var bool = confirm("공유자 목록에서 "+ text +" 회원을 삭제하시겠습니까?");
				// 공유자 목록에서 이순신(leess/leesunsin@naver.com) 회원을 삭제하시겠습니까?
				
				if(bool) {
					$(this).parent().remove();
				}
		});
		
		// 수정 버튼 클릭
		$("button#edit").click(function(){
		
			// 일자 유효성 검사 (시작일자가 종료일자 보다 크면 안된다!!)
			var startDate = $("input#startDate").val();	
	    	var sArr = startDate.split("-");
	    	startDate= "";	
	    	for(var i=0; i<sArr.length; i++){
	    		startDate += sArr[i];
	    	}
	    	
	    	var endDate = $("input#endDate").val();	
	    	var eArr = endDate.split("-");   
	     	var endDate= "";
	     	for(var i=0; i<eArr.length; i++){
	     		endDate += eArr[i];
	     	}
			
	     	var startHour= $("select#startHour").val();
	     	var endHour = $("select#endHour").val();
	     	var startMinute= $("select#startMinute").val();
	     	var endMinute= $("select#endMinute").val();
	        
	     	// 조회기간 시작일자가 종료일자 보다 크면 경고
	        if (Number(endDate) - Number(startDate) < 0) {
	         	alert("종료일이 시작일 보다 작습니다."); 
	         	return;
	        }
	        
	     	// 시작일과 종료일 같을 때 시간과 분에 대한 유효성 검사
	        else if(Number(endDate) == Number(startDate)) {
	        	
	        	if(Number(startHour) > Number(endHour)){
	        		alert("종료일이 시작일 보다 작습니다."); 
	        		return;
	        	}
	        	else if(Number(startHour) == Number(endHour)){
	        		if(Number(startMinute) > Number(endMinute)){
	        			alert("종료일이 시작일 보다 작습니다."); 
	        			return;
	        		}
	        		else if(Number(startMinute) == Number(endMinute)){
	        			alert("시작일과 종료일이 동일합니다."); 
	        			return;
	        		}
	        	}
	        }// end of else if---------------------------------
	    	
			// 제목 유효성 검사
			var subject = $("input#subject").val().trim();
	        if(subject==""){
				alert("제목을 입력하세요."); 
				return;
			}
	        
	        // 캘린더 선택 유무 검사
			var calSelect = $("select.calSelect").val().trim();
			if(calSelect==""){
				alert("캘린더 종류를 선택하세요."); 
				return;
			}
			
			// 달력 형태로 만들어야 한다.(시작일과 종료일)
			// 오라클에 들어갈 date 형식(년월일시분초)으로 만들기
			var sdate = startDate+$("select#startHour").val()+$("select#startMinute").val()+"00";
			var edate = endDate+$("select#endHour").val()+$("select#endMinute").val()+"00";
			
			$("input[name=startdate]").val(sdate);
			$("input[name=enddate]").val(edate);
		
		//	console.log("캘린더 소분류 번호 => " + $("select[name=fk_smcatgono]").val());
			/*
			      캘린더 소분류 번호 => 1 OR 캘린더 소분류 번호 => 2 OR 캘린더 소분류 번호 => 3 OR 캘린더 소분류 번호 => 4 
			*/
			
		//  console.log("색상 => " + $("input#color").val());
			
			      
			// 공유자 넣어주기
			var plusUser_elm = document.querySelectorAll("div.displayUserList > span.plusUser");
			var joinUserArr = new Array();
			
			plusUser_elm.forEach(function(item,index,array){
			//	console.log(item.innerText.trim());
				/*
					이순신(leess) 
					아이유1(iyou1) 
					설현(seolh) 
				*/
				joinUserArr.push(item.innerText.trim());
			});
			
			var joinuser = joinUserArr.join(",");
		//	console.log("공유자 => " + joinuser);
			// 이순신(leess),아이유1(iyou1),설현(seolh) 
			
			$("input[name=joinuser]").val(joinuser);
			
		    var frm = document.scheduleEditFrm;
		  	frm.action="<%= ctxPath%>/calendar/editSchedule_end.bts";
			frm.method="post";
			frm.submit(); 

		});// end of $("button#edit").click(function(){})--------------------
		
		
	}); // end of $(document).ready(function(){}----------------------------------------------------------------------

	
	// ********** Function Declaration ************//
	
	// div.displayUserList 에 공유자를 넣어주는 함수
	function add_joinUser(value){  // value 가 공유자로 선택한이름 이다.
		
		var plusUser_es = $("div.displayUserList > span.plusUser").text();
	
	 // console.log("확인용 plusUser_es => " + plusUser_es);
	    /*
	    	확인용 plusUser_es => 
 			확인용 plusUser_es => 이순신(leess/hanmailrg@naver.com)
 			확인용 plusUser_es => 이순신(leess/hanmailrg@naver.com)아이유1(iyou1/younghak0959@naver.com)
 			확인용 plusUser_es => 이순신(leess/hanmailrg@naver.com)아이유1(iyou1/younghak0959@naver.com)아이유2(iyou2/younghak0959@naver.com)
	    */
	
		if(plusUser_es.includes(value)) {  // plusUser_es 문자열 속에 value 문자열이 들어있다라면 
			alert("이미 추가한 회원입니다.");
		}
		
		else {
			$("div.displayUserList").append("<span class='plusUser'>"+value+"&nbsp;<i class='fas fa-times-circle'></i></span>");
		}
		
		$("input#joinUserName").val("");
		
	}// end of function add_joinUser(value){}----------------------------			


</script>

<div id="scheduleEdit">
<h4 style="margin: 0 80px">일정수정</h4>
	<div id="srFrm" style="margin:50px 100px;">
		<form name="scheduleEditFrm">
			<div>
				<input type="text" id="subject" name="subject" size="50" value="${requestScope.map.SUBJECT}"/>&nbsp;&nbsp;
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
							 <%-- 일정등록시 사내캘린더 등록은 oginuser.gradelevel =='1' 인 사용자만 등록이 가능하도록 한다. --%> 
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
						<select class="calNo schedule" name="fk_calno"></select>
					</td>
				</tr>
				<tr>
					<th>참석자</th>
					<td>
					<input type="text" id="joinUserName" class="form-control" placeholder="일정을 공유할 회원명을 입력하세요"/>
					<div class="displayUserList" style="margin:10px 2px 5px 0;"></div>
					<input type="hidden" name="joinuser"/>
					</td>
				</tr>
				<tr>
					<th>색상</th>
					<td><input type="color" id="color" name="color" value="${requestScope.map.COLOR}"/></td>
				</tr>
				<tr>
					<th>장소</th>
					<td><input type="text" name="place" class="form-control" value="${requestScope.map.PLACE}"/></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea rows="10" cols="100" style="height: 200px;" name="content" id="content"  class="form-control">${requestScope.map.CONTENT}</textarea></td>
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
			<input type="hidden" value="${requestScope.map.PK_SCHNO}" name="pk_schno"/>
			</form>
			
		<div style="text-align: center;">
		<button type="button" class="btn btn-primary btn-sm" id="edit" >수정</button>
		<button type="button" class="btn btn-outline-primary btn-sm" onclick="javascript:location.href='<%= ctxPath%>/${gobackURL_ds}'">취소</button>
		</div>
	 </div>	
</div>
				