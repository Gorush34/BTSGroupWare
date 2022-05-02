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
      <a class="navbar-brand" href="<%= ctxPath %>/index.action" style="margin-right: 5%;"><span style="font-weight: bold;">BTSGroupware</span></a>
      
      <!-- 아코디언 같은 Navigation Bar 만들기 -->
       <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
         <span class="navbar-toggler-icon"></span>
       </button>
      
      
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
	    <ul class="navbar-nav mr-auto">
	       <%-- 전자결재 시작 --%>
	      <li class="nav-item">
	        <a class="nav-link " href="#" id="navbar" role="button" aria-expanded="false">
	          	전자결재
	        </a>
	      </li>
	      <%-- 전자결재 끝 --%>
	       
	      <%-- 메일 시작 --%>
	      <li class="nav-item">
	        <a class="nav-link" href="#" id="navbar" role="button" aria-expanded="false">
	        	메일함
	        </a>
	      </li>
	      <%--메일 끝 --%>
	      
	       <%--게시판 / 자료실 시작 --%>
	       <li class="nav-item">
	        <a class="nav-link" href="#" id="navbar" role="button" aria-expanded="false">
	          	게시판
	        </a>
	      </li>
	      <li class="nav-item ">
	        <a class="nav-link " href="#" id="navbar" role="button" aria-expanded="false">
	          	자료실
	        </a>
	      </li>
	      <%-- 게시판 / 자료실 끝 --%>
	      
	      <%-- 일정관리 / 자원관리 시작 --%>
	      <li class="nav-item">
	        <a class="nav-link" href="#" id="navbar" role="button" aria-expanded="false">
	          	일정관리
	        </a>
	      </li>
	      
	      <li class="nav-item">
	        <a class="nav-link" href="#" id="navbar" role="button" aria-expanded="false">
	          	자원관리
	        </a>
	      </li>
	      <%-- 일정 끝 --%>
	      
	      <%-- 근태관리 시작 --%>
	      <li class="nav-item">
	        <a class="nav-link" href="#" id="navbar" role="button" aria-expanded="false">
	          	근태관리
	        </a>
	      </li>
	      <%-- 근태관리 끝 --%>
	      
	      <%-- 주소록 / 조직도 시작 --%>
	      <li class="nav-item">
	        <a class="nav-link" href="#" id="navbar" role="button" aria-expanded="false">
	          	주소록
	        </a>
	      </li>
	      
	      <li class="nav-item">
	        <a class="nav-link" href="#" id="navbar" role="button" aria-expanded="false">
	          	조직도
	        </a>
	      </li>
	      <%-- 주소록 / 조직도 끝 --%>
	    </ul>
	    <form class="form-inline my-2 my-lg-0">
	      <input class="form-control mr-sm-2" type="search" placeholder="통합검색" aria-label="Search">
	      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
	    </form>
	  </div>
      
      <!-- === #49. 로그인이 성공되어지면 로그인되어진 사용자의 이메일 주소를 출력하기 === -->
      <c:if test="${not empty sessionScope.loginuser}">
         <div style="float: right;">
           <span style="color: navy; font-weight: bold;">${sessionScope.loginuser.uq_email}</span> 님 로그인중.. 
         </div>
      </c:if>
         
   </nav>
   <!-- 상단 네비게이션 끝 -->

  