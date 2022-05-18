<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
   String ctxPath = request.getContextPath();
%>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<style>
td.commentContentsClosed:hover {
	font-weight: bold;
}
td#no{
    text-align: center;
    padding-top: 110px;
    font-weight: bold;
    font-size: 15pt;
}
</style>

<script type="text/javascript">

	var weatherTimejugi = 0;  // 단위는 밀리초

	$(document).ready(function(){
		
		  // 기상가져오기 시작
		  loopshowNowTime();
	      
	      // 시간이 대략 매 30분 0초가 되면 기상청 날씨정보를 자동 갱신해서 가져오려고 함.
	      // (매 정시마다 변경되어지는 날씨정보를 정시에 보내주지 않고 대략 30분이 지난다음에 보내주므로)
	   
	      var now = new Date();
	      var minute = now.getMinutes();  // 현재시각중 분을 읽어온다.
	      
	      if(minute < 30) { // 현재시각중 분이 0~29분 이라면
	         weatherTimejugi = (30-minute)*60*1000;  // 현재시각의 분이 0분이라면 weatherTimejugi에 30분을 넣어준다.
	                                                 // 현재시각의 분이 5분이라면 weatherTimejugi에 25분을 넣어준다.
	                                                 // 현재시각의 분이 29분이라면 weatherTimejugi에 1분을 넣어준다.
	      }
	      else if(minute == 30) {
	         weatherTimejugi = 1000;                 // 현재시각의 분이 30분이라면 weatherTimejugi에 1초 넣어준다.
	      }
	      else {                                      // 현재시각의 분이 31~59분이라면
	         weatherTimejugi = ( (60-minute)+30 )*60*1000;  // 현재시각의 분이 31분이라면 weatherTimejugi에 (29+30)분을 넣어준다.
	                                                        // 현재시각의 분이 40분이라면 weatherTimejugi에 (20+30)분을 넣어준다.
	                                                        // 현재시각의 분이 59분이라면 weatherTimejugi에 (1+30)분을 넣어준다.
	      }
	   
	      
	      startshowWeather(); // 기상청 날씨정보 공공API XML데이터 호출 및 매 1시간 마다 주기적으로 기상청 날씨정보 공공API XML데이터 호출하기
	      
		  // 기상 가져오기 끝
		
		
		goReadAll();	
		goReadNotice();	
		goReadBoard();	
		goReadFileboard();	
		scheduleCount();
		reservationCount();
		employeeBirth();
		readRecMail();
		
	});// end of $(document).ready(function(){})----------------------
	
	
// function declaration 

	// 로그인한 사용자의 받은메일함 보여주기
	function readRecMail() {
		
		$.ajax({
			url:"<%= request.getContextPath()%>/mail/mailReceive_main.bts",
			dataType:"JSON",
			success:function(json) {
				
				let html = "";
				if(json.length > 0) {
					$.each(json, function(index, item) {
						  html += "<tr style='text-align: center;'>";  
						  html += "<td class='mail' style='width:20%; style='text-align: center;'>"+item.sendempname+"</td>";
						  html += "<td class='mail' style='width:60%; text-align: left; padding-left: 30px;'><span onclick='goView_recMail("+item.pk_mail_num+")'style='color: black; cursor: pointer; '>"+item.subject+"</span></td>";
						  html += "<td class='mail' style='width:20%; text-align: center;'>"+item.reg_date+"</td>";	
						  html += "</tr>";
					});
				/*
						<tr>
					      <td style="width:20%; text-align: center;">정환모</td>
					      <td style="width:60%; text-align: left; padding-left: 30px;">여기는 메일함이에요!</td>
					      <td style="width:20%; text-align: center;">2022/4/30</td>
					    </tr>
				*/
				}
				else {
					  html += "<tr>";
					  html += "<td colspan='4' id='no' class='mail'>받은 메일이 없습니다.</td>";
					  html += "</tr>";					
				}
				
				  $("tbody#mailRecDisplay").html(html);				
			},
			  error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		});
		
	}// end of function recMailList()-----------------------
	  
	  function goView_recMail(pk_mail_num) {
					  
		  const searchType = $("select#searchType").val();
		  const searchWord = $("input#searchWord").val();
		
		  location.href="<%= ctxPath%>/mail/mailReceiveDetail.bts?pk_mail_num="+pk_mail_num+"&searchType="+searchType+"&searchWord="+searchWord;
		}// end of function goView(seq){}----------------------------------------------
	
</script>

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
				<div class="tab-pane in active" id="recieve_mail">
					<div class="board-area">
                	<table class="table" id="tbl_notice">
					  <thead class="thead-light th_all" id="all_head">
					    <tr style="text-align: center;">
					      <th style="width:20%; text-align: center;">보낸이</th>
					      <th style="width:60%; text-align: center;">제목</th>
					      <th style="width:20%; text-align: center;">보낸날짜</th>
					    </tr>
					  </thead>
					  
					  <tbody id="mailRecDisplay"></tbody>
					  
					</table>
                	</div>
				</div>
				
				
			</div>
		    
        </div>        
    </div>
    <!-- 메일함 카드 끝 -->
    