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
			<div>
				<input type="text" id="subject" name="subject" size="50" value="${requestScope.map.SUBJECT}" readonly/>&nbsp;&nbsp;
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
			
	<input type="hidden" value="${sessionScope.loginuser.pk_emp_no}" />
	<input type="hidden" value="${requestScope.map.FK_LGCATGONO}" />
	
	<c:set var="v_fk_emp_no" value="${requestScope.map.FK_EMP_NO}" />
	<c:set var="v_fk_lgcatgono" value="${requestScope.map.FK_LGCATGONO}"/>
	<c:set var="v_loginuser_emp_no" value="${sessionScope.loginuser.pk_emp_no}"/>
<%--
	<div style="float: right;">
		<c:if test="${not empty requestScope.listgobackURL_schedule}">
			<c:if test="${v_fk_lgcatgono eq '2' && sessionScope.loginuser.gradelevel == 1 }">
				<button type="button" id="edit" class="btn_normal" onclick="editSchedule('${requestScope.map.PK_SCHNO}')">수정</button>
				<button type="button" class="btn_normal" onclick="delSchedule('${requestScope.map.PK_SCHNO}')">삭제</button>
			</c:if>
			<c:if test="${v_fk_lgcatgono eq '1' && v_fk_emp_no eq v_loginuser_emp_no}">
				<button type="button" id="edit" class="btn_normal" onclick="editSchedule('${requestScope.map.PK_SCHNO}')">수정</button>
				<button type="button" class="btn_normal" onclick="delSchedule('${requestScope.map.PK_SCHNO}')">삭제</button>
			</c:if>
				<button type="button" id="cancel" class="btn_normal" style="margin-right: 0px;" onclick="javascript:location.href='<%= ctxPath%>/${requestScope.listgobackURL_schedule}'">취소</button> 
		</c:if>
	
		<c:if test="${empty requestScope.listgobackURL_schedule}">
	        <c:if test="${v_fk_lgcatgono eq '2' && sessionScope.loginuser.gradelevel == 1 }">
				<button type="button" id="edit" class="btn_normal" onclick="editSchedule('${requestScope.map.PK_SCHNO}')">수정</button>
				<button type="button" class="btn_normal" onclick="delSchedule('${requestScope.map.PK_SCHNO}')">삭제</button>
			</c:if>
			<c:if test="${v_fk_lgcatgono eq '1' && v_fk_emp_no eq v_loginuser_emp_no}">
				<button type="button" id="edit" class="btn_normal" onclick="editSchedule('${requestScope.map.PK_SCHNO}')">수정</button>
				<button type="button" class="btn_normal" onclick="delSchedule('${requestScope.map.PK_SCHNO}')">삭제</button>
			</c:if>
				<button type="button" id="cancel" class="btn_normal" style="margin-right: 0px; background-color: #990000;" onclick="javascript:location.href='<%= ctxPath%>/calendar/detailSchedule.bts'">취소</button> 
		</c:if>
		
	</div>
 --%>
</div>
	<div id="commentView">
	
	</div>


</div>
<form name="goEditFrm">
	<input type="hidden" name="pk_schno"/>
	<input type="hidden" name="gobackURL_ds" value="${requestScope.gobackURL_ds}"/>
</form>
		