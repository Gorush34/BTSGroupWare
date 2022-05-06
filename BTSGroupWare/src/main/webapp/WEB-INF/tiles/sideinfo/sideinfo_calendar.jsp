<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    
<% String ctxPath = request.getContextPath(); %>

<%-- 캘린더(일정) 사이드 tiles 만들기 --%>

<style type="text/css">


</style>


<script type="text/javascript">

	$(document).ready(function(){
		
		// 캘린더 클릭시 일정 체크 박스 보이기, 숨기기
	//	$("div.slideTogglebox").hide();
		
		$("div#calenderbtn1").click(function(){
			$("div#slideTogglebox1").slideToggle();
		})
		
		$("div#calenderbtn2").click(function(){
			$("div#slideTogglebox2").slideToggle();
		})
		
		// 일정 체크 박스 추가
		
	
		
		
		
	});// end of $(document).ready(function(){}-------------------

			
	//Function Declaration
	
	
	
	// === 사내 캘린더 소분류 추가를 위해 +아이콘 클릭시 ===
	function addComCalendar(){
		$('#addComCalModal').modal('show'); // 모달창 보여주기	
	}// end of function addComCalendar(){}--------------------
		
		
	// === 사내 캘린더 추가 모달창에서 추가 버튼 클릭시 ===
	function goAddComCal(){
		
		if($("input.addCom_calname").val().trim() == ""){
	 		  alert("추가할 사내캘린더 소분류명을 입력하세요!!");
	 		  return;
	 	}
		
	 	else {
	 		 $.ajax({
	 			 url: "<%= ctxPath%>/schedule/addComCalendar.bts",
	 			 type: "post",
	 			 data: {"addCom_calname": $("input.addCom_calname").val(), 
	 				    "fk_emp_no": "${sessionScope.loginuser.pk_emp_no}"},
	 			 dataType: "json",
	 			 success:function(json){
	 				 if(json.n != 1){
	  					alert("이미 존재하는 '사내캘린더 소분류명' 입니다.");
	  					return;
	  				 }
	 				 else if(json.n == 1){
	 					 $('#addComCalModal').modal('hide'); // 모달창 감추기				
	 					 alert("사내 캘린더에 "+$("input.addCom_calname").val()+" 소분류명이 추가되었습니다.");
	 					 
	 					 $("input.addCom_calname").val("");
	 					 showCompanyCal();  // 사내 캘린더 소분류 보여주기
	 				 }
	 			 },
	 			 error: function(request, status, error){
	  	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	    	     }	 
	 		 });
	 	  }
		
	}// end of function goAddComCal(){}------------------------------------

	// === 내 캘린더에서 내캘린더 소분류 보여주기  === //
	function showCompanyCal(){
		$.ajax({
			url:"<%= ctxPath%>/calendar/showshowCompanyCalendar.bts",
			type:"get",
			dataType:"json",
			success:function(json){
				var html = "";
				
				if(json.length>0){
					
				}
			},error: function(request, status, error){
  	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
   	     	}	
		});
	}
	
	
</script>

	<div>
	   <div id="sidebar" style="font-size: 11pt;">
		 <h4>캘린더</h4>
		 
			<input type="hidden" value="${sessionScope.loginuser.pk_emp_no}" id="fk_emp_no"/>
		
		<button type="button" class="btn btn-outline-primary btn-lg " style="margin: 15px auto; width:200px; display:block;" onclick="javascript:location.href='<%= ctxPath%>/calendar/scheduleRegister.bts'">일정등록</button>
			<ul style="list-style-type: none; padding: 10px;">
				<li style="margin-bottom: 15px;">
					<div id="calenderbtn1" class="calenderbtn">사내 캘린더</div>
						<div id="slideTogglebox1"  class="slideTogglebox">
							<%-- 사내 캘린더를 보여주는 곳 --%>
							<div id="companyCal" style="margin-left: 50px; margin-bottom: 10px;"></div>			
						</div>
						<%-- 사내 캘린더 추가를 할 수 있는 직원은 직위코드가 3 이면서 부서코드가 4 에 근무하는 사원이 로그인 한 경우에만 가능하도록 조건을 걸어둔다.  	
	     				<c:if test="${sessionScope.loginuser.fk_pcode =='3' && sessionScope.loginuser.fk_dcode == '4' }"> --%>
	     				<c:if test="${sessionScope.loginuser.gradelevel =='1'}"> 
						<span id="addmyschedule" onclick="addComCalendar()">&nbsp;&nbsp;+ 사내 캘린더 추가</span>
						</c:if> 
						<%-- </c:if>	--%>
				</li>
				<li style="margin-bottom: 15px;">
					<div id="calenderbtn2" class="calenderbtn">관심 캘린더</div>
						<div id="slideTogglebox2"  class="slideTogglebox">	
							<table style="margin: 0 20px;">
								<tbody>
									<tr id="schecheck">
										<td>			  
	    									<input type="checkbox" id="allMyCal" class="calendar_checkbox" checked/>&nbsp;&nbsp;<label for="allMyCal">내 캘린더</label>
	    									<%-- 내 캘린더를 보여주는 곳 --%>
											<div id="myCal" style="margin-left: 50px; margin-bottom: 10px;"></div>
	    								</td>
	   								</tr>	
				   				</tbody>	
			   				</table>				
						</div>
						
						<span id="addschedule" onclick="">&nbsp;&nbsp;+ 내 캘린더 추가</span>		
				</li>
			</ul>
		<input type="checkbox" id="sharedCal" class="calendar_checkbox" value="0" checked/>&nbsp;&nbsp;<label for="sharedCal">공유받은 캘린더</label> 
	</div>
		
	</div>
	
	
	<%-- 모달로 추가창 띄우기 
  <div class="modal fade" id="addMyScheModal" data-backdrop="static">
  	<div class="modal-dialog modal-dialog-centered">
  		<div class="modal-content">
		  <div class="modal-header">
	        <h5 class="modal-title">내 캘린더 추가</h5>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	      <div class="modal-body">
	      	<input type="hidden" name="fk_emp_no" id="fk_emp_no"/>
	        <input type="text" name="cal_name" id="cal_name"/>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-primary btn-sm" onclick="goAddCheckbox()">확인</button>
	        <button type="button" class="btn btn-outline-primary btn-sm" data-dismiss="modal">취소</button>
	      </div>
	    </div>
  		</div>
  	 </div>--%>
  	 
  	 <%-- 모달로 추가창 띄우기 : 
	  <div class="modal fade" id="addScheModal" data-backdrop="static">
	  	<div class="modal-dialog modal-dialog-centered">
	  		<div class="modal-content">
			  <div class="modal-header">
		        <h5 class="modal-title">관심 캘린더 추가</h5>
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		      </div>
		      <div class="modal-body">
		        <input type="text" name="searchMember" id="searchMember" autocomplete="off" placeholder="이름/아이디/부서/직책/이메일/전화"/>
		        <div >
		        </div>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-primary btn-sm" onclick="goAddCheckbox()">확인</button>
		        <button type="button" class="btn btn-outline-primary btn-sm" data-dismiss="modal">취소</button>
		      </div>
		    </div>
   		</div>
   	 </div>--%>	