<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
 	String ctxPath = request.getContextPath();
	//     /board
%>

<style type="text/css">

</style>

<div class="container_myAtt">
    <div class="row">
    	<%-- 연차내역 시작 --%>
        <div class="col-md-6">
        	<div id="title"><span style="font-size: 30px; margin-bottom: 20px; font-weight: bold;">공가 / 경조신청</span></div>
        	
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
			     <table class="table" id="tbl_vacCnt">
					  <thead class="thead-light">
					    <tr style="text-align: center;">
					      <th style="width:20%; text-align: center;">년도</th>
					      <th style="width:20%; text-align: center;">전체연차</th>
					      <th style="width:20%; text-align: center;">사용연차</th>
					      <th style="width:20%; text-align: center;">잔여연차</th>
					      <th style="width:20%; text-align: center;">사용한 대체휴가</th>
					    </tr>
					  </thead>
					  <tbody>
						<tr style="text-align: center;">
					      <td style="width:20%; text-align: center;">${requestScope.leaveVO.regdate}</td>
					      <td style="width:20%; text-align: center;">${requestScope.leaveVO.total_vac_days}</td>
					      <td style="width:20%; text-align: center;">${requestScope.leaveVO.use_vac_days}</td>
					      <td style="width:20%; text-align: center;">${requestScope.leaveVO.rest_vac_days}</td>
					      <td style="width:20%; text-align: center;">${requestScope.leaveVO.instead_vac_days}</td>
					    </tr>
					  </tbody>
				  </table>
        	</div>
        </div>
        <%-- 연차내역 시작 --%>
        
        <%-- 공가/ 경조신청서 시작 --%>
        <div class="col-md-6">
        
        </div>
        <%-- 공가/ 경조신청서 끝 --%>
    </div>
    
    <%-- 공가/경조신청내역 시작 --%>
    <div class="row" style="padding-left:15px;">
        <div class="col-xs-12" style="width:90%;">
        	<div id="title" style="margin-bottom: 20px;">
        		<span style="font-size: 24px; margin-bottom: 20px; font-weight: bold;">공가 / 경조신청내역</span>
        		<br>
        		<span style="margin-bottom: 20px; "> ※ 현재 시스템에 표기된 연자일수는 관리의 편의상 <b>회계연도</b> 기준으로 계산되었으며, <b>퇴사 시</b> 입사일 기준으로 <b>재정산</b> 합니다.</span>
        	</div>
        	
        	<table class="table" id="tbl_vacList">
				  <thead class="thead-light">
				    <tr style="text-align: center;">
				      <th style="width:7%; text-align: center;">순번</th>
				      <th style="width:10%; text-align: center;">부서</th>
				      <th style="width:10%; text-align: center;">상신자사번</th>
				      <th style="width:7%; text-align: center;">상신자</th>
				      <th style="width:10%; text-align: center;">공가명</th>
				      <th style="width:10%; text-align: center;">일수</th>
				      <th style="width:18%; text-align: center;">휴가기간</th>
				      <th style="width:18%; text-align: center;">결재상황</th>
				      <th style="width:10%; text-align: center;">최종상태</th>
				    </tr>
				  </thead>
				  <tbody>
				  <c:forEach var="myAtt" items="${requestScope.myAttList}" begin="${requestScope.idx.startIdx}" end="${requestScope.idx.endIdx}" step="1">
					<tr style="text-align: center;">
				      <td style="width:7%; text-align: center;">${myAtt.pk_att_num}</td>
				      <td style="width:10%; text-align: center;">${myAtt.ko_depname}</td>
				      <td style="width:10%; text-align: center;">${myAtt.fk_emp_no}</td>
				      <td style="width:7%; text-align: center;">${myAtt.emp_name}</td>
				      <td style="width:14%; text-align: center;">${myAtt.att_sort_korname}</td>
				      <td style="width:10%; text-align: center;">${myAtt.vacation_days}일</td>
				      <td style="width:16%; text-align: center;">${myAtt.leave_start}&nbsp;~&nbsp;${myAtt.leave_end}</td>
				      <td style="width:16%; text-align: center;">
				      	<div id="dms_status" style="width: 80%; text-align: center; margin: 0 auto;">
					      	<table id="vac_dms" style="width: 100%;">
					      		<thead>
						      		<tr>
							      		<th>결재자</th>
						      		</tr>
					      		</thead>
					      		<tbody>
						      		<tr>
							      		<td>${myAtt.managername}(${myAtt.manager})</td>
						      		</tr>
						      		<tr>
							      		<td>
							      		<c:if test="${myAtt.approval_status eq 0}">
							      		결재대기
							      		</c:if>
							      		<c:if test="${myAtt.approval_status eq 1}">
							      		<span style="color:red;">반려</span>
							      		</c:if>
							      		<c:if test="${myAtt.approval_status eq 2}">
							      		<span style="color:blue;">결재완료</span>
							      		</c:if>							      		
							      		</td>
						      		</tr>
						      	</tbody>
					      	</table>
				      	</div>
				      </td>
				      <td style="width:10%; text-align: center;">
					      <c:if test="${myAtt.approval_status eq 0}">
			      		    결재대기
			      		  </c:if>
			      		  <c:if test="${myAtt.approval_status eq 1}">
			      		  <span style="color:red;">반려</span>
			      		  </c:if>
			      		  <c:if test="${myAtt.approval_status eq 2}">
			      		  <span style="color:blue;">결재완료</span>
			      		  </c:if>
				      </td>
				    </tr>
				    </c:forEach>
				  </tbody>
				  
			</table>
			
			<%-- === #122. 페이지바 보여주기 === --%>
		    <div align="center" style="border: solid 0px gray; width: 70%; margin: 20px auto;">
			  ${requestScope.pageBar}
		    </div>
        </div>
    </div>
    <%-- 공가/경조신청내역 끝 --%>
    
</div>