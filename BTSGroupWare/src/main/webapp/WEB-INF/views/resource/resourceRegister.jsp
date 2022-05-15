<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<style type="text/css">

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
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

	// function declaration
	// 자원 등록하기
	function addResource(){
		
		// 제목 유효성 검사
		var subject = $("input#rname").val().trim();
        if(subject==""){
			alert("자원명을 입력하세요."); 
			return;
		}
        
        // 분류 선택 유무 검사
		var calType = $("select.pk_classno").val().trim();
		if(calType==""){
			alert("분류를 선택하세요."); 
			return;
		}
		
		// 내용 유효성 검사
		var subject = $("textarea#rinfo").val().trim();
        if(subject==""){
			alert("자원정보를 입력하세요."); 
			return;
		}
		

		
		var frm = document.resourceRegisterFrm;
		frm.action="<%= ctxPath%>/resource/resourceRegister_end.bts";
		frm.method="post";
		frm.submit();
	
	}
	
</script>

<div id="resourceRegister" >
<h4 style="margin: 0 80px">자산목록 > 자산추가</h4>
	<form name="resourceRegisterFrm">
		<div id="resourceFrm" style="margin:50px auto;">
			<table id="resourceRegisterContent" style="margin-left:auto; margin-right:auto;">
				<tr>
					<th>자산명</th>
					<td><input type="text" name="rname" id="rname" class="form-control"/></td>
				</tr>
				<tr> 
					<th>분류</th>
					<td>
						<select class="pk_classno" name="pk_classno"> 
	                   	 <option value="">선택하세요</option>
						 <option value="1">3층 회의실</option>
						 <option value="2">자동차</option>
						 <option value="3">빔프로젝터</option>
					    </select>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea rows="10" cols="100" style="height: 200px;" name="rinfo" id="rinfo"  class="form-control"></textarea></td>
				</tr>
			</table>
			<div style="text-align: center; margin-top:30px;">
				<button type="button" class="btn btn-primary btn-sm" onclick="addResource()" >확인</button>
				<button type="button" class="btn btn-outline-primary btn-sm" onclick="javascript:location.href='<%= ctxPath%>/reservation/reservationMain.bts'">취소</button>
			</div>
	  </div>
	</form>
</div>