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
				html+="<option value='0"+i+"'>0"+i+"&#58;00</option>";
				html+="<option value='0"+i+"'>0"+i+"&#58;30</option>";
			}
			else{
				html+="<option value="+i+">"+i+"&#58;00</option>";
				html+="<option value="+i+">"+i+"&#58;30</option>";
			}
		}// end of for----------------------
		
		$("select#startHour").html(html);
		$("select#endHour").html(html);
		
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
	
		
	});

</script>

<div id="resourceRegister">
<h4 style="margin: 0 80px">자산목록 > 자산추가</h4>
	<form name="schedualRegister">
	<h5 style="margin: 50px 90px 0 0;">기본정보</h5>	
		<div id="resourceFrm" style="margin:50px 100px;">
			<table id="resourceRegisterContent">
				<tr>
					<th>자산명</th>
					<td><input type="text" name="reso_name" class="form-control"/></td>
				</tr>
				<tr>
					<th>사용시간</th>
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
					<th>이용권한</th>
					<td>
						<input type="radio" name="allUse"/><label for="allUse">전체 허용</label>
						<input type="radio" name="partUse"/><label for="partUse">일부만 허용</label>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea rows="10" cols="100" style="height: 200px;" name="content" id="content"  class="form-control"></textarea></td>
				</tr>
			</table>
			<div style="text-align: center;">
				<button type="button" class="btn btn-primary btn-sm" >확인</button>
				<button type="button" class="btn btn-outline-primary btn-sm" onclick="javascript:location.href='<%= ctxPath%>/calendar/reservationAdmin.bts'">취소</button>
			</div>
	  </div>
	</form>
</div>