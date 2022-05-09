<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
 	String ctxPath = request.getContextPath();
	//     /bts
%>


<style type="text/css">

</style>

<script type="text/javascript">

  $(document).ready(function(){

	  
	  
  }); // end of  $(document).ready(function(){})--------------
  
</script>	

<div class="container_myAtt">
	<div class="row">
    	<%-- 연차내역 시작 --%>
        <div class="col-md-8 mx-3">
        	<div id="title"><span style="font-size: 30px; margin-bottom: 20px; font-weight: bold;">나의 출퇴근기록</span></div>
        	
        	<div id="vacCnt">
        		<div id="selectYear">
	        		<form name="vacCntFrm" style="margin-top: 20px;">
		        		<span style="">년도 :</span>
					    <select name="year" id="year" style="height: 26px;">
					         <option value="2022">2022</option>
					         <option value="2021">2021</option>
					    </select>
					    <button type="button" id="btn_vacCnt" class="btn btn-secondary btn-sm" onclick="goSearchMyVacCnt()">검색</button>
			        </form>
			     </div>
			     <table class="table" id="tbl_commute">
					  <thead class="thead-light">
					    <tr style="text-align: center;">
					      <th style="width:20%; text-align: center;">연월일</th>
					      <th style="width:20%; text-align: center;">출근시간</th>
					      <th style="width:20%; text-align: center;">퇴근시간</th>
					      <th style="width:20%; text-align: center;">근무시간</th>
					    </tr>
					  </thead>
					  <tbody>
					  	<c:forEach var="cmt" items="${requestScope.cmtList}" varStatus="status">
							<tr style="text-align: center;">
						      <td style="width:20%; text-align: center;">${cmt.regdate }</td>
						      <td style="width:20%; text-align: center;">${cmt.in_time }</td>
						      <td style="width:20%; text-align: center;">${cmt.out_time }</td>
						      <td style="width:20%; text-align: center;">${cmt.total_worktime } 시간</td>
						    </tr>
					    </c:forEach>
					  </tbody>
				  </table>
				  <input type="hidden" value="${sessionScope.loginuser.pk_emp_no}" id="pk_emp_no">
        	</div>
        </div>
        <%-- 연차내역 시작 --%>
	

	</div>
</div>