<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
 	String ctxPath = request.getContextPath();
	//     /board
%>

<style type="text/css">

</style>

<script type="text/javascript">
	// 휴가일수
	var vacDay = "";
	// 휴가시작일
	let strDate = "";
	// 휴가종료일
	var endDay = "";

	$(function() {
        //모든 datepicker에 대한 공통 옵션 설정
        var thisDate = new Date();
        var thisYear = thisDate.getFullYear();        //해당 연
        var thisMonth = thisDate.getMonth() + 1;    //해당 월
 
        $.datepicker.setDefaults({
            dateFormat: 'yy-mm-dd'         //Input Display Format 변경
            ,showOtherMonths: true         //빈 공간에 현재월의 앞뒤월의 날짜를 표시
            ,showMonthAfterYear:true     //년도 먼저 나오고, 뒤에 월 표시
            ,changeYear: true             //콤보박스에서 년 선택 가능
            ,changeMonth: true             //콤보박스에서 월 선택 가능         
            ,yearSuffix: "년"             //달력의 년도 부분 뒤에 붙는 텍스트
            ,monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12']                     //달력의 월 부분 텍스트
            ,monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'] //달력의 월 부분 Tooltip 텍스트
            ,dayNamesMin: ['일','월','화','수','목','금','토']                                         //달력의 요일 부분 텍스트
            ,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일']                 //달력의 요일 부분 Tooltip 텍스트
        });                    
        
        //시작일의 초기값을 설정
        $('#sDatepicker').datepicker({
            onClose: function( selectedDate ) {    
                $("#eDatepicker").datepicker( "option", "minDate", selectedDate );
                // 시작일(sDatepicker) datepicker가 닫힐때
                // 종료일(eDatepicker)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
            }                
        });
        $('#sDatepicker').datepicker('setDate', thisYear+'-'+thisMonth+'-01');    //시작일 초기값 셋팅
        
        //종료일의 초기값을 내일로 설정
        $('#eDatepicker').datepicker({
            onClose: function( selectedDate ) {
                $("#sDatepicker").datepicker( "option", "maxDate", selectedDate );
                // 종료일(eDatepicker) datepicker가 닫힐때
                // 시작일(eDatepicker)의 선택할수있는 최대 날짜(maxDate)를 선택한 종료일로 지정 
            }
        });
        $('#eDatepicker').datepicker('setDate', 'today');                        //끝일 초기값 셋팅
        
    }); // end of $(function() {})------------------------------
	
	$(document).ready(function() {
		
		$("input#vac_days").val("");
		
		// 연차 종류에 따른 차감연차값 가져오기
		$('input#van_common').click(function () {
	          var radioVal = $('input[name="van_common"]:checked').val();
	          console.log(radioVal);
	          
	          if( 0 < radioVal && radioVal < 1 ) {
	          		$("input#vac_days").prop("disabled", true);
	          		$("input#vac_days").val("1");
	          }	
	          else {
	        	  	$("input#vac_days").prop("disabled", false);
		          	$("input#vac_days").val("");
	          }
        }); // end of $('input#van_common').click(function () {}---------------
        		
        // 휴가일계산 버튼 클릭시
        $("button#btn_vac_cal").click(function() {
        	
        	if( $("input#rest_vac_days").val() - $("input#vac_days").val() < 0 ) {
        		// 잔여휴가가 부족할 때
        		alert(" 잔여휴가 개수가 부족합니다.(잔여휴가일수 : " + $("input#rest_vac_days").val() + " 일)");
        		return;
        	}
        	else if( $("input#vac_days").val().trim() == "" ) {
        		// 휴가일자를 입력하지 않았을 때
        		alert("휴가일수를 입력해주세요!");
        		return;
        	}
        	else if($('input:radio[name="van_common"]').is(':checked') == false ) {
        		// 휴가구분을 체크하지 않았을 때
        		alert("휴가구분을 반드시 선택해주세요!");
        		return;
        	}
        	else {
        		// 잔여휴가일수가 휴가일자보다 많을 때
        		var vacDay = $("input#vac_days").val();
				let strDate = $("input#eDatepicker").val();
        		
        		endDate = getVacationDate(vacDay, strDate);
        		endDate = getYmd10(endDate);
        		// console.log("시작일 : " + strDate);
        		// console.log("종료일 : " + endDate);
        		$("td#vacation_days").text(strDate+" ~ "+endDate);
        		
        		// 시작, 종료일, 휴가기간 담아줌
        		$("input#vacation_days").val(vacDay);
        		$("input#leave_start").val(strDate);
        		$("input#leave_end").val(endDate);
        	}
        }); // end of $("button#btn_vac_cal").click(function()--------------------
        
        		
        $("button#btnReportVacation").click(function(){
        	
        	
        	
        }); // end of $("button#btnReportVacation").click(function(){})-------------
		
	}); // end of $(document).ready(function() {})-----------------------------
	
	// Function Declaration
	
	// 휴가시작/종료일 구하기
	function getVacationDate(vacDay, strDate) {
		
		var endDate = new Date(strDate);
		
		if(vacDay > 1) {
			for(var i = vacDay; i > 1; i--) {
				
				endDate.setDate(endDate.getDate() + 1);
				if(endDate.getDay() == 0 || endDate.getDay() == 6) {
					i++;
				}
			}	
		}
		
		return endDate;
		
	} // end of function getEndVacationDate()------------------
	
	//yyyy-mm-dd 포맷 날짜 생성
	function getYmd10(d) {
	    
		return d.getFullYear() + "-" + ((d.getMonth() + 1) > 9 ? (d.getMonth() + 1).toString() : "0" + (d.getMonth() + 1)) + "-" + (d.getDate() > 9 ? d.getDate().toString() : "0" + d.getDate().toString());
	} // end of function getYmd10(d) {}--------------------
	
	function reportVacation() {
		
		if( $("td#vacation_days").text() == "" ) {
			// 휴가기간이 없을 때
			alert("휴가일계산 버튼을 클릭하신 뒤 확인 후 제출하세요!");
			return;
		}
		
	} // end of function reportVacation()----------------------
	
</script>
		
<div class="container_myAtt">
    <%-- 공가/경조신청서 작성 시작 --%>
    <div class="row" style="padding-left:15px;">
        <div class="col-xs-12" style="width:90%;">
        <form name="reportVacationFrm">
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
				      <td style="text-align: left;">${requestScope.deptMap.manager}</td>
				      <th class="th_title" style="text-align: center;">결재자 성명</th>
				      <td style="text-align: left;">${requestScope.deptMap.manager_name}</td>
				    </tr>
				    
				    <tr style="text-align: center;">
				      <th class="th_title" style="text-align: center;">소속</th>
				      <td style="width:35%; text-align: left;">${requestScope.deptMap.ko_depname}</td>
				      <th class="th_title" style="text-align: center;">직급</th>
				      <td style="width:25%; text-align: left;">${requestScope.loginuser.ko_rankname}</td>
				    </tr>
				    
				    <tr style="text-align: center;">
				      <th class="th_title" style="text-align: center;">사번</th>
				      <td style="text-align: left;">${requestScope.loginuser.pk_emp_no}</td>
				      <th class="th_title" style="text-align: center;">성명</th>
				      <td style="text-align: left;">${requestScope.loginuser.emp_name}</td>
				    </tr>
				    
				    <tr style="text-align: center;">
				      <th class="th_title" style="text-align: center;">연락처</th>
				      <td style="text-align: left;"><!-- ${requestScope.loginuser.uq_phone} --></td>
				    </tr>
				    <tr style="text-align: center;">
				      <th class="th_title" style="text-align: center;">휴가구분</th>
				      <td colspan="3" style="text-align: center;">
				      	<div id="vac_sort_container" style="width: 80%; text-align: center; margin: 0 auto;">
				      		<!-- 휴가구분 시작 -->
				      		<table id="vac_sort" style="width: 100%;">
					      		<tr class="tr_gray">
						      		<th>일반휴가선택</th>
						      	</tr>
						      	<tr>
						      		<td>
						      		<c:forEach items="${requestScope.attSortList}" var="attSort" begin="0" end="3" step="1">
						      			<input type="radio" id="van_common" name="van_common" value="${attSort.minus_cnt}">
						      			<label for="van_common">${attSort.att_sort_korname}</label>
						      			<input type="hidden" id="fk_att_sort_no" value="${attSort.pk_att_sort_no}" />
						      		</c:forEach>
						      		</td>
						      	</tr>	
						      	<tr>
						      		<td>
					      			<c:forEach items="${requestScope.attSortList}" var="attSort" begin="4" end="7" step="1">
						      			<input type="radio" id="van_common" name="van_common" value="${attSort.minus_cnt}">
						      			<label for="van_common">${attSort.att_sort_korname}</label>
						      			<input type="hidden" id="fk_att_sort_no" value="${attSort.pk_att_sort_no}" />
						      		</c:forEach>
						      		</td>
						      	</tr>
						      	
						      	<tr class="tr_gray">
						      		<th>가족사랑 특별휴가-기념일</th>
						      	</tr>
						      	
						      	<tr>
						      		<td>
					      			<c:forEach items="${requestScope.attSortList}" var="attSort" begin="8" end="11" step="1">
						      			<input type="radio" id="van_common" name="van_common" value="${attSort.minus_cnt}">
						      			<label for="van_common">${attSort.att_sort_korname}</label>
						      			<input type="hidden" id="fk_att_sort_no" value="${attSort.pk_att_sort_no}" />
						      		</c:forEach>
						      		</td>
						      	</tr>
					      	</table>
				      	</div>
				      </td>
				    </tr>
				    <!-- 휴가구분 끝 -->
				    
				    <!-- 
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
				     -->
				    <tr style="text-align: center;">
				      <th class="th_title" style="width:20%; text-align: center;">희망휴가일수</th>
				      <td style="text-align: left;"><input type="text" id="vac_days" name="vac_days" style="width: 50px; text-align: center;" />&nbsp;일</td>
				      <th class="th_title" style="width:20%; text-align: center;">휴가시작일</th>
				      <td style="text-align: left;">
				      	<input class="requiredInfo" type="text" id="eDatepicker" name="start_vac">
				        <button type="button" class="btn btn-secondary btn-sm mr-3" id="btn_vac_cal" style="margin-bottom: 7px;">휴가일계산</button>
					  </td>
				    </tr>
				    
				    <tr style="text-align: center; " id="bold_hr">
				      <th class="th_title" style="text-align: center;">휴가일</th>
				      <td colspan="3" id="vacation_days" style="text-align: left;"></td>
				    </tr>
				    
				    <tr style="text-align: center; " id="bold_hr">
				      <th class="th_title" style="text-align: center;">증빙서류 제출</th>
				      <td colspan="3" style="text-align: left;">
				      	<input type="file" name="attach" id="attach" />
				      	<br>당일휴가시 필수항목 : 당일휴가 증빙서류를 꼭 첨부해주시기 바랍니다.
				      	<br>훈련휴가시 필수항목 : 훈련참여 증빙서류를 꼭 첨부해주시기 바랍니다.
				      </td>
				    </tr>
				    
				    <tr style="text-align: center; " id="bold_hr">
				      <th class="th_title" style="text-align: center;">휴가사유</th>
				      <td colspan="3" style="text-align: left;"><input type="text" id="att_content" name="att_content" style="width: 80%;"/>			    
				      	<br>포상휴가시 필수항목 : 포상휴가 사유 및 포상내용을 꼭 적어주시기 바랍니다.
				      	<br>대체휴가시 필수항목 : 대체휴가에 해당하는 날짜(기간) 및 사유, 휴가내용을 꼭 적어주시기 바랍니다.
				      	<br>그 외 휴가시 필수항목 : 휴가 사유 및 포상내용을 꼭 적어주시기 바랍니다.
				      </td>
				    </tr>
				    	
			</table>
			
		<div id="vac_button" style="text-align: center;">
			<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnReportVacation" onclick="reportVacation();" style="margin-right: 20px; width:80px; height:30px;">신청하기</button>
			<button type="button" class="btn btn-secondary btn-sm mr-3" id="btn_vac_certification" style="margin-right: 20px; width:80px; height:30px;">목록보기</button>
				      	
		</div>	
		<input type="hidden" id="fk_fin_app_no" name="fk_fin_app_no" value="${requestScope.deptMap.manager}" />
		<input type="hidden" id="fk_vacation_no" name="fk_vacation_no" value="${requestScope.leaveMap.pk_vac_no}" />
		<input type="hidden" id="total_vac_days" name="total_vac_days" value="${requestScope.leaveMap.total_vac_days}" />
		<input type="hidden" id="use_vac_days" name="use_vac_days" value="${requestScope.leaveMap.use_vac_days}" />
		<input type="hidden" id="rest_vac_days" name="rest_vac_days" value="${requestScope.leaveMap.rest_vac_days}" />
        <input type="hidden" id="instead_vac_days" name="instead_vac_days" value="${requestScope.leaveMap.instead_vac_days}" />
        <input type="hidden" id="vacation_days" name="vacation_days" />
        <input type="hidden" id="leave_start" name="leave_start" />
        <input type="hidden" id="leave_end" name="leave_end" />

        </form>
        </div>
    </div>
    <%-- 공가/경조신청서 작성 끝 --%>
    
</div>