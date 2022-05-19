<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%
   String ctxPath = request.getContextPath();
%>
<style type="text/css">
	th#th_title {
		width: 120px;
	
	}
</style>
<script type="text/javascript">
	let b_flagIdDuplicateClick = false;
	// 가입하기 버튼 클릭시 "아이디중복확인" 을 클릭했는지 클릭안했는지를 알아보기 위한 용도이다.
	
	let b_flagEmailDuplicateClick = false;
	// 가입하기 버튼 클릭시 "이메일중복확인" 을 클릭했는지 클릭안했는지를 알아보기 위한 용도이다.
	var imgname = "";
	
	$(document).ready(function() {
		
		var pk_emp_no = $("input#emp_no").val();
		
		getEmpImgName();
		$("#empProfile").attr("src", "<%= ctxPath%>/resources/files/" + imgname); 
		
		// select 된 곳의 값들 넣어주기 시작
		$("select[name=fk_department_id]").val((("${requestScope.loginuser.fk_department_id}" == '') ? "" : "${requestScope.loginuser.fk_department_id}")).prop("selected", true); 
		$("select[name=fk_rank_id]").val((("${requestScope.loginuser.fk_rank_id}" == '') ? "" : "${requestScope.loginuser.fk_rank_id}")).prop("selected", true); 
		$("input#postcode").val("${requestScope.loginuser.postal}");
		
		$("select[name=num1]").val((("${requestScope.loginuser.num1}" == '') ? "" : "${requestScope.loginuser.num1}")).prop("selected", true); 
		$("input[name=num2]").val( ("${requestScope.loginuser.num2}" == '') ? "" : "${requestScope.loginuser.num2}" ); 
		$("input[name=num3]").val( ("${requestScope.loginuser.num3}" == '') ? "" : "${requestScope.loginuser.num3}" ); 
		
		$("input[name=hp2]").val( ("${requestScope.loginuser.hp2}" == '') ? "" : "${requestScope.loginuser.hp2}" ); 
		$("input[name=hp3]").val( ("${requestScope.loginuser.hp3}" == '') ? "" : "${requestScope.loginuser.hp3}" ); 
		
		if( $("input#gen").val() == "1") {
			$("input#male").prop("checked", true);
		}
		else {
			$("input#female").prop("checked", true);
		}
		
	    $("select[name=fk_department_id]").prop('disabled',true);
	    $("select[name=fk_rank_id]").prop('disabled',true);
	    
		if( pk_emp_no == 80000001 ) {
			$("select[name=fk_department_id]").prop('disabled', false);
		    $("select[name=fk_rank_id]").prop('disabled', false);
	    }
	    
		// select 된 곳의 값들 넣어주기 끝
		
		$("span.error").hide();	
		$("input#emp_name").focus();
		
		// 아이디가 pk_emp_no 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		$("input#pk_emp_no").blur(() => { 
			const $target = $(event.target);
			
			const name = $target.val().trim();
			if(name == "" ){
				// 입력하지 않거나 공백만 입력했을 경우
			    $("table#tblEmpUpdate :input").prop("disabled", true);
			    $target.prop("disabled", false);
			//	$target.next().show();
			// 	또는
				$target.parent().find(".error").show();
			
				$target.focus();
				
	
			} else if( pk_emp_no == 80000001 ) {
				$("table#tblEmpUpdate :input").prop("disabled", false);
				$("select[name=fk_department_id]").prop('disabled', false);
			    $("select[name=fk_rank_id]").prop('disabled', false);
		    } else {
				// 공백이 아닌 글자를 입력했을 경우
				$("table#tblEmpUpdate :input").prop("disabled", false);
				$("select[name=fk_department_id]").prop('disabled',true);
			    $("select[name=fk_rank_id]").prop('disabled',true);
				//	$target.next().hide();
				// 	또는
				$target.parent().find(".error").hide();
			}
		});  // end of $("input#pk_emp_no").blur(() => {------------------------
		
		// 아이디가 pwd 제약 조건 
		$("input#emp_pwd").blur(() => {  
			const $target = $(event.target);
			
			const regExp = new RegExp(/^.*(?=^.{8,16}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
			// 영어대/소문자 , 숫자, 특수기호를 모두 사용한 8글자 이상 16자 이하로 구성된 정규표현식
			
			const bool = regExp.test($target.val());  
			
			if(!bool){ // !bool == false 암호가 정규표현식에 위배된 경우
				// 암호가 정규표현식에 위배된 경우 
				  $("table#tblEmpUpdate :input").prop("disabled", true);
				  $target.prop("disabled", false);
				  
			   // $target.next().show();
			   // 또는
			      $target.parent().find(".error").show();
				  
				  $target.focus();
			
			
			} else if( pk_emp_no == 80000001 ) {
				$("table#tblEmpUpdate :input").prop("disabled", false);
				$("select[name=fk_department_id]").prop('disabled', false);
			    $("select[name=fk_rank_id]").prop('disabled', false);
		    } else {
				// bool == true 암호가 정규표현식에 맞는 경우
				$("table#tblEmpUpdate :input").prop("disabled", false);
				$("select[name=fk_department_id]").prop('disabled',true);
			    $("select[name=fk_rank_id]").prop('disabled',true);
			    
				$target.parent().find(".error").hide();
			}
		 
		}); // end of $("input#emp_pwd").blur(() => {})---------------------------------------
		
		// pwdcheck 제약 조건 패스워드 확인 검사
		$("input#pwdCheck").blur( () => {
			const $target = $(event.target);
			const pwd = $("input#emp_pwd").val();
			const pwdcheck = $target.val();
			
			if(pwd != pwdcheck){ // 암호와 암호확인값이 다른 경우 
				$("table#tblEmpUpdate :input").prop("disabled", true);
				$target.prop("disabled", false);
				$("input#emp_pwd").prop("disabled", false);
				
				$target.next().show();
			// 	또는
			//	$target.parent().find(".error").show();
				$("input#emp_pwd").focus();
			
			} else if( pk_emp_no == 80000001 ) {
				$("table#tblEmpUpdate :input").prop("disabled", false);
				$("select[name=fk_department_id]").prop('disabled', false);
			    $("select[name=fk_rank_id]").prop('disabled', false);
		    } else {
				// 암호와 암호확인값이 같은 경우
				$("table#tblEmpUpdate :input").prop("disabled", false);
				$("select[name=fk_department_id]").prop('disabled',true);
			    $("select[name=fk_rank_id]").prop('disabled',true);
				//	$target.next().hide();
				// 	또는
				$target.parent().find(".error").hide();
			}
		}); // end of $("input#pwdcheck").blur(() => {})--------------------------------------
		
		// 아이디가 name 제약 조건 
		$("input#emp_name").blur(() => { 
			const $target = $(event.target);
			
			const name = $target.val().trim();
			if(name == ""){
				// 입력하지 않거나 공백만 입력했을 경우
				$("table#tblEmpUpdate :input").prop("disabled", true);
				$target.prop("disabled", false);
			//	$target.next().show();
			// 	또는
				$target.parent().find(".error").show();
			
				$target.focus();
				
			
			} else if( pk_emp_no == 80000001 ) {
				$("table#tblEmpUpdate :input").prop("disabled", false);
				$("select[name=fk_department_id]").prop('disabled', false);
			    $("select[name=fk_rank_id]").prop('disabled', false);
		    } else {
				// 공백이 아닌 글자를 입력했을 경우
				$("table#tblEmpUpdate :input").prop("disabled", false);
				$("select[name=fk_department_id]").prop('disabled',true);
			    $("select[name=fk_rank_id]").prop('disabled',true);
				//	$target.next().hide();
				// 	또는
				$target.parent().find(".error").hide();
			}
		}); // end of $("input#emp_name").blur(() => {})-------------------------------------------
		
		// 아이디가 email 제약 조건 
		$("input#uq_email").blur(() => {
			const $target = $(event.target);
			
	        const regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i); 
	        // 이메일 정규표현식 객체 생성
		    
	         const bool = regExp.test($target.val());  
	        
			if(!bool){ // !bool == false 이메일이 정규표현식에 위배된 경우
				// 이메일이 정규표현식에 위배된 경우 
				$("table#tblEmpUpdate :input").prop("disabled", true);
				$target.prop("disabled", false);
				
			//	$target.next().show();
			// 	또는
				$target.parent().find(".error").show();
			
				$target.focus();
				
			} else if( pk_emp_no == 80000001 ) {
				$("table#tblEmpUpdate :input").prop("disabled", false);
				$("select[name=fk_department_id]").prop('disabled', false);
			    $("select[name=fk_rank_id]").prop('disabled', false);
		    } else {
				// bool == true 이메일이 정규표현식에 맞는 경우
				$("table#tblEmpUpdate :input").prop("disabled", false);
				$("select[name=fk_department_id]").prop('disabled',true);
			    $("select[name=fk_rank_id]").prop('disabled',true);
				//	$target.next().hide();
				// 	또는
				$target.parent().find(".error").hide();
			}
		}); // end of $("input#uq_email").blur(() => {})---------------------------
		
		// 아이디가 hp2인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
		$("input#hp2").blur(() => {
			const $target = $(event.target);
			
	        const regExp = new RegExp(/^[1-9][0-9]{3}$/g); 
	        // 숫자 4자리만 들어오도록 검사해주는 정규표현식 객체 생성(첫글자는 숫자 1~9까지만 가능함)
		    
	         const bool = regExp.test($target.val());  
	        
			if(!bool){ // !bool == false 국번이 정규표현식에 위배된 경우
				$("table#tblEmpUpdate :input").prop("disabled", true);
				  $target.prop("disabled", false);
			
			//	$target.next().show();
			// 	또는
				$target.parent().find(".error").show();
				
				$target.focus();
			} else if( pk_emp_no == 80000001 ) {
				$("table#tblEmpUpdate :input").prop("disabled", false);
				$("select[name=fk_department_id]").prop('disabled', false);
			    $("select[name=fk_rank_id]").prop('disabled', false);
		    } else {
				// bool == true 국번이 정규표현식에 맞는 경우
				$("table#tblEmpUpdate :input").prop("disabled", false);
				$("select[name=fk_department_id]").prop('disabled',true);
			    $("select[name=fk_rank_id]").prop('disabled',true);
				//	$target.next().hide();
				// 	또는
				$target.parent().find(".error").hide();
			}
		});  // end of $("input#hp2").blur(() => {})----------------------------------
		
		// 아이디가 hp3인 것은 포커스를 잃어버렸을 경우(blur) 이벤트를 처리해주는 것이다.
		
		$("input#hp3").blur(() => {
			const $target = $(event.target);
			
	        const regExp = new RegExp(/^[1-9][0-9]{3}$/g); 
	        // 숫자 4자리만 들어오도록 검사해주는 정규표현식 객체 생성(첫글자는 숫자 1~9까지만 가능함)
		    
	         const bool = regExp.test($target.val());  
	        
			if(!bool){ // !bool == false 국번이 정규표현식에 위배된 경우
				$("table#tblEmpUpdate :input").prop("disabled", true);
				  $target.prop("disabled", false);
			
			//	$target.next().show();
			// 	또는
				$target.parent().find(".error").show();
				
				$target.focus();
			} else if( pk_emp_no == 80000001 ) {
				$("table#tblEmpUpdate :input").prop("disabled", false);
				$("select[name=fk_department_id]").prop('disabled', false);
			    $("select[name=fk_rank_id]").prop('disabled', false);
		    } else {
				// bool == true 국번이 정규표현식에 맞는 경우
				$("table#tblEmpUpdate :input").prop("disabled", false);
				$("select[name=fk_department_id]").prop('disabled',true);
			    $("select[name=fk_rank_id]").prop('disabled',true);
				//	$target.next().hide();
				// 	또는
				$target.parent().find(".error").hide();
			}
		});  // end of $("input#hp3").blur(() => {})----------------------------------
		
		// 우편번호찾기 클릭시
		$("img#zipcodeSearch").click(function() {
			
	 	      new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                let addr = ''; // 주소 변수
	                let extraAddr = ''; // 참고항목 변수
	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }
	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("extraaddress").value = extraAddr;
	                
	                } else {
	                    document.getElementById("extraaddress").value = '';
	                }
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('postcode').value = data.zonecode;
	                document.getElementById("address").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("detailaddress").focus();
	            }
	        }).open();
	 			
		}); // end of $("img#zipcodeSearch").click(function() {-------------------------------------
			
		//////////////////////////////////////////////////////////////////////////////////////////	
		
		// 아이디값이 변경되면 가입하기 버튼 클릭시 "아이디중복확인" 을 클릭했는지 클릭안했는지를 알아보기 위한 용도를 초기화 시키기
	 	$("input#pk_emp_no").bind("change",()=>{  
	  	 	b_flagIdDuplicateClick = false;
	 	});
		
		// 이메일값이 변경되면 가입하기 버튼 클릭시 "이메일중복확인" 을 클릭했는지 클릭안했는지를 알아보기 위한 용도를 초기화 시키기
	 	$("input#uq_email").bind("change",()=>{  
	 		b_flagEmailDuplicateClick = false;
	 	});
		
	 // 한글입력막기 스크립트
	 	$("#pk_emp_no").keyup(function(e) { 
	 		if (!(e.keyCode >=37 && e.keyCode<=40)) {
	 			var v = $(this).val();
	 			$(this).val(v.replace(/[^0-9]/gi,''));
	 		}
	 	});
		
	 	// 사진변경버튼 클릭시
	 	$("button#updateImage").on("click", function (event) {
	 		/// event.preventDefault(); 
	 		var url = $("#updateImgFrm").attr("action"); 
	 		var form = $('#updateImgFrm')[0]; 
	 		var formData = new FormData(form); 
	 		$.ajax({ 
	 			url: url
	 		  , type: 'POST'
	 		  , data: formData
	 		  , dataType: "json"
	 		  , async: false
	 		  , success: function (json) { 
	 			 alert("사진이 변경되었습니다. 변경된 사진은 재접속시 적용됩니다.");
	 			 <%-- $("#empProfile").attr("src", "<%= ctxPath%>/resources/files/${json.img_name}"); --%>
	 			 /* $("#empProfile").attr("src", json.path +"/"+json.img_name);  */
	 			 // history.go(0);
	 		  }, error: function (json) { 
	 			  alert("실패!");
	 		  }, 
	 		    cache: false
	 		  , contentType: false
	 		  , processData: false 
	 		  });
	 	
	 	}); // end of $("button#updateImage").on("click", function (event) {}---------------------------
	}); // end of $(document).ready(function() {})---------------
	
	// 함수 정의
	
	// 수정하기		
	function goUpdate() {
		
		$("select[name=fk_department_id]").prop('disabled',false);
	    $("select[name=fk_rank_id]").prop('disabled',false);
		
		// *** 필수입력사항에 모두 입력이 되었는지 검사한다. *** //
		let b_FlagRequiredInfo = false;
		
		$("input.requiredInfo").each(function(index, item) {
			const data = $(item).val().trim();
			if(data == ""){
				console.log("item : " + data);
				alert("*표시된 필수입력사항은 모두 입력하셔야 합니다.");
				b_FlagRequiredInfo = true;
				return false; // each문에서 for문에서 break; 와 같은 기능이다.
			}
		});
		
		if(b_FlagRequiredInfo) {
			console.log("b_FlagRequiredInfo : " + b_FlagRequiredInfo);
			return;
		}
		
		// *** 성별이 선택 되었는지 검사한다. *** //
		const genderCheckedLength = $("input:radio[name='gender']:checked").length;
		
		if(genderCheckedLength == 0){
			alert("성별을 선택하셔야 합니다.");
			console.log("genderCheckedLength : " + genderCheckedLength);
			return; // 종료
		}
		
		
		const frm = document.updateFrm;
		frm.action = "<%= ctxPath%>/emp/updateEmpEnd.bts";
		frm.method = "POST";
		frm.submit();
		
		
	}// end of function goUpdate()--------------------------------
	
	function getEmpImgName() {
		
		imgname = $("input#img_name").val();
	}
	
</script>
<div id="tbl_regEmp">
<c:set var="emp" value="${requestScope.loginuser}"/>
	<form name="updateImgFrm" id="updateImgFrm" action="<%= ctxPath%>/emp/updateImg.bts" method="post" enctype="multipart/form-data" role="form">
		<table id="tblEmpUpdate">
		<tr>
			<td><h2>내 정보수정<br><br></h2></td>
		</tr>
		<tr>
			<td><strong>사진</strong></td>
			<td><input type="hidden" name="emp_no" id="emp_no" value="${emp.pk_emp_no}" /></td>
			<td style="align:center;">
				<img id="empProfile">
				<%-- <img id="empProfile" src="<%= ctxPath%>/resources/images/nol.png"> --%>
				<%-- <img id="empProfile" src="<%= ctxPath%>/resources/files/${emp.img_name}"> --%>
			</td>
			<td style="padding-left: 20px;"><input type="file" name="attach" id="attach" />
			<br><button type="button" style="margin-top: 30px;" id="updateImage" class="btn btn-primary">사진변경</button></td>
		</tr>
		</table>
	</form>
	<form name="updateFrm" enctype="multipart/form-data">
	<table id="tblEmpUpdate">
		<tr>
			<td><input type="hidden" id="img_name" name="img_name" value="${emp.img_name}"/></td>
		</tr>
		
		<tr>
			<th id="th_title"><strong>이름&nbsp;</strong><span id="star">*</span></th>
			<td><input required type="text" class="requiredInfo" id="emp_name" name="emp_name" size="5" placeholder="이름" style="width: 100px;" value="${emp.emp_name}" /></td>
		</tr>
		<tr>
			<th id="th_title"><label for="pk_emp_no">사번&nbsp;<span id="star">*</span></label></th>
			<td>
				<input required type="text" class="requiredInfo" id="pk_emp_no" name="pk_emp_no" size="20"  maxlength='16' value="${emp.pk_emp_no}" readonly/>
			</td>    
		</tr>
		<tr>
			<th id="th_title"><label for="emp_pwd">비밀번호&nbsp;<span id="star">*</span></label></th>
			<td><input type="password" class="requiredInfo" id="emp_pwd" name="emp_pwd" size="20" maxlength="20" required autoComplete="off" />&nbsp;(영문 대소문자/숫자/특수문자 모두 조합, 8자~16자)<br><span class="error" style="margin-left: 200px;">암호가 올바르지 않습니다.</span></td>
		</tr>
		<tr>
			<th id="th_title"><label for="pwdCheck">비밀번호확인&nbsp;<span id="star">*</span></label></th>
			<td><input type="password" class="requiredInfo" id="pwdCheck" size="20" maxlength="20" required autoComplete="off" /><span class="error">암호가 일치하지 않습니다.</span></td>
		</tr>
		<tr>
			<th id="th_title"><strong>부서</strong> &nbsp;<span id="star">*</span></th>
			<td>
				<select name="fk_department_id" id="fk_department_id" style="height: 26px;" >
			         <option value="">부서 선택</option>
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
			<th id="th_title"><strong>직위</strong> &nbsp;<span id="star">*</span></th>
			<td>
				<select name="fk_rank_id" id="fk_rank_id" style="height: 26px;" >
			         <option value="">직위 선택</option>
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
			<th id="th_title">우편번호 &nbsp;<span id="star">*</span></th>
		    <td>
		       <input required type="text" class="requiredInfo" id="postcode" name="postcode" size="5" placeholder="우편번호" values="addr" style="width: 100px;" />
		       &nbsp;&nbsp;
		       <img id="zipcodeSearch" src="<%=ctxPath %>/resources/images/member/btn_zipcode.gif" style="cursor: pointer;" />
		    </td>
		</tr>
		<tr>
			<th id="th_title">주소 &nbsp;<span id="star">*</span></th>
			<td>
				<input class="my-1" class="requiredInfo" required type="text" id="address" name="address"  size="50" placeholder="주소" value="${emp.address}"/><br>
				<input class="my-1" type="text" id="detailaddress" name="detailaddress" size="50" placeholder="상세주소" value="${emp.detailaddress}" /><br>
				<input class="my-1" type="text" id="extraaddress" name="extraaddress" size="50" placeholder="참고항목" value="${emp.extraaddress}" />                
			</td>
		</tr>
		<tr>
			<th id="th_title">일반전화</th>
			<td>
				<select id="num1" name="num1">
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
				<input id="num2" name="num2" type="text" size="5" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" />&nbsp;-&nbsp; 
				<input id="num3" name="num3" type="text" size="5" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" />
			</td>
		</tr>
		<tr>
			<th id="th_title">휴대전화 &nbsp;<span id="star">*</span></th>
	        <td>
	        	<select id="hp1" name="hp1">
					<option value="010">010</option>
				</select>&nbsp;-&nbsp;
				<input class="requiredInfo" required id="hp2" name="hp2" type="text" size="5" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">&nbsp;-&nbsp; 
				<input class="requiredInfo" required id="hp3" name="hp3" type="text" size="5" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
			 	<span class="error">올바른 휴대전화 번호가 아닙니다.</span>
			 </td>
	     </tr>
		<tr>
			<th id="th_title">이메일 &nbsp;<span id="star">*</span></th>
			<td>
				<input type="email" class="requiredInfo" id="uq_email" name="uq_email" size="20" maxlength="20" required placeholder="example@gmail.com" value="${emp.uq_email }" readonly/>
			</td>
		</tr>            
		 <tr>
	        <th id="th_title">생년월일&nbsp;<span id="star">*</span></th> 
	        <td>
	           <input class="requiredInfo" type="text" id=birthday name="birthday" value="${emp.birthday}" readonly/>
	        </td>
	      </tr>
		<tr>
	        <th id="th_title">성별&nbsp;<span id="star">*</span></th>
	        <td>
	           <input type="radio" id="male" name="gender" value="1" /><label for="male" style="margin-left: 2%;">남자</label>
	           <input type="radio" id="female" name="gender" value="2" style="margin-left: 10%;" /><label for="female" style="margin-left: 2%;">여자</label>
	           <input type="hidden" id="gen" name="gen" value="${emp.gender}" />
	           <input type="hidden" id="img_name" name="img_name" value="${emp.img_name}" />
	        </td>
	    </tr>
		
	</table>
	</form>
	<div style="padding-left: 200px;">
		<button class="btn btn-info" id="btn_register" style="border: solid lightgray 2px;" onclick="goUpdate();">저장</button>
		<!-- <button class="btn btn-default" id="btn_cancel" style="border: solid lightgray 2px;">취소</button> -->
	</div>
	
	 	
</div>
