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
		}
		
		$("button#btnIdFind").click(function(){
			func_idFind();
		});
		
		$("input#uq_email").keydown(function(event){
			
			if(event.keyCode == 13) { // 엔터를 했을 경우
				func_idFind();	
			}
		});
		
		
	}); 

	// Function Declaration
	function func_idFind(){
      
		var emp_name = $("input#emp_name").val() == undefined ? "" : $("input#emp_name").val().trim();
		var uq_email = $("input#uq_email").val() == undefined ? "" : $("input#uq_email").val().trim();
		
        if(emp_name.trim()=="") {
           alert("성함을 입력하세요!!");
          $("input#emp_name").val(""); 
          $("input#emp_name").focus();
          return; // 종료 
        }
      
        if(uq_email.trim()=="") {
          alert("이메일을 입력하세요!!");
          $("input#uq_email").val(""); 
          $("input#uq_email").focus();
          return; // 종료 
        }
        
        
        const frm = document.idFindFrm;
        frm.action = "<%= ctxPath%>/idFindEnd.bts";
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
                            <div class="col-lg-6 d-none d-lg-block bg-login-image" id="image"><img src="<%= ctxPath%>/resources/images/login_two.png" title="" /></div>
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4">BTSGroupware</h1>
                                    </div>
                                    <form name="idFindFrm" class="idFindFrm">
                                        <div class="form-group">
                                            <input type="text" class="form-control form-control-user"
                                                name="emp_name" id="emp_name" value="" aria-describedby="emp_name"
                                                placeholder="사원명">
                                        </div>
                                        <div class="form-group">
                                            <input type="text" class="form-control form-control-user"
                                                name="uq_email" id="uq_email" value="" placeholder="이메일">
                                        </div>
                                        <button type="button" class="btn btn-primary btn-user btn-block" id="btnIdFind">
                                            	ID 찾기
                                        </button>
                                        <hr>
                                        <div class="center" id="div_findResult" style="text-align: center;">
	                                       	<c:if test="${not empty requestScope.pk_emp_no}">
	                                         	사원번호 :&nbsp;<span style="color: red; font-size: 16pt; font-weight: bold;">${requestScope.pk_emp_no}</span> 
	                                    	</c:if>
	                                    	
	                                    	<c:if test="${empty requestScope.pk_emp_no}">
	                                        	 <span style="color: red; font-size: 16px; font-weight: bold;">입력하신 정보와 일치하는 사원번호가 없습니다.</span> 
	                                    	</c:if>
                                        </div>
                                    </form>
                                    <hr>
                                    <div class="text-center">
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

</body>

</html>