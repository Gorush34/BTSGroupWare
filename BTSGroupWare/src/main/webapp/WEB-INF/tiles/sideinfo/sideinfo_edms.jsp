<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<% String ctxPath = request.getContextPath(); %>

<style type="text/css">
</style>


<script type="text/javascript">

	$(document).ready(function(){
		
		// 캘린더 클릭시 일정 체크 박스 보이기, 숨기기
	//	$("div.slideTogglebox").hide();
		
		$("div#slideTogglebox1").show();
		$("div#slideTogglebox2").show();
		$("div#slideTogglebox3").show();
		
		
		$("div#edmsSideBar1").click(function(){
			$("div#slideTogglebox1").slideToggle();
		});
		
		$("div#edmsSideBar2").click(function(){
			$("div#slideTogglebox2").slideToggle();
		});
		
		$("div#edmsSideBar3").click(function(){
			$("div#slideTogglebox3").slideToggle();
		});
			
		
		
	});// end of $(document).ready(function(){}-------------------

			
	//Function Declaration
	
</script>

<div>
	<div id="sidebar" style="font-size: 11pt;">
		<span class="h4" id="sideInfo_edmsTitle" onclick="javascript:location.href='<%= ctxPath%>/edms/edmsHome.bts'">전자결재</span>

		<%--	 <input type="hidden" value="${sessionScope }" id="fk_emp_no"> --%>

		<button type="button" class="btn btn-outline-primary btn-lg "
				style="margin: 15px auto; width: 200px; display: block;"
				onclick="javascript:location.href='<%= ctxPath%>/edms/edmsAdd.bts'">문서작성</button>

		<ul style="list-style-type: none; padding: 10px;">
			<li style="margin-bottom: 15px;">
				
				<div class="edmsSideMenu">
					<label for="mySche"><span style="margin-left: 5px;" onclick="javascript:location.href='<%= ctxPath%>/edms/edmsHome.bts'">전자결재 홈으로</span></label>
				</div>
				
				<!-- 문서작성 시작 -->
				<div class="edmsSideMenu">
					<label for="mySche"><span style="margin-left: 5px;" onclick="javascript:location.href='<%= ctxPath%>/edms/edmsAdd.bts'">문서작성</span></label>
				</div>
				<!-- 문서작성 종료 -->
				
				
				<!-- 전체문서함 시작 -->
				<div id="edmsSideBar1" class="edmsSideMenu">전체문서함</div>
				
				<div id="slideTogglebox1" class="slideTogglebox1">
					<table style="margin: 0 20px;">
						<tr>
							<td>
								<label for="mySche"><span style="margin-left: 5px;" onclick="javascript:location.href='<%= ctxPath%>/edms/list.bts'">전체문서함</span></label>
							</td>
						</tr>
						<tr>
							<td>
								<label for="mySche"><span style="margin-left: 5px;" onclick="javascript:location.href='<%= ctxPath%>/edms/wait/list.bts'">대기문서함</span></label>
							</td>
						</tr>
						<tr>
							<td>
								<label for="mySche"><span style="margin-left: 5px;" onclick="javascript:location.href='<%= ctxPath%>/edms/accept/list.bts'">승인문서함</span></label>
							</td>
						</tr>
						<tr>
							<td>
								<label for="mySche"><span style="margin-left: 5px;" onclick="javascript:location.href='<%= ctxPath%>/edms/reject/list.bts'">반려문서함</span></label>
							</td>
						</tr>
					</table>
				</div>
				<!-- 전체문서함 종료 -->
				
				<!-- 내문서함 시작 -->
				<div id="edmsSideBar2" class="edmsSideMenu">내문서함</div>
				
				<div id="slideTogglebox2" class="slideTogglebox2">
					<table style="margin: 0 20px;">
						<tr>
							<td>
								<label for="mySche"><span style="margin-left: 5px;" onclick="javascript:location.href='<%= ctxPath%>/edms/mydoc/waitlist.bts'">대기문서함</span></label>
							</td>
						</tr>
						<tr>
							<td>
								<label for="mySche"><span style="margin-left: 5px;" onclick="javascript:location.href='<%= ctxPath%>/edms/mydoc/acceptlist.bts'">승인문서함</span></label>
							</td>
						</tr>
						<tr>
							<td>
								<label for="mySche"><span style="margin-left: 5px;" onclick="javascript:location.href='<%= ctxPath%>/edms/mydoc/rejectlist.bts'">반려문서함</span></label>
							</td>
						</tr>
					</table>
				</div>
				<!-- 내문서함 종료 -->
				
				<div id="edmsSideBar3" class="edmsSideMenu">결재하기</div>
				
				<div id="slideTogglebox3" class="slideTogglebox3">
					<table style="margin: 0 20px;">
						<tr>
							<td>
								<label for="mySche">
								 <span style="margin-left: 5px;" onclick="javascript:location.href='<%= ctxPath%>/edms/waitingSignList.bts'">
								 	결재대기목록
								 </span>&nbsp;
								 <a href="#" class="badge badge-pill badge-info">대기개수</a>
								</label>
							</td>
						</tr>
					</table>
				</div>
			</li>
		</ul>
	</div>
</div>
