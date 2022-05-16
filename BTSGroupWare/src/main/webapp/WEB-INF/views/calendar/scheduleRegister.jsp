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
	     	
	     	// 내용 유효성 검사
	     	var content = $("textarea#content").val();
	     	
	     	// p태그 작업 막기
	     	if(content == "" || content == "<p>&nbsp;</p>") {
	             alert("글내용을 입력하세요!!");
	             return;
	          }
	     	content = $("textarea#content").val().replace(/<p><br><\/p>/gi, "<br>");
	     	content = content.replace(/<\/p><p>/gi, "<br>"); //</p><p> -> <br>로 변환  
	     	content = content.replace(/(<\/p><br>|<p><br>)/gi, "<br><br>"); //</p><br>, <p><br> -> <br><br>로 변환
	     	content = content.replace(/(<p>|<\/p>)/gi, ""); //<p> 또는 </p> 모두 제거시
	      
	        $("textarea#content").val(content);
	     	
	     	
	     	// 시작일과 종료일, 오라클에 들어갈 date 형식으로  변경
	     	var sdate = startDate+$("select#startHour").val()+$("select#startMinute").val()+"00";
	     	var edate = endDate+$("select#endHour").val()+$("select#endMinute").val()+"00";
	     	
	     	$("input[name=startdate]").val(sdate);
	     	$("input[name=enddate]").val(edate);
	     	
	     	// 공유자 넣어주기 
	     	var plusUser_elm = document.querySelectorAll("div.displayUserList > span.plusUser");
			var joinUserArr = new Array();
			
			plusUser_elm.forEach(function(item,index,array){
				joinUserArr.push(item.innerText.trim());
			});
	     	
			var joinuser = joinUserArr.join(",");
			$("input[name=joinuser]").val(joinuser);
			
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
		
	}); // end of $(document).ready(function(){}-----------------------------------

		
	// Function Declaration 
	
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

<div id="scheduleRegister">
<h4 style="margin: 0 80px">일정등록</h4>
	<div id="srFrm" style="margin:50px 100px;">
		<form name="scheduleRegisterFrm">
			
			<table id="scheduleRegisterContent">
				<tr>
					<th>일정</th>
					<td>
						<input type="text" id="subject" name="subject" size="50"/>&nbsp;&nbsp;
					</td>
				</tr>
				<tr>
					<th>날짜</th>
					<td>
						<input type="date" id="startDate" min="1900-01-01" max="2999-12-31" value="${requestScope.chooseDate}" style="height: 30px;"/>&nbsp; 
						<select id="startHour" class="schedule"></select> 시
						<select id="startMinute" class="schedule"></select> 분
						- <input type="date" id="endDate" min="1900-01-01" max="2999-12-31" value="${requestScope.chooseDate}" style="height: 30px;"/>&nbsp;
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
				
				
			</table>
			<input type="hidden" value="${sessionScope.loginuser.pk_emp_no}" name="fk_emp_no"/>
			</form>
			
		<div style="text-align: center;">
		<button type="button" class="btn btn-primary btn-sm" id="register" >확인</button>
		<button type="button" class="btn btn-outline-primary btn-sm" onclick="javascript:location.href='<%= ctxPath%>/calendar/calenderMain.bts'">취소</button>
		</div>
	 </div>	
</div>