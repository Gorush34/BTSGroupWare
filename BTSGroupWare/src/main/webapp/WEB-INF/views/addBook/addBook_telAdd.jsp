<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
   String ctxPath = request.getContextPath();

%>




<style type="text/css">

#tbl_telAdd { 
		border-collapse: separate;
		border-spacing: 0 12px;
	}
	





</style>

<title>연락처추가페이지</title>

	<div id="telAdd_main_tbl" style="text-align:center;">
		<form name="updateImgFrm" id="updateImgFrm" action="<%= ctxPath%>/emp/updateImg.bts" method="post" enctype="multipart/form-data" role="form">
		<table id="tblEmpUpdate" style="">	
			<tr>
				<td><h2>주소록 추가<br><br></h2><input type="hidden" id="registeruser" value="${sessionScope.loginuser.pk_emp_no}"></td>
			</tr>
			<tr>
				<td><strong>사진</strong></td>
				<td style="text-align:left;"><img id="empProfile" src="<%= ctxPath%>/resources/images/nol.png" style="width:60%;"><br></td>
				<td>	
					<input type="file" name="attach" id="attach" style="display:inline;"/><br><br>
					<button type="button" style=" display:inline;" id="updateImage" class="btn btn-primary">사진변경</button> 
				</td>
			</tr>
		</table>
		</form>
		<form name="telAddFrm"> 
		<table id="tbl_telAdd">
		<tr>
			<td><strong>이름*</strong></td>
			<td>
				<input type="text" class="form-control requiredInfo" id="addb_name" name="addb_name" placeholder="이름">
				<span class="error">이름 을 입력해주세요.</span> 
			</td>
			
		</tr>
		<tr>
			<td><strong>부서*</strong></td>
			<td>
				<select id="department" name="department" class="form-control requiredInfo">
				  <c:if test="${not empty requestScope.ab_depList}">
				   	  <c:forEach var="dep" items="${requestScope.ab_depList}" varStatus="i">
							<option value="${dep.pk_dep_no}">${dep.ko_depname}</option>
					  </c:forEach>
				  </c:if>	
				</select>
			</td>
		</tr>
		<tr>
			<td><strong>직급*</strong></td>
			<td>
				<select id="rank" name="rank" class="form-control requiredInfo">
				  <c:if test="${not empty requestScope.ab_rankList}">
				   	  <c:forEach var="rank" items="${requestScope.ab_rankList}" varStatus="i">
							<option value="${rank.pk_rank_no}">${rank.ko_rankname}</option>
					  </c:forEach>
				  </c:if>
				</select>
				
			</td>
		</tr>
		<tr>
			<td><strong>이메일*</strong></td>
			<td>
				<p>
					<input class="form-control requiredInfo" id="email" name="email" style="width:260px; margin-top:2%; display:inline;" type="text" maxlength="20">
					<input type="button" id="isExistIdCheck" class="duplicateCheck form-control" style="display:inline; width:158px;" onclick="isExistEmailCheck();" value="이메일중복확인" />
					<br>
					<span class="error">올바른 이메일 양식이 아닙니다.</span>
					<span id="emailCheckResult"></span>
				</p>
			</td>
		</tr>
		<tr>
			<td><strong>휴대폰*</strong></td>
			<td>
				<select class="form-control requiredInfo" id="hp1" name="hp1" style="width:130px; display:inline;" >
					<option value="010">010</option>
				</select>&nbsp;-&nbsp;
				<input class="form-control requiredInfo" id="hp2" name="hp2" style="width:130px; display:inline;" type="text" size="5" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">&nbsp;-&nbsp; 
				<input class="form-control requiredInfo" id="hp3" name="hp3" style="width:130px; display:inline;" type="text" size="5" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
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
	

<script type="text/javascript">

	
	$( document ).ready( function() {
		
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
	
	}); // end of $( document ).ready( function()------------------------------------------
	
	/* -------------- 유효성 검사 시작 --------------  */

	let b_flagEmailDuplicateClick = false;
	// 가입하기 버튼 클릭시 "이메일중복확인" 을 클릭했는지 클릭안했는지를 알아보기 위한 용도이다.

	/* 이름 유효성검사 */
	$("span.error").hide();	
		$("input#addb_name").focus();
		
		// 아이디가 name 제약 조건 
		$("input#addb_name").blur(() => { 
			const $target = $(event.target);
			
			const name = $target.val().trim();
			if(name == ""){
				// 입력하지 않거나 공백만 입력했을 경우
				$("table#telAdd_main_tbl :input").prop("disabled", true);
				$target.prop("disabled", false);
			//	$target.next().show();
			// 	또는
				$target.parent().find(".error").show();
			
				$target.focus();
				
				
			} else {
				// 공백이 아닌 글자를 입력했을 경우
				$("table#telAdd_main_tbl :input").prop("disabled", false);
				//	$target.next().hide();
				// 	또는
				$target.parent().find(".error").hide();
			}
		}); // end of $("input#emp_name").blur(() => {})-------------------------------------------
		
		
		// 아이디가 email 제약 조건 
		$("input#email").blur(() => {
			const $target = $(event.target);
			
	        const regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i); 
	        // 이메일 정규표현식 객체 생성
		    
	         const bool = regExp.test($target.val());  
	        
			if(!bool){ // !bool == false 이메일이 정규표현식에 위배된 경우
				// 이메일이 정규표현식에 위배된 경우 
				$("table#telAdd_main_tbl :input").prop("disabled", true);
				$target.prop("disabled", false);
				
			//	$target.next().show();
			// 	또는
				$target.parent().find(".error").show();
			
				$target.focus();
				
			} else {
				// bool == true 이메일이 정규표현식에 맞는 경우
				$("table#telAdd_main_tbl :input").prop("disabled", false);
				
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
				$("table#telAdd_main_tbl :input").prop("disabled", true);
				  $target.prop("disabled", false);
			
			//	$target.next().show();
			// 	또는
				$target.parent().find(".error").show();
				
				$target.focus();
			} else {
				// bool == true 국번이 정규표현식에 맞는 경우
				$("table#telAdd_main_tbl :input").prop("disabled", false);
				
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
				$("table#telAdd_main_tbl :input").prop("disabled", true);
				  $target.prop("disabled", false);
			
			//	$target.next().show();
			// 	또는
				$target.parent().find(".error").show();
				
				$target.focus();
			} else {
				// bool == true 국번이 정규표현식에 맞는 경우
				$("table#telAdd_main_tbl :input").prop("disabled", false);
				
				//	$target.next().hide();
				// 	또는
				$target.parent().find(".error").hide();
			}
		});  // end of $("input#hp3").blur(() => {})----------------------------------
		

		// 이메일 중복여부 검사하기
		function isExistEmailCheck(){
			b_flagEmailDuplicateClick = true;
		 	// 가입하기 버튼 클릭시 "아이디중복확인" 을 클릭했는지 클릭안했는지를 알아보기 위한 용도이다.
		 	
		 	// 입력하고자 하는 이메일이 데이터베이스 테이블에 존재하는지 존재하지 않는지 알아와야한다.
		 	/*
	     	    Ajax (Asynchronous JavaScript and XML)란?
	       		==> 이름만 보면 알 수 있듯이 '비동기 방식의 자바스크립트와 XML' 로서
	       	    Asynchronous JavaScript + XML 인 것이다.
	       	    한마디로 말하면, Ajax 란? Client 와 Server 간에 XML 데이터를 JavaScript 를 사용하여 비동기 통신으로 주고 받는 기술이다.
	       	    하지만 요즘에는 데이터 전송을 위한 데이터 포맷방법으로 XML 을 사용하기 보다는 JSON 을 더 많이 사용한다.
	       	    참고로 HTML은 데이터 표현을 위한 포맷방법이다.
	       	    그리고, 비동기식이란 어떤 하나의 웹페이지에서 여러가지 서로 다른 다양한 일처리가 개별적으로 발생한다는 뜻으로서, 
	       	    어떤 하나의 웹페이지에서 서버와 통신하는 그 일처리가 발생하는 동안 일처리가 마무리 되기전에 또 다른 작업을 할 수 있다는 의미이다.
	        */
			// ==== jQuery 를 이용한 Ajax (Asynchronous JavaScript and XML)처리하기 ====
		 		$.ajax({
		 			url:"<%= ctxPath%>/addBook/emailDuplicateCheck.bts",
		 			data:{"email":$("input#email").val()
		 				}, // data 는 MyMVC/member/emailDuplicateCheck.up로 전송해야할 데이터를 말한다.
		 			type: "post" , // type 은 생략하면 "get" 이다.
					dataType: "json",
					success: function(json){
		 			
		 			const regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i); 
		 			const bool = regExp.test($("input#email").val());  	
		 			
		 				if(json.isExist) {	// 입력한 $("input#uq_email").val() 값이 이미 사용중이라면
		 					$("span#emailCheckResult").html($("input#email").val()+"은 중복된 ID 이므로 사용 불가합니다.").css("color","red");
		 					$("input#email").val("");
		 				} else if( !bool ) {
		 					
		 				} else {	// 입력한 $("input#uq_email").val() 값이 DB테이블(tbl_member)에 존재하지 않는 경우라면
		 					$("span#emailCheckResult").html($("input#email").val()+"은 사용 가능합니다.").css("color","green");
		 				}
	                   
		 			}, 
		 			error: function(request, status, error){
		 				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		 			}
		 			
		 		}); // end of $.ajax({})
		 	
		} // end of function isExistEmailCheck(){}---------------------------------------
		
	
		// 가입하기		
		function goTelAdd() {
			
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
			  
			  
			// *** 이메일 중복확인을 클릭했는지 검사한다. *** //
			if(!b_flagEmailDuplicateClick) {
				// "이메일중복확인" 을 클릭했는지 클릭안했는지를 알아보기위한 용도임.
				alert("이메일중복확인 클릭하여 email 중복검사를 하세요!!");
				return; // 종료
			}
			
			const frm = document.telAddFrm;
		    frm.action = "<%=ctxPath%>/addBook/addBook_telAdd_insert.bts"
		    frm.method = "post"
		    frm.submit();
			
			
			
		}// end of 	function goRegister()--------------------------------
		
	
		/* -------------- 유효성 검사 끝 --------------  */		
			

</script>	
	

