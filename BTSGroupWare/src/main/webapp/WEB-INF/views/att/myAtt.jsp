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
					      <td style="width:20%; text-align: center;">2022</td>
					      <td style="width:20%; text-align: center;">17</td>
					      <td style="width:20%; text-align: center;">3</td>
					      <td style="width:20%; text-align: center;">14</td>
					      <td style="width:20%; text-align: center;">2</td>
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
					<tr style="text-align: center;">
				      <td style="width:7%; text-align: center;">2</td>
				      <td style="width:10%; text-align: center;">인사과</td>
				      <td style="width:10%; text-align: center;">80000888</td>
				      <td style="width:7%; text-align: center;">정환모</td>
				      <td style="width:10%; text-align: center;">연차</td>
				      <td style="width:10%; text-align: center;">365일</td>
				      <td style="width:18%; text-align: center;">2022-05-02 ~ 2023-05-02</td>
				      <td style="width:18%; text-align: center;">
				      	<div id="dms_status" style="width: 80%; text-align: center; margin: 0 auto;">
					      	<table id="vac_dms" style="width: 100%;">
					      		<thead>
						      		<tr>
							      		<th>결재1</th>
							      		<th>결재2</th>
						      		</tr>
					      		</thead>
					      		<tbody>
						      		<tr>
							      		<td>김민정(80000801)</td>
							      		<td>문병윤(80000800)</td>
						      		</tr>
						      		<tr>
							      		<td>반려</td>
							      		<td>-</td>
						      		</tr>
						      	</tbody>
					      	</table>
				      	</div>
				      </td>
				      <td style="width:10%; text-align: center;"><span style="color:red;">반려</span></td>
				    </tr>
				    
				    <tr style="text-align: center;">
				      <td style="width:7%; text-align: center;">1</td>
				      <td style="width:10%; text-align: center;">인사과</td>
				      <td style="width:10%; text-align: center;">80000888</td>
				      <td style="width:7%; text-align: center;">정환모</td>
				      <td style="width:10%; text-align: center;">연차</td>
				      <td style="width:10%; text-align: center;">1일</td>
				      <td style="width:18%; text-align: center;">2022-04-22 ~ 2022-04-22</td>
				      <td style="width:18%; text-align: center;">
				      	<div id="dms_status" style="width: 80%; text-align: center; margin: 0 auto;">
					      	<table id="vac_dms" style="width: 100%;">
					      		<thead>
						      		<tr>
							      		<th>결재1</th>
							      		<th>결재2</th>
						      		</tr>
					      		</thead>
					      		<tbody>
						      		<tr>
							      		<td>김민정(80000801)</td>
							      		<td>문병윤(80000800)</td>
						      		</tr>
						      		<tr>
							      		<td>결재완료</td>
							      		<td>결재완료</td>
						      		</tr>
						      	</tbody>
					      	</table>
				      	</div>
				      </td>
				      <td style="width:10%; text-align: center;"><span style="color:blue;">결재완료</span></td>
				    </tr>
				  </tbody>
			</table>
        </div>
    </div>
    <%-- 공가/경조신청내역 끝 --%>
    
</div>