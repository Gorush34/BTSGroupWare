<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<%
	String ctxPath = request.getContextPath();
%>   
 <!-- Bootstrap core CSS -->
<link href="/docs/5.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

    <!-- Favicons -->
<link rel="apple-touch-icon" href="/docs/5.1/assets/img/favicons/apple-touch-icon.png" sizes="180x180">
<link rel="icon" href="/docs/5.1/assets/img/favicons/favicon-32x32.png" sizes="32x32" type="image/png">
<link rel="icon" href="/docs/5.1/assets/img/favicons/favicon-16x16.png" sizes="16x16" type="image/png">
<link rel="manifest" href="/docs/5.1/assets/img/favicons/manifest.json">
<link rel="mask-icon" href="/docs/5.1/assets/img/favicons/safari-pinned-tab.svg" color="#7952b3">
<link rel="icon" href="/docs/5.1/assets/img/favicons/favicon.ico">
<meta name="theme-color" content="#7952b3">


    <style>
    a:hover{
	font-weight: bold;
	color: black;
	}
    
    .small, small {
    margin-left: 15px;
	}
    
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }
      
      a{color: black; text-decoration: none !important; cursor: pointer;}
    </style>

    
    <!-- Custom styles for this template -->
    <link href="offcanvas.css" rel="stylesheet">
  </head>
  <body class="bg-light">
    

<main class="container">
  <div class="d-flex align-items-center p-3 my-3 text-white bg-purple rounded shadow-sm" style="background-color: darkblue; ">
    <div class="lh-1" style="text-align: center;">
      <h1 class="h6 mb-0 text-white lh-1" style="font-size:22px; font-weight: bold; margin-left: 30px; ">게시판</h1>
    </div>
  </div>

	<div class="my-3 p-3 bg-body rounded shadow-sm">
    <h6 class="border-bottom pb-2 mb-0">목록</h6>
    <div class="d-flex text-muted pt-3">
      <svg class="bd-placeholder-img flex-shrink-0 me-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 32x32" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#007bff"/><text x="50%" y="50%" fill="#007bff" dy=".3em">32x32</text></svg>

      <a class="pb-3 mb-0 small lh-sm border-bottom" href="<%= request.getContextPath()%>/notice/list.bts">
        <strong class="d-block text-gray-dark">공지사항</strong>
        	우리 회사의 소식이나 정보 및 공지사항 입니다. <span style="font-weight: bold;">필히 확인 부탁드립니다.</span>
      </a>
    </div>
    <div class="d-flex text-muted pt-3">
      <svg class="bd-placeholder-img flex-shrink-0 me-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 32x32" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#e83e8c"/><text x="50%" y="50%" fill="#e83e8c" dy=".3em">32x32</text></svg>
      <a class="pb-3 mb-0 small lh-sm border-bottom" href="<%= request.getContextPath()%>/fileboard/list.bts">
        <strong class="d-block text-gray-dark">자료실</strong>
        	우리 회사의 자료실 입니다. 각 부서별로 필요한 자료를 올리거나 받아주십시오.
      </a>
    </div>
    <div class="d-flex text-muted pt-3">
      <svg class="bd-placeholder-img flex-shrink-0 me-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 32x32" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#6f42c1"/><text x="50%" y="50%" fill="#6f42c1" dy=".3em">32x32</text></svg>

      <a class="pb-3 mb-0 small lh-sm border-bottom" href="<%= request.getContextPath()%>/board/list.bts">
        <strong class="d-block text-gray-dark">자유게시판</strong>
        	누구나 이용가능한 자유게시판 입니다. 자유롭게 이용해주십시오.
      </a>
    </div>
  </div>

  <div class="my-3 p-3 bg-body rounded shadow-sm">
    <h6 class="border-bottom pb-2 mb-0">최신글</h6>
    <div class="d-flex text-muted pt-3">
      <svg class="bd-placeholder-img flex-shrink-0 me-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 32x32" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#007bff"/><text x="50%" y="50%" fill="#007bff" dy=".3em">32x32</text></svg>

      <a class="pb-3 mb-0 small lh-sm border-bottom">
        <strong class="d-block text-gray-dark">관리자</strong>
        	공지사항공지사항공지사항공지사항공지사항공지사항공지사항공지사항공지사항공지사항공지사항공지사항공지사항공지사항공지사항공지사항
      </a>
    </div>
    <div class="d-flex text-muted pt-3">
      <svg class="bd-placeholder-img flex-shrink-0 me-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 32x32" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#e83e8c"/><text x="50%" y="50%" fill="#e83e8c" dy=".3em">32x32</text></svg>

      <a class="pb-3 mb-0 small lh-sm border-bottom">
        <strong class="d-block text-gray-dark">총무팀</strong>
        	자료입니다.자료입니다.자료입니다.자료입니다.자료입니다.자료입니다.자료입니다.자료입니다.자료입니다.자료입니다.자료입니다.자료입니다.
      </a>
    </div>
    <div class="d-flex text-muted pt-3">
      <svg class="bd-placeholder-img flex-shrink-0 me-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 32x32" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#6f42c1"/><text x="50%" y="50%" fill="#6f42c1" dy=".3em">32x32</text></svg>

      <a class="pb-3 mb-0 small lh-sm border-bottom">
        <strong class="d-block text-gray-dark">사원</strong>
        	잘부탁드립니다.잘부탁드립니다.잘부탁드립니다.잘부탁드립니다.잘부탁드립니다.잘부탁드립니다.잘부탁드립니다.잘부탁드립니다.잘부탁드립니다.잘부탁드립니다.잘부탁드립니다.
      </a>
    </div>
    <div class="d-flex text-muted pt-3">
      <svg class="bd-placeholder-img flex-shrink-0 me-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 32x32" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#6f42c1"/><text x="50%" y="50%" fill="#6f42c1" dy=".3em">32x32</text></svg>

      <a class="pb-3 mb-0 small lh-sm border-bottom">
        <strong class="d-block text-gray-dark">사원</strong>
        	잘부탁드립니다.잘부탁드립니다.잘부탁드립니다.잘부탁드립니다.잘부탁드립니다.잘부탁드립니다.잘부탁드립니다.잘부탁드립니다.잘부탁드립니다.잘부탁드립니다.잘부탁드립니다.
      </a>
    </div>
    <div class="d-flex text-muted pt-3">
      <svg class="bd-placeholder-img flex-shrink-0 me-2 rounded" width="32" height="32" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: 32x32" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#6f42c1"/><text x="50%" y="50%" fill="#6f42c1" dy=".3em">32x32</text></svg>

      <a class="pb-3 mb-0 small lh-sm border-bottom">
        <strong class="d-block text-gray-dark">사원</strong>
        	잘부탁드립니다.잘부탁드립니다.잘부탁드립니다.잘부탁드립니다.잘부탁드립니다.잘부탁드립니다.잘부탁드립니다.잘부탁드립니다.잘부탁드립니다.잘부탁드립니다.잘부탁드립니다.?
      </a>
    </div>
  </div>


</main>


    <script src="/docs/5.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>

      <script src="offcanvas.js"></script>
      
      </body>
      