<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
   String ctxPath = request.getContextPath();

%>


<script type="text/javascript">

	/* 유리 줄 부분 모달꺼 시작  */
	
	$( document ).ready( function() {
		
	  $( "div#y_teamwon" ).slideToggle().hide();
	  $( "button#y_team" ).click( function() {
	      $( "div#y_teamwon" ).slideToggle();
	    });
		  
	  $( "div#m_teamwon" ).slideToggle().hide();
	  $( "button#m_team" ).click( function() {
	    $( "div#m_teamwon" ).slideToggle();
	  });
	  
	  $( "div#g_teamwon" ).slideToggle().hide();
	  $( "button#g_team" ).click( function() {
	    $( "div#g_teamwon" ).slideToggle();
	  });
	  
	  $( "div#c_teamwon" ).slideToggle().hide();
	  $( "button#c_team" ).click( function() {
	    $( "div#c_teamwon" ).slideToggle();
	  });
	  
	  $( "div#i_teamwon" ).slideToggle().hide();
	  $( "button#i_team" ).click( function() {
	    $( "div#i_teamwon" ).slideToggle();
	  });
	  
	  $( "div#h_teamwon" ).slideToggle().hide();
	  $( "button#h_team" ).click( function() {
	    $( "div#h_teamwon" ).slideToggle();
	  });
	  
	  $('input:checkbox[name=empno]').click(function(){
		  
		  checkOnlyOne(this);
		  
		  $("input#emp_no").val("");
		  $("input#emp_name").val("");
		  $("input#emp_rank").val("");
		  $("input#emp_dept").val("");
		  
		  var employee_no =  $(this).val();
		     $("input#emp_no").val(employee_no);
		  var employee_name =  $(this).next().val();
		     $("input#emp_name").val(employee_name);
		     var employee_rank =  $(this).next().next().val();
		     $("input#emp_rank").val(employee_rank);
		     var employee_dept =  $(this).next().next().next().val();
		     $("input#emp_dept").val(employee_dept);
		     
	  });
	  
/////////////////////////////////////////////////////////////////////////////
/* 유효성 검사 시작 */

 		$("span.error").hide();	
		$("input#addb_name").focus();
		
	// 이름 시작
	  $("input#addb_name").blur(() => { 
			const $target = $(event.target);
			
			const name = $target.val().trim();
			if(name == ""){
				// 입력하지 않거나 공백만 입력했을 경우
				$("table#tbl_telAdd :input").prop("disabled", true);
				$target.prop("disabled", false);
			//	$target.next().show();
			// 	또는
				$target.parent().find(".error").show();
			
				$target.focus();
				
			} else {
				// 공백이 아닌 글자를 입력했을 경우
				$("table#tbl_telAdd :input").prop("disabled", false);
				//	$target.next().hide();
				// 	또는
				$target.parent().find(".error").hide();
			}
		});
	// 이름 끝
	
	// 휴대폰번호 시작
		
		$("input#hp2").blur(() => {
			const $target = $(event.target);
			
	        const regExp = new RegExp(/^[1-9][0-9]{3}$/g); 
	        // 숫자 4자리만 들어오도록 검사해주는 정규표현식 객체 생성(첫글자는 숫자 1~9까지만 가능함)
		    
	         const bool = regExp.test($target.val());  
	        
			if(!bool){ // !bool == false 국번이 정규표현식에 위배된 경우
				$("table#tbl_telAdd :input").prop("disabled", true);
				  $target.prop("disabled", false);
			
			//	$target.next().show();
			// 	또는
				$target.parent().find(".error").show();
				
				$target.focus();
			} else {
				// bool == true 국번이 정규표현식에 맞는 경우
				$("table#tbl_telAdd :input").prop("disabled", false);
				
				//	$target.next().hide();
				// 	또는
				$target.parent().find(".error").hide();
			}
		});  // end of $("input#hp2").blur(() => {})
		
		// hp3
		
		$("input#hp3").blur(() => {
			const $target = $(event.target);
			
	        const regExp = new RegExp(/^[1-9][0-9]{3}$/g); 
	        // 숫자 4자리만 들어오도록 검사해주는 정규표현식 객체 생성(첫글자는 숫자 1~9까지만 가능함)
		    
	         const bool = regExp.test($target.val());  
	        
			if(!bool){ // !bool == false 국번이 정규표현식에 위배된 경우
				$("table#tbl_telAdd :input").prop("disabled", true);
				  $target.prop("disabled", false);
			
			//	$target.next().show();
			// 	또는
				$target.parent().find(".error").show();
				
				$target.focus();
			} else {
				// bool == true 국번이 정규표현식에 맞는 경우
				$("table#tbl_telAdd :input").prop("disabled", false);
				
				//	$target.next().hide();
				// 	또는
				$target.parent().find(".error").hide();
			}
		});  // end of $("input#hp3").blur(() => {})
	// 휴대폰번호 끝
	
	// 이메일 시작
	$("input#email1").blur(() => {
			const $target = $(event.target);
	        
			if(!bool){ // !bool == false 국번이 정규표현식에 위배된 경우
				$("table#tbl_telAdd :input").prop("disabled", true);
				  $target.prop("disabled", false);
			
			//	$target.next().show();
			// 	또는
				$target.parent().find(".error").show();
				
				$target.focus();
			} else {
				// bool == true 국번이 정규표현식에 맞는 경우
				$("table#tbl_telAdd :input").prop("disabled", false);
				
				//	$target.next().hide();
				// 	또는
				$target.parent().find(".error").hide();
			}
		});  // end of $("input#hp2").blur(() => {})
		
		$("input#email2").blur(() => {
			const $target = $(event.target);
	        
			if(!bool){ // !bool == false 국번이 정규표현식에 위배된 경우
				$("table#tbl_telAdd :input").prop("disabled", true);
				  $target.prop("disabled", false);
			
			//	$target.next().show();
			// 	또는
				$target.parent().find(".error").show();
				
				$target.focus();
			} else {
				// bool == true 국번이 정규표현식에 맞는 경우
				$("table#tbl_telAdd :input").prop("disabled", false);
				
				//	$target.next().hide();
				// 	또는
				$target.parent().find(".error").hide();
			}
		});  // end of $("input#hp2").blur(() => {})
	
	
	
	}); // end of $( document ).ready( function()------------------------------------------
 	
	/* 체크박스 하나만 선택되게 하는 함수 시작 */
	function checkOnlyOne(element) {
		  
		  const checkboxes 
		      = document.getElementsByName("empno");
		  
		  checkboxes.forEach((cb) => {
		    cb.checked = false;
		  })
		  
		  element.checked = true;
		}		
	/* 체크박스 하나만 선택되게 하는 함수 끝 */

	function middle_approve(){
		
		var emp_no = $("input#emp_no").val();
		var emp_name = $("input#emp_name").val();
		var emp_rank = $("input#emp_rank").val();
		var emp_dept = $("input#emp_dept").val();
		
		$("input#middle_empno").val(emp_no);
	 	$("input#middle_name").val(emp_name);
	 	$("input#middle_rank").val(emp_rank);
	 	$("input#middle_dept").val(emp_dept);
	}
	    
	function last_approve(){
			
			var emp_no = $("input#emp_no").val();
			var emp_name = $("input#emp_name").val();
			var emp_rank = $("input#emp_rank").val();
			var emp_dept = $("input#emp_dept").val();
			
		 	$("input#last_empno").val(emp_no);
		 	$("input#last_name").val(emp_name);
		 	$("input#last_rank").val(emp_rank);
		 	$("input#last_dept").val(emp_dept);
		}
 	
	
	function middle_reset() {
		
		$("input#middle_empno").val("");
	 	$("input#middle_name").val("");
	 	$("input#middle_rank").val("");
	 	$("input#middle_dept").val("");
	}
	
	function last_reset() {
		
		$("input#last_empno").val("");
	 	$("input#last_name").val("");
	 	$("input#last_rank").val("");
	 	$("input#last_dept").val("");
	
	}

	
	$(document).on("click", "#insert_customer_btn", function(event){
		if( $("#last_name").val() == ""){
		     alert("최종승인자 값이 없습니다");
		     return false;
		}
		else if ( $("#last_empno").val() != "" ) {
			const frm = document.submitFrm;
		    frm.action = "<%=ctxPath%>/addBook/addBook_telAdd.bts"
		    frm.method = "post"
	    	frm.submit();
	 	}
	});
	
	 /* 유리 줄 부분 모달꺼 끝 */
	
		function goTelAdd() {
			
			const frm = document.telAddFrm;
		    frm.action = "<%=ctxPath%>/addBook/addBook_telAdd_insert.bts"
		    frm.method = "post"
		    frm.submit();
		}
	 
		/* 이메일 선택or직접입력 */
		function selectEmail(ele){ 
			var $ele = $(ele); 
			var $email2 = $('input[name=email2]');
			
			// '1'인 경우 직접입력 
			if($ele.val() == "1"){ 
				$email2.attr('readonly', false); 
				$email2.val(''); 
			} else { 
				$email2.attr('readonly', true); 
				$email2.val($ele.val()); 
			} 
		}
		/* 이메일 선택or직접입력 */
		
		
	

	
		
	 // end of $("input#emp_name").blur(() => {})-------------------------------------------
			

</script>

<style type="text/css">

#tbl_telAdd { 
		border-collapse: separate;
		border-spacing: 0 12px;
	}
	
	.arrow-next_1 {
    position: relative;
    float:left;
    width:90px;
    height:90px;
}

.arrow-next_1::after {
    position: absolute;
    left: 10px; 
    top: 20px; 
    content: '';
    width: 50px; /* 사이즈 */
    height: 50px; /* 사이즈 */
    border-top: 5px solid #000; /* 선 두께 */
    border-right: 5px solid #000; /* 선 두께 */
    transform: rotate(45deg); /* 각도 */
}


	.arrow-next_2 {
    position: relative;
    float:left;
    width:90px;
    height:90px;
}

.arrow-next_2::after {
    position: absolute;
    left: 10px; 
    top: 20px; 
    content: '';
    width: 50px; /* 사이즈 */
    height: 50px; /* 사이즈 */
    border-top: 5px solid #000; /* 선 두께 */
    border-right: 5px solid #000; /* 선 두께 */
    transform: rotate(45deg); /* 각도 */
}



</style>

<title>연락처추가페이지</title>

	<div id="telAdd_main_tbl" style="text-align:center;">
	<form name="telAddFrm"> 
	<table id="tbl_telAdd">
		<tr>
			<td><h2>연락처 추가<br><br></h2><input type="hidden" id="registeruser" value="${sessionScope.loginuser.pk_emp_no}"></td>
		</tr>
		<tr>
			<td><strong>사진</strong></td>
			<td><img src="<%=ctxPath %>/resources/images/addBook_telAdd_sample.jpg" alt="..." class="img-rounded"><button class="btn btn-default" id="telAdd_mini_btn">삭제</button></td>
		</tr>
		<tr>
			<td><strong>이름</strong></td>
			<td>
				<input type="text" class="form-control" id="addb_name" name="addb_name" placeholder="이름">
				<span class="error">이름 을 입력해주세요.</span> 
			</td>
			
		</tr>
		<tr>
			<td><strong>부서</strong></td>
			<td>
				<select id="department" name="department" class="form-control">
				  <option value="700" placeholder="없음">&nbsp;</option>
				  <option value="100">영업</option>
				  <option value="200">마케팅</option>
				  <option value="300">기획</option>
				  <option value="400">총무</option>
				  <option value="500">인사</option>
				  <option value="600">회계</option>
				</select>
			</td>
		</tr>
		<tr>
			<td><strong>직위</strong></td>
			<td>
				<select id="rank" name="rank" class="form-control">
				  <option value="90" placeholder="없음">&nbsp;</option>
				  <option value="10">사원</option>
				  <option value="20">주임</option>
				  <option value="30">대리</option>
				  <option value="40">과장</option>
				  <option value="50">차장</option>
				  <option value="60">부장</option>
				  <option value="70">전무</option>
				  <option value="80">사장</option>
				</select>
				
			</td>
		</tr>
		<tr>
			<td><strong>이메일</strong></td>
			<td>
			<input class="form-control" id="email1" name="email1" style="width:130px; display:inline;" type="text" maxlength="15">&nbsp;@
			<input class="form-control" id="email2" name="email2" style="width:130px; display:inline;" type="text" maxlength="15" placeholder="직접입력">&nbsp;
			<select class="form-control" name="select_email" style="width:130px; display:inline;" onChange="selectEmail(this)">
				<option value="1">직접입력</option>
				<option value="gmail.com">gmail.com</option>
				<option value="naver.com">naver.com</option>
				<option value="nate.com">nate.com</option>
				<option value="hanmail.net">hanmail.net</option>
			</select>
			</td>
		</tr>
		<tr>
			<td><strong>휴대폰</strong></td>
			<td>
				<select class="form-control" id="hp1" name="hp1" style="width:130px; display:inline;" >
					<option value="010">010</option>
				</select>&nbsp;-&nbsp;
				<input class="form-control" id="hp2" name="hp2" style="width:130px; display:inline;" type="text" size="5" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">&nbsp;-&nbsp; 
				<input class="form-control" id="hp3" name="hp3" style="width:130px; display:inline;" type="text" size="5" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
			</td>
		</tr>
		<tr>
			<td><strong>회사</strong></td>
			<td><input type="text" class="form-control" id="company" name="company" placeholder="회사"></td>
		</tr>
		<tr>
			<td><strong>회사전화번호</strong></td>
			<td>
				<select class="form-control" id="num1" name="num1" style="width:130px; display:inline; ">
						<option value="">선택</option>
						<option value="02">02</option>
						<option value="031">031</option>
						<option value="032">032</option>
						<option value="033">033</option>
						<option value="041">041</option>
						<option value="042">042</option>
						<option value="043">043</option>
						<option value="044">044</option>
						<option value="051">051</option>
						<option value="052">052</option>
						<option value="053">053</option>
						<option value="054">054</option>
						<option value="055">055</option>
						<option value="061">061</option>
						<option value="062">062</option>
						<option value="063">063</option>
						<option value="064">064</option>
						<option value="070">070</option>
						<option value="010">010</option>
					</select>&nbsp;-&nbsp;
				<input class="form-control" id="num2" name="num2" style="width:130px; display:inline; " type="text" size="5" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">&nbsp;-&nbsp; 
				<input class="form-control" id="num3" name="num3" style="width:130px; display:inline; " type="text" size="5" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
			</td>
		</tr>
		<tr>
			<td><strong>회사주소</strong></td>
			<td><input type="text" class="form-control" id="company_address" name="company_address" placeholder="회사주소" style=""></td>
		</tr>
		<tr>
			<td><strong>메모사항</strong></td>
			<td><input type="text" class="form-control" id="memo" name="memo" placeholder="메모사항" style="height: 80px;"></td>
		</tr>
		</table>
		</form>
			<div id="buttonmenu">
				<input type="submit" class="btn btn-info" style="border: solid lightgray 2px;" value="확인" onclick="goTelAdd()" />
				<input type="reset" class="btn btn-default" style="border: solid lightgray 2px;" value="취소"  onclick="location.href='http://localhost:9090/bts/addBook/addBook_main.bts'"  />
			</div>
			
	</div>
	
	
	

	
	<!-- 모달 -->
<button class="btn btn-default" data-toggle="modal" data-target="#viewModal">유리한테 줄 조직도 틀</button>

<div class="modal fade" data-backdrop="static" id="viewModal">
	<div class="modal-dialog">
	<div class="modal-content" style= "height:90%; width:200%;">
	<div class="modal-header">
	<h4 class="modal-title" id="exampleModalLabel">결재 참조</h4>
	</div>
	
	<div class="modal-body">
		<div id="tbl_one" style="float:left; width:22%;">
			<table style="text-align:center;">
				<tr>
					<td><button class="btn btn-default" id="y_team" style="width:150px; border: solid darkgray 2px;">영업팀</button></td>
				</tr>
				<c:forEach var="emp" items="${requestScope.empList}" varStatus="i">
				<c:if test="${emp.ko_depname  eq '영업'}">
				<tr>
				<td>
					<div id="y_teamwon">
						<label>
							<input type="checkbox" id="pk_emp_no_${i.count}" name="empno" value="${emp.pk_emp_no}" />
							<input type="hidden" id="employee_name" name="employee_name" value="${emp.emp_name}" />
							<input type="hidden" id="employee_rank" name="employee_rank" value="${emp.ko_rankname}" />
							<input type="hidden" id="employee_dept" name="employee_dept" value="${emp.ko_depname}" />
							&nbsp;${emp.emp_name}&nbsp;[${emp.ko_rankname}]
						</label>
					</div>
				</td>
				</tr>
				</c:if>
		   		</c:forEach>
		   		
				<tr>
					<td><button class="btn btn-default" id="m_team" style="width:150px; border: solid darkgray 2px;">마케팅팀</button></td>
				</tr>
				<c:forEach var="emp" items="${requestScope.empList}" varStatus="i">
				<c:if test="${emp.ko_depname  eq '마케팅'}">
				<tr>
				<td>
					<div id="m_teamwon">
						<label>
							<input type="checkbox" id="pk_emp_no_${i.count}" name="empno" value="${emp.pk_emp_no}" />
							<input type="hidden" id="employee_name" name="employee_name" value="${emp.emp_name}" />
							<input type="hidden" id="employee_rank" name="employee_rank" value="${emp.ko_rankname}" />
							<input type="hidden" id="employee_dept" name="employee_dept" value="${emp.ko_depname}" />
							&nbsp;${emp.emp_name}&nbsp;[${emp.ko_rankname}]
						</label>
					</div>
				</td>
				</tr>
				</c:if>
		   		</c:forEach>
				<tr>
					<td><button class="btn btn-default" id="g_team" style="width:150px; border: solid darkgray 2px;">기획팀</button></td>
				</tr>
				<c:forEach var="emp" items="${requestScope.empList}" varStatus="i">
				<c:if test="${emp.ko_depname  eq '기획'}">
				<tr>
				<td>
					<div id="g_teamwon">
						<label>
							<input type="checkbox" id="pk_emp_no_${i.count}" name="empno" value="${emp.pk_emp_no}" />
							<input type="hidden" id="employee_name" name="employee_name" value="${emp.emp_name}" />
							<input type="hidden" id="employee_rank" name="employee_rank" value="${emp.ko_rankname}" />
							<input type="hidden" id="employee_dept" name="employee_dept" value="${emp.ko_depname}" />
							&nbsp;${emp.emp_name}&nbsp;[${emp.ko_rankname}]
						</label>
					</div>
				</td>
				</tr>
				</c:if>
		   		</c:forEach>
				<tr>
					<td><button class="btn btn-default" id="c_team" style="width:150px; border: solid darkgray 2px;">총무팀</button></td>
				</tr>
				<c:forEach var="emp" items="${requestScope.empList}" varStatus="i">
				<c:if test="${emp.ko_depname  eq '총무'}">
				<tr>
				<td>
					<div id="c_teamwon">
						<label>
							<input type="checkbox" id="pk_emp_no_${i.count}" name="empno" value="${emp.pk_emp_no}" />
							<input type="hidden" id="employee_name" name="employee_name" value="${emp.emp_name}" />
							<input type="hidden" id="employee_rank" name="employee_rank" value="${emp.ko_rankname}" />
							<input type="hidden" id="employee_dept" name="employee_dept" value="${emp.ko_depname}" />
							&nbsp;${emp.emp_name}&nbsp;[${emp.ko_rankname}]
						</label>
					</div>
				</td>
				</tr>
				</c:if>
		   		</c:forEach>
				<tr>
					<td><button class="btn btn-default" id="i_team" style="width:150px; border: solid darkgray 2px;">인사팀</button></td>
				</tr>
				<c:forEach var="emp" items="${requestScope.empList}" varStatus="i">
				<c:if test="${emp.ko_depname  eq '인사'}">
				<tr>
				<td>
					<div id="i_teamwon">
						<label>
							<input type="checkbox" id="pk_emp_no_${i.count}" name="empno" value="${emp.pk_emp_no}" />
							<input type="hidden" id="employee_name" name="employee_name" value="${emp.emp_name}" />
							<input type="hidden" id="employee_rank" name="employee_rank" value="${emp.ko_rankname}" />
							<input type="hidden" id="employee_dept" name="employee_dept" value="${emp.ko_depname}" />
							&nbsp;${emp.emp_name}&nbsp;[${emp.ko_rankname}]
						</label>
					</div>
				</td>
				</tr>
				</c:if>
		   		</c:forEach>
				<tr>
					<td><button class="btn btn-default" id="h_team" style="width:150px; border: solid darkgray 2px;">회계팀</button></td>
				</tr>
				<c:forEach var="emp" items="${requestScope.empList}" varStatus="i">
				<c:if test="${emp.ko_depname  eq '회계'}">
				<tr>
				<td>
					<div id="h_teamwon">
						<label>
							<input type="checkbox" id="pk_emp_no_${i.count}" name="empno" value="${emp.pk_emp_no}" />
							<input type="hidden" id="employee_name" name="employee_name" value="${emp.emp_name}" />
							<input type="hidden" id="employee_rank" name="employee_rank" value="${emp.ko_rankname}" />
							<input type="hidden" id="employee_dept" name="employee_dept" value="${emp.ko_depname}" />
							&nbsp;${emp.emp_name}&nbsp;[${emp.ko_rankname}]
						</label>
					</div>
				</td>
				</tr>
				</c:if>
		   		</c:forEach>
		  	</table>
		  		<input type="hidden" id="emp_no" name="emp_no" />
		  		<input type="hidden" id="emp_name" name="emp_name" />
		   		<input type="hidden" id="emp_rank" name="emp_rank" />
		   		<input type="hidden" id="emp_dept" name="emp_dept" />
	  	</div>
	  	
	  	<div id="tbl_two" style="float:left; width:20%;">
		  	<table>
			  	<tr><td><button class="arrow-next_1" onclick="middle_approve();" ></button></td></tr>
			  	<tr><td><button class="arrow-next_2" onclick="last_approve();" style="margin-top:115%;"></button></td></tr>
		  	</table>
	  	</div>
	  	
	  	<div id="tbl_three" style="float:left; width:50%;">
	  		<form name="submitFrm">
		  	<table style="text-align:center;">
		  		<tr><td colspan="7">중간 결재&nbsp;<input type="reset" value="삭제" onclick="middle_reset()"/></td></tr>
				<tr style="border: solid darkgray 2px; margin-left:2%">
					<td style="width:0%;"><input type="hidden" id="pk_emp_no_${i.count}" name="pk_emp_no_${i.count}" value="${emp.pk_emp_no}" readonly /></td>
					<td style="width:13%;"><strong>이름</strong></td>
					<td style="width:13%;"><strong>직급</strong></td>
					<td style="width:13%;"><strong>부서</strong></td>
				</tr>
				<tr style="border-bottom: solid darkgray 2px;">
					<td style="width:0%;"><input type="hidden" id="pk_emp_no_${i.count}" name="pk_emp_no_${i.count}" value="${emp.pk_emp_no}" readonly />
					<input type="hidden" id="middle_empno" name="middle_empno"  style="border:none; text-align:center; " ></td>
					<td><input type="text" id="middle_name" name="middle_name"  style="border:none; text-align:center; " ><br></td>
					<td><input type="text" id="middle_rank" name="middle_rank"  style="border:none; text-align:center;" ><br></td>
					<td><input type="text" id="middle_dept" name="middle_dept"  style="border:none; text-align:center;"  ><br></td>
				</tr>
			</table>
			<table style="text-align:center; margin-top:30%;">
				<tr><td colspan="7">최종 결재&nbsp;<input type="reset" value="삭제" onclick="last_reset()" /></td></tr>
				<tr style="border: solid darkgray 2px; margin-left:2%">
					<td style="width:0%;"><input type="hidden" id="pk_emp_no_${i.count}" name="pk_emp_no_${i.count}" value="${emp.pk_emp_no}" readonly /></td>
					<td style="width:13%;"><strong>이름</strong></td>
					<td style="width:13%;"><strong>직급</strong></td>
					<td style="width:13%;"><strong>부서</strong></td>
				</tr>
				<tr style="border-bottom: solid darkgray 2px;">
					<td style="width:0%;"><input type="hidden" id="pk_emp_no_${i.count}" name="pk_emp_no_${i.count}" value="${emp.pk_emp_no}" readonly />
					<input type="hidden" id="last_empno" name="last_empno"  style="border:none; text-align:center; " ></td>
					<td><input type="text" id="last_name" name="last_name"  style="border:none; text-align:center; " ><br></td>
					<td><input type="text" id="last_rank" name="last_rank"  style="border:none; text-align:center;" ><br></td>
					<td><input type="text" id="last_dept" name="last_dept"  style="border:none; text-align:center;"  ><br></td>
				</tr>
			</table>
			</form>
	  	</div>
	</div><!-- modal-body -->
	
	<div class="modal-footer">
	<input type="button" class="btn btn-primary" id="insert_customer_btn" onclick="" value="등록">
	<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	</div>
	</div>
	</div>
	</div>
