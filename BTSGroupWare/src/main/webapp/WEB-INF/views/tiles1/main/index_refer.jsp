<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<% String ctxPath = request.getContextPath(); %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    
<style type="text/css">
/* div, span {
	border: solid 1px gray;
} */
div.go-gadget-content {
	display: inline-block;
	border: solid 1px #c9c9c9;
	border-radius: 5px;
	margin-top: 20px;
}
div.left_section {
	width: 320px;
}
div.profile {
	padding: 40px 40px 10px;
}
img.emp_photo {
	display: block;
	width: 82px;
	height: 82px;
	border-radius: 50%;
	margin: 0 auto;
}
span.info {
	display: block;
	text-align: center;
	margin: 0 auto;
}
span.profileInfo {
	text-align: center;
	font-size: 18px;
	font-weight: bold;
}
span.company {
	display: inline-block;
	width: 100px;
	text-align: center;
	color: #919191;
}
li.today_list {
	line-height: 30px;
}
span.mybadge {
	margin-left: 130px;
}
ul#btn_list_block {
	margin-right: 0;
}
li.btn_list_li {
	border: solid 1px #c9c9c9;
	width: 150px;
	height: 70px;
	margin: 0 auto 10px auto;
	padding: 15px 8px;
}
li.odd {
	margin-right: 10px;
}
ul {
	list-style: none;
}
ul.type_btn_list_block {
	padding-left: 0;
}
li.odd, li.even {
	display: inline-block;
}
div.go-gadget-header, div.go_gadget_header {
	padding: 16px 21px 4px;
}
span.title {
	padding: 0px 2px 0px 0px;
	font-size: 16px;
	font-weight: bold;
}
p.txt {
	font-size: 13px;
	padding: 10px 21px 5px;
}
div.content-section-2 {
	width: 702px;
}
ul.dashboard_tab.gadget_tab {
	padding: 0px 24px;
}
ul.dashboard_tab.gadget_tab > li {
	display: inline-block;
}
ul.dashboard_tab.gadget_tab > li > a {
	font-size: 13px;
	padding: 0px 10px;
}
hr {
	margin: 0;
}
li.integrated {
	padding: 6px 36px 6px 21px;
}
li.board_menu, li.note_menu {
	cursor: pointer;
}
.whereBoard, .whereNote {
	border-bottom: solid 1px #000;
}
.whereBoard a, .whereNote a {
	color: #000;
	font-weight: bold;
}
ul.mailList {
	padding: 20px 0;
}
div.content-section-3 {
	width: 230px;
}
img.ic_dashboard {
	width: 30px;
	height: 28px;
}
div#section_1, div#section_2 {
	display: inline-block;
}
div#section_1 {
	float: left;
}
div#section_2_1, div#section_2_2 {
	display: inline-block;
}
div#section_2_2 {
	float: right;
}
div.ehr_stat_data.summary {
	position: relative;
	color: #333;
	font-size: 13px;
	padding: 0 21px 45px;
}
p#workTime {
	color: #000;
	font-size: 28px;
}
b {
	font-size: 20px;
	margin: 0 0 0 2px;
}
div#timemin {
	position: absolute;
	font-size: 13px;
	margin: 0 0 0 -40px;
	top: 60%;
}
div#bar {
	position: absolute;
	border: dotted 1px red;
	width: 2px;
	height: 30px;
	margin: -10px 0 0;
	/* top: 55%; */
}
div#timemax {
	position: absolute;
	font-size: 13px;
	right: 10%;
	top: 20%;
}
div.board_card.cardItem {
	width: 200px;
	height: 45px;
	color: #333;
	font-size: 13px;
	background-color: #F0F5FC;
	padding: 0 10px 10px;
	margin: 5px 0 5px 15px;
}
div.board_card.cardItem > div.title {
	padding: 16px 0 4px;
	cursor: pointer;
}

i#idx-icon {
	min-width:40px;
	text-align: center;
}

a#btn_a {
	text-decoration: none !important;
	color: black;
	font-weight: bold;
}

</style>

<script>
	$(document).ready(function(){

		loopshowNowTime();
		
	});// end of $(document).ready(function(){})----------------------
	
	// 현재 시간
	function showNowTime() {
		
		var now = new Date();
		
		var month = now.getMonth() + 1;
		
		if(month < 10) {
			month = "0" + month;
		}// end of if(month < 10) {}----------------------
		
		var date = now.getDate();
		
		if(date < 10) {
			date = "0" + date;
		}// end of if(date < 10) {}--------------------
		
		var week = new Array('일', '월', '화', '수', '목', '금', '토');
		var dayOfWeek = now.getDay();
		
		var strNow = now.getFullYear() + "년" + month + "월" + date + "일" + "(" + week[dayOfWeek] + ")";
		$("span#timelineGadgetDate").html(strNow);
		
		var hour = "";
		
		if(now.getHours() < 10) {
			hour = "0" + now.getHours();
		} else {
			hour = now.getHours();
		}// end of if(now.getHours() < 10) {}----------------------
		
		var minute = "";
		
		if(now.getMinutes() < 10) {
			minute = "0" + now.getMinutes();
		} else {
			minute = now.getMinutes();
		}// end of if(now.getMinutes() < 10) {}----------------------
		
		var second = "";
		
		if(now.getSeconds() < 10) {
			second = "0" + now.getSeconds();
		} else {
			second = now.getSeconds();
		}// end of if(now.getSeconds < 10) {} --------------------
		
		var strTime = hour + ":" + minute + ":" + second;
		$("span#timelineGadgetTime").html(strTime);
	   
	}// end of function showNowTime() -----------------------------
	
	// 반복
	function loopshowNowTime() {
		
		showNowTime();
		
		var timejugi = 1000;
		
		setTimeout(function(){
			loopshowNowTime();
		}, timejugi);
	      
	}// end of function loopshowNowTime() {} --------------------------
	

</script>

<div id="go-dashboard-10" class="go-dashboard go_dashboard_5_1">
	<!-- 1 block -->
	<div class="col-lg-3 go-gadget-column gadget-col-1 gadget_section1 layout_fixed" id="section_1" data-columnid="1">
		<div class="go-gadget go-gadget-17">
			<div class="go-gadget-config gadget_edit" style="display:none">
				<p class="desc">
					<span class="txt_caution error-msg-wrapper"></span>
				</p>
				<form name="gadget_options" class="gadget-options-form"></form>
				<footer class="btn_layer_wrap">
					<a class="btn_major_s btn-option-save"><span class="txt">저장</span></a>
					<a class="btn_minor_s btn-option-cancel"><span class="txt">취소</span></a>
				</footer>
			</div>
			<div class="go-gadget-content">
				<div class="gadget_design_wrap left_section">
					<div class="profile">
						<span class="photo">
							<c:choose>
								<c:when test="${not empty sessionScope.loginemp.photo_route}"><img src="<%= ctxPath%>/resources/images/${sessionScope.loginemp.photo_route}" class="emp_photo" title="${sessionScope.loginemp.emp_name}"></c:when>
								<c:otherwise><img src="<%= ctxPath%>/resources/images/photo_profile_small.jpg" class="emp_photo" title="${sessionScope.loginemp.emp_name}"></c:otherwise>
							</c:choose>
						</span>
						<br>
						<span class="info">
							<span class="profileInfo emp_name" title="${sessionScope.loginemp.emp_name}">${sessionScope.loginemp.emp_name}</span>
							<span class="profileInfo position_name">${sessionScope.loginemp.position_name}</span>
							<br>
							<span class="company">파이널 1팀</span>
						</span>
					</div>
					<ul class="type_simple_list today_list">
						<li class="summary-approval today_list">
							<a href="<%=ctxPath %>/elecapproval/waiting.os" data-bypass="true">
								<span class="type">
									<span class="ic_dashboard2 ic_type_approval" title="approval"></span>
								</span>
								<span class="txt">결재대기 문서</span>
								<span class="badge badge_zero mybadge" id="approvalBadge">0</span>
							</a>
						</li>
						<li class="summary-calendar today_list">
							<a href="<%=ctxPath %>/goCalendar.os" data-bypass="true">
								<span class="type">
									<span class="ic_dashboard2 ic_type_cal" title="calendar"></span>
								</span>
								<span class="txt">오늘의 일정</span>
								<span class="badge mybadge" id="calendarBadge">8</span>
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="go-gadget go-gadget-21">
			<div class="go-gadget-config gadget_edit" style="display:none">
				<p class="desc">
					<span class="txt_caution error-msg-wrapper"></span>
				</p>
				<form name="gadget_options" class="gadget-options-form"></form>
				<footer class="btn_layer_wrap">
					<a class="btn_major_s btn-option-save"><span class="txt">저장</span></a>
					<a class="btn_minor_s btn-option-cancel"><span class="txt">취소</span></a>
				</footer>
			</div>
			<div class="go-gadget-content" style="border: none;">
				<div class="gadget_design_wrap left_section">
					<ul class="type_btn_list_block" id="btn_list_block">
						<li class="odd btn_list_li" style="border-top-left-radius: 5px;">
							<a href="" data-bypass="true" data-popup="width=1024,height=790,scrollbars=yes,resizable=yes" id="btn_a">
								<span class="type">
									<i class="far fa-envelope fa-2x" id="idx-icon"></i>
								</span>
								<span class="txt">메일함</span>
							</a>
						</li>
						<li class="even btn_list_li" style="border-top-right-radius: 5px;">
							<a href="" id="btn_a">
								<span class="type">
									<i class="far fa-address-book fa-2x" id="idx-icon"></i>
								</span>
								<span class="txt">연락처 추가</span>
							</a>
						</li>
						<li class="odd btn_list_li" style="border-bottom-left-radius: 5px;">
							<a href="" id="btn_a">
								<span class="type">
									<i class="far fa-calendar-check fa-2x" id="idx-icon"></i>
								</span>
								<span class="txt">일정등록</span>
							</a>
						</li>
						<li class="even btn_list_li" style="border-bottom-right-radius: 5px;">
							<a href="" data-bypass="true" id="btn_a">
								<span class="type">
									<i class="fas fa-chalkboard fa-2x" id="idx-icon"></i>
								</span>
								<span class="txt">게시글 작성</span>
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="go-gadget go-gadget-15">
			<div class="go-gadget-config gadget_edit" style="display:none">
				<p class="desc">
					<span class="txt_caution error-msg-wrapper"></span>
				</p>
				<form name="gadget_options" class="gadget-options-form"></form>
				<footer class="btn_layer_wrap">
					<a class="btn_major_s btn-option-save"><span class="txt">저장</span></a>
					<a class="btn_minor_s btn-option-cancel"><span class="txt">취소</span></a>
				</footer>
			</div>
		</div>
	</div>

	<div class="col-lg-9 gadget_layout_wrapper" id="section_2">
		<!-- 2 block -->
		<div class="col-lg-9 gadget_layout_wrapper2" id="section_2_1">
			<div class="gadget_layout_wrapper3">
				<div class="go-gadget-column gadget-col-2 gadget_section2" data-columnid="2">
					<div class="go-gadget go-gadget-19">
						<div class="go-gadget-config gadget_edit" style="display:none">
							<p class="desc">
								<span class="txt_caution error-msg-wrapper"></span>
							</p>
							<form name="gadget_options" class="gadget-options-form"></form>
							<footer class="btn_layer_wrap">
								<a class="btn_major_s btn-option-save"><span class="txt">저장</span></a>
								<a class="btn_minor_s btn-option-cancel"><span class="txt">취소</span></a>
							</footer>
						</div>
						<div class="go-gadget-content content-section-2">
							<div data-cid="view73">
								<div class="gadget_design_wrap gadget_board_wrap">
									<div class="go_gadget_header">
						    			<div class="gadget_h1">
						        			<span class="type">
						        				<span class="ic_dashboard2 ic_type_bbs" title="전사게시판 최근글"></span>
						        			</span>
						        			<span class="title">전사게시판 최근글</span>
						    			</div>
									</div>
									<div class="design_content_header">
										<div class="tab_control tab_btn_prev tab_disabled">
											<span class="btn_wrap">
												<span class="ic_prev" title="이전"></span>
											</span>
										</div>
										<div id="gadget_tabs" class="swipe gadget_tab_wrap" style="visibility: visible;">
											<div class="swipe-wrap" style="width: 596px;">
												<div data-index="0" style="width: 596px; left: 0px; transition-duration: 0ms; transform: translate(0px, 0px) translateZ(0px);">
													<ul class="dashboard_tab gadget_tab">
														<li class="on board_menu" id="board_1" data-type="250">
															<a data-bypass="" title="전체" onclick="integratedBoard();">전체</a>
														</li>
														<li class="on board_menu" id="board_2" data-type="250">
															<a data-bypass="" title="전사 공지" onclick="noticeBoard();">전사 공지</a>
														</li>
														<li class="on board_menu" id="board_3" data-type="250">
															<a data-bypass="" title="일반 게시판" onclick="generalBoard();">일반 게시판</a>
														</li>
														<li class="on board_menu" id="board_4" data-type="250">
															<a data-bypass="" title="자료 게시판" onclick="fileBoard();">자료 게시판</a>
														</li>
													</ul>
													<hr>
												</div>
											</div>
										</div>
									</div>
									<ul class="type_simple_list simple_list_notice" id="postList">
									</ul>
									<div class="tool_bar tool_absolute" id="pageControl">
										<div class="dataTables_paginate paging_full_numbers">
											<a class="previous paginate_button_disabled" data-value="-1" data-type="prev" id="prev" data-bypass="true"></a>
											<a class="next paginate_button_disabled" data-value="1" data-type="next" id="next" data-bypass="true"></a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<div class="go-gadget go-gadget-51 gadget_design_border">
						<div class="go-gadget-config gadget_edit" style="display:none">
							<p class="desc">
								<span class="txt_caution error-msg-wrapper"></span>
							</p>
							<form name="gadget_options" class="gadget-options-form"></form>
							<footer class="btn_layer_wrap">
								<a class="btn_major_s btn-option-save"><span class="txt">저장</span></a>
								<a class="btn_minor_s btn-option-cancel"><span class="txt">취소</span></a>
							</footer>
						</div>
					</div>
					
					<div class="go-gadget go-gadget-25">
						<div class="go-gadget-config gadget_edit" style="display:none">
							<p class="desc">
								<span class="txt_caution error-msg-wrapper"></span>
							</p>
							<form name="gadget_options" class="gadget-options-form"></form>
							<footer class="btn_layer_wrap">
								<a class="btn_major_s btn-option-save"><span class="txt">저장</span></a>
								<a class="btn_minor_s btn-option-cancel"><span class="txt">취소</span></a>
							</footer>
						</div>
						<div class="go-gadget-content content-section-2">
							<div class="gadget_design_wrap gadget_board_wrap">
								<div class="go_gadget_header">
									<div class="gadget_h1">
										<span class="type">
											<span class="ic_dashboard2 ic_type_mail" title="메일함"></span>
										</span>
										<span class="title">쪽지함</span>
									</div>
								</div>
								<div id="tab">
									<div class="design_content_header">
										<div class="tab_control tab_btn_prev tab_disabled">
											<span class="btn_wrap">
												<span class="ic_prev" title="이전"></span>
											</span>
										</div>
										<div id="gadget_tabs" class="swipe gadget_tab_wrap" style="visibility: visible;">
											<div class="swipe-wrap" style="width: 596px;">
												<div data-index="0" style="width: 596px; left: 0px; transition-duration: 0ms; transform: translate(0px, 0px) translateZ(0px);">
													<ul class="dashboard_tab gadget_tab">
														<li class="on note_menu" id="note_1" data-type="folder/Inbox">
															<a data-bypass="" title="받은쪽지함" onclick="receivedAndSendNote(1);">받은쪽지함</a>
														</li>
														<li class="on note_menu" id="note_2" data-type="folder/Sent">
															<a data-bypass="" title="보낸쪽지함" onclick="receivedAndSendNote(2);">보낸쪽지함</a>
														</li>
														<li class="on note_menu" id="note_3" data-type="folder/Reserved">
															<a data-bypass="" title="중요쪽지함" onclick="receivedAndSendNote(3);">중요쪽지함</a>
														</li>
														<li class="on note_menu" id="note_4" data-type="quick/flaged">
															<a data-bypass="" title="임시쪽지함" onclick="receivedAndSendNote(4);">임시쪽지함</a>
														</li>
													</ul>
													<hr>
												</div>
											</div>
										</div>
										<div class="tab_control tab_btn_next tab_disabled">
											<span class="btn_wrap">
												<span class="ic_next" title="다음"></span>
											</span>
										</div>
									</div>
								</div>
								<div id="items">
									<div data-cid="view66">
										<ul class="mailList type_simple_list simple_list_mail" id="noteList">
										</ul>
										<div class="tool_bar tool_absolute">
											<div class="dataTables_paginate paging_full_numbers">
												<a data-bypass="true" class="previous paginate_button  paginate_button_disabled " title="이전"></a>
												<a data-bypass="true" class="next paginate_button  paginate_button_disabled " title="다음"></a>
											</div>
										</div>
									</div>
								</div>
								<div></div>
							</div>
						</div>
					</div>
					
					<div class="go-gadget go-gadget-27">
						<div class="go-gadget-config gadget_edit" style="display:none">
							<p class="desc">
								<span class="txt_caution error-msg-wrapper"></span>
							</p>
							<form name="gadget_options" class="gadget-options-form"></form>
							<footer class="btn_layer_wrap">
								<a class="btn_major_s btn-option-save"><span class="txt">저장</span></a>
								<a class="btn_minor_s btn-option-cancel"><span class="txt">취소</span></a>
							</footer>
						</div>
					</div>
				</div>
			</div>
			
			<div class="gadget_layout_wrapper4">
				<div class="go-gadget-column gadget-col-4 gadget_section2" data-columnid="4"></div>
				<div class="go-gadget-column gadget-col-5 gadget_section2" data-columnid="5"></div>
			</div>
		</div>
			
		<!-- 3 block -->
		<div class="col-lg-3 go-gadget-column gadget-col-3 gadget_section3 layout_fixed" id="section_2_2" data-columnid="3">
			<div class="go-gadget go-gadget-24 gadget_design_border">
			<div class="go-gadget-config gadget_edit" style="display:none">
				<p class="desc">
					<span class="txt_caution error-msg-wrapper"></span>
				</p>
				<form name="gadget_options" class="gadget-options-form"></form>
				<footer class="btn_layer_wrap">
					<a class="btn_major_s btn-option-save"><span class="txt">저장</span></a>
					<a class="btn_minor_s btn-option-cancel"><span class="txt">취소</span></a>
				</footer>
			</div>
			<div class="go-gadget-content content-section-3">
				<div class="gadget_design_wrap">
					<div class="go-gadget-header go_gadget_header">
						<div class="gadget_h1">
						<span class="type"><span class="ic_dashboard2 ic_type_todo" title="예약"></span></span>
						<span class="title">ToDO+ 카드 목록</span>
						</div>
					</div>
					<div class="board_card_wrap">
						<div class="layout_left_wrap" id="card_todo_card">
						</div>
					</div>
					<div class="tool_bar tool_absolute">
					    <div class="dataTables_paginate paging_full_numbers">
					        <a data-bypass="true" class="previous paginate_button paginate_button_disabled btnDisable" title="이전"></a>
					        <a data-bypass="true" class="next paginate_button " title="다음"></a>
					    </div>
					</div>
				</div>
			</div>
		</div>
		<div class="go-gadget go-gadget-24">
			<div class="go-gadget-config gadget_edit" style="display:none">
				<p class="desc">
					<span class="txt_caution error-msg-wrapper"></span>
				</p>
				<form name="gadget_options" class="gadget-options-form"></form>
				<footer class="btn_layer_wrap">
					<a class="btn_major_s btn-option-save"><span class="txt">저장</span></a>
					<a class="btn_minor_s btn-option-cancel"><span class="txt">취소</span></a>
				</footer>
			</div>
		</div>
			
			<div class="go-gadget go-gadget-24">
				<!-- <div class="go-gadget-header go_gadget_header">
					<div class="gadget_h1">
						<span class="title">가입 커뮤니티 바로가기</span>
						<span class="btn-mgmt btn_side_wrap">
							<span class="btn-edit btn_wrap"><span class="ic_dashboard2 ic_d_mgmt" title="편집"></span></span>
							<span class="btn-remove btn_wrap"><span class="ic_dashboard2 ic_d_delete" title="삭제"></span></span>
						</span>
					</div>
				</div> -->
				<div class="go-gadget-config gadget_edit" style="display:none">
					<p class="desc">
						<span class="txt_caution error-msg-wrapper"></span>
					</p>
					<form name="gadget_options" class="gadget-options-form"></form>
					<footer class="btn_layer_wrap">
						<a class="btn_major_s btn-option-save"><span class="txt">저장</span></a>
						<a class="btn_minor_s btn-option-cancel"><span class="txt">취소</span></a>
					</footer>
				</div>
				<div class="go-gadget-content content-section-3">
					<div class="gadget_design_wrap">
						<div class="go_gadget_header">
							<div class="gadget_h1">
							    <span class="type"><span class="ic_dashboard2 ic_type_login"></span></span>
							    <span class="title">최근 로그인 정보</span>
							</div>
						</div>
						<table class="type_normal table_fix gadget_login_info">
							<thead>
							    <tr>
							        <th class="time sorting_disabled" style="padding: 0 0 0 21px;"><span class="title_sort">일시</span></th>
							        <th class="ip sorting_disabled"><span class="title_sort">IP</span></th>
							    </tr>
							</thead>
							<tbody id="loginHistory">
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>