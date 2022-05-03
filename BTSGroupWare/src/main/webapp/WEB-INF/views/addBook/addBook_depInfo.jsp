<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
   String ctxPath = request.getContextPath();
  //       /board 
%>
<script type="text/javascript">



</script>

<style type="text/css">

#myTable {
  width: 100%; 
  border: 1px solid #ddd; 
  font-size: 18px; 
}

#myTable th, #myTable td {
  text-align: left; 
  padding: 12px; 
}

#myTable tr {

  border-bottom: 1px solid #ddd;
}

  


</style>

<title>부서상세정보</title>

<ul class="nav nav-tabs">
  <li class="nav-item">
    <a class="nav-link active" data-toggle="tab" href="#qwe">부서정보</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" data-toggle="tab" href="#asd">부서원 목록</a>
  </li>
</ul>
<div class="tab-content">
  <div class="tab-pane fade show active" id="qwe">
    <table id="myTable">
	  <tr>
	    <th style="width:40%;">부서명</th>
	    <th style="width:40%;">영업본부</th>
	  </tr>
	  <tr>
	    <td>부서메일아이디</td>
	    <td>bts@jjangjjangman.com</td>
	  </tr>
	  <tr>
	    <td>부서코드</td>
	    <td>A0502</td>
	  </tr>
	  <tr>
	    <td>상위부서</td>
	    <td>임원진</td>
	  </tr>
	  <tr>
	    <td>하위부서</td>
	    <td>영업팀,마케팅팀,서비스팀</td>
	  </tr>
	</table>
  </div>
  <div class="tab-pane fade" id="asd">
  <table id="myTable">
    <tr>
	    <th style="width:40%;">부장</th>
	    <th style="width:40%;">정환모 부장</th>
	  </tr>
	  <tr>
	    <td>차장</td>
	    <td>김민정 차장</td>
	  </tr>
	  <tr>
	    <td>과장</td>
	    <td>임유리 과장</td>
	  </tr>
	  <tr>
	    <td>대리</td>
	    <td>김지은 대리</td>
	  </tr>
	  <tr>
	    <td>주임</td>
	    <td>성문길 주임</td>
	  </tr>
	  <tr>
	    <td>사원</td>
	    <td>문병윤 사원</td>
	  </tr>
	 </table>
  </div>
  
</div>