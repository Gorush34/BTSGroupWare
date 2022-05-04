<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String ctxPath = request.getContextPath();
    //    /MyMVC
%>

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

<!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/style.css" />

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script>

<script type="text/javascript">
	
	$(document).ready(function(){
		
		const method = "${requestScope.method}"; 
		// console.log("method => " + method);
		
		if( method == "GET" ) {
			$("div#div_findResult").hide();
		}
		else if(method == "POST") {
			$("div#div_findResult").show();
			
			$("input#userid").val("${requestScope.userid}");
			$("input#email").val("${requestScope.email}");
			
			if(${requestScope.sendMailSuccess == true}) {
				$("div#div_btnFind").hide();
			}		
		
		}
		
		// 찾기
		$("button#btnFind").click(function(){
			goFind();
		});
		
		$("input#email").bind("keydown", function(event){
			// keydown시 발생하는 함수
			if(event.keyCode == 13) { // 암호입력란에 엔터를 했을 경우
				goFind();
			}
		});
		
		// 인증하기
		$("button#btnConfirmCode").click(function(){
			
			const frm = document.verifyCertificationFrm;
			
			frm.userCertificationCode.value = $("input#input_confirmCode").val();
			frm.userid.value = $("input#userid").val();
			
			frm.action = "<%= ctxPath%>/verifyCertification.up";
			frm.method = "post";
			frm.submit();
			
		});
		
		
		
	}); // $(document).ready(function(){})-------------------------
	
	// Function Declaration
	function goFind() {
		// 아이디 및 이메일에 대한 유효성 검사(정규표현식)은 생략함(전에 배우던 거에 있음)
		const frm = document.pwdFindFrm;
		frm.action = "<%= ctxPath%>/pwdFind.up";
		frm.method = "post"; 
		frm.submit(); // "POST" 방식으로 보내준다
	} // end of function goFind()-------------------------------

</script>



<form name="pwdFindFrm">
   
   <ul style="list-style-type: none">
         <li style="margin: 25px 0">
            <label for="userid" style="display: inline-block; width: 90px">아이디</label>
            <input type="text" name="userid" id="userid" size="25" placeholder="ID" autocomplete="off" required />
         </li>
         <li style="margin: 25px 0">
            <label for="email" style="display: inline-block; width: 90px">이메일</label>
            <input type="text" name="email" id="email" size="25" placeholder="abc@def.com" autocomplete="off" required />
         </li>
   </ul>
   
   <div class="my-3" id="div_btnFind">
    <p class="text-center">
       <button type="button" class="btn btn-success" id="btnFind">찾기</button>
    </p>
   </div>
   
   <div class="my-3" id="div_findResult">
        <p class="text-center">
        	<c:if test="${requestScope.isUserExist == false }">
        		<span style="color: red;">사용자 정보가 없습니다.</span>
        	</c:if>   
        	
        	<c:if test="${requestScope.isUserExist == true && requestScope.sendMailSuccess == true }">
	        	 <span style="font-size: 10pt;">인증코드가 ${requestScope.email}로 발송되었습니다.</span><br>
	             <span style="font-size: 10pt;">인증코드를 입력해주세요.</span><br>
	             <input type="text" name="input_confirmCode" id="input_confirmCode" required />
	             <br><br>
	             <button type="button" class="btn btn-info" id="btnConfirmCode">인증하기</button>
        	</c:if>
           
            <c:if test="${requestScope.isUserExist == true && requestScope.sendMailSuccess == false }">
        		<span style="color: red;">메일 발송이 실패했습니다.</span>
        	</c:if> 
        </p>
   </div>
   
</form>


<form name="verifyCertificationFrm">
	<input type="hidden" name="userCertificationCode">
	<input type="hidden" name="userid">
</form>
 