<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String ctxPath = request.getContextPath();
  //       /board 
%>



<title>주소록</title>

	<table id="Main_main_tbl">
		<tr>
			<td colspan="8" style="text-align: left;"><br><h2>${sessionScope.loginuser.emp_name} 의 주소록&nbsp;<!--  <button class="btn btn-info btn-sm" id="" style="border: solid lightgray 1.5px;" onclick="location.href='http://localhost:9090/bts/addBook/addBook_telAdd.bts'">추가</button>--></h2><br><br></td>
			<td>
				  <div class="d-flex align-items-center">
				    <form name="searchFrm">
					    <input class="form-control" type="text" name="searchWord" id="searchWord" value="" style="width:120px;" placeholder="이름으로 검색" aria-label="Search">
					    <input type="text" style="display: none;"/>
				    </form>
				    <button id="searchBtn" class="btn btn-outline-success flex-shrink-0" type="button" style="margin-bottom:10%;" onclick="goSearch()">검색</button>
				  </div>
			</td>
		</tr>
		<!--  
		<tr>
			<td colspan="6" style="text-align:left;"><button class="btn btn-default" id="fastadd" style="border: solid darkgray 2px;">빠른등록</button>
				<button class="btn btn-default" id="" style="border: solid darkgray 2px;">삭제</button>
			</td>
		</tr>
		<tr>
			<td colspan="7" style="text-align:left;">
				<div id="fassadd_input">
						<input type="text" style="border-radius: 10px; height: 35px;" placeholder="이름">
						<input type="text" style="border-radius: 10px; height: 35px;" placeholder="이메일">
						<input type="text" style="border-radius: 10px; height: 35px;" placeholder="휴대폰">
						<button class="btn btn-default" id="mini_btn" style="background-color:lightgray;">+</button>
						<button class="btn btn-default">상세정보추가</button>
				</div>
			</td>
		</tr>
		<tr>
		<td colspan="10">
			<ul class="nav nav-pills">
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn">전체</button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn">ㄱ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn">ㄴ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn">ㄷ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn">ㄹ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn">ㅁ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn">ㅂ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn">ㅅ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn">ㅇ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn">ㅈ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn">ㅊ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn">ㅋ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn">ㅌ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn">ㅍ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn">ㅎ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn">a-z</button></li>
			</ul>
		</td>
		</tr>
		-->
		<tr style="border: solid darkgray 2px; margin-left:2%">
			<td style="width:5%;"><input type="hidden" id="pk_addbook_no_${i.count}" name="pk_addbook_no_${i.count}" value="${adb.pk_addbook_no}" readonly /></td>
			<td style="width:13%;"><strong>이름</strong></td>
			<td style="width:13%;"><strong>직급</strong></td>
			<td style="width:22%;"><strong>휴대폰</strong></td>
			<td style="width:22%;"><strong>이메일</strong></td>
			<td style="width:13%;"><strong>회사</strong></td>
			<td style="width:22%;"><strong>회사전화</strong></td>
		</tr>
		<c:if test="${not empty (requestScope.adbList)}">
        <c:forEach var="adb" items="${requestScope.adbList}" varStatus="i">
		<tr>
			<td><input type="hidden" id="pk_addbook_no_${i.count}" name="pk_addbook_no_${i.count}" value="${adb.pk_addbook_no}" readonly /></td>
			<td><input type="text" class="form-control" style="text-align:center; border:none; " onclick="telUpdate(${i.count})" data-toggle="modal" data-target="#viewModal" onclick="modal_view('이름','부서','직급','이메일','휴대폰','회사','회사전화번호','회사주소','메모사항');" value="${adb.addb_name}" readonly></td>
			<td><input type="text" class="form-control" style="text-align:center; border:none;" onclick="telUpdate(${i.count})" data-toggle="modal" data-target="#viewModal" onclick="modal_view('이름','부서','직급','이메일','휴대폰','회사','회사전화번호','회사주소','메모사항');" value="${adb.ko_rankname}" readonly></td>
			<td><input type="text" class="form-control" style="text-align:center; border:none;" onclick="telUpdate(${i.count})" data-toggle="modal" data-target="#viewModal" onclick="modal_view('이름','부서','직급','이메일','휴대폰','회사','회사전화번호','회사주소','메모사항');" value="${adb.phone}" readonly></td>
			<td><input type="text" class="form-control" style="text-align:center; border:none;" onclick="telUpdate(${i.count})" data-toggle="modal" data-target="#viewModal" onclick="modal_view('이름','부서','직급','이메일','휴대폰','회사','회사전화번호','회사주소','메모사항');" value="${adb.email}" readonly></td>
			<td><input type="text" class="form-control" style="text-align:center; border:none;" onclick="telUpdate(${i.count})" data-toggle="modal" data-target="#viewModal" onclick="modal_view('이름','부서','직급','이메일','휴대폰','회사','회사전화번호','회사주소','메모사항');" value="${adb.companyname}" readonly></td>
			<td><input type="text" class="form-control" style="text-align:center; border:none;" onclick="telUpdate(${i.count})" data-toggle="modal" data-target="#viewModal" onclick="modal_view('이름','부서','직급','이메일','휴대폰','회사','회사전화번호','회사주소','메모사항');" value="${adb.com_tel}" readonly></td>
		</tr>
		</c:forEach>
		</c:if>
		<c:if test="${empty (requestScope.adbList)}">
        <tr>
           <td colspan="6" style="text-align:center;padding-top: 16%; padding-left: 16%;"><strong>새로운 연락처를 등록하세요</strong><br><br><button class="btn btn-info btn-sm" id="" style="border: solid lightgray 1.5px;" onclick="location.href='http://localhost:9090/bts/addBook/addBook_telAdd.bts'">연락처 추가</button></td>
        </tr>
        </c:if>
	</table>
	
	
	<%-- === #122. 페이지바 보여주기 === --%>
	<div align="center" style="border: solid 0px gray; width: 70%; margin: 20px auto;">
		${requestScope.pageBar}
	</div>
	
	<!-- 
			<div style="text-align:center; margin-top: 18%; ">
			<ul class="nav nav-pills justify-content-center"  >
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn"> 맨 앞 </button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn"> 1 </button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn"> 2 </button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn"> 3 </button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn"> 맨 뒤로 </button></li>
			</ul>
			</div>
		 -->	

			
	
	<!-- 연락처 수정 모달창 -->	
	<div class="modal fade" data-backdrop="static" id="viewModal">
	<div class="modal-dialog">
	<div class="modal-content">
	<div class="modal-header">
	<h4 class="modal-title" id="exampleModalLabel">연락처 수정</h4>
	</div>
	
	<div class="modal-body">
	<form name="updateFrm" action="<%=ctxPath%>/addBook/addBook_main_telUpdate_update.bts" method="POST" >
		<input type="hidden" class="form-control" id="pk_addbook_no" name="pk_addbook_no">
		
		
		<div class="form-group">
			<label for="recipient-name" class="control-label"><strong>이름*</strong></label>
			<input type="text" class="form-control requiredInfo" id="name" name="name" maxlength="3">
			<span class="error">이름을 입력해주세요.</span> 
			<span id="idcheckResult"></span>
		</div>
		
		<div class="form-group">
		<label for="recipient-name" class="control-label"><strong>부서*</strong></label>
			<select id="department" name="department" class="form-control requiredInfo">
			  <option value="700">--</option>
			  <option value="100">영업</option>
			  <option value="200">마케팅</option>
			  <option value="300">기획</option>
			  <option value="400">총무</option>
			  <option value="500">인사</option>
			  <option value="600">회계</option>
			</select>
		</div>
		
		<div class="form-group">
		<label for="recipient-name" class="control-label"><strong>직급*</strong></label>
			<select id="rank" name="rank" class="form-control requiredInfo">
			  <option value="90">--</option>
			  <option value="10">사원</option>
			  <option value="20">주임</option>
			  <option value="30">대리</option>
			  <option value="40">과장</option>
			  <option value="50">차장</option>
			  <option value="60">부장</option>
			  <option value="70">전무</option>
			  <option value="80">사장</option>
			</select>
		</div>
		
		<div class="form-group">
		<label for="recipient-name" class="control-label"><strong>이메일*</strong></label>
			<p>
				<input class="form-control requiredInfo" id="email" name="email" style="width:302px; margin-top:2%; display:inline;" type="text" maxlength="20">
				<input type="button" id="isExistIdCheck" class="duplicateCheck form-control" style="display:inline; width:158px;" onclick="isExistEmailCheck();" value="이메일중복확인" />
				<br>
				<span class="error">올바른 이메일 양식이 아닙니다.</span>
				<span id="emailCheckResult"></span>
			</p>
		</div>
		
		<div class="form-group" style="display:inline;">
		<label for="recipient-name" class="control-label"><strong>휴대폰*</strong></label>
			<p>
        	<select class="form-control" id="hp1" name="hp1" style="width:143px; display:inline;" >
				<option value="010">010</option>
			</select>&nbsp;-&nbsp;
			<input class="form-control requiredInfo" id="hp2" name="hp2" style="width:143px; display:inline;" type="text" size="5" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">&nbsp;-&nbsp; 
			<input class="form-control requiredInfo" id="hp3" name="hp3" style="width:143px; display:inline;" type="text" size="5" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
			</p>
		</div>
		
		<div class="form-group">
		<label for="recipient-name" class="control-label"><strong>회사</strong></label>
		<input type="text" class="form-control" id="company_name" name="company_name">
		</div>
		
		<div class="form-group" >
		<label for="recipient-name" class="control-label"><strong>회사전화번호</strong></label>
		<div style="display:inline;">
		<p>
		<select class="form-control" id="num1" name="num1" style="width:143px; display:inline; ">
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
		<input class="form-control" id="num2" name="num2" style="width:143px; display:inline; " type="text" size="5" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">&nbsp;-&nbsp; 
		<input class="form-control" id="num3" name="num3" style="width:143px; display:inline; " type="text" size="5" maxlength="4" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
		</p>
		</div>
		</div>
		
		<div class="form-group">
		<label for="recipient-name" class="control-label"><strong>회사주소</strong></label>
		<input type="text" class="form-control" id="company_address" name="company_address">
		</div>
		
		
		<div class="form-group">
		<label for="recipient-name" class="control-label"><strong>메모사항</strong></label>
		<input type="text" class="form-control" id="memo" name="memo">
		</div>
	</form>
	</div>
	
	<div class="modal-footer">
	<button type="button" class="btn btn-primary" id="insert_customer_btn_1" onclick="update()">수정</button>
	<button type="button" class="btn btn-danger" id="insert_customer_btn_2" onclick="deletebtn()">삭제</button>
	<button type="button" class="btn btn-success" data-dismiss="modal">닫기</button>
	</div>
	</div>
	</div>
	</div>
	
<script type="text/javascript">

$( document ).ready( function() {
<%-- 빠른등록 만들지말지..
	$( "div#fassadd_input" ).slideToggle().hide();
	  $( "button#fastadd" ).click( function() {
	    $( "div#fassadd_input" ).slideToggle();
	  });
--%> 
	
<%--
	  - true: 사용함 상태로 바꾸기, 속성값 disabled="disabled"  추가 된다.

	  - false: 사용안함 상태로 바꾸기, 속성값 disabled="disabled"  삭제 된다.
--%>
	
	
	
	  



	  
	  
}); // end of $( document ).ready( function()

	/* -------------- 유효성 검사 시작 --------------  */
	
	let b_flagEmailDuplicateClick = false;
	// 가입하기 버튼 클릭시 "이메일중복확인" 을 클릭했는지 클릭안했는지를 알아보기 위한 용도이다.

	/* 이름 유효성검사 */
	$("span.error").hide();	
		$("input#name").focus();
		
		// 아이디가 name 제약 조건 
		$("input#name").blur(() => { 
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
		function update() {
			
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
			
			const frm = document.updateFrm;
			frm.action = "<%= ctxPath%>/addBook/addBook_main_telUpdate_update.bts"
			frm.method = "POST";
			frm.submit();
		
		}
		
		
		/* -------------- 유효성 검사 끝 --------------  */
	
	function telUpdate(i)	{
		$.ajax({
			url:"<%= ctxPath%>/addBook/addBook_main_telUpdate_select.bts",
			data:{"pk_addbook_no" : $("input#pk_addbook_no_"+i).val()},
			type: "post",
			dataType: 'json',
			success : function(json) {
				
				var a; // 부서 select
				var b; // 직급 select
				
				switch (json.department) {
					case "영업": a=100; break;
					case "마케팅": a=200; break;
					case "기획": a=300; break;
					case "총무": a=400; break;
					case "인사": a=500; break;
					case "회계": a=600; break;
					case "--": a=700; break;
				}
				
				switch (json.rank) {
					case "사원": b=10; break;
					case "주임": b=20; break;
					case "대리": b=30; break;
					case "과장": b=40; break;
					case "차장": b=50; break;
					case "부장": b=60; break;
					case "전무": b=70; break;
					case "사장": b=80; break;
					case "--": b=70; break;
				}
				
				$("input#pk_addbook_no").val(json.pk_addbook_no)
				$("input#name").val(json.name)
				$("select#department").val(a).prop("selected",true);
				$("select#rank").val(b).prop("selected",true);
				$("input#email").val(json.email)
			//	$("input#email1").val(json.email1)
			//	$("input#email2").val(json.email2)
				$("input#phone").val(json.phone)
				$("input#hp2").val(json.hp2)
				$("input#hp3").val(json.hp3)
				$("input#company_name").val(json.company_name)
				$("input#company_tel").val(json.company_tel)
				$("select#num1").val(json.num1).prop("selected",true);
				$("input#num2").val(json.num2)
				$("input#num3").val(json.num3)
				$("input#company_address").val(json.company_address)
				$("input#memo").val(json.memo)
			},
			error: function(request){
				
			}
		});
	}
	
	
	function deletebtn() {
		
		if(!confirm("정말 삭제하시겠습니까?")){  
			
		}
		else { 
			const frm = document.updateFrm;
		    frm.action = "<%=ctxPath%>/addBook/addBook_delete.bts"
		    frm.method = "post"
	    	frm.submit();
		}
		
	}
	
	
	function goSearch()	{
		const frm = document.searchFrm;
	    frm.action = "<%=ctxPath%>/addBook/addBook_main.bts"
	    frm.method = "get"
    	frm.submit();
	}

	
	

</script>


