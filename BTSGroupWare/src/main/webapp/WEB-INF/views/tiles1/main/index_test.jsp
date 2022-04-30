<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
   String ctxPath = request.getContextPath();
%>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>


<script type="text/javascript">

	$(document).ready(function(){
		
	});// end of $(document).ready(function(){})----------------------

	
</script>



<div class="container_fluid">
	    <div class="row">
        <!-- 왼쪽 섹션 시작 -->
        <div class="col-sm-2 gadget_design_wrap" id="section_left">
        	<!-- 사원정보 시작 -->
	        <div id="empInfo">
	        	<div class="profile">
	        		<span class="photo">
	        			<span class="photo">
	        				<img src="<%= ctxPath%>/resources/images/nol.png" title="" />
	        			</span>
	        		</span>
	        		<span class="info">
	        			<span class="name" title="">정환모</span>
	        			<span class="position">사원</span>
	        			<br>
	        			<span class="part">인사과</span>
	        		</span>
	        	</div>
	        
		        <ul class="type_simple_list today_list">
		        	<li class="summary-approval2">
		        		<a href="">
		        			<span class="type">
		        				<span class="ic_dashboard2 ic_type_approval2" title="approval2"></span>
		        			</span>
		        			<span class="text">결재 수신 문서</span>
		        			<span class="badge">0</span>
		        		</a>
		        	</li>
		        	<li class="summary-approval">
	 		        	<a href="">
		        			<span class="type">
		        				<span class="ic_dashboard2 ic_type_approval" title="approval"></span>
		        			</span>
		        			<span class="text">결재할 문서</span>
		        			<span class="badge">0</span>
		        		</a>
		        	</li>
		        	<li class="summary-calendar">
	     		        <a href="">
		        			<span class="type">
		        				<span class="ic_dashboard2 ic_type_calendar" title="calendar"></span>
		        			</span>
		        			<span class="text">오늘의 일정</span>
		        			<span class="badge">0</span>
		        		</a>
		        	</li>
		        	<li class="summary-community">
		        		<a href="">
		        			<span class="type">
		        				<span class="ic_dashboard2 ic_type_community" title="community"></span>
		        			</span>
		        			<span class="text">내 커뮤니티 새글</span>
		        			<span class="badge">0</span>
		        		</a>
		        	</li>
		        	<li class="summary-asset">
		        		<a href="">
		        			<span class="type">
		        				<span class="ic_dashboard2 ic_type_asset" title="asset"></span>
		        			</span>
		        			<span class="text">내 예약/대여 현황</span>
		        			<span class="badge">0</span>
		        		</a>
		        	</li>
		        	<li class="summary-report">
		        		<a href="">
		        			<span class="type">
		        				<span class="ic_dashboard2 ic_type_report" title="report"></span>
		        			</span>
		        			<span class="text">작성할 보고</span>
		        			<span class="badge">0</span>
		        		</a>
		        	</li>	
		        	<li class="summary-survey">
		        		<a href="">
		        			<span class="type">
		        				<span class="ic_dashboard2 ic_type_survey" title="survey"></span>
		        			</span>
		        			<span class="text">참여할 문서</span>
		        			<span class="badge">0</span>
		        		</a>
		        	</li>	
		        </ul>
		    </div>
		    <!-- 사원정보 끝 -->
		    <!-- 퀵메뉴 시작 -->
		    <div class="go-gadget-content" style="border: none;">
				<div class="gadget_design_wrap left_section" id="gadget_design_wrap">
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
			<!-- 퀵메뉴 끝 -->
			
			<!-- 생일자 시작 -->
        	<div class="go-gadget-content" id="empBirthday">
	        	<div class="go_gadget_header empBirthday_title">
	        		<div class="gadget_h1">
		        		<span id="title">임직원 생일</span>
		        	</div>
		        	<div class="birth_month" style="border-bottom: solid 1px dee2e6;">
	        			<span style="font-size:20px; font-weight:bold;">2022.04</span>
        				<div id="birth_prevenext">
        					<a href=""><i class="fas fa-angle-left"></i></a>&nbsp;&nbsp;
        					<a href=""><i class="fas fa-angle-right"></i></a>
        				</div>
        			</div>
        		</div>
	        	
	        	<br>
	        	<br>
	        	<br>
	        	<div id="birthList">
		        	<table id="todayBirthday">
		        	<tbody style="text-align: center;">
		        		<tr style="border-top:solid 1px #dee2e6;"></tr>
		        		<tr id="birth_person" style="width:100%;">
		        			<td id="date" style="width:40%; text-align: center;">
		        				04 / 30
		        			</td>
		        			<td id="name" style="width:60%; text-align: center;">
		        				정환모 사원
		        			</td>
		        		</tr>
		        		<tr id="birth_person" style="width:100%;">
		        			<td id="date" style="width:40%; text-align: center;">
		        				04 / 30
		        			</td>
		        			<td id="name" style="width:60%; text-align: center;">
		        				정환모 대리
		        			</td>
		        		</tr>
		        	</tbody>
		        	</table>
		        </div>	
		        	
		    </div>
		    <!-- 생일자 끝 -->
		
        </div>
        <!-- 왼쪽 섹션 끝 -->
	        
        <!-- 중간 섹션 시작 -->
        <div class="col-sm-7" id="section_center">
        
        
        
        <div id="margin_left">
        	<!-- 게시판 카드 시작 -->
			<div class="card shadow mb-4" style="min-height: 400px;">
                <!-- Card Header - Dropdown -->
                <div
                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
	                    <!-- <h6 class="m-0 font-weight-bold">게시판</h6>  -->
	                    <ul class="nav nav-tabs board-tab">
						<!-- Tab 아이템이다. 태그는 li과 li > a이다. li태그에 active는 현재 선택되어 있는 탭 메뉴이다. -->
						<li class="active"><a href="#all" data-toggle="tab">전체</a></li>
						<li><span>|</span></li>
						<!-- a 태그의 href는 아래의 tab-content 영역의 id를 설정하고 data-toggle 속성을 tab으로 설정한다. -->
						<li><a href="#notice" data-toggle="tab">공지게시판</a></li>
						<li><span>|</span></li>
						<li><a href="#board" data-toggle="tab">일반게시판</a></li>
						<li><span>|</span></li>
						<li><a href="#archive" data-toggle="tab">자료게시판</a></li>
					</ul>
                </div>
                <!-- Card Body -->
                <div class="card-body">
                
	                <!-- Tab이 선택되면 내용이 보여지는 영역이다. -->
					<!-- 태그는 div이고 class는 tab-content로 설정한다. -->
					<div class="tab-content">
						<!-- 각 탭이 선택되면 보여지는 내용이다. 태그는 div이고 클래스는 tab-pane이다. -->
						<!-- active 클래스는 현재 선택되어 있는 탭 영역이다. -->
						<div class="tab-pane in active" id="all">
							<div class="board-area">
	                    	<table class="table" id="tbl_notice">
							  <thead class="thead-light th_all" id="all_head">
							    <tr style="text-align: center;">
							      <th style="width:60%; text-align: center;">제목</th>
							      <th style="width:20%; text-align: center;">작성자</th>
							      <th style="width:20%; text-align: center;">작성일자</th>
							    </tr>
							  </thead>
							  <tbody id="all_body">
								<tr style="text-align: center;">
							      <td style="width:60%; text-align: left; padding-left: 30px;">문길이는 웃고있다.</td>
							      <td style="width:20%; text-align: center;">정환모 사원</td>
							      <td style="width:20%; text-align: center;">2022/4/30</td>
							    </tr>
							    <tr style="text-align: center;">
							      <td style="width:60%; text-align: left; padding-left: 30px;">안녕하세요~</td>
							      <td style="width:20%; text-align: center;">정환모 사원</td>
							      <td style="width:20%; text-align: center;">2022/4/30</td>
							    </tr>
							  </tbody>
							</table>
	                    	</div>
						</div>
						<!-- id는 고유한 이름으로 설정하고 tab의 href와 연결되어야 한다. -->
						<div class="tab-pane" id="notice">
							<div class="board-area">
	                    	<table class="table" id="tbl_notice">
							  <thead class="thead-light th_all" id="all_head">
							    <tr style="text-align: center;">
							      <th style="width:60%; text-align: center;">제목</th>
							      <th style="width:20%; text-align: center;">작성자</th>
							      <th style="width:20%; text-align: center;">작성일자</th>
							    </tr>
							  </thead>
							  <tbody id="all_body">
								<tr style="text-align: center;">
							      <td style="width:60%; text-align: left; padding-left: 30px;">다들 열심히 해주시길 바랍니다.</td>
							      <td style="width:20%; text-align: center;">김민정 상무</td>
							      <td style="width:20%; text-align: center;">2022/4/30</td>
							    </tr>
							    <tr style="text-align: center;">
							      <td style="width:60%; text-align: left; padding-left: 30px;">알아서 잘 딱 깔끔하고 센스있게 하세요.</td>
							      <td style="width:20%; text-align: center;">문병윤 대표</td>
							      <td style="width:20%; text-align: center;">2022/4/30</td>
							    </tr>
							  </tbody>
							</table>
	                    	</div>
						</div>
						<!-- fade 클래스는 선택적인 사항으로 트랜지션(transition)효과가 있다.
						<!-- in 클래스는 fade 클래스를 선언하여 트랜지션효과를 사용할 때 in은 active와 선택되어 있는 탭 영역의 설정이다. -->
						<div class="tab-pane" id="board">
							<div class="board-area">
	                    	<table class="table" id="tbl_notice">
							  <thead class="thead-light th_all" id="all_head">
							    <tr style="text-align: center;">
							      <th style="width:60%; text-align: center;">제목</th>
							      <th style="width:20%; text-align: center;">작성자</th>
							      <th style="width:20%; text-align: center;">작성일자</th>
							    </tr>
							  </thead>
							  <tbody id="all_body">
								<tr style="text-align: center;">
							      <td style="width:60%; text-align: left; padding-left: 30px;">주말에도 일하기 싫습니다.</td>
							      <td style="width:20%; text-align: center;">임유리 대리</td>
							      <td style="width:20%; text-align: center;">2022/4/30</td>
							    </tr>
							    <tr style="text-align: center;">
							      <td style="width:60%; text-align: left; padding-left: 30px;">팀장님이 도망갔습니다.</td>
							      <td style="width:20%; text-align: center;">김지은 대리</td>
							      <td style="width:20%; text-align: center;">2022/4/30</td>
							    </tr>
							  </tbody>
							</table>
	                    	</div>
						</div>
						<div class="tab-pane" id="archive">
							<div class="board-area">
	                    	<table class="table" id="tbl_notice">
							  <thead class="thead-light th_all" id="all_head">
							    <tr style="text-align: center;">
							      <th style="width:60%; text-align: center;">제목</th>
							      <th style="width:20%; text-align: center;">작성자</th>
							      <th style="width:20%; text-align: center;">작성일자</th>
							    </tr>
							  </thead>
							  <tbody id="all_body">
								<tr style="text-align: center;">
							      <td style="width:60%; text-align: left; padding-left: 30px;">지하철에서 앉기 위한 10가지 전략</td>
							      <td style="width:20%; text-align: center;">정환모 사원</td>
							      <td style="width:20%; text-align: center;">2022/4/30</td>
							    </tr>
							    <tr style="text-align: center;">
							      <td style="width:60%; text-align: left; padding-left: 30px;">등 뒤에 곰이 업혀있다.</td>
							      <td style="width:20%; text-align: center;">성문길 차장</td>
							      <td style="width:20%; text-align: center;">2022/4/30</td>
							    </tr>
							  </tbody>
							</table>
	                    	</div>
						</div>
					</div>
				    
                </div>
                
            </div>
            <!-- 게시판 카드 끝 -->
        	
			<!-- 메일함 카드 시작 -->
			<div class="card shadow mb-4" style="min-height: 400px;">
                <!-- Card Header - Dropdown -->
                <div
                    class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
	                    <!-- <h6 class="m-0 font-weight-bold">게시판</h6>  -->
	                    <ul class="nav nav-tabs board-tab">
						<!-- a 태그의 href는 아래의 tab-content 영역의 id를 설정하고 data-toggle 속성을 tab으로 설정한다. -->
						<li class="active"><a href="#recieve" data-toggle="tab">받은메일함</a></li>
					</ul>
                </div>
                <!-- Card Body -->
                <div class="card-body">
                
	                <!-- Tab이 선택되면 내용이 보여지는 영역이다. -->
					<!-- 태그는 div이고 class는 tab-content로 설정한다. -->
					<div class="tab-content">
						<!-- 각 탭이 선택되면 보여지는 내용이다. 태그는 div이고 클래스는 tab-pane이다. -->
						<!-- active 클래스는 현재 선택되어 있는 탭 영역이다. -->
						<div class="tab-pane in active" id="recieve">
							<div class="board-area">
	                    	<table class="table" id="tbl_notice">
							  <thead class="thead-light th_all" id="all_head">
							    <tr style="text-align: center;">
							      <th style="width:20%; text-align: center;">보낸이</th>
							      <th style="width:60%; text-align: center;">제목</th>
							      <th style="width:20%; text-align: center;">작성일자</th>
							    </tr>
							  </thead>
							  <tbody id="all_body">
								<tr style="text-align: center;">
							      <td style="width:20%; text-align: center;">정환모</td>
							      <td style="width:60%; text-align: left; padding-left: 30px;">여기는 메일함이에요!</td>
							      <td style="width:20%; text-align: center;">2022/4/30</td>
							    </tr>
							    <tr style="text-align: center;">
							      <td style="width:20%; text-align: center;">정환모</td>
							      <td style="width:60%; text-align: left; padding-left: 30px;">메인화면 채워야되니까 보존해주세요..</td>
							      <td style="width:20%; text-align: center;">2022/4/30</td>
							    </tr>
							  </tbody>
							</table>
	                    	</div>
						</div>
					</div>
				    
                </div>
                
            </div>
            <!-- 메일함 카드 끝 -->
			
		</div>
        </div>
        <!-- 중간 섹션 끝 -->
        
        <!-- 오른쪽 섹션 시작 -->
        <div class="col-sm-3" id="section_right">
        	<!-- 웹채팅 시작 -->
        	<div id="empInfo">
        		<div id="web_title" style="text-align:center;"></div>
	        	<div class="profile">
	        		<span class="photo">
	        			<span class="photo">
	        				<img src="<%= ctxPath%>/resources/images/choo.png" title="" />
	        			</span>
	        		</span>
	        		<span class="title">
	        			<span class="name" title="">웹채팅</span>
	        		</span>
	        	</div>
	        	<hr>
		        <div id="chatFrame" style="width:90%">
		        	<table id="chatting">
		        	<tbody>
			        	<tr>
			        	<span><td>[17:25]정환모 : 안녕하세요!</td></span>
			        	</tr>
			        	<tr>
			        	<span><td>[03:40]정환모 : 아무도 없네요..</td></span>
			        	</tr>
		        	</tbody>
		        	
		        	</table>
		        </div>
		        <div id="input" style="width:100%">
		        	<input type="text" name="chatContent" id="chatContent"/>
		        	<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnChat">입력</button>
		        </div>
		    </div>
		    <!-- 메모장 끝 -->
		    
        </div>
        <!-- 오른쪽 섹션 끝 -->
	        
    </div>
</div>