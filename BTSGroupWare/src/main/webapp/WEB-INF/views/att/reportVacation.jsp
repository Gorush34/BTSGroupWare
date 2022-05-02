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
    <%-- 공가/경조신청서 작성 시작 --%>
    <div class="row" style="padding-left:15px;">
        <div class="col-xs-12" style="width:90%;">
        	<div id="title" style="margin-bottom: 20px;">
        		<span style="font-size: 24px; margin-bottom: 20px; margin-right:20px; font-weight: bold;">공가 /연가 신청서 작성하기</span>
        		<div>
	        		<span style="margin-bottom: 5px; padding-left: 20px; font-size:14px;"> 1. 사원이 휴가를 사용하고자 할 때에는 최소 1일전에 휴가 신청서를 제출하여 휴가 시행일 전, 전결자의 승인을 얻어야 한다.</span>
	        		<br>
	        		<span style="margin-bottom: 5px; padding-left: 20px; font-size:14px;"> 2. 전항의 예외로, 긴급을 요하는 휴가시(병원방문, 가족병원 등) 반드시 이를 입증할 수 있는 입증자료를 첨부하여 소속 팀장 및 본부장의 승인을 득해야 한다.</span>	
        		</div>
        	</div>
        	
        	<table class="table" id="tbl_reportVacation">
				    <tr style="text-align: center;">
				      <th class="th_title" style="text-align: center;">결재자 사번</th>
				      <td style="text-align: left;">80000801</td>
				      <th class="th_title" style="text-align: center;">결재자 성명</th>
				      <td style="text-align: left;">김민정</td>
				    </tr>
				    
				    <tr style="text-align: center;">
				      <th class="th_title" style="text-align: center;">소속</th>
				      <td style="width:35%; text-align: left;">인사과</td>
				      <th class="th_title" style="text-align: center;">직위/직책</th>
				      <td style="width:25%; text-align: left;">사원/팀원</td>
				    </tr>
				    
				    <tr style="text-align: center;">
				      <th class="th_title" style="text-align: center;">사번</th>
				      <td style="text-align: left;">80000888</td>
				      <th class="th_title" style="text-align: center;">성명</th>
				      <td style="text-align: left;">정환모</td>
				    </tr>
				    
				    <tr style="text-align: center;">
				      <th class="th_title" style="text-align: center;">연락처</th>
				      <td style="text-align: left;">010-1234-5678</td>
				    </tr>
				    
				    
					<tr style="text-align: center;">
				      <th class="th_title" style="text-align: center;">휴가구분</th>
				      <td colspan="3" style="text-align: center;">
				      	<div id="vac_sort_container" style="width: 80%; text-align: center; margin: 0 auto;">
					      	<table id="vac_sort" style="width: 100%;">
					      		<tr class="tr_gray">
						      		<th>일반휴가선택</th>
						      	</tr>
						      	<tr>
						      		<td>
						      			<input type="radio" id="van_common" name="van_common" value="vac_ban_morning">
						      			<label for="vac_ban_morning">반차(오전)</label>
						      			<input type="radio" id="van_common" name="van_common" value="vac_ban_afternoon">
						      			<label for="vac_ban_afternoon">반차(오후)</label>
						      			<input type="radio" id="van_common" name="van_common" value="vac_day">
						      			<label for="vac_day">연차</label>
						      			<input type="radio" id="van_common" name="van_common" value="vac_gift">
						      			<label for="vac_gift">포상휴가(장기근속 1일)</label>
						      		</td>
						      	</tr>	
						      	
						      	<tr>
						      		<td>
						      			<input type="radio" id="van_common" name="van_common" value="vac_instead_mor">
						      			<label for="vac_instead_mor">대체휴가 반차(오전)</label>
						      			<input type="radio" id="van_common" name="van_common" value="vac_instead_afternoon">
						      			<label for="vac_instead_afternoon">대체휴가 반차(오후)</label>
						      			<input type="radio" id="van_common" name="van_common" value="vac_instead_day">
						      			<label for="vac_instead_day">대체휴가</label>
						      			<input type="radio" id="van_common" name="van_common" value="vac_trainning">
						      			<label for="vac_trainning">훈련(1일)</label>
						      		</td>
						      	</tr>
						      	
						      	<tr class="tr_gray">
						      		<th>가족사랑 특별휴가-기념일</th>
						      	</tr>
						      	
						      	<tr>
						      		<td>
						      			<input type="radio" id="van_common" name="van_common" value="vac_my_birthday">
						      			<label for="vac_my_birthday">본인생일(오후반차)</label>
						      			<input type="radio" id="van_common" name="van_common" value="vac_marry">
						      			<label for="vac_marry">결혼기념일(오후반차)</label>
						      			<input type="radio" id="van_common" name="van_common" value="var_parent_birthday">
						      			<label for="var_parent_birthday">부모님 생신(오후반차)</label>
						      			<input type="radio" id="van_common" name="van_common" value="var_family_birthday">
						      			<label for="var_family_birthday">자녀 및 배우자생일(오후반차)</label>
						      		</td>
						      	</tr>
					      	</table>
				      	</div>
				      </td>
				    </tr>
				    
				    <tr style="text-align: center;">
				      <th class="th_title" style="width:20%; text-align: center;">희망휴가일수</th>
				      <td style="text-align: left;"><input type="text" id="vac_days" name="vac_days" />&nbsp;일</td>
				      <th class="th_title" style="width:20%; text-align: center;">휴가시작일</th>
				      <td style="text-align: left;"><input type="text" id="vac_startday" name="vac_startday" />
				      	<button type="button" class="btn btn-secondary btn-sm mr-3" id="btn_vac_cal" style="margin-bottom: 7px;">휴가일계산</button>

				      </td>
				    </tr>
				    
				    <tr style="text-align: center; " id="bold_hr">
				      <th class="th_title" style="text-align: center;">휴가일</th>
				      <td colspan="3" style="text-align: left;">365일</td>
				    </tr>
				    
				    <tr style="text-align: center; " id="bold_hr">
				      <th class="th_title" style="text-align: center;">증빙서류 제출</th>
				      <td colspan="3" style="text-align: left;">
				      	<input type="file" name="attach" id="attach" />
				      	<button type="button" class="btn btn-secondary btn-sm mr-3" id="btn_vac_certification">파일 첨부</button>
				      	<br>당일휴가시 필수항목 : 당일휴가 증빙서류를 꼭 첨부해주시기 바랍니다.
				      	<br>훈련휴가시 필수항목 : 훈련참여 증빙서류를 꼭 첨부해주시기 바랍니다.
				      </td>
				    </tr>
				    
				    <tr style="text-align: center; " id="bold_hr">
				      <th class="th_title" style="text-align: center;">휴가사유</th>
				      <td colspan="3" style="text-align: left;"><input type="text" id="vac_days" name="vac_days" style="width: 80%;"/>			    
				      	<br>포상휴가시 필수항목 : 포상휴가 사유 및 포상내용을 꼭 적어주시기 바랍니다.
				      	<br>대체휴가시 필수항목 : 대체휴가에 해당하는 날짜(기간) 및 사유, 휴가내용을 꼭 적어주시기 바랍니다.
				      	<br>그 외 휴가시 필수항목 : 휴가 사유 및 포상내용을 꼭 적어주시기 바랍니다.
				      </td>
				    </tr>
				    	
			</table>
			
		<div id="vac_button" style="text-align: center;">
			<button type="button" class="btn btn-secondary btn-sm mr-3" id="btn_vac_certification" style="margin-right: 20px; width:80px; height:30px;">신청하기</button>
			<button type="button" class="btn btn-secondary btn-sm mr-3" id="btn_vac_certification" style="margin-right: 20px; width:80px; height:30px;">목록보기</button>
				      	
		</div>	
		
        </div>
    </div>
    <%-- 공가/경조신청서 작성 끝 --%>
    
</div>