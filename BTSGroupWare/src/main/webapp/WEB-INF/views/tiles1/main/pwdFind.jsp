<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- === #24. tiles 를 사용하는 레이아웃1 페이지 만들기 === --%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
	String ctxPath = request.getContextPath();
%>    
    
<!DOCTYPE html>
<html>
<head>
<title>로그인</title>

  <!-- Required meta tags -->
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"> 
  <meta name="description" content="">
  <meta name="author" content="">
  
  <!-- Bootstrap CSS -->
  <link rel="stylesheet" type="text/css" href="<%= ctxPath%>/resources/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 
  
  <!-- 직접 만든 CSS 1 -->
  <link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/style1.css" />
  
  <!-- Optional JavaScript -->
  <script type="text/javascript" src="<%= ctxPath%>/resources/js/jquery-3.6.0.min.js"></script>
  <script type="text/javascript" src="<%= ctxPath%>/resources/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script> 

  <!-- 구글 폰트를 쓰기 위한 링크 -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Nanum+Myeongjo&family=Noto+Sans+KR&display=swap" rel="stylesheet">


	<style type="text/css">
	
		body {
			margin-top: 100px;
		}
	
		div#image > img {
			max-width: 475px;
			min-height: 538px;
			border-radius: 0.25rem;
		}
	
	</style>

<script type="text/javascript">
	
	

	$(document).ready(function(){
		
		const method = "${requestScope.method}";
		
		console.log("method =>" + method);
		
		
		if(method == "GET") {
			$("div#div_findResult").hide();
		}
		else if( method == "POST") {
			$("div#div_findResult").show();
			
			$("input#pk_emp_no").val("${requestScope.pk_emp_no}");
			$("input#uq_email").val("${requestScope.uq_email}");
		}
		
		if(${requestScope.sendMailSuccess == true}) {
			$("div#div_btnFind").hide();
		}	 
		
		$("button#btnPwdFind").click(function(){
			func_pwdFind();
		});
		
		$("input#uq_email").keydown(function(event){
			
			if(event.keyCode == 13) { // 엔터를 했을 경우
				func_pwdFind();	
			}
		});
		
		// 인증하기
		$("button#btnConfirmCode").click(function(){
			
			const frm = document.verifyCertificationFrm;
			
			frm.userCertificationCode.value = $("input#input_confirmCode").val();
			frm.pk_emp_no.value = $("input#pk_emp_no").val();
			
			frm.action = "<%= ctxPath%>/emp/verifyCertification.bts";
			frm.method = "post";
			frm.submit();
			
		});
		
		 
	}); // end of $(document).ready(function(){})------------------

	// Function Declaration
	function func_pwdFind(){
      
		var pk_emp_no = $("input#pk_emp_no").val() == undefined ? "" : $("input#pk_emp_no").val().trim();
		var uq_email = $("input#uq_email").val() == undefined ? "" : $("input#uq_email").val().trim();
		
        if(pk_emp_no.trim()=="") {
           alert("사번을 입력하세요!!");
          $("input#pk_emp_no").val(""); 
          $("input#pk_emp_no").focus();
          return; // 종료 
        }
      
        if(uq_email.trim()=="") {
          alert("이메일을 입력하세요!!");
          $("input#uq_email").val(""); 
          $("input#uq_email").focus();
          return; // 종료 
        }
        
        
        const frm = document.pwdFindFrm;
        frm.action = "<%= ctxPath%>/pwdFindEnd.bts";
		frm.method = "post";
		frm.submit();
		
	} // end of function func_idFind()-------------
	
</script>

</head>

<body class="bg-gradient-primary">

    <div class="container">

        <!-- Outer Row -->
        <div class="row justify-content-center">

            <div class="col-xl-10 col-lg-12 col-md-9">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-6 d-none d-lg-block bg-login-image" id="image"><img src="<%= ctxPath%>/resources/images/login_main.jpg" title="" /></div>
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4">BTSGroupware</h1>
                                    </div>
                                    <form name="pwdFindFrm" class="pwdFindFrm">
                                        <div class="form-group">
                                            <input type="text" class="form-control form-control-user"
                                                name="pk_emp_no" id="pk_emp_no" value="" aria-describedby="pk_emp_no"
                                                placeholder="사번">
                                        </div>
                                        <div class="form-group">
                                            <input type="text" class="form-control form-control-user"
                                                name="uq_email" id="uq_email" value="" placeholder="이메일">
                                        </div>
                                        <button type="button" class="btn btn-primary btn-user btn-block" id="btnPwdFind">
                                            	비밀번호 찾기
                                        </button>
                                        <hr>
                                        <div class="my-3" id="div_findResult">
									        <p class="text-center">
									        	<c:if test="${requestScope.isUserExist == false }">
									        		<span style="color: red;">사용자 정보가 없습니다.</span>
									        	</c:if>   
									        	
									        	<c:if test="${requestScope.isUserExist == true && requestScope.sendMailSuccess == true }">
										        	 <span style="font-size: 10pt;">인증코드가 ${requestScope.uq_email}로 발송되었습니다.</span><br>
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
                                    <hr>
                                    <div class="text-center">
                                    	<a href="<%= ctxPath%>/idFind.bts">ID 찾기</a><span>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;</span>
                                    	<a href="<%= ctxPath%>/login.bts">로그인 화면으로</a><br>
                                        	문의 : 인사과(정환모 / 8887)
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>
    
    <form name="verifyCertificationFrm">
	<input type="hidden" name="userCertificationCode">
	<input type="hidden" name="pk_emp_no" value="${requestScope.pk_emp_no}">
	
</form>

</body>

</html>