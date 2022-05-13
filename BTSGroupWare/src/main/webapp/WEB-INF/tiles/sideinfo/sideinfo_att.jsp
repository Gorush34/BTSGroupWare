<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    
<% String ctxPath = request.getContextPath(); %>

<%-- 캘린더(일정) 사이드 tiles 만들기 --%>

<style type="text/css">

#link > a { 
	text-decoration: none !important;
	color : black;	
}

</style>


<script type="text/javascript">

	$(document).ready(function(){
		
		// 현재시간 가져오기
		loopshowNowTime();

		// 내 출퇴근시간 가져오기
		showWorkInOutTime();
		
		// 출근버튼 클릭시
		$("button#in_time").click(function(){
			
			if( $("input#fk_emp_no").val().trim() == "" ) {
				alert("로그인 하고 오세요~");
				return;
			}
			
			$.ajax({
				url:"<%= ctxPath%>/att/workIn.bts",
				data:{"yymmdd":$("span#yymmdd").text(),
					  "clock":$("span#clock").text(),
					  "fk_emp_no":$("input#fk_emp_no").val()},
				dataType:"json",
				success:function(json){
					if(json.n == 1){
						alert("출근하셨습니다. 오늘도 좋은 하루 되세요!");
						$("button#in_time").prop("disabled",true);
						$("span#workin").html( $("span#clock").text() );
					}
					else if(json.n == 0) {
						alert("출근했잖아 이양반아... 그래도 좋은 하루 되세요!");
						$("button#in_time").prop("disabled",true);
					}
				} // end of success----------------------------------
			}); // end of $.ajax({})------------------------
			
		}); // end of $("button#in_time").click(function(){})---------------
		
		$("button#out_time").click(function(){
			
			if($("span#workin").text() == "미등록") {
				alert("출근부터 하시기 바랍니다!");
				return;
			}
			else {
				var yymmdd = $("span#yymmdd").text();
				var in_time = $("span#workin").text();
				var out_time = $("span#clock").text();
				var total_workTime = getTotalWorkTime(yymmdd, in_time, out_time);
				
				$.ajax({
					url:"<%= ctxPath%>/att/workOut.bts",
					data:{"yymmdd":$("span#yymmdd").text(),
						  "out_time":out_time,
						  "total_workTime":total_workTime,
						  "fk_emp_no":$("input#fk_emp_no").val()},
					dataType:"json",
					success:function(json){
						if(json.n == 1){
							alert("퇴근처리하셨습니다. 오늘 하루도 고생 많으셨습니다!");
							$("button#in_time").prop("disabled",true);
							$("button#out_time").prop("disabled",true);
							$("span#workout").html( out_time );
						}
						else if(json.n == 0) {
							alert("퇴근했잖아 이양반아... 수고했어 오늘도~");
							$("button#in_time").prop("disabled",true);
							$("button#out_time").prop("disabled",true);
						}
					} // end of success----------------------------------
				}); // end of $.ajax({})------------------------
			}
			
			
		}); // end of $("button#out_time").click(function(){})-----------
		
	});// end of $(document).ready(function(){}-------------------
			
	// Function Declartion

	function showNowYYYYMMDD() {
      
      var now = new Date();
   
      var month = now.getMonth() + 1;
      if(month < 10) {
         month = "0"+month;
      }
      
      var date = now.getDate();
      if(date < 10) {
         date = "0"+date;
      }
      
      var day = now.getDay();
      var korDay = "";
      if(day == 0){
    	  korDay = "일"
      }
      else if(day == 1){
    	  korDay = "월"
      }
      else if(day == 2){
    	  korDay = "화"
      }
      else if(day == 3){
    	  korDay = "수"
      }
      else if(day == 4){
    	  korDay = "목"
      }
      else if(day == 5){
    	  korDay = "금"
      }
      else if(day == 6){
    	  korDay = "토"
      }
      var strNow = now.getFullYear() + "-" + month + "-" + date + "("+korDay+")";
      
      $("span#yymmdd").html(strNow);
   
   }// end of function showNowYYYYMMDD() -----------------------------	
	
	function showNowHHMMSS() {
      
	  var now = new Date(); 
	   
      var hour = "";
       if(now.getHours() < 10) {
           hour = "0"+now.getHours();
       } 
       else {
          hour = now.getHours();
       }
      
      var minute = "";
      if(now.getMinutes() < 10) {
         minute = "0"+now.getMinutes();
      } else {
         minute = now.getMinutes();
      }
      
      var second = "";
      if(now.getSeconds() < 10) {
         second = "0"+now.getSeconds();
      } else {
         second = now.getSeconds();
      }
      
      var strNow = hour + ":" + minute + ":" + second;
      
      $("span#clock").html(strNow);
   
   }// end of function showNowHHMMSS() -----------------------------

	// 시간을 계속 보여주는 함수
   function loopshowNowTime() {
      showNowHHMMSS();
      showNowYYYYMMDD();
      
      var timejugi = 1000;   // 시간을 1초 마다 자동 갱신하려고.
      
      setTimeout(function() {
    	  		  loopshowNowTime();   
               }, timejugi);
      
   }// end of function loopshowNowTime() --------------------------

   // 하루에 근무한 시간을 계산하는 함수
   function getTotalWorkTime(yymmdd, in_time, out_time) {
	   
	    var test1 = yymmdd + " " + in_time;
		var test2 = yymmdd + " " + out_time;
		
		test1 = new Date(test1);
		test2 = new Date(test2);
		// 계산식
		var total_workTime = Math.round( ((test2 - test1) / (60 * 60 * 1000))*10 ) / 10;

		// 결과 확인
		console.log(total_workTime);
		
		return total_workTime;
	   
   } // end of getTotalWorkTime(yymmdd, in_time, out_time)
   
   // 출퇴근시간 보여주는 함수
   function showWorkInOutTime() {
	   
	   $.ajax({
			url:"<%= ctxPath%>/att/getWorkInOutTime.bts",
			data:{"yymmdd":$("span#yymmdd").text(),
				  "fk_emp_no":${sessionScope.loginuser.pk_emp_no}},  
			dataType:"json",
			success:function(json){
				if(json.in_time != "미등록" && json.out_time == "미등록"){
					$("button#in_time").prop("disabled",true);
					$("span#workin").html( json.in_time );
					$("span#workout").html( json.out_time );
				}
				else if(json.in_time != "미등록" && json.out_time != "미등록"){
					$("button#in_time").prop("disabled",true);
					$("button#out_time").prop("disabled",true);
					$("span#workin").html( json.in_time );
					$("span#workout").html( json.out_time );
				}
				else {
					// 00시가 되면 출/퇴근시간 초기화하기
					refreshInOutTime();
				}
			} // end of success----------------------------------
		});
	   
   } // end of function showWorkInOutTime()------------
   
	// 00시가 되면 출/퇴근시간 초기화하기
   function refreshInOutTime() {
	   
	   $.ajax({
			url:"<%= ctxPath%>/att/refreshInOutTime.bts",
			data:{"yymmdd":$("span#yymmdd").text(),
				  "fk_emp_no":${sessionScope.loginuser.pk_emp_no}},  
			dataType:"json",
			success:function(json){
				if(json.isTomorrow == 0){
					$("button#in_time").prop("disabled",false);
					$("button#out_time").prop("disabled",false);
					$("span#workin").html( json.in_time );
					$("span#workout").html( json.out_time );
				}
			} // end of success----------------------------------
		});
	   
   } // end of function refreshInOutTime()--------------
   
</script>

<div>
   <div id="sidebar" style="font-size: 11pt;">
	 <h4>근태관리</h4>
	 <form name = "commutFrm">
		 <div style="text-align: left; font-size: 16px;">
		      <span id="yymmdd" style="color:black;"></span>
		 </div>
		 <div style="text-align: left; padding-left:50px; font-size: 36px;">
		      <span id="clock" style="color:black; font-weight:bold;"></span>
		 </div>
		 <div style="display:block; margin-top:8px;">
		 	<span style="float:left;">출근시간</span>
		 	<span id="workin" style="float:right; padding-right: 10px;">미등록</span><br>
		 </div>
		 <div style="display:block; margin-top:8px;">	
		 	<span style="float:left;">퇴근시간</span>
		 	<span id="workout" style="float:right; padding-right: 10px;">미등록</span>
		 </div>
		 <hr style="margin-top: 40px;">
		<input type="hidden" value="${sessionScope.loginuser.pk_emp_no}" id="fk_emp_no">
	  	<button type="button" class="btn btn-outline-primary btn-lg " id="in_time" style="margin: 15px auto; width:110px; display:inline-block;" >출근</button>
		<button type="button" class="btn btn-outline-primary btn-lg " id="out_time" style="margin: 15px 0 15px 10px; width:110px; display:inline-block;" >퇴근</button>
	</form>
			<ul style="list-style-type: none; padding: 10px;">
			<li style="margin-bottom: 15px;"> 
				<div id="calenderbtn1" class="calenderbtn">근태관리</div>
					<div id="slideTogglebox1"  class="slideTogglebox">
						<table style="margin: 0 20px;">
							<tbody>
								<tr id="">
				   					<td><span id="link" style="margin-left: 5px;"><a href="<%= ctxPath %>/att/myCommute.bts">나의 출퇴근기록</span></label></td>
				   				</tr>
				   				<tr>
				   					<td><span id="link" style="margin-left: 5px;"><a href="<%= ctxPath %>/att/myAtt.bts">내 연차 내역</a></span></label></td>
				   				</tr>	
				   				<tr>
				   					<td><span id="link" style="margin-left: 5px;"><a href="<%= ctxPath %>/att/reportVacation.bts">연차신청</a></span></label></td>
				   				</tr>
				   				<tr>
				   					<td><span id="link" style="margin-left: 5px;"><a href="<%= ctxPath %>/att/waitingSign.bts">결재대기문서 확인</a></span></label></td>
				   				</tr>
			   				</tbody>	
		   				</table>	
					</div>
			</li>
		</ul>
		<hr>
		
		
	</div>
</div>
	