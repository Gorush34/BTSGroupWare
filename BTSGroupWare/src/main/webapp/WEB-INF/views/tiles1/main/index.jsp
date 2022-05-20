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

td.mail_subject:hover {
	font-weight: bold;
}

#memberProfile {
    width: 82px !important;
    height: 82px !important;
    border-radius: 100px !important;
}

</style>

<script type="text/javascript">

	var weatherTimejugi = 0;  // 단위는 밀리초

	$(document).ready(function(){
		
		  // 기상가져오기 시작
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
	      
		// 퇴근시간 클릭시
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
		
		mybd_cnt();
		goReadAll();	
		goReadNotice();	
		goReadBoard();	
		goReadFileboard();	
		scheduleCount();
		reservationCount();
		employeeBirth();
		readRecMail();
		vacCount();
		
	});// end of $(document).ready(function(){})----------------------

// Function Declartion
	
	function goReadAll() {
		  
		  $.ajax({
			  url:"<%= request.getContextPath()%>/board/readAll.bts",
			  dataType:"JSON",
			  success:function(json){
				  
				  let html = "";
				  if(json.length > 0) {
					  $.each(json, function(index, item){
						  if(item.tblname == "자유게시판"){
							  html += "<tr>";  
							  html += "<td class='board' style='width: 11%; text-align: center; font-size: 9pt; color: gray; padding-left: 30px;'>"+item.tblname+"</td>";	
							  html += "<td class='commentContentsClosed'><span onclick='goView_board("+item.pk_seq+")' class='subject2' style='color: black; cursor: pointer; '>"+item.subject+"</span></td>";
							  if(item.user_name == "관리자"){
								  html += "<td class='board' style='text-align: center;'>"+item.user_name+"</td>";
							  }
							  if(item.user_name != "관리자"){
								  html += "<td class='board' style='text-align: center;'>"+item.user_name+" "+item.ko_rankname+"</td>";
							  }
							  html += "<td class='board' style='text-align: center;'>"+item.write_day+"</td>";	
							  html += "</tr>";
						  }
						  if(item.tblname == "공지사항"){
							  html += "<tr>";  
							  html += "<td class='board' style='width: 11%; text-align: center; font-size: 9pt; color: gray; padding-left: 30px;'>"+item.tblname+"</td>";	
							  html += "<td class='commentContentsClosed'><span onclick='goView_notice("+item.pk_seq+")' class='subject2' style='color: black; cursor: pointer; '>"+item.subject+"</span></td>";
							  html += "<td class='board' style='text-align: center;'>"+item.user_name+"</td>";
							  html += "<td class='board' style='text-align: center;'>"+item.write_day+"</td>";	
							  html += "</tr>";
						  }
						  if(item.tblname == "자료실"){
							  html += "<tr>";  
							  html += "<td class='board' style='width: 11%; text-align: center; font-size: 9pt; color: gray; padding-left: 30px;'>"+item.tblname+"</td>";	
							  html += "<td class='commentContentsClosed'><span onclick='goView_fileboard("+item.pk_seq+")' class='subject2' style='color: black; cursor: pointer; '>"+item.subject+"</span></td>";
							  if(item.user_name == "관리자"){
								  html += "<td class='board' style='text-align: center;'>"+item.user_name+"</td>";
							  }
							  if(item.user_name != "관리자"){
								  html += "<td class='board' style='text-align: center;'>"+item.user_name+" "+item.ko_rankname+"</td>";
							  }
							  html += "<td class='board' style='text-align: center;'>"+item.write_day+"</td>";	
							  html += "</tr>";
						  }
					  });
				  }
				  else {
					  html += "<tr>";
					  html += "<td colspan='4' id='no' class='board'>게시물이 없습니다.</td>";
					  html += "</tr>";
				  }
				  
				  $("tbody#allDisplay").html(html);
			  },
			  error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		  });
		  
	  }// end of function goReadComment(){}--------------------------
	
	
	function goReadNotice() {
		  
		  $.ajax({
			  url:"<%= request.getContextPath()%>/board/readNotice.bts",
			  dataType:"JSON",
			  success:function(json){
				  
				  let html = "";
				  if(json.length > 0) {
					  $.each(json, function(index, item){
						  html += "<tr>";  
						  html += "<td class='board' style='width: 11%; text-align: center; font-size: 9pt; color: gray; padding-left: 30px;'>"+item.header+"</td>";	
						  html += "<td class='commentContentsClosed'><span onclick='goView_notice("+item.pk_seq+")' class='subject2' style='color: black; cursor: pointer; '>"+item.subject+"</span></td>";
						  html += "<td class='board' style='text-align: center;'>"+item.user_name+"</td>";
						  html += "<td class='board' style='text-align: center;'>"+item.write_day+"</td>";	
						  html += "</tr>";
					  });
				  }
				  else {
					  html += "<tr>";
					  html += "<td colspan='4' id='no' class='board'>게시물이 없습니다.</td>";
					  html += "</tr>";
				  }
				  
				  $("tbody#noticeDisplay").html(html);
			  },
			  error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		  });
		  
	  }// end of function goReadComment(){}--------------------------	
	
	function goReadBoard() {
		  
		  $.ajax({
			  url:"<%= request.getContextPath()%>/board/readBoard.bts",
			  dataType:"JSON",
			  success:function(json){
				  
				  let html = "";
				  if(json.length > 0) {
					  $.each(json, function(index, item){
						  html += "<tr>";  
						  html += "<td class='commentContentsClosed'><span onclick='goView_board("+item.pk_seq+")' class='subject2' style='color: black; cursor: pointer; padding-left: 30px;'>"+item.subject+"</span></td>";
						  if(item.user_name == "관리자"){
							  html += "<td class='board' style='text-align: center;'>"+item.user_name+"</td>";
						  }
						  if(item.user_name != "관리자"){
							  html += "<td class='board' style='text-align: center;'>"+item.user_name+" "+item.ko_rankname+"</td>";
						  }
						  html += "<td class='board' style='text-align: center;'>"+item.write_day+"</td>";	
						  html += "</tr>";
					  });
				  }
				  else {
					  html += "<tr>";
					  html += "<td colspan='3' id='no' class='board'>게시물이 없습니다.</td>";
					  html += "</tr>";
				  }
				  
				  $("tbody#boardDisplay").html(html);
			  },
			  error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		  });
		  
	  }// end of function goReadComment(){}--------------------------	
	  
	  
	function goReadFileboard() {
		  
		  $.ajax({
			  url:"<%= request.getContextPath()%>/board/readFileboard.bts",
			  dataType:"JSON",
			  success:function(json){
				  
				  let html = "";
				  if(json.length > 0) {
					  $.each(json, function(index, item){
						  html += "<tr>";  
						  html += "<td class='board' style='width: 11%; text-align: center; font-size: 9pt; color: gray; padding-left: 30px;'>"+item.ko_depname+"</td>";	
						  html += "<td class='commentContentsClosed'><span onclick='goView_fileboard("+item.pk_seq+")' class='subject2' style='color: black; cursor: pointer;'>"+item.subject+"</span></td>";
						  if(item.user_name == "관리자"){
							  html += "<td class='board' style='text-align: center;'>"+item.user_name+"</td>";
						  }
						  if(item.user_name != "관리자"){
							  html += "<td class='board' style='text-align: center;'>"+item.user_name+" "+item.ko_rankname+"</td>";
						  }
						  html += "<td class='board' style='text-align: center;'>"+item.write_day+"</td>";	
						  html += "</tr>";
					  });
				  }
				  else {
					  html += "<tr>";
					  html += "<td colspan='4' id='no' class='board'>게시물이 없습니다.</td>";
					  html += "</tr>";
				  }
				  
				  $("tbody#fileboardDisplay").html(html);
			  },
			  error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		  });
		  
	  }// end of function goReadComment(){}--------------------------	
	  
	  function goView_board(pk_seq) {
			
		  const gobackURL = "${requestScope.gobackURL}"; 
		  
		  const searchType = $("select#searchType").val();
		  const searchWord = $("input#searchWord").val();
		
		  location.href="<%= ctxPath%>/board/view.bts?pk_seq="+pk_seq+"&gobackURL="+gobackURL; 
		}// end of function goView(seq){}----------------------------------------------
	  
	  function goView_notice(pk_seq) {
			
		  const gobackURL = "${requestScope.gobackURL}"; 
		  
		  const searchType = $("select#searchType").val();
		  const searchWord = $("input#searchWord").val();
		
		  location.href="<%= ctxPath%>/notice/view.bts?pk_seq="+pk_seq+"&gobackURL="+gobackURL; 
		}// end of function goView(seq){}----------------------------------------------
	
	function goView_fileboard(pk_seq) {
		
		  const gobackURL = "${requestScope.gobackURL}"; 
		  
		  const searchType = $("select#searchType").val();
		  const searchWord = $("input#searchWord").val();
		
		  location.href="<%= ctxPath%>/fileboard/view.bts?pk_seq="+pk_seq+"&gobackURL="+gobackURL; 
		}// end of function goView(seq){}----------------------------------------------
	
	
	// 내가쓴글 
	function mybd_cnt(){
			
			$.ajax({
				url:"<%= ctxPath%>/board/my_cnt.bts",
				dataType:"JSON",
				success:function(json){
					//console.log("json.n"+json.n);
					let html = "";
					if(json.n == 0){
						html += 0;
					}
					else if(json.n > 0){
						html += json.n;
					}
					
					$("span#mybd_cnt").html(html);
				},
				error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
			
		}// end of function mybd_cnt(){}-------------------------------------------------
		
	// ==== 일정 및 자원 예약 관련 함수 ==== //	
	// 오늘의 일정 수 
	function scheduleCount(){
			
			$.ajax({
				url:"<%= ctxPath%>/calendar/scheduleCount.bts",
				dataType:"JSON",
				success:function(json){
					//console.log("json.n"+json.n);
					let html = "";
					//scheCount
					if(json.n == 0){
						html += 0;
					}
					else if(json.n > 0){
						html += json.n;
					}
					
					$("span#scheCount").html(html);
				},
				error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
			
		}// end of function scheduleCount(){}-------------------------------------------------
		
	// 나의 예정 대여 현황	
	function reservationCount(){
			
			$.ajax({
				url:"<%= ctxPath%>/reservation/reservationCount.bts",
				dataType:"JSON",
				success:function(json){
					//console.log("json.n"+json.n);
					let html = "";
					
					if(json.n == 0){
						html += 0;
					}
					else if(json.n > 0){
						html += json.n;
					}
					
					$("span#rserCount").html(html);
				},
				error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
			});
			
		}// end of function reservationCount(){}-------------------------------------------------
		
	     function vacCount(){
				
				$.ajax({
					url:"<%= ctxPath%>/att/vacCount.bts",
					dataType:"JSON",
					success:function(json){
						//console.log("json.n"+json.n);
						let html = "";
						//vacCount
						if(json.n == 0){
							html += 0;
						}
						else if(json.n > 0){
							html += json.n;
						}
						
						$("span#vacCount").html(html);
					},
					error: function(request, status, error){
							alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
				});
				
		}// end of function vacCount(){}-------------------------------------------------
		
		
		// 기상 관련함수 시작
		
		function showNowTime() {
      
	      var now = new Date();
	   
	      var month = now.getMonth() + 1;
	      if(month < 10) {
	         month = "0"+month;
	      }
	      
	      var date = now.getDate();
	      if(date < 10) {
	         date = "0"+date;
	      }
	      
	      var strNow = now.getFullYear() + "-" + month + "-" + date;
	      
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
	      
	      strNow += " "+hour + ":" + minute + ":" + second;
	      
	      // $("span#clock").html(strNow);
	   
	   }// end of function showNowTime() -----------------------------
		
		function loopshowNowTime() {
	      showNowTime();
	      showNowHHMMSS();
	      showNowYYYYMMDD();
	      
	      var timejugi = 1000;   // 시간을 1초 마다 자동 갱신하려고.
	      
	      setTimeout(function() {
	                  loopshowNowTime();   
	               }, timejugi);
	      
	   }// end of loopshowNowTime() --------------------------
	
	   
	   // ------ 기상청 날씨정보 공공API XML데이터 호출하기 -------- //
	   function showWeather() {
	
	      $.ajax({
	         url:"<%= request.getContextPath()%>/opendata/weatherXML.bts",
	         type:"GET",
	         dataType:"XML",
	         success: function(xml){
	            var rootElement = $(xml).find(":root");
	         //   console.log("확인용 : " + $(rootElement).prop("tagName") );
	            // 확인용 : current 
	            
	            var weather = $(rootElement).find("weather");
	            var updateTime = $(weather).attr("year")+"년 "+$(weather).attr("month")+"월 "+$(weather).attr("day")+"일 "+$(weather).attr("hour")+"시";    
	         //  console.log(updateTime); 
	            // 2020년 12월 18일 09시 
	            
	            var localArr = $(rootElement).find("local");
	         //   console.log("지역개수 : " + localArr.length);
	            // 지역개수 : 95
	            
	            var html = "날씨정보 발표시각 : <span style='font-weight:bold;'>"+updateTime+"</span>&nbsp;";
	                 html += "<span style='color:blue; cursor:pointer; font-size:9pt;' onClick='javascript:showWeather();'>업데이트</span><br/><br/>";
	                 html += "<table class='table table-hover' align='center'>";
	                html += "<tr>";
	                html += "<th>지역</th>";
	                html += "<th>날씨</th>";
	                html += "<th>기온</th>";
	                html += "</tr>";
	                
	            // ====== XML 을 JSON 으로 변경하기  ====== //
	               var jsonObjArr = [];
	            /////////////////////////////////////////
	            
	            for(var i=0; i<localArr.length; i++) { 
	               var local = $(localArr).eq(i);
	               /* .eq(index) 는 선택된 요소들을 인덱스 번호로 찾을 수 있는 선택자이다. 
	                                    마치 배열의 인덱스(index)로 값(value)를 찾는 것과 같은 효과를 낸다.
	                  */
	                  
	            //   console.log( $(local).text() + " stn_id:" + $(local).attr("stn_id") + " icon:" + $(local).attr("icon") + " desc:" + $(local).attr("desc") + " ta:" + $(local).attr("ta") );
	               // 속초 stn_id:90 icon:02 desc:구름조금 ta:1.6
	               // 북춘천 stn_id:93 icon:02 desc:구름조금 ta:-3.9 
	               
	               var icon = $(local).attr("icon");
	               if(icon == "") {
	                  icon = "없음";
	               }
	               
	               html += "<tr>";
	               html += "<td>"+$(local).text()+"</td><td><img src='/board/resources/images/weather/"+icon+".png' />"+$(local).attr("desc")+"</td><td>"+$(local).attr("ta")+"</td>";
	               html += "</tr>";
	               
	               // ====== XML 을 JSON 으로 변경하기  ====== //
	                  var jsonObj = {"locationName":$(local).text(),
	                               "ta":$(local).attr("ta")};
	                  
	                  jsonObjArr.push(jsonObj);
	               //////////////////////////////////////////////////
	               
	            }// end of for----------------------------
	                
	            html += "</table>";
	            
	            $("div#displayWeather").html(html);
	            
	         },// end of success: function(xml){}---------------------------
	         error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	         }
	      });
	   }// end of function showWeather(){}----------------------------- 
	   
	   
	   function startshowWeather() {
	      loopshowWeather();
	      
	      setTimeout(function() {
	         showWeather();   
	      }, weatherTimejugi); // 현재시각의 분이 5분이라면 weatherTimejugi가 25분이므로 25분후인 30분에 showWeather();를 실행한다.
	   }// end of function startshowWeather() --------------------------   
	   
	   
	   function loopshowWeather() {
	      showWeather();
	      
	      setTimeout(function() {
	           loopshowWeather();   
	      }, weatherTimejugi + (60*60*1000));  // 현재시각의 분이 5분이라면 weatherTimejugi가 25분이므로 25분후인 30분에 1시간을 더한후에 showWeather();를 실행한다.
	   }// end of function loopshowWeather() --------------------------   
	
	// 기상 관련함수 끝
		
	// 임직원 생일 관련 함수
	function employeeBirth(){
		   $.ajax({
			   url:"<%= ctxPath%>/calendar/employeeBirthIndex.bts",
			   dataType:"JSON",
			   success:function(json){
				    let html = "";
				    let html_1 = "";
				   		html +="<tr style='border-top:solid 1px #dee2e6;'></tr>";
					  if(json.length > 0) {
						  $.each(json, function(index, item){
							  html +="<tr id='birth_person' style='width:100%;'>";
							  html +="<td id='date' style='width:40%; text-align: center;'>"+item.BIRTHDAY+"</td>";
							  html +="<td id='name' style='width:60%; text-align: center;'>"+item.EMP_NAME+"</td>";
							  html +="</tr>";
							  
							  if(item.MONTH == item.MONTH){
								  html_1 = item.MONTH+"<input id='sysMonth' type='hidden' value='"+item.MONTH+"' />";
							  }
						  });
					  } 
					  
					  
					  $("span#today_month").html(html_1);
					  $("tbody#employeeBirthday").html(html);
			   },
			   error: function(request, status, error){
	                  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	           }
		   });
	}// end of function employeeBirth(){}---------------------------------
	
	// 전월 생일자
	function preMonth(){
		$.ajax({
			url:"<%= ctxPath%>/calendar/preMonthBirthIndex.bts",
			data:{"month": $('input#sysMonth').val()},
			dataType:"JSON",
			success:function(json){
				let html = "";
			    let html_1 = "";
			   		html +="<tr style='border-top:solid 1px #dee2e6;'></tr>";
				  if(json.length > 0) {
					  $.each(json, function(index, item){
						  html +="<tr id='birth_person' style='width:100%;'>";
						  html +="<td id='date' style='width:40%; text-align: center;'>"+item.BIRTHDAY+"</td>";
						  html +="<td id='name' style='width:60%; text-align: center;'>"+item.EMP_NAME+"</td>";
						  html +="</tr>";
						  
						  if(item.MONTH == item.MONTH){
							  html_1 = item.MONTH+"<input id='sysMonth' type='hidden' value='"+item.MONTH+"' />";
						  }
					  });
				  } 
				  
				  
				  $("span#today_month").html(html_1);
				  $("tbody#employeeBirthday").html(html);
			},
			error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
         	}
		});
	}// end of function preMonth(){}---------------------------------
	
	// 전월 생일자
	function nextMonth(){
		$.ajax({
			url:"<%= ctxPath%>/calendar/nextMonthBirthIndex.bts",
			data:{"month": $('input#sysMonth').val()},
			dataType:"JSON",
			success:function(json){
				let html = "";
			    let html_1 = "";
			   		html +="<tr style='border-top:solid 1px #dee2e6;'></tr>";
				  if(json.length > 0) {
					  $.each(json, function(index, item){
						  html +="<tr id='birth_person' style='width:100%;'>";
						  html +="<td id='date' style='width:40%; text-align: center;'>"+item.BIRTHDAY+"</td>";
						  html +="<td id='name' style='width:60%; text-align: center;'>"+item.EMP_NAME+"</td>";
						  html +="</tr>";
						  
						  if(item.MONTH == item.MONTH){
							  html_1 = item.MONTH+"<input id='sysMonth' type='hidden' value='"+item.MONTH+"' />";
						  }
					  });
				  } 
				  
				  
				  $("span#today_month").html(html_1);
				  $("tbody#employeeBirthday").html(html);
			},
			error: function(request, status, error){
                alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
         	}
		});
	}// end of function preMonth(){}---------------------------------

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
						  html += "<td class='mail_subject' style='width:60%; text-align: left; padding-left: 30px;'><span onclick='goView_recMail("+item.pk_mail_num+")'style='color: black; cursor: pointer; '>"+item.subject+"</span></td>";
						  if(item.reservation_date != null) {
						  	html += "<td class='mail' style='width:20%; text-align: center;'>"+item.reservation_date+"</td>";	
						  }
						  else {
							  	html += "<td class='mail' style='width:20%; text-align: center;'>"+item.reg_date+"</td>";							  
						  }
						  html += "</tr>";
					});

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
	  
  // 로그인한 사용자의 메일 상세내용 보여주기		
  function goView_recMail(pk_mail_num) {
				  	
	  location.href="<%= ctxPath%>/mail/mailReceiveDetail.bts?pk_mail_num="+pk_mail_num;
	}// end of function goView(seq){}----------------------------------------------
	
	///////////////// 정환모 메인화면 작업 함수 시작 /////////////////////////
	
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
  				  "fk_emp_no":"${sessionScope.loginuser.pk_emp_no}"},  
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
  				  "fk_emp_no":"${sessionScope.loginuser.pk_emp_no}"},  
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
    
     
	///////////////// 정환모 메인화면 작업 함수 끝 /////////////////////////
	
</script>



<div class="container_fluid">
		<c:set var="emp" value="${requestScope.empList.get(0)}" />
	    <div class="row">
        <!-- 왼쪽 섹션 시작 -->
        <div class="col-sm-2 gadget_design_wrap" id="section_left">
        	<!-- 사원정보 시작 -->
	        <div id="empInfo">
	        	<div class="profile">
	        		<span class="photo">
	        			<span class="photo">
	        				<c:if test="${sessionScope.loginuser.img_name ne null}">
	        					<img src="<%= ctxPath%>/resources/files/${sessionScope.loginuser.img_name}" title="" />
	        				</c:if>
	        				<c:if test="${sessionScope.loginuser.img_name eq null}">
	        					<img src="<%= ctxPath%>/resources/images/mu.png" />
	        				</c:if>
	        			</span>
	        		</span>
	        		<span class="info">
	        			<span class="name" title="">${emp.emp_name}</span>
	        			<c:if test="${sessionScope.loginuser.pk_emp_no != 80000001 }">
	        			<span class="position">${emp.ko_rankname}</span>
	        			<br>
	        			<span class="part">${emp.ko_depname}</span>
	        			</c:if>
	        		</span>
	        	</div>
	        
		        <ul class="type_simple_list today_list">
		        	<li class="summary-approval2">
		        		<a href="">
		        			<span class="type">
		        				<span class="ic_dashboard2 ic_type_approval2" title="approval2"></span>
		        			</span>
		        			<span class="text">전자결재 수신 문서</span>
		        			<span class="badge">0</span>
		        		</a>
		        	</li>
		        	<li class="summary-approval">
	 		        	<a href="javascript:location.href='<%= request.getContextPath()%>/att/waitingSign.bts'">
		        			<span class="type">
		        				<span class="ic_dashboard2 ic_type_approval" title="approval"></span>
		        			</span>
		        			<span class="text">공가 결재대기문서</span>
		        			<span class="badge" id="vacCount"></span>
		        		</a>
		        	</li>
		        	<li class="summary-calendar">
	     		        <a href="javascript:location.href='<%= ctxPath%>/calendar/calenderMain.bts'">
		        			<span class="type">
		        				<span class="ic_dashboard2 ic_type_calendar" title="calendar"></span>
		        			</span>
		        			<span class="text">오늘의 일정</span>
		        			<span class="badge" id="scheCount"></span>
		        		</a>
		        	</li>
		        	<li class="summary-community">
		        		<a href="javascript:location.href='<%= request.getContextPath()%>/board/my.bts'">
		        			<span class="type">
		        				<span class="ic_dashboard2 ic_type_community" title="community"></span>
		        			</span>
		        			<span class="text">작성한 글</span>
		        			<span class="badge" id="mybd_cnt"></span>
		        		</a>
		        	</li>
		        	<li class="summary-asset">
		        		<a href="<%= ctxPath%>/reservation/reservationMain.bts">
		        			<span class="type">
		        				<span class="ic_dashboard2 ic_type_asset" title="asset"></span>
		        			</span>
		        			<span class="text">내 예약/대여 현황</span>
		        			<span class="badge" id="rserCount"></span>
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
							<a href="<%= ctxPath%>/mail/mailReceiveList.bts" data-bypass="true" data-popup="width=1024,height=790,scrollbars=yes,resizable=yes" id="btn_a">
								<span class="type">
									<i class="far fa-envelope fa-2x" id="idx-icon"></i>
								</span>
								<span class="txt">메일함</span>
							</a>
						</li>
						<li class="even btn_list_li" style="border-top-right-radius: 5px;">
							<a href="<%= ctxPath%>/addBook/addBook_telAdd.bts" id="btn_a">
								<span class="type">
									<i class="far fa-address-book fa-2x" id="idx-icon"></i>
								</span>
								<span class="txt">연락처 추가</span>
							</a>
						</li>
						<li class="odd btn_list_li" style="border-bottom-left-radius: 5px;">
							<a href="<%= ctxPath%>/calendar/calenderMain.bts" id="btn_a">
								<span class="type">
									<i class="far fa-calendar-check fa-2x" id="idx-icon"></i>
								</span>
								<span class="txt">일정등록</span>
							</a>
						</li>
						<li class="even btn_list_li" style="border-bottom-right-radius: 5px;">
							<a href="<%= ctxPath%>/board/main.bts" data-bypass="true" id="btn_a">
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
	        			<span id="today_month" style="font-size:20px; font-weight:bold;"></span>
        				<div id="birth_prevenext">
        					<a onclick="preMonth()"><i class="fas fa-angle-left"></i></a>&nbsp;&nbsp;
        					<a onclick="nextMonth()"><i class="fas fa-angle-right"></i></a>
        				</div>
        			</div>
        		</div>
	        	
	        	<br>
	        	<br>
	        	<br>
	        	<div id="birthList">
		        	<table id="todayBirthday">
		        	<tbody id="employeeBirthday" style="text-align: center;">
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
						<!-- a 태그의 href는 아래의 tab-content 영역의 id를 설정하고 data-toggle 속성을 tab으로 설정한다. -->
						<li class="active"><a href="#all" data-toggle="tab">전체게시판</a></li>
						<li><span>|</span></li>
						<li class="active"><a href="#notice" data-toggle="tab">공지게시판</a></li>
						<li><span>|</span></li>
						<li><a href="#board" data-toggle="tab">자유게시판</a></li>
						<li><span>|</span></li>
						<li><a href="#archive" data-toggle="tab">자료실</a></li>
					</ul>
                </div>
                <!-- Card Body -->
                <div class="card-body">
                
	                <!-- Tab이 선택되면 내용이 보여지는 영역이다. -->
					<!-- 태그는 div이고 class는 tab-content로 설정한다. -->
					<div class="tab-content">
						<!-- 각 탭이 선택되면 보여지는 내용이다. 태그는 div이고 클래스는 tab-pane이다. -->
						<!-- active 클래스는 현재 선택되어 있는 탭 영역이다. -->
						<!-- id는 고유한 이름으로 설정하고 tab의 href와 연결되어야 한다. -->
						<div class="tab-pane in active" id="all">
							<div class="board-area">
	                    	<table class="table" id="tbl_notice">
									<thead class="thead-light th_all" id="all_head">
									    <tr style="text-align: center;">
									      <th colspan='2' style="width:60%; text-align: center;">제목</th>
									      <th style="width:20%; text-align: center;">작성자</th>
									      <th style="width:20%; text-align: center;">작성일자</th>
									    </tr>
									  </thead>
					
									<tbody id="allDisplay"></tbody>
									
							</table>	
	                    	</div>
						</div>
						<!-- fade 클래스는 선택적인 사항으로 트랜지션(transition)효과가 있다.
						<!-- in 클래스는 fade 클래스를 선언하여 트랜지션효과를 사용할 때 in은 active와 선택되어 있는 탭 영역의 설정이다. -->
						<div class="tab-pane" id="notice">
							<div class="board-area">
	                    	<table class="table" id="tbl_notice">
									<thead class="thead-light th_all" id="all_head">
									    <tr style="text-align: center;">
									      <th colspan='2' style="width:60%; text-align: center;">제목</th>
									      <th style="width:20%; text-align: center;">작성자</th>
									      <th style="width:20%; text-align: center;">작성일자</th>
									    </tr>
									  </thead>
					
									<tbody id="noticeDisplay"></tbody>
									
							</table>	
	                    	</div>
						</div>
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
					
									<tbody id="boardDisplay"></tbody>
							</table>
	                    	</div>
						</div>
						<div class="tab-pane" id="archive">
							<div class="board-area">
	                    	<table class="table" id="tbl_notice">
							  <thead class="thead-light th_all" id="all_head">
									    <tr style="text-align: center;">
									      <th colspan='2' style="width:60%; text-align: center;">제목</th>
									      <th style="width:20%; text-align: center;">작성자</th>
									      <th style="width:20%; text-align: center;">작성일자</th>
									    </tr>
									  </thead>
					
									<tbody id="fileboardDisplay"></tbody>
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
			
		</div>
        </div>
        <!-- 중간 섹션 끝 -->
        
        <!-- 오른쪽 섹션 시작 -->
        <div class="col-sm-3" id="section_right">
        	<!-- 출퇴근 시작 -->
        	<div id="webChatting">
        		<form name = "commutFrm">
					 <div style="text-align: left; padding-left:20px; font-size: 16px;">
					      <span id="yymmdd" style="color:black;"></span>
					 </div>
					 <div style="text-align: center; font-size: 36px;">
					      <span id="clock" style="color:black; font-weight:bold;"></span>
					 </div>
					 <div style="display:block; margin-top:8px;">
					 	<span style="float:left; padding-left: 30px;">출근시간</span>
					 	<span id="workin" style="float:right; padding-right: 40px;">미등록</span><br>
					 </div>
					 <div style="display:block; margin-top:8px;">	
					 	<span style="float:left; padding-left: 30px;">퇴근시간</span>
					 	<span id="workout" style="float:right; padding-right: 40px;">미등록</span>
					 </div>
					 <hr style="margin-top: 40px;">
					<input type="hidden" value="${sessionScope.loginuser.pk_emp_no}" id="fk_emp_no">
				  	<button type="button" class="btn btn-outline-primary btn-lg " id="in_time" style="margin: 15px 0 15px 15px; width:110px; display:inline-block;" >출근</button>
					<button type="button" class="btn btn-outline-primary btn-lg " id="out_time" style="margin: 15px 0 15px 10px; width:110px; display:inline-block;" >퇴근</button>
					<button type="button" class="btn btn-outline-danger btn-lg " id="reportVacation" style="margin: 15px 0 15px 10px; width:110px; display:inline-block;" onclick="location.href='<%= ctxPath %>/att/reportVacation.bts'" >휴가신청</button>
				</form>
		    </div>
        	<!-- 출퇴근 시작 -->
        	
        	<!-- 웹채팅 시작 -->
        	<%-- <div id="webChatting">
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
		    </div> --%>
		    <!-- 웹채팅 끝 -->
		    
		    <div id="displayWeather" style="min-width: 90%; max-height: 500px; overflow-y: scroll; margin-top: 40px; margin-bottom: 70px; padding-left: 10px; padding-right: 10px;"></div> 
		   
		    
        </div>
        <!-- 오른쪽 섹션 끝 -->
	        
    </div>
</div>