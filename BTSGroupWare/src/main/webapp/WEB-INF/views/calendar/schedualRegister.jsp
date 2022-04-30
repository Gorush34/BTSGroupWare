<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style type="text/css">

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
	//	$('#question').tooltip(options)

		
	});

</script>

<div id="schedualRegister">
<h4>일정등록</h4>
	<form name="schedualRegister">
		<div id="srFrm" style="margin:50px 100px;">
			<div>
				<input type="text" size="50"/>&nbsp;&nbsp;&nbsp;
				<input type="checkbox" id="secret" name="secret"/><label for="secret">비공개</label> &nbsp;&nbsp;&nbsp;
				<span class="tooltip-arrow" id="question" data-toggle="tooltip" data-placement="right" title="비공개 일정은 참석자만 확인가능합니다."><i class="bi bi-question-circle-fill" ></i></span>
			</div>
			<table id="schedualRegisterContent">
				<tr>
					<td>데이트피커</td>
					<td><input type="checkbox" id="allday" name="allday"/><label for="allday">종일</label></td>
					<td><input type="checkbox" id="repeat" name="repeat"/><label for="repeat">반복</label></td>
				</tr>
				<tr>
					<th>내 캘린더</th>
					<td><select></select></td>
				</tr>
				<tr>
					<th>참석자<i class="bi bi-question-circle-fill"></i></th>
					<td></td>
				</tr>
				<tr>
					<th>외부참석자</th>
					<td><input type="text"/></td>
					<td><button type="button">추가</button></td>
				</tr>
				<tr>
					<th>장소</th>
					<td><input type="text"/></td>
				</tr>
				<tr>
					<th>내용</th>
					<td><input type="text"/></td>
				</tr>
				<tr>
					<th>알람</th>
					<td><i class="bi bi-alarm"></i>알람 추가</td>
					<td><input type="text"/></td>
					<td><select></select></td>
					<td><select></select></td>
					<td><i class="bi bi-x-circle"></i></td>
				</tr>
				<tr>
					<th>예약하기<i class="bi bi-question-circle-fill"></i></th>
					<td><div id="reservateResource"><span><i class="bi bi-caret-down-fill"></i></span><span></span></div></td>
				</tr>
			</table>
	  </div>
	</form>
</div>