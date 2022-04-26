<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
   String ctxPath = request.getContextPath();
  //       /board 
%>

<!-- <div class="container"> -->
<div class="container-fluid">
<div class="row">
<div class="col-md-10 offset-md-1">

  <div id="myCarousel" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <ol class="carousel-indicators">
    <%-- 
      <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
      <li data-target="#myCarousel" data-slide-to="1"></li>
      <li data-target="#myCarousel" data-slide-to="2"></li>
    --%> 
       <c:forEach items="${requestScope.imgfilenameList}" varStatus="status">
          <c:if test="${status.index == 0}">
             <li data-target="#myCarousel" data-slide-to="${status.index}" class="active"></li>
          </c:if>
          <c:if test="${status.index > 0}">
             <li data-target="#myCarousel" data-slide-to="${status.index}"></li>
          </c:if>
       </c:forEach> 
    </ol>

    <!-- Wrapper for slides -->
    <div class="carousel-inner">
      <%-- 
      <div class="carousel-item active">
        <img src="image/image1.jpg" alt="야외 풀장" class="d-block w-100">
      </div>

      <div class="carousel-item">
        <img src="image/image2.jpg" alt="디럭스룸" class="d-block w-100">
      </div>
    
      <div class="carousel-item">
        <img src="image/image3.jpg" alt="레스토랑" class="d-block w-100">
      </div>
      --%>
       <c:forEach var="filename" items="${requestScope.imgfilenameList}" varStatus="status">
          <c:if test="${status.index == 0}">
             <div class="carousel-item active">
               <img src="<%= ctxPath%>/resources/images/${filename}" class="d-block w-100">
             </div>   
          </c:if>
          <c:if test="${status.index > 0}">
             <div class="carousel-item">
               <img src="<%= ctxPath%>/resources/images/${filename}" class="d-block w-100">
               </div>
          </c:if>
       </c:forEach>       
    </div>

    <!-- Left and right controls -->
    <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
      <span class='carousel-control-prev-icon' aria-hidden='true'></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
      <span class='carousel-control-next-icon' aria-hidden='true'></span>
      <span class="sr-only">Next</span>
    </a>
  </div>
  
</div>  
</div>
</div>  