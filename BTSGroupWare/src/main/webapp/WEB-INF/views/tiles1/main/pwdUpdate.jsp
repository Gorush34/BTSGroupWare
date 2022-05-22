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
		
		$("button#btnUpdate").click(function(){
					
			const emp_pwd = $("input#emp_pwd").val();
			const emp_pwd2 = $("input#emp_pwd2").val();
			
			const regExp = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
		    // 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성
			
			const bool = regExp.test(emp_pwd);   
				  
			  if(!bool) { // 암호가 정규표현식에 위배된 경우 
				  alert("암호는 8글자 이상 15글자 이하의 영문자, 숫자, 특수문자를 포함해야 합니다!");
				  $("input#emp_pwd").val("");
				  $("input#emp_pwd2").val("");
				  return; // 종료
				  
			  }
			  else if(bool && emp_pwd != emp_pwd2){ // 암호가 정규표현식에 맞지만 변경암호와 확인암호가 불일치시
				  alert("변경하려는 암호와 확인암호가 일치하지 않습니다!");
				  $("input#emp_pwd").val("");
				  $("input#emp_pwd2").val("");
				  return; // 종료
			  }
			  else {
				  const frm = document.pwdUpdateEndFrm;
				  frm.action = "<%= ctxPath%>/pwdUpdateEnd.bts";
				  frm.method= "post";
				  frm.submit();
				  
			  }
			
		});
		
		 
	}); // end of $(document).ready(function(){})------------------

	
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
                                    <form name="pwdUpdateEndFrm" class="pwdUpdateEndFrm">
                                        <div class="form-group">
                                            <input type="password" class="form-control form-control-user"
                                                name="emp_pwd" id="emp_pwd" value="" aria-describedby="emp_pwd"
                                                placeholder="새암호">
                                        </div>
                                        <div class="form-group">
                                            <input type="password" class="form-control form-control-user"
                                                name="emp_pwd2" id="emp_pwd2" value="" aria-describedby="emp_pwd"
                                                placeholder="새암호확인">
                                        </div>
                                        <input type="hidden" name="pk_emp_no" value="${requestScope.pk_emp_no}">
                                        
                                        <c:if test="${requestScope.method == 'GET'}">
											<div id="div_btnUpdate" align="center">
									           <button type="button" class="btn btn-primary btn-user btn-block" id="btnUpdate">
                                            	비밀번호 변경하기
                                        		</button>
										    </div>
									    </c:if>   
                                        <hr>
                                        <div class="my-3" id="div_findResult">
									        <p class="text-center">
									        	<c:if test="${requestScope.method == 'POST' && requestScope.n == 1 }">
													<div id="div_updateResult" align="center">
												    	사원번호 ${requestScope.pk_emp_no}님의 암호가 변경되었습니다.<br/>
												    </div>
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
	<input type="hidden" name="pk_emp_no">
	
</form>

</body>

</html>