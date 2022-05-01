<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<style type="text/css">

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
	//	$('#question').tooltip(options)

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

<div id="schedualRegister">
<h4 style="margin: 0 80px">일정등록</h4>
	<form name="schedualRegister">
		<div id="srFrm" style="margin:50px 100px;">
			<div>
				<input type="text" id="subject" name="subject" size="50"/>&nbsp;&nbsp;
				<input type="checkbox" id="secret" name="secret"/><label for="secret">비공개</label> &nbsp;&nbsp;&nbsp;
				<span class="tooltip-right" data-tooltip="비공개 일정은 참석자만 확인가능합니다."><i class="bi bi-question-circle-fill"></i></span>
			</div>
			<table id="schedualRegisterContent">
				<tr>
					<td>데이트피커</td>
					<td><input type="checkbox" id="allday" name="allday"/><label for="allday"> &nbsp;종일</label>&nbsp;&nbsp;&nbsp;<input type="checkbox" id="repeat" name="repeat"/><label for="repeat">&nbsp;반복</label></td>
				</tr>
				<tr>
					<th>내 캘린더</th>
					<td>
						<select class="calSelect">
						<c:choose>
							 <%-- 일정등록시 사내캘린더 등록은 oginuser.gradelevel =='10' 인 사용자만 등록이 가능하도록 한다. --%> 
							<c:when test="${loginuser.gradelevel =='10'}"> 
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
						</select>
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
									<thead class="table-primary" style="color:white; ">
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
			<div style="text-align: center;">
			<button type="button" class="btn btn-primary btn-sm" >확인</button>
			<button type="button" class="btn btn-outline-primary btn-sm" onclick="javascript:location.href='<%= ctxPath%>/calendar/calendarMain.bts'">취소</button>
			</div>
			
	  </div>
	</form>
</div>