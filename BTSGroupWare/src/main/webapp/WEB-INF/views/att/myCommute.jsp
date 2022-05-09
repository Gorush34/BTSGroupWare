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

	  $("button#btn_myCommute").click(function(){
		  goSearch();
	  });
	  
	//검색시 검색조건 및 검색어 값 유지시키기
	if( ${not empty paraMap} ) {  // 또는 if( ${paraMap != null} ) { 
		$("select#year").val("${paraMap.year}");
		$("input#month").val("${paraMap.month}");
	}
	  
  }); // end of  $(document).ready(function(){})--------------
  
  // Function Declaration
  
  function goSearch() {
			
	  const frm = document.myCommuteFrm;
	  frm.method = "GET";
	  frm.action = "<%= ctxPath%>/att/myCommute.bts";
	  frm.submit();
		
  }// end of function goSearch() {}-----------------------
  
</script>	

<div class="container_myAtt">
	<div class="row">
    	<%-- 출퇴근내역 시작 --%>
        <div class="col-md-8 mx-3">
        	<div id="title"><span style="font-size: 30px; margin-bottom: 20px; font-weight: bold;">나의 출퇴근기록</span></div>
        	
        	<div id="vacCnt">
        		<div id="selectYear">
	        		<form name="myCommuteFrm" style="margin-top: 20px;">
		        		<span style="">기간 검색</span>
					    <select name="year" id="year" style="height: 26px;">
					    	 <option value="">연도</option>
					         <option value="2022">2022</option>
					         <option value="2021">2021</option>
					    </select>
					    <select name="month" id="month" style="height: 26px;">
					         <option value="">월</option>
					         <option value="01">1월</option>
					         <option value="02">2월</option>
					         <option value="03">3월</option>
					         <option value="04">4월</option>
					         <option value="05">5월</option>
					         <option value="06">6월</option>
					         <option value="07">7월</option>
					         <option value="08">8월</option>
					         <option value="09">9월</option>
					         <option value="10">10월</option>
					         <option value="11">11월</option>
					         <option value="12">12월</option>
					    </select>
					    <input type="hidden" value="${sessionScope.loginuser.pk_emp_no}" id="pk_emp_no">
					    <button type="button" id="btn_myCommute" class="btn btn-secondary btn-sm" onclick="goSearchMyCommute()">검색</button>
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
					  	<c:if test="${ not empty requestScope.cmtList}">
					  	<c:forEach var="cmt" items="${requestScope.cmtList}" varStatus="status">
							<tr style="text-align: center;">
						      <td style="width:20%; text-align: center;">${cmt.regdate }</td>
						      <td style="width:20%; text-align: center;">${cmt.in_time }</td>
						      <td style="width:20%; text-align: center;">${cmt.out_time }</td>
						      <td style="width:20%; text-align: center;">${cmt.total_worktime } 시간</td>
						    </tr>
					    </c:forEach>
					    </c:if>
					    <c:if test="${ empty requestScope.cmtList}">
					    	<td colspan="4" style="width:20%; text-align: center;">출퇴근 기록이 없습니다.</td>
					    </c:if>
					  </tbody>
				  </table>
				  
				  <%-- === #122. 페이지바 보여주기 === --%>
				  <div align="center" style="border: solid 0px gray; width: 70%; margin: 20px auto;">
					  ${requestScope.pageBar}
				  </div>
				  
        	</div>
        </div>
        <%-- 출퇴근내역 끝 --%>
	

	</div>
</div>