<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    
<% String ctxPath = request.getContextPath(); %>

<%-- 캘린더(일정) 사이드 tiles 만들기 --%>

<style type="text/css">


</style>


<script type="text/javascript">
    
    /////////////////////////////////////
     let arr_checkbox_com_calno = [];
     let arr_checkbox_my_calno = [];
     
     let arr_checkbox_com_calno_a = []; //페이지 처음 로딩될 때 찍힌 체크박스 불러오기 (변동X) : 사내
     let arr_checkbox_my_calno_a = [];  //페이지 처음 로딩될 때 찍힌 체크박스 불러오기 (변동X) : 내
     
     let arr_checkbox_calno = [];       // 사내 캘린더와 내 캘린더 전부 포함 체크 유무
    /////////////////////////////////////

	$(document).ready(function(){
		
		// === 사내 캘린더에 사내캘린더 소분류 보여주기 ===
		showCompanyCal();

		// === 내 캘린더에 내캘린더 소분류 보여주기 ===
		showMyCal();
		
		// === 캘린더 클릭시 일정 체크 박스 보이기, 숨기기 ===
		$("div#calenderbtn1").click(function(){
			$("div#slideTogglebox1").slideToggle();
		})
		
		$("div#calenderbtn2").click(function(){
			$("div#slideTogglebox2").slideToggle();
		})
	
		
		//////////////////////////////////////////////////
		$(document).on("click","input.com_calno",function(){
			
			let str_checkbox_com_calno =  sessionStorage.getItem('arr_checkbox_com_calno');
			let str_checkbox_calno =  sessionStorage.getItem('arr_checkbox_calno');
			
			if($(this).prop("checked")) {
				
				arr_checkbox_com_calno = str_checkbox_com_calno.split(",");				
				
				let flag = false;
				for(let i=0; i<arr_checkbox_com_calno.length; i++) {
					if( arr_checkbox_com_calno[i] == $(this).val() ) {
						flag = true;
					}
				}// end of for---------------------
				
				if(flag == false) {
					arr_checkbox_com_calno.push($(this).val());
					
					let str = arr_checkbox_com_calno.join();
					if(str.substring(0,1) == ",") {
						str = str.substring(1);
					}
					
					sessionStorage.setItem('arr_checkbox_com_calno', str);
				}
				
			}
			else {
				const idx = str_checkbox_com_calno.indexOf($(this).val());
				if(idx != -1) {
					let str = str_checkbox_com_calno.substring(0,idx) + str_checkbox_com_calno.substring(idx+$(this).val().length+1);  
					if(str.substring(str.length-1) == ',') {
						str = str.substring(0, str.length-1);
					}
					sessionStorage.setItem('arr_checkbox_com_calno', str);
				}
				
			}
			// alert(arr_checkbox_com_calno.join());
			
		});
		
		
		$(document).on("click","input.my_calno",function(){
			
			let str_checkbox_my_calno =  sessionStorage.getItem('arr_checkbox_my_calno');
			
			if($(this).prop("checked")) {
				
				arr_checkbox_my_calno = str_checkbox_my_calno.split(",");
				
				let flag = false;
				for(let i=0; i<arr_checkbox_my_calno.length; i++) {
					if( arr_checkbox_my_calno[i] == $(this).val() ) {
						flag = true;
					}
				}// end of for---------------------
				
				if(flag == false) {
					arr_checkbox_my_calno.push($(this).val());
					
					let str = arr_checkbox_my_calno.join();
					if(str.substring(0,1) == ",") {
						str = str.substring(1);
					}
					
					sessionStorage.setItem('arr_checkbox_my_calno', str);
				}
				
			}
			else {
				const idx = str_checkbox_my_calno.indexOf($(this).val());
				if(idx != -1) {
					let str = str_checkbox_my_calno.substring(0,idx) + str_checkbox_my_calno.substring(idx+$(this).val().length+1);  
					if(str.substring(str.length-1) == ',') {
						str = str.substring(0, str.length-1);
					}
					sessionStorage.setItem('arr_checkbox_my_calno', str);
				}
				
			}
			// alert(arr_checkbox_com_calno.join());
			
		});
		
		
		
		$(document).on("click","input.calendar_checkbox",function(){
			
			let str_checkbox_calno =  sessionStorage.getItem('arr_checkbox_calno');
			
			if($(this).prop("checked")) {
				
				arr_checkbox_calno = str_checkbox_calno.split(",");
				
				let flag = false;
				for(let i=0; i<arr_checkbox_calno.length; i++) {
					if( arr_checkbox_calno[i] == $(this).val() ) {
						flag = true;
					}
				}// end of for---------------------
				
				if(flag == false) {
					arr_checkbox_calno.push($(this).val());
					
					let str = arr_checkbox_calno.join();
					if(str.substring(0,1) == ",") {
						str = str.substring(1);
					}
					
					sessionStorage.setItem('arr_checkbox_calno', str);
				}
				
			}
			else {
				const idx = str_checkbox_calno.indexOf($(this).val());
				if(idx != -1) {
					let str = str_checkbox_calno.substring(0,idx) + str_checkbox_calno.substring(idx+$(this).val().length+1);  
					if(str.substring(str.length-1) == ',') {
						str = str.substring(0, str.length-1);
					}
					sessionStorage.setItem('arr_checkbox_calno', str);
				}
				
			}
			// alert(arr_checkbox_com_calno.join());
			
		});
		//////////////////////////////////////////////////
		
		// 추가창에서 엔터를 친 경우
		  $("input.addCom_calname").keyup(function(event){
			 if(event.keyCode == 13){ 
				 goAddComCal();
			 }
		  });
		  $("input.addMy_calname").keyup(function(event){
			 if(event.keyCode == 13){ 
				 goAddMyCal();
			 }
		  });
		  $("input.editCom_calname").keyup(function(event){
			 if(event.keyCode == 13){ 
				 goEditComCal();
			 }
		  });
		  $("input.editMy_calname").keyup(function(event){
			 if(event.keyCode == 13){ 
				 goEditMyCal();
			 }
		  });
		
	});// end of $(document).ready(function(){}-------------------

			
	//Function Declaration
	
	
	<%-- 사내 캘린더 관련 --%>
	
	// === 사내 캘린더 추가 클릭시 ===
	function addComCalendar(){
		$('#addComCalModal').modal('show'); // 모달창 보여주기	
	}// end of function addComCalendar(){}--------------------
		
		
	// === 사내 캘린더 추가 모달창에서 추가 버튼 클릭시 ===
	function goAddComCal(){
		
		if($("input.addCom_calname").val().trim() == ""){
	 		  alert("추가할 사내캘린더 소분류명을 입력하세요!!");
	 		  return;
	 	}
		if($("input.addCom_calname").val().length > 50){
			  alert("50자 이내로 입력하세요!!");
	 		  return;
		}
		
	 	else {
	 		 $.ajax({
	 			 url: "<%= ctxPath%>/calendar/addComCalendar.bts",
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

	// === 사내 캘린더에서 사내캘린더 소분류 보여주기  === //
	function showCompanyCal(){
		$.ajax({
			url:"<%= ctxPath%>/calendar/showCompanyCalendar.bts",
			type:"get",
			dataType:"json",
			success:function(json){
				
				var html = "";
				
				if(json.length > 0){
					
					html += "<table style='margin: 0 20px;'>";
					html += "<tbody>";
					$.each(json, function(index, item){
					//	console.log("캘린더 소분류 번호 : " + $("input:checkbox[name=my_calno]:checked").length);
						html += "<tr id='schecheck'>";
						html += "<td style='width:110%;'><input type='checkbox' name='com_calno' class='calendar_checkbox com_calno' value='"+item.pk_calno+"' id='com_calno_"+index+"' checked />&nbsp;&nbsp;<label for='com_calno_"+index+"'>"+item.calname+"</label></td>";
					
						if("${sessionScope.loginuser.gradelevel}" =='1') {
							 html += "<td style='width:20%; vertical-align: text-top; text-align: right;'><button class='btn_edit' style='background-color: #fff; border: none; outline:none;' data-target='editCal' onclick='editComCalendar("+item.pk_calno+",\""+item.calname+"\")'><i class='bi bi-pen'></i></button></td>";  
							 html += "<td style='width:20%; vertical-align: text-top; text-align: right;'><button class='btn_edit delCal' style='background-color: #fff; border: none;' onclick='delCalendar("+item.pk_calno+",\""+item.calname+"\")'><i class='bi bi-trash3'></i></button></td>";
						 }
						
						html += "</tr>";
						
						////////////////////////////////////////////////////////////////////////////////
						arr_checkbox_com_calno.push(item.pk_calno);
						sessionStorage.setItem('arr_checkbox_com_calno', arr_checkbox_com_calno.join());
						
						arr_checkbox_com_calno_a.push(item.pk_calno);
						sessionStorage.setItem('arr_checkbox_com_calno_a', arr_checkbox_com_calno_a.join());
						
						arr_checkbox_calno.push(item.pk_calno);
						sessionStorage.setItem('arr_checkbox_calno', arr_checkbox_calno.join());
						////////////////////////////////////////////////////////////////////////////////
					});
					html += "</tbody>";
					html += "</table>";
				}
				
				$("div#companyCal").html(html);
				
			},
			error: function(request, status, error){
  	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
   	     	}	
		});
	}// end of function showCompanyCal()------------------
	
	// === 사내 캘린더 수정하기 === //
	function editComCalendar(pk_calno, calname){
		$("#editComCalModal").modal('show');
		$("input.editCom_pk_calno").val(pk_calno);
		$("input.editCom_calname").val(calname);
	}
	
	function goEditComCal(){
		
		if($("input.editCom_calname").val().trim()== ""){
			alert("수정할 사내캘린더 소분류명을 입력하세요!!");
	  		return;
		}
		else {
			
			$.ajax({
				url:"<%= ctxPath%>/calendar/editCalendar.bts",
				data:{"pk_calno":$("input.editCom_pk_calno").val(),
					  "calname":$("input.editCom_calname").val(),
					  "fk_emp_no":"${sessionScope.loginuser.pk_emp_no}",
					  "caltype":"2" 
					 },
				type: "post",
				dataType:"json",
				success:function(json){
					if(json.n == 0){
						alert($("input.editCom_calname").val()+"은(는) 이미 존재하는 캘린더 명입니다.");
	   					return;
					}
					if(json.n ==1){
						$('#editComCalModal').modal('hide'); // 모달 숨기기
						alert("사내 캘린더명을 수정하였습니다.");
						showCompanyCal();
					}
				},
				 error: function(request, status, error){
			            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			    }
			});
		}
		
	}// end of function goEditComCal()----------------------------------------------------------
	
	<%-- 내 캘린더 관련 --%>
	
	// === 내 캘린더 추가 클릭시 ===
	function addMyCalendar(){
		$('#addMyCalModal').modal('show'); // 모달창 보여주기	
	}// end of function addComCalendar(){}--------------------
		
		
	// === 내 캘린더 추가 모달창에서 추가 버튼 클릭시 ===
	function goAddMyCal(){
		
		if($("input.addMy_calname").val().trim() == ""){
	 		  alert("추가할 사내캘린더 소분류명을 입력하세요!!");
	 		  return;
	 	}
		if($("input.addMy_calname").val().length > 50){
			  alert("50자 이내로 입력하세요!!");
	 		  return;
		}
		
	 	else {
	 		 $.ajax({
	 			 url: "<%= ctxPath%>/calendar/addMyCalendar.bts",
	 			 type: "post",
	 			 data: {"addMy_calname": $("input.addMy_calname").val(), 
	 				    "fk_emp_no": "${sessionScope.loginuser.pk_emp_no}"},
	 			 dataType: "json",
	 			 success:function(json){
	 				 if(json.n != 1){
	  					alert("이미 존재하는 '내캘린더 소분류명' 입니다.");
	  					return;
	  				 }
	 				 else if(json.n == 1){
	 					 $('#addMyCalModal').modal('hide'); // 모달창 감추기				
	 					 alert("내 캘린더에 "+$("input.addMy_calname").val()+" 소분류명이 추가되었습니다.");
	 					 
	 					 $("input.addMy_calname").val("");
	 					 showMyCal();  // 사내 캘린더 소분류 보여주기
	 				 }
	 			 },
	 			 error: function(request, status, error){
	  	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	    	     }	 
	 		 });
	 	  }
		
	}// end of function goAddMyCal(){}------------------------------------

	// === 내 캘린더에서 내캘린더 소분류 보여주기  === //
	function showMyCal(){
		$.ajax({
			url:"<%= ctxPath%>/calendar/showMyCalendar.bts",
			type:"get",
			data:{"fk_emp_no":"${sessionScope.loginuser.pk_emp_no}"},
			dataType:"json",
			success:function(json){
				
				var html = "";
				
				if(json.length > 0){
					
					html += "<table style='margin: 0 20px;'>";
					html += "<tbody>";
					$.each(json, function(index, item){
					
						html += "<tr id='schecheck'>";
						html += "<td style='width:110%;'><input type='checkbox' name='my_calno' class='calendar_checkbox my_calno' value='"+item.pk_calno+"' id='my_calno_"+index+"' checked />&nbsp;&nbsp;<label for='my_calno_"+index+"'>"+item.calname+"</label></td>";				
						if(item.pk_calno != '1'){
							html += "<td style='width:20%; vertical-align: text-top; text-align: right;'><button class='btn_edit' style='background-color: #fff; border: none; outline:none;' data-target='editCal' onclick='editMyCalendar("+item.pk_calno+",\""+item.calname+"\")'><i class='bi bi-pen'></i></button></td>";  
							html += "<td style='width:20%; vertical-align: text-top; text-align: right;'><button class='btn_edit delCal' style='background-color: #fff; border: none;' onclick='delCalendar("+item.pk_calno+",\""+item.calname+"\")'><i class='bi bi-trash3'></i></button></td>";
						}
						html += "</tr>";
						
						////////////////////////////////////////////////////////////////////////////////
						arr_checkbox_my_calno.push(item.pk_calno);
						sessionStorage.setItem('arr_checkbox_my_calno', arr_checkbox_my_calno.join());
						
						arr_checkbox_my_calno_a.push(item.pk_calno);
						sessionStorage.setItem('arr_checkbox_my_calno_a', arr_checkbox_my_calno_a.join());
						
						arr_checkbox_calno.push(item.pk_calno);
						sessionStorage.setItem('arr_checkbox_calno', arr_checkbox_calno.join());
						////////////////////////////////////////////////////////////////////////////////
					});
					html += "</tbody>";
					html += "</table>";
				}
				
				$("div#myCal").html(html);
				
			},
			error: function(request, status, error){
  	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
   	     	}	
		});
	}// end of function showMyCal()------------------
	
	// === 사내 캘린더 수정하기 === //
	function editMyCalendar(pk_calno, calname){
		$("#editMyCalModal").modal('show');
		$("input.editMy_pk_calno").val(pk_calno);
		$("input.editMy_calname").val(calname);
	}
	
	function goEditMyCal(){
		
		if($("input.editMy_calname").val().trim() == ""){
			alert("수정할 사내캘린더 소분류명을 입력하세요!!");
	  		return;
		}
		else {
			
			$.ajax({
				url:"<%= ctxPath%>/calendar/editCalendar.bts",
				data:{"pk_calno":$("input.editMy_pk_calno").val(),
					  "calname":$("input.editMy_calname").val(),
					  "fk_emp_no":"${sessionScope.loginuser.pk_emp_no}",
					  "caltype":"1"
					 },
				dataType:"json",
				type: "post",
				success:function(json){
					if(json.n == 0){
						alert($("input.editMy_calname").val()+"은(는) 이미 존재하는 캘린더 명입니다.");
	   					return;
					}
					if(json.n ==1){
						$('#editMyCalModal').modal('hide'); // 모달 숨기기
						alert("내 캘린더명을 수정하였습니다.");
						showMyCal();
					}
				},
				 error: function(request, status, error){
			            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			    }
			});
		}
		
	}// end of function editMyCalModal()----------------------------------------------------------
	
	
	// === 캘린더 소분류 삭제하기 === //
	function delCalendar(pk_calno, calname){
		
		var bool = confirm(calname + " 캘린더를 삭제 하시겠습니까?");
		
		
		if(bool){
			$.ajax({
				url:"<%= ctxPath%>/calendar/deleteCalendar.bts",
				data:{"pk_calno":pk_calno},
				dataType:"json",
				type:"post",
				success:function(json){
					if(json.n==1){
						alert(calname + " 캘린더를 삭제하였습니다.");
						location.href="javascript:history.go(0);"; // 페이지 새로고침
					}
				},
				 error: function(request, status, error){
			            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			    }
				
			});
		}
	}// end of function delCalendar(pk_calno, calname)-------------------------------------
	
	// function declaration
	
</script>

	<div>
	   <div id="sidebar" style="font-size: 11pt;">
		 <h4 style="margin-top: 30px; ">캘린더</h4>
		 
			<input type="hidden" value="${sessionScope.loginuser.pk_emp_no}" id="fk_emp_no"/>
		
			<ul style="list-style-type: none; padding: 10px;">
				<li style="margin-bottom: 15px;">
					<div id="calenderbtn1" class="calenderbtn">사내 캘린더</div>
						<div id="slideTogglebox1"  class="slideTogglebox">
							<%-- 사내 캘린더를 보여주는 곳 --%>
							<div id="companyCal" style="margin-bottom: 10px;"></div>			
						</div>
						<%-- 사내 캘린더 추가를 할 수 있는 직원은 직위코드가 3 이면서 부서코드가 4 에 근무하는 사원이 로그인 한 경우에만 가능하도록 조건을 걸어둔다.  	
	     				<c:if test="${sessionScope.loginuser.fk_pcode =='3' && sessionScope.loginuser.fk_dcode == '4' }"> --%>
	     				<c:if test="${sessionScope.loginuser.gradelevel =='1'}"> 
						<span id="addComCalendar" onclick="addComCalendar()">&nbsp;&nbsp;+ 사내 캘린더 추가</span>
						</c:if> 
						<%-- </c:if>	--%>
				</li>
				<li style="margin-bottom: 15px;">
					<div id="calenderbtn2" class="calenderbtn">내 캘린더</div>
						<div id="slideTogglebox2"  class="slideTogglebox">
						<div>
 							<%-- 내 캘린더를 보여주는 곳 --%>
							<div id="myCal" style="margin-bottom: 10px;"></div>					
						</div>
						</div>
						<span id="addMyCalendar" onclick="addMyCalendar()">&nbsp;&nbsp;+ 내 캘린더 추가</span>		
				</li>
			</ul>
		<input type="checkbox" id="sharedCal" class="calendar_checkbox" style="margin-left: 5px;" value="0" checked/>&nbsp;&nbsp;<label for="sharedCal">공유받은 캘린더</label> 
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