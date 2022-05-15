<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
    
<%
    String ctxPath = request.getContextPath();
    //    /bts
%>

<style type="text/css">

/* 테이블 */
  table, th, td, input, textarea {border: solid #a0a0a0 0px;}
  
  #table {border-collapse: collapse;
          width: 1175px;
          }
         
  #table th, #table td{padding: 5px;}
  #table th{ 
  		background-color: #6F808A; 
  		color: white;
  }

/*버튼 */   
  .buttonList {
  		display: inline-block;
  		list-style-type: none; 	
  		size: 10px;	
  }
 
  #buttonGroup {
  		padding: 0px;
  		margin-top: 5px;
  }
  
    button {
  		border-radius: 3px !important;
  } 
  
  /* 파일첨부 */
  /*input="file" 태그 원래 형태 지우기*/

   
</style>


<script src="<%= request.getContextPath()%>/resources/ckeditor/ckeditor.js"></script> 
<script src="<%= request.getContextPath()%>/resources/plugins/bower_components/jquery/dist/jquery.min.js"></script>

<script type="text/javascript">

	$(document).ready(function(){
		// 문서가 준비되면 매개변수로 넣은 콜백함수 실행하기
				
			// 새로고침 버튼 이벤트 (새로고침 버튼 클릭 시 reset)
			$("#reset").click(function() {
				
				 location.reload();
				
			})// end of $("#reset").click(function(){})----------------------
				
			
		 // 메일 쓰기	
		  <%-- === 스마트 에디터 구현 시작 === --%>
	       //전역변수
	       var obj = [];
	       
	       //스마트에디터 프레임생성
	       nhn.husky.EZCreator.createInIFrame({
	           oAppRef: obj,
	           elPlaceHolder: "content",
	           sSkinURI: "<%= ctxPath%>/resources/smarteditor/SmartEditor2Skin.html",
	           htParams : {
	               // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	               bUseToolbar : true,            
	               // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
	               bUseVerticalResizer : true,    
	               // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
	               bUseModeChanger : true,
	           }
	       });
	      <%-- === 스마트 에디터 구현 끝 === --%>
		
	       // 보내기 버튼 클릭 시 event 발생
	       $("button#btnMailSend").click(function() {
		  		 <%-- === 스마트 에디터 구현 시작 === --%>
		       	//id가 content인 textarea에 에디터에서 대입
		        	obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
		      	 <%-- === 스마트 에디터 구현 끝 === --%>		      	 
		      	
		    // 	  alert("클릭 확인");
		      	 
		      	 // 받는사람 유효성 검사
		      	 var recemail = $("input#recemail").val().trim();
		      	 if(recemail == "") {
		      		 alert("받는 사람을 입력해주세요.");
		      		 return false;
		      	 }
		      	 
		      	 // 메일제목 유효성 검사
		      	 var subject = $("input#subject").val().trim();
		      	 if(subject == "") {
		      		 alert("제목을 입력해주세요.");
		      		 return false;
		      	 }

		      	 // 메일제목 글자수 검사
		      	 var subject_length = $("input#subject").val().length;
		      	 if(subject_length > 150) {
		      		 alert("제목은 150자 이상 입력이 불가합니다.");
		      		 return false;
		      	 }
		      	 
		      	 // 메일내용 유효성 검사 (스마트 에디터)
		 		<%-- === 스마트에디터 구현 시작 === --%>
		        //스마트에디터 사용시 무의미하게 생기는 p태그 제거
		         var contentval = $("textarea#content").val();
		             
		          // === 확인용 ===
		          // alert(contentval); // content에 내용을 아무것도 입력치 않고 쓰기할 경우 알아보는것.
		          // "<p>&nbsp;</p>" 이라고 나온다.
		          
		          // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기전에 먼저 유효성 검사를 하도록 한다.
		          // 글내용 유효성 검사 
		          if(contentval == "" || contentval == "<p>&nbsp;</p>") {
		             alert("글내용을 입력하세요!!");
		             return;
		          }
		          
		          // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기
		          contentval = $("textarea#content").val().replace(/<p><br><\/p>/gi, "<br>"); //<p><br></p> -> <br>로 변환
		      	/*    
		                  대상문자열.replace(/찾을 문자열/gi, "변경할 문자열");
		          ==> 여기서 꼭 알아야 될 점은 나누기(/)표시안에 넣는 찾을 문자열의 따옴표는 없어야 한다는 점입니다. 
		                            그리고 뒤의 gi는 다음을 의미합니다.
	
		             g : 전체 모든 문자열을 변경 global
		             i : 영문 대소문자를 무시, 모두 일치하는 패턴 검색 ignore
		      	*/    
		          contentval = contentval.replace(/<\/p><p>/gi, "<br>"); //</p><p> -> <br>로 변환  
		          contentval = contentval.replace(/(<\/p><br>|<p><br>)/gi, "<br><br>"); //</p><br>, <p><br> -> <br><br>로 변환
		          contentval = contentval.replace(/(<p>|<\/p>)/gi, ""); //<p> 또는 </p> 모두 제거시
		      
		          $("textarea#content").val(contentval);
		       
		          // alert(contentval);
		      	<%-- === 스마트에디터 구현 끝 === --%>	      	 
		      	 
		      	// 중요 체크박스에 체크되어있는지 확인
		      	var importanceVal = 0;
		      	if($("input[name=importance]").prop("checked")) {
		      		// 중요 체크박스에 체크되어 있을 때 중요메일함에 들어가도록 하기
		      		importanceVal = 1;
		      	}
		 
		      	var frm = document.mailWriteFrm;
		      	frm.importanceVal.value = importanceVal;
		      	frm.method = "POST";
		      	frm.action = "<%= ctxPath%>/mail/mailWriteEnd.bts";
		        frm.submit();
		      	
		   	//	console.log(frm);		// form 태그 전체
		   	//	console.log(frm.importanceVal.value);	// 체크 안했을 때 0
		   	//	console.log(frm.method); 	// post

				// === 발송 예약 시 사용자가 입력한 날짜 값이 존재한다면 메일 테이블에서 RESERVATION_STATUS 를 0에서 1로 바꿔주도록 한다.
				if($("span#reservationTime").text() != "") {
				
					var sendResSetTime = $("span#reservationTime").text();
					var frm = document.mailWriteFrm;
					frm.importanceVal.value = importanceVal;
					frm.reservation_date.value = sendResSetTime;
					frm.method = "POST";
					frm.action = "<%= ctxPath%>/mail/mailWriteReservationEnd.bts";
					frm.submit();
					
				//	console.log(frm);	// 전체 mailWriteFrm form 태그
				//	console.log(frm.importanceVal.value);			// 0
				//	console.log(frm.reservation_date.value);	// 2022-06-03:18:15
				//	console.log(frm.method);	// post
				//	console.log(frm.action);	// http://localhost:9090/bts/mail/mailWriteReservationEnd.bts
					
				}
				else {
					return false;
				}
		   	
			});// end of $("button#btnMailSend").click(function() {})-------------------------

		
			// ==== 메일쓰기가 아닌 ***임시저장*** 버튼 클릭 시 메일 테이블에서 TEMP_STATUS 을 0에서 1로 update 하기
			$("button#tempSave").click(function() {

	  		 <%-- === 스마트 에디터 구현 시작 === --%>
		       	//id가 content인 textarea에 에디터에서 대입
		        	obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
		      	 <%-- === 스마트 에디터 구현 끝 === --%>		      	 
		      	
		    // 	  alert("클릭 확인");
		      	 
		      	 // 받는사람 유효성 검사
		      	 var recemail = $("input#recemail").val().trim();
		      	 if(recemail == "") {
		      		 alert("받는 사람을 입력해주세요.");
		      		 return false;
		      	 }
		      	 
		      	 // 메일제목 유효성 검사
		      	 var subject = $("input#subject").val().trim();
		      	 if(subject == "") {
		      		 alert("제목을 입력해주세요.");
		      		 return false;
		      	 }
		      	 
		      	 // 메일내용 유효성 검사 (스마트 에디터)
		 		<%-- === 스마트에디터 구현 시작 === --%>
		        //스마트에디터 사용시 무의미하게 생기는 p태그 제거
		         var contentval = $("textarea#content").val();
		             
		          // === 확인용 ===
		          // alert(contentval); // content에 내용을 아무것도 입력치 않고 쓰기할 경우 알아보는것.
		          // "<p>&nbsp;</p>" 이라고 나온다.
		          
		          // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기전에 먼저 유효성 검사를 하도록 한다.
		          // 글내용 유효성 검사 
		          if(contentval == "" || contentval == "<p>&nbsp;</p>") {
		             alert("글내용을 입력하세요!!");
		             return;
		          }
		          
		          // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기
		          contentval = $("textarea#content").val().replace(/<p><br><\/p>/gi, "<br>"); //<p><br></p> -> <br>로 변환
		      	/*    
		                  대상문자열.replace(/찾을 문자열/gi, "변경할 문자열");
		          ==> 여기서 꼭 알아야 될 점은 나누기(/)표시안에 넣는 찾을 문자열의 따옴표는 없어야 한다는 점입니다. 
		                            그리고 뒤의 gi는 다음을 의미합니다.
	
		             g : 전체 모든 문자열을 변경 global
		             i : 영문 대소문자를 무시, 모두 일치하는 패턴 검색 ignore
		      	*/    
		          contentval = contentval.replace(/<\/p><p>/gi, "<br>"); //</p><p> -> <br>로 변환  
		          contentval = contentval.replace(/(<\/p><br>|<p><br>)/gi, "<br><br>"); //</p><br>, <p><br> -> <br><br>로 변환
		          contentval = contentval.replace(/(<p>|<\/p>)/gi, ""); //<p> 또는 </p> 모두 제거시
		      
		          $("textarea#content").val(contentval);
		       
		          // alert(contentval);
		      	<%-- === 스마트에디터 구현 끝 === --%>	      	 
		      	 
		      	// 중요 체크박스에 체크되어있는지 확인
		      	var importanceVal = 0;
		      	if($("input[name=importance]").prop("checked")) {
		      		// 중요 체크박스에 체크되어 있을 때 중요메일함에 들어가도록 하기 (importance = 1)
		      		importanceVal = 1;			// 1
		      	//	console.log(importanceVal);
		      	}

				const frm = document.mailWriteFrm;
				frm.importanceVal.value = importanceVal;
				frm.method = "POST";
				frm.action = "<%= ctxPath%>/mail/mailTemporaryEnd.bts"
				frm.submit();
			//	console.log("확인용 frm : " + frm);
			//	console.log("확인용 method : " + frm.method);
			//	console.log("확인용 action : " + frm.action);

			
			});// end of $("button#tempSave").click(function(){})---------------

	   
	 <%--    
		// 직원 주소록 자동 검색 (aJax)
			// 받는 사람 이메일 입력 시 포함된 키워드를 통해 재직중인 사원 목록 검색, 결과 없으면 유효한 이메일의 형식만 들어오도록 한다.
			$("receiverInput").autocomplete({
				source : function(request, response) {
					$.ajax({
							type:"get",
							url : "empList.bts",
							dataType : "json",
							data : {
								searchValue:request.term	// input 에 입력되는 value 값
							},
							success : function(data) {							
								response(
									$.map(data, function(item) {
										
									<%--	return {
											label:item.DEPS_depName + " / " + 
										} 
										
									})	
								);
							}
					})
				}
			});
	   --%>
	
	});// end of $(document).ready(function (){})--------------------

	// function declaration
	<%-- 발송예약 모달에서 시간 선택 후 '확인'버튼( onClick() ) 클릭 시 실행하는 함수 --%>
	function sendReservationOk() {
	
	/*	
		// 사용자가 선택한 날짜값이 오늘 이전의 날짜에 선택되게 해서는 안됨. (유효성검사)
		var SelectResDate = $("input#resSendDate").val();	// 사용자가 선택하는 날짜
		var today = new Date();
		
		if(SelectResDate < today) {	
			alert("예약시간은 현재시간보다 늦은 시간이어야 합니다.");	
			return false;
		}
	*/
	
		// === 메일쓰기 모달 JS 시작 === //

		var SelectResDate = $("input#resSendDate").val();	// 사용자가 선택하는 날짜
		var today = new Date();				
		var year = today.getFullYear();		// 년
		var month = (today.getMonth() + 1);	// 월
		var date = today.getDate();	// 일
		
		if(month < 10)
			month = "0" + month;
		
		if(date < 10)
			date = "0" + date;
		
		var dateToday = year + '-' + month + '-' + date;
		// 2022-05-12
	//	resSendDate = $('#resSendDate').val();
		SelectResDate = $("input#resSendDate").val();
		
		// 사용자가 선택한 날짜값이 오늘 이전의 날짜에 선택되게 해서는 안됨.
		if(SelectResDate < dateToday) {
			alert("예약시간은 현재시간보다 늦은 시간이어야 합니다.")
			return false;
		}
		
		// 현재 hour 구하기
		var date = new Date();
		var hour = date.getHours();			// 현재날짜에서 hour 갖고옴
				
		$("#resSendTimeHour").val();
		
		// 현재 minute 구하기
		var minute = date.getMinutes();		// 현재날짜에서 minute 갖고옴
		$("#resSendTimeMinute").val();
/*		
		$("#resSendTimeHour option").filter(function () {	// option 에서 text가 minute과 있으면 select
			return $(this).text() == hour;
		}).attr('selected', true);
*/
//		$("#resSendTimeMinute option").eq(0).prop('selected', true);		

		// === 메일쓰기 모달 JS 끝 === //
	
	
		// 메일 쓰기 창에서 사용자가 선택한 날짜값 받아오기
		var SendDateVal = $("input#resSendDate").val();
		
		// 메일 쓰기 창에서 사용자가 선택한 시 값 받아오기
		var SendTimeHourVal = $("#resSendTimeHour option:selected").val();
		
		// 메일 쓰기 창에서 사용자가 선택한 분 값 받아오기
		var SendTimeMinuteVal = $("#resSendTimeMinute option:selected").val();
		
		var sendReservationDate = SendDateVal+ " " + SendTimeHourVal + ":" + SendTimeMinuteVal;
	//	console.log(sendReservationDate);
		
		$("span#reservationTime").text(sendReservationDate);
		
		$('.modal').modal('hide');	// 확인버튼 클릭 후 모달창 숨기기
	}
	
</script>

<div class="container" style="width: 100%; margin: 50px;">
	<div class="row bg-title" style="border-bottom: solid 1.5px #e6e6e6;">	
		<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
			<h4 class="page-title" style="color: black;">메일 쓰기</h4>
		</div>
	</div>
	
	<ul id="buttonGroup">
		<li class="buttonList">
			<button type="button" id="btnMailSend" class="btn btn-secondary btn-sm">
			<i class="fa fa-send-o fa-fw" aria-hidden="true"></i>
			보내기
			</button>
		</li>	
		<li class="buttonList">
			<button type="button" id="tempSave" class="btn btn-secondary btn-sm">
			<i class="fa fa-pencil-square-o fa-fw" aria-hidden="true"></i>
			임시저장
			</button>
		</li>	
		<li class="buttonList">
			<button type="button" id="reset" class="btn btn-secondary btn-sm">
			<i class="fa fa-refresh fa-fw" aria-hidden="true"></i>
			새로고침
			</button>
		</li>			
	</ul>

	<%-- 메일쓰기 부분 --%>	
	<form name="mailWriteFrm" enctype="multipart/form-data" class="form-horizontal" style="margin-top: 20px;">
		<table id="mailWriteTable">
			<tr>
				<th width="14%">받는 사람</th>
				<td width="86%" data-toggle="tooltip" data-placement="top" title="">
					<input type="text" id="recemail" name="recemail" style="width: 90%; margin-left:10px; margin-right: 1%; border-radius: 3px; border: 1px solid gray; " />
					
					<%-- hidden 타입으로 데이터값 보내기 --%>
			     	<input type="hidden" id="sendemail" name="sendemail" value="${sessionScope.loginuser.uq_email}" style="width: 90%; margin-left:10px; margin-right: 1%; border-radius: 3px; border: 1px solid gray; " /> 
					<input type="hidden" id="fk_senduser_num" name="fk_senduser_num" value="${sessionScope.loginuser.pk_emp_no}"  style="width: 90%; margin-left:10px; margin-right: 1%; border-radius: 3px; border: 1px solid gray; " />
					<input type="hidden" id="sendempname" name="sendempname" value="${sessionScope.loginuser.emp_name}" />
               		<%-- 임시저장의 경우 --%>
               		<input type="hidden" name="temp_status" id="temp_status" value="${temp_status}"/> 
               		<input type="hidden" name="pk_mail_num" id="pk_mail_num" value="${requestScope.mailvo.pk_mail_num}"/> 
					<button type="button" class="btn btn-secondary btn-sm">주소록</button>
				</td>
			</tr>
			<tr>
				<th width="14%">
					<span style="margin-right: 40px;">제목</span>
						<input type="checkbox" id="importance" name="importance" />&nbsp;중요&nbsp;<span class="fa fa-exclamation" style="color: red;" class="text-center"></span>
						<input type="hidden" id="importanceVal" name="importanceVal" />
				</th>
				<td width="110%" >
					<input type="text" id="subject" name="subject" style="width: 90%; margin-left:10px; margin-right: 1%; border-radius: 3px; border: 1px solid gray; display: inline-block;" />
				</td>
			</tr>		
			<tr>
				<th width="14%">파일첨부</th>
				<td width="86%" style="padding-top: 9px">
					<input type="file" name="attach" id="attach" style="width: 30%; margin-left:10px; margin-right: 1%; border-radius: 3px; border: 0px solid gray;" />
				</td>
			</tr>			
		</table>	
		
		<br>
		
		<%-- 메일 내용 시작 (스마트 에디터 사용) --%>
		<table style="border: 0px; width: 1110px;">
			<tr style="border: 0px;">
				<td width="1200px;" style="border: 0px">
					<textarea rows="20" cols="100" style="width: 1090px; border: solid 1px gray; height: 400px;" name="content" id="content" >					
					</textarea>						
				</td>
			</tr>
		</table>
		
		<%-- 예약시간 설정하기 --%>
		<input type="hidden" name="reservation_date" id="reservation_date" />
				
		<%-- 메일 내용 끝 --%>
	</form>
	
	<ul id="buttonGroup" style="margin-top: 10px;">
		<li class="buttonList">
			<button type="button" id="Reservation" name="Reservation" class="btn btn-secondary btn-sm"
					data-toggle="modal" data-target="#sendReservation_Modal">
			<i class="fa fa-clock-o fa-fw" aria-hidden="true"></i>
			발송예약
			</button>
			<span id="reservationTime" style="margin-left: 20px;"></span>
		</li>	
	</ul>	
</div>

<%-- 발송예약 모달 --%>
<div id="sendReservation_Modal" class="modal fade" role="dialog" data-keyword="false" data-backdrop="static">
  <div class="modal-dialog" style="width: 400px;">
  
    <div class="modal-content">   
      <div class="modal-header" style="height: 60px;">
        <h5 class="modal-title" id="staticBackdropLabel">발송예약</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      
      <div class="modal-body">
      	<div id="sendReservation">
      		<%-- 발송예약 모달 내용 시작 --%>
	      		
	      		<div id="sendReservation_content">
		      		<%-- 모달 form 태그 시작 --%>
					<form>
						<div class="form-group form-wrap form-sendDate">
							<label for="resSendDate" class="sendLabel">발송날짜 :</label>
							<input type="date" id="resSendDate" />
						</div>
						
						<div class="form-group form-wrap">
							<label for="selectSendTime" class="sendLabel">발송시간 : </label>
							<select class="form-control" id="resSendTimeHour" style="display:inline-block; height: 35px; width: 70px;">
							  	<c:forEach begin="0" end="9" varStatus="loop">
							  		 <option>0${loop.index}</option>
							  	</c:forEach>
							  	<c:forEach begin="0" end="9" varStatus="loop">
							  		 <option>1${loop.index}</option>
							  	</c:forEach>	
							  	<c:forEach begin="0" end="3" varStatus="loop">
							  		 <option>2${loop.index}</option>
							  	</c:forEach>
							</select>
						  	<span>시</span>		
							<select class="form-control" id="resSendTimeMinute" style="display:inline-block; height: 35px; width: 70px;">
							  	<option>00</option>
							  	<option>05</option>
						  		<option>10</option>
						  		<option>15</option>
						  		<option>20</option>
						  		<option>25</option>
						  		<option>30</option>
						  		<option>35</option>
						  		<option>40</option>
						  		<option>45</option>
						  		<option>50</option>
						  		<option>55</option>
							</select>	
							<span>분</span>					  								
						</div>
					</form> 	
		      		<%-- 모달 form 태그 끝 --%>
	      		</div>	      		
      		<%-- 발송예약 모달 내용 끝 --%>
      	</div>
      </div>
      
      <div class="modal-footer">
        <button type="button" class="btn" style="border: solid 1px gray; background-color: #e6e6e6;" onclick="sendReservationOk()">확인</button>
        <button type="button" class="btn btn-light" data-dismiss="modal" style="border: solid 1px gray">취소</button>
      </div>
    </div>    
  </div>
</div>