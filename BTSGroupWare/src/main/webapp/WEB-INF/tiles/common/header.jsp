<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.net.InetAddress"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- ======= #27. tile1 중 header 페이지 만들기 (#26.번은 없다 샘이 장난침.) ======= --%>
<%
   String ctxPath = request.getContextPath();

   // === #172. (웹채팅관련3) === 
   // === 서버 IP 주소 알아오기(사용중인 IP주소가 유동IP 이라면 IP주소를 알아와야 한다.) ===
   InetAddress inet = InetAddress.getLocalHost(); 
   String serverIP = inet.getHostAddress();
   
 // System.out.println("serverIP : " + serverIP);
 // serverIP : 211.238.142.72
   
   // String serverIP = "211.238.142.72"; 만약에 사용중인 IP주소가 고정IP 이라면 IP주소를 직접입력해주면 된다.
   
   // === 서버 포트번호 알아오기   ===
   int portnumber = request.getServerPort();
 // System.out.println("portnumber : " + portnumber);
 // portnumber : 9090
   
   String serverName = "http://"+serverIP+":"+portnumber; 
 // System.out.println("serverName : " + serverName);
 // serverName : http://211.238.142.72:9090 
%>
    <!-- 상단 네비게이션 시작 -->
   <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top mx-4 py-3">
      <!-- Brand/logo --> 
      <a class="navbar-brand" href="<%= ctxPath %>/index.action" style="margin-right: 10%;"><img src="<%= ctxPath %>/resources/images/sist_logo.png" /></a>
      
      <!-- 아코디언 같은 Navigation Bar 만들기 -->
       <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
         <span class="navbar-toggler-icon"></span>
       </button>
      
      <div class="collapse navbar-collapse" id="collapsibleNavbar">
        <ul class="navbar-nav h5"> <%-- .h5 는 글자크기임 --%>  
           <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle text-info" href="#" id="navbarDropdown" data-toggle="dropdown">Home</a> 
                                           <%-- .text-info 는 글자색으로 청록색임 --%>  
              <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                 <a class="dropdown-item" href="<%= ctxPath %>/index.action">Home</a>
                 <a class="dropdown-item" href="<%= serverName%><%=ctxPath%>/chatting/multichat.action">웹채팅</a>
              </div>
           </li>
           
           <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle text-info" href="#" id="navbarDropdown" data-toggle="dropdown">게시판</a>  
              <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                 <a class="dropdown-item" href="<%=ctxPath%>/list.action">목록보기</a>
            <%-- <c:if test="${not empty sessionScope.loginuser}"> --%>
                 <a class="dropdown-item" href="<%=ctxPath%>/add.action">글쓰기</a>
            <%-- </c:if>  --%>
              </div>
           </li>
           
           <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle text-info" href="#" id="navbarDropdown" data-toggle="dropdown">로그인</a>  
              <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                 <c:if test="${empty sessionScope.loginuser}">
                    <a class="dropdown-item" href="#">회원가입</a>
                    <a class="dropdown-item" href="<%=ctxPath%>/login.action">로그인</a>
                 </c:if>
                             
               <c:if test="${not empty sessionScope.loginuser}">
                  <a class="dropdown-item" href="#">나의정보</a>
                  <a class="dropdown-item" href="<%=ctxPath%>/logout.action">로그아웃</a>
               </c:if>
              </div>
           </li>
           
           <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle text-info" href="#" id="navbarDropdown" data-toggle="dropdown">인사관리</a>  
              <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                 <a class="dropdown-item" href="<%=ctxPath%>/emp/empList.action">직원목록</a>
                 <a class="dropdown-item" href="<%=ctxPath%>/emp/chart.action">통계차트</a>
              </div>
           </li>
           
     <%-- <c:if test="${sessionScope.loginuser.gradelevel == 10 }">  --%>
           <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle text-info" href="#" id="navbarDropdown" data-toggle="dropdown">제품등록(다중파일첨부)</a>  
              <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                 <a class="dropdown-item" href="#">제품등록</a>
                 <a class="dropdown-item" href="#">제품입고</a>
              </div>
           </li>
    <%-- </c:if>  --%>
           
          <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle text-info" href="#" id="navbarDropdown" data-toggle="dropdown">제품정보</a>  
              <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                 <a class="dropdown-item" href="#">제품목록</a>
              </div>
          </li>
          
          <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle text-info" href="#" id="navbarDropdown" data-toggle="dropdown">일정관리</a>  
              <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                 <a class="dropdown-item" href="<%=ctxPath%>/schedule/scheduleManagement.action">일정관리</a>
              </div>
          </li>
          
        </ul>
      </div>
      
      <!-- === #49. 로그인이 성공되어지면 로그인되어진 사용자의 이메일 주소를 출력하기 === -->
      <c:if test="${not empty sessionScope.loginuser}">
         <div style="float: right;">
           <span style="color: navy; font-weight: bold;">${sessionScope.loginuser.email}</span> 님 로그인중.. 
         </div>
      </c:if>
         
   </nav>
   <!-- 상단 네비게이션 끝 -->
   

      <p class="h5" style="margin: auto">
         <marquee> [공지사항] 쌍용강북교육센터 C클래스 수강생 여러분들의 수료후 프로그래머 입사를 진심으로 기원합니다.</marquee>
        </p>

  