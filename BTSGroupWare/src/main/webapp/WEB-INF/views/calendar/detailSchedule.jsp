<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<style type="text/css">

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		// ==== 종일체크박스에 체크를 할 것인지 안할 것인지를 결정하는 것 시작 ==== //
		// 시작 시 분
		var str_startdate = $("span#startdate").text();
	 // console.log(str_startdate); 
		// 2021-12-01 09:00
		var target = str_startdate.indexOf(":");
		var start_min = str_startdate.substring(target+1);
	 // console.log(start_min);
		// 00
		var start_hour = str_startdate.substring(target-2,target);
	 //	console.log(start_hour);
		// 09
		
		// 종료 시 분
		var str_enddate = $("span#enddate").text();
	//	console.log(str_enddate);
		// 2021-12-01 18:00
		target = str_enddate.indexOf(":");
		var end_min = str_enddate.substring(target+1);
	 // console.log(end_min);
	    // 00 
		var end_hour = str_enddate.substring(target-2,target);
	 //	console.log(end_hour);
		// 18
		
		if(start_hour=='00' && start_min=='00' && end_hour=='23' && end_min=='59' ){
			$("input#allDay").prop("checked",true);
		}
		else{
			$("input#allDay").prop("checked",false);
		}
		// ==== 종일체크박스에 체크를 할 것인지 안할 것인지를 결정하는 것 끝 ==== //
	
	}); // end of $(document).ready(function(){}----------------------------------------------------------------------

	
	// ********** Function Declaration ************//
	
		// 일정 삭제하기
	function delSchedule(pk_schno){
	
		var bool = confirm("일정을 삭제하시겠습니까?");
		
		if(bool){
			$.ajax({
				url: "<%= ctxPath%>/calendar/deleteSchedule.bts",
				type: "post",
				data: {"pk_schno":pk_schno},
				dataType: "json",
				success:function(json){
					if(json.n==1){
						alert("일정을 삭제하였습니다.");
					}
					else {
						alert("일정을 삭제하지 못했습니다.");
					}
					
					location.href="<%= ctxPath%>/calendar/calenderMain.bts";
				},
				error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }
			});
		}
		
	}// end of function delSchedule(scheduleno){}-------------------------


	// 일정 수정하기
	function editSchedule(pk_schno){
		var frm = document.goEditFrm;
		frm.pk_schno.value = pk_schno;
		
		frm.action = "<%= ctxPath%>/calendar/editSchedule.bts";
		frm.method = "post";
		frm.submit();
	}

</script>

<div id="detailSchedule">
<h4 style="margin: 0 80px">일정상세</h4>
	<div style="margin:50px 100px;">
			<div style="margin-bottom: 30px;">
				<span id="subject" style="font-weight: bold; font-size: 15pt; color: #007acc;">${requestScope.map.SUBJECT}</span>&nbsp;&nbsp;
			</div>
			<table id="detailScheduleContent">
				<tr>
					<th>일자</th>
					<td>
						<span id="startdate">${requestScope.map.STARTDATE}</span>&nbsp;~&nbsp;<span id="enddate">${requestScope.map.ENDDATE}</span>&nbsp;&nbsp;  
						<input type="checkbox" id="allDay" disabled/>&nbsp;종일
					</td>
				</tr>
				<tr>
					<th>캘린더</th>
					<td>
						<c:if test="${requestScope.map.FK_LGCATGONO eq '2'}">
							사내 캘린더&nbsp;&nbsp;&#58;&nbsp;&nbsp;${requestScope.map.CALNAME}
						</c:if>
						<c:if test="${requestScope.map.FK_LGCATGONO eq '1'}">
							내 캘린더&nbsp;&nbsp;&#58;&nbsp;&nbsp;${requestScope.map.CALNAME}
						</c:if>
					</td>
				</tr>
				<tr>
					<th>참석자</th>
					<td>
					${requestScope.map.JOINUSER}
					</td>
				</tr>
				<tr>
					<th>장소</th>
					<td>${requestScope.map.PLACE}</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>${requestScope.map.CONTENT}</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${requestScope.map.EMP_NAME}</td>
				</tr>
				
			
			 
				
			</table>
			
	<input type="hidden" value="${sessionScope.loginuser.pk_emp_no}" />
	<input type="hidden" value="${requestScope.map.FK_LGCATGONO}" />
	
	<c:set var="v_fk_emp_no" value="${requestScope.map.FK_EMP_NO}" />
	<c:set var="v_fk_lgcatgono" value="${requestScope.map.FK_LGCATGONO}"/>
	<c:set var="v_loginuser_emp_no" value="${sessionScope.loginuser.pk_emp_no}"/>

	<div style="margin: 40px; text-align: center;">
		<c:if test="${not empty requestScope.listgobackURL_schedule}">
			<c:if test="${v_fk_lgcatgono eq '2' && sessionScope.loginuser.gradelevel == 1 }">
				<button type="button" id="edit" class="btn btn-outline-primary" style="margin-right: 8px;" onclick="editSchedule('${requestScope.map.PK_SCHNO}')">수정</button>
				<button type="button" class="btn_normal" style="margin-right: 8px;"  onclick="delSchedule('${requestScope.map.PK_SCHNO}')">삭제</button>
			</c:if>
			<c:if test="${v_fk_lgcatgono eq '1' && v_fk_emp_no eq v_loginuser_emp_no}">
				<button type="button" id="edit" class="btn btn-outline-primary" style="margin-right: 8px;"  onclick="editSchedule('${requestScope.map.PK_SCHNO}')">수정</button>
				<button type="button" class="btn_normal" style="margin-right: 8px;"  onclick="delSchedule('${requestScope.map.PK_SCHNO}')">삭제</button>
			</c:if>
				<button type="button" id="cancel" class="btn btn-primary"  style="margin-right: 8px;"  onclick="javascript:location.href='<%= ctxPath%>/${requestScope.listgobackURL_schedule}'">취소</button> 
		</c:if>
	
		<c:if test="${empty requestScope.listgobackURL_schedule}">
	        <c:if test="${v_fk_lgcatgono eq '2' && sessionScope.loginuser.gradelevel == 1 }">
				<button type="button" id="edit" class="btn btn-outline-primary"  style="margin-right: 8px;" onclick="editSchedule('${requestScope.map.PK_SCHNO}')">수정</button>
				<button type="button" class="btn btn-outline-primary"  style="margin-right: 8px;" onclick="delSchedule('${requestScope.map.PK_SCHNO}')">삭제</button>
			</c:if>
			<c:if test="${v_fk_lgcatgono eq '1' && v_fk_emp_no eq v_loginuser_emp_no}">
				<button type="button" id="edit" class="btn btn-outline-primary"  style="margin-right: 8px;" onclick="editSchedule('${requestScope.map.PK_SCHNO}')">수정</button>
				<button type="button" class="btn btn-outline-primary"  style="margin-right: 8px;" onclick="delSchedule('${requestScope.map.PK_SCHNO}')">삭제</button>
			</c:if>
				<button type="button" id="cancel" class="btn btn-primary" style="margin-right: 8px;" onclick="javascript:location.href='<%= ctxPath%>/calendar/detailSchedule.bts'">캘린더로 돌아가기</button> 
		</c:if>
		
	</div>

</div>
	<div id="commentView">
	
	</div>


</div>
<form name="goEditFrm">
	<input type="hidden" name="pk_schno"/>
	<input type="hidden" name="gobackURL_ds" value="${requestScope.gobackURL_ds}"/>
</form>
		