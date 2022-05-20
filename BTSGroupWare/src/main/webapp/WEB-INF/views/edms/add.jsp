<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String ctxPath = request.getContextPath();
%>

<!-- style_edms.css 는 이미 layout-tiles_edms.jsp 에 선언되어 있으므로 쓸 필요 X! -->

<!-- datepicker를 사용하기 위한 링크 / 나중에 헤더에 추가되면 지우기 -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.1/themes/base/jquery-ui.css">
<!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.1/jquery-ui.js"></script>

<!-- 긴급버튼 토글을 사용하기 위한 링크 -->
<!-- <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.3/jquery.min.js"></script> -->


<style type="text/css">

/* 문서작성 페이지 테이블 th 부분 */
.edmsView_th {
	width: 15%;
	background-color: #e8e8e8;
}

/* 주소록 모달창 띄우기 */
#tbl_telAdd {
	border-collapse: separate;
	border-spacing: 0 12px;
}

.arrow-next_1 {
	position: relative;
	float: left;
	width: 90px;
	height: 90px;
}

.arrow-next_1::after {
	position: absolute;
	left: 10px;
	top: 20px;
	content: '';
	width: 50px; /* 사이즈 */
	height: 50px; /* 사이즈 */
	border-top: 5px solid #000; /* 선 두께 */
	border-right: 5px solid #000; /* 선 두께 */
	transform: rotate(45deg); /* 각도 */
}

.arrow-next_2 {
	position: relative;
	float: left;
	width: 90px;
	height: 90px;
}

.arrow-next_2::after {
	position: absolute;
	left: 10px;
	top: 20px;
	content: '';
	width: 50px; /* 사이즈 */
	height: 50px; /* 사이즈 */
	border-top: 5px solid #000; /* 선 두께 */
	border-right: 5px solid #000; /* 선 두께 */
	transform: rotate(45deg); /* 각도 */
}
</style>



<script type="text/javascript">
   
	$(document).ready(function(){
     
	
	<%-- ************************************************** 결재요청 버튼 시작 ************************************************** --%>
	// 결재요청 버튼
	$("button#btnWrite").click(function() {
      
		// 문서양식 선택여부 검사
		const docform = $("select#fk_appr_sortno").val();
		console.log("양식선택 확인 : " + docform);
		
		// 카테고리를 선택하지 않은 경우 에러 메시지 출력
		// if ($("select#docform option:selected").length == 0) {
		if(docform == "" || docform == null) {
		   alert("양식을 입력하세요!!");
		   return;
		}
        
		// 제목 유효성 검사 1 - 데이터 유무
		var title = $("input#title").val().trim();
		if(title == "") {
		   alert("글제목을 입력하세요!!");
		   return;
		}
		
		// 제목 유효성 검사 2 - 제목 길이
		if(title.length > 66) {
			alert("제목이 너무 깁니다!!");
			return;
		}
      	
		// 제목 유효성 검사 3- 제목에 script 막기 및 break-all
		title = title.replace(/<p><br><\/p>/gi, "<br>"); //<p><br></p> -> <br>로 변환
		title = title.replace(/<\/p><p>/gi, "<br>"); //</p><p> -> <br>로 변환  
		title = title.replace(/(<\/p><br>|<p><br>)/gi, "<br><br>"); //</p><br>, <p><br> -> <br><br>로 변환
		title = title.replace(/(<p>|<\/p>)/gi, ""); //<p> 또는 </p> 모두 제거시
		
		title = title.replaceAll("<", "&lt;");
		title = title.replaceAll(">", "&gt;");
		title = title.replaceAll("&", "&amp;");
		title = title.replaceAll("\\", "&quot;");
		
		$("input#title").val(title);
		
		// 긴급버튼 체크 시 값 전달(긴급이면 1을, 아니면 0을 전달, default값은 0이다.) ////////////// 
		let flag = $('input:checkbox[name="emg"]').is(':checked');
		
		let emergency = "";
		// 여기서 값이 넘어가지 않음 -> 넘어감.
		   
		if (flag == true) { // 체크된 경우
			console.log("true");
			emergency = "1";
		} else {         // 안된 경우
			console.log("false");
			emergency = "0";
		}
         
		$("input#emergency").val(emergency);
		console.log($("input#emergency").val());
		          
		const apprCheck_mid = $("input#fk_mid_empno").val();
		if(apprCheck_mid == '') {
			alert("결재선을 지정하세요!");
			return;
		}
		
		const apprCheck_fin = $("input#fk_fin_empno").val();
		if(apprCheck_fin == '') {
			alert("결재선을 지정하세요!");
			return;
		}
		
		// 폼(form)을 전송(submit)
		const frm = document.addFrm;
		frm.method = "POST";
		frm.action = "<%= ctxPath%>/edms/edmsAddEnd.bts";
			frm.submit();
		}); // end of $("button#btnWrite").click(function(){}) --------------------

		
		
		
		// 긴급버튼
		/* var check = $("input[type='checkbox']");
		check.click(function() {
		   $("p").toggle();
		}); */
		
		// datepicker
		$("#datepicker").datepicker({
			showOn : "button",
			buttonImage : "<%= ctxPath%>/resources/images/calendar.gif",
			buttonImageOnly: true,
			buttonText: "Select date"
		});
     
		<%-- 결재선 지정하기 시작 --%>
		$( "div#y_teamwon" ).slideToggle().hide();
		$( "button#y_team" ).click( function() {
			$( "div#y_teamwon" ).slideToggle();
		});
		   
		$( "div#m_teamwon" ).slideToggle().hide();
		$( "button#m_team" ).click( function() {
			$( "div#m_teamwon" ).slideToggle();
		});
		
		$( "div#g_teamwon" ).slideToggle().hide();
		$( "button#g_team" ).click( function() {
			$( "div#g_teamwon" ).slideToggle();
		});
		
		$( "div#c_teamwon" ).slideToggle().hide();
		$( "button#c_team" ).click( function() {
			$( "div#c_teamwon" ).slideToggle();
		});
		
		$( "div#i_teamwon" ).slideToggle().hide();
		$( "button#i_team" ).click( function() {
			$( "div#i_teamwon" ).slideToggle();
		});
		
		$( "div#h_teamwon" ).slideToggle().hide();
		$( "button#h_team" ).click( function() {
			$( "div#h_teamwon" ).slideToggle();
		});
        
		
		// 이름에 체크했을 때
		$('input:checkbox[name=empno]').click(function(){
           
			checkOnlyOne(this);
			
			$("input#emp_no").val("");
			$("input#emp_name").val("");
			$("input#emp_rank").val("");
			$("input#emp_dept").val("");
			
			$("input#emp_no2").val("");
			$("input#emp_name2").val("");
			$("input#emp_rank2").val("");
			$("input#emp_dept2").val("");
			
			// 처음 지정한 값이 최종으로 바뀌어서 오류가 떴던 것이다.
			// employee_no가 fk_mid_empno에도 되고, fk_fin_empno에도 되니까
			// 그런데 등록이 아니라 추가할 때 아예 바뀌어야 하므로
			// middle_approve과 last_approve 에서 if문으로 조건을 걸어준다.
			
			var employee_no =  $(this).val();
			$("input#emp_no").val(employee_no);
			$("input#fk_mid_empno").val(employee_no);   ////////////////////////////////////////////////////////////////      
			
			$("input#emp_no2").val(employee_no);
			$("input#fk_fin_empno").val(employee_no);   
              
			var employee_name =  $(this).next().val();
			$("input#emp_name").val(employee_name);
			$("input#emp_name2").val(employee_name);
			
			var employee_rank =  $(this).next().next().val();
			$("input#emp_rank").val(employee_rank);
			$("input#emp_rank2").val(employee_rank);
			
			var employee_dept =  $(this).next().next().next().val();
			$("input#emp_dept").val(employee_dept);
			$("input#emp_dept2").val(employee_dept);
			
		});
		<%-- 결재선 지정하기 종료 --%>
		;
		
	}); // end of $(document).ready(function(){}) --------------------
	
	<%-- ************************************************** 결재요청 버튼 종료 ************************************************** --%>

   /* 체크박스 하나만 선택되게 하는 함수 시작 */
   function checkOnlyOne(element) {
     
     const checkboxes 
         = document.getElementsByName("empno");
     
     checkboxes.forEach((cb) => {
       cb.checked = false;
     })
     
     element.checked = true;
   }      
   /* 체크박스 하나만 선택되게 하는 함수 끝 */
   
   
   // 중간결재자 값을 테이블에 넣어주는 함수
	function middle_approve(){
      
		var emp_no = $("input#emp_no").val();		// 담아준 중간결재자번호(로그인사번 아니다!)
		var emp_name = $("input#emp_name").val();
		var emp_rank = $("input#emp_rank").val();
		var emp_dept = $("input#emp_dept").val();
      
		var mid = emp_no;
		var fk = $("input#fk_emp_no").val();		// fk에는 로그인한 유저의 사번을 담아준다.
       
	//	console.log(mid);
	//	console.log(fk);

		// 결재자의 사번이 자신과 동일한 경우, 즉 본인을 결재자로 지정하는 경우 아예 값이 안 들어가도록 공백을 넣어준다.
		if( mid == fk ) {
			alert("본인을 결재선으로 추가하는 것은 불허합니다!");
			$("input#fk_mid_empno").val("");
			$("input#fk_mid_empno2").val("");
			return false;
		}
		
		// 결재자의 사번이 자신과 다른 경우, 즉 본인을 결재자로 지정하지 않은 '정상적인' 경우에는 값이 담아준다.
		else {
			$("input#middle_empno").val(emp_no);
			$("input#middle_name").val(emp_name);
			$("input#middle_rank").val(emp_rank);
			$("input#middle_dept").val(emp_dept);
		}
	} // end of function middle_approve() --------------------

	// 최종결재자 값을 테이블에 넣어주는 함수
	function last_approve(){
		
		var emp_no2 = $("input#emp_no2").val();		// 담아준 중간결재자번호(로그인사번 아니다!)
		var emp_name2 = $("input#emp_name2").val();
		var emp_rank2 = $("input#emp_rank2").val();
		var emp_dept2 = $("input#emp_dept2").val();
      
		var fin = emp_no2;
		var fk = $("input#fk_emp_no").val();		// fk에는 로그인한 유저의 사번을 담아준다.
       
	//	console.log(fin);
	//	console.log(fk);

		// 결재자의 사번이 자신과 동일한 경우, 즉 본인을 결재자로 지정하는 경우 아예 값이 안 들어가도록 공백을 넣어준다.
		if( fin == fk ) {
			alert("본인을 결재선으로 추가하는 것은 불허합니다!");
			$("input#fk_fin_empno").val("");
			$("input#fk_fin_empno2").val("");
			
			return false;
		}
		
		// 결재자의 사번이 자신과 다른 경우, 즉 본인을 결재자로 지정하지 않은 '정상적인' 경우에는 값이 담아준다.
		else {
			$("input#last_empno").val(emp_no2);
			$("input#last_name").val(emp_name2);
			$("input#last_rank").val(emp_rank2);
			$("input#last_dept").val(emp_dept2);
		}		
	} // end of function middle_approve() --------------------
	
	
	// 중간결재자 삭제
	function middle_reset() {
      
      $("input#middle_empno").val("");
       $("input#middle_name").val("");
       $("input#middle_rank").val("");
       $("input#middle_dept").val("");
   
       $("input#fk_mid_empno").val() = "";
		$("input#fk_mid_empno2").val() = "";
	} // end of function middle_reset() --------------------
   
	
	// 최종결재자 삭제
	function last_reset() {
      
      $("input#last_empno").val("");
       $("input#last_name").val("");
       $("input#last_rank").val("");
       $("input#last_dept").val("");
       
       $("input#fk_fin_empno").val() = "";
	   $("input#fk_fin_empno2").val() = "";
   
   } // end of function last_reset() --------------------
   
   
   // 결재라인을 지정해서 담아주는 메소드
   function getAppr() {
      $(document).on("click", "#insert_customer_btn", function(event){

    	 if( $("#last_name").val() == ""){
              alert("최종승인자 값이 없습니다");
              return false;
         }
 
    	// console.log(${sessionScope.loginuser.pk_emp_no});
    	// console.log($('input#fk_mid_empno').val()); // 여기까지는 잘 들어옴
         
         if( $("input#fk_fin_empno").val() == $("input#fk_emp_no").val() ) { // 결재자의 사번이 자신과 동일한 경우
        	 alert("본인을 결재선으로 추가하는 것은 불허합니다!");
        	 $("input#fk_fin_empno").val("");
 			$("input#fk_fin_empno2").val("");
        	 return false;
         }
         
         else if ( $("#last_empno").val() != "" ) {
        	
        	var emp_no = $("input#middle_empno").val();
            var emp_name = $("input#middle_name").val();
            var emp_rank = $("input#middle_rank").val();
            var emp_dept = $("input#middle_dept").val();

            $("input#emp_no").val(emp_no);
            $("input#emp_name").val(emp_name);
            $("input#emp_rank").val(emp_rank);
            $("input#emp_dept").val(emp_dept);
            
            // 중간결재
            
            var emp_no2 = $("input#last_empno").val();
            var emp_name2 = $("input#last_name").val();
            var emp_rank2 = $("input#last_rank").val();
            var emp_dept2 = $("input#last_dept").val();
             
            $("input#emp_no2").val(emp_no2);
            $("input#emp_name2").val(emp_name2);
            $("input#emp_rank2").val(emp_rank2);
            $("input#emp_dept2").val(emp_dept2);
             
            // 최종결재
            
            
            // 보여주기 위해서 담아주는 곳
			$("input#fk_mid_empno2").val(emp_name+"("+emp_no+")");
			$("input#fk_fin_empno2").val(emp_name2+"("+emp_no2+")");
			
			// 오류 / 실제로 컨트롤러로 넘어가는 곳 <<<< 위와 같이 "(" ~ 넘기면 fk_mid_empno에 "(" ~ 가 담기는데, 그러면 컨트롤러에서 값을 못 받아서 자꾸 작성이 안되는 것이다!
			$("input#fk_mid_empno").val(emp_no);
			$("input#fk_fin_empno").val(emp_no2);

            // 값 input
          }
    	
      });
   }   // end of getAppr()
   
</script>




<%-- layout-tiles_edms.jsp의 #mycontainer 과 동일하므로 굳이 만들 필요 X --%>

<div class="edmsDiv">

   <div class="edmsHomeTitle">
      <span class="edms_maintitle">문서작성</span>
      <p style="margin-bottom: 10px;"></p>
   </div>

   <!-- 문서작성 시작 -->
   <form name="addFrm" enctype="multipart/form-data">
   <div>
   
	<table style="width: 100%" class="table table-bordered">
		<tr>
		<th class="edmsView_th">문서양식</th>
		<td colspan="4" style="width: 60%;">
			<select name="fk_appr_sortno" id="fk_appr_sortno" class="form-control" style="width: 100%;">
			<option value="">양식선택</option>
			<option value="1">업무기안서</option>
			<option value="2">증명서신청</option>
			<option value="3">사유서</option>
			</select>
		</td>
		</tr>
      
		<tr>
			<th class="edmsView_th">작성자</th>
			<td colspan="4">
				<input type="hidden" id="fk_emp_no" name="fk_emp_no" value="${sessionScope.loginuser.pk_emp_no}" />
				<input type="text" class="form-control-plaintext" name="name" value="${sessionScope.loginuser.emp_name}" readonly />
			</td>
		</tr>
		
		<tr>
			<th class="edmsView_th">긴급</th>
			<td colspan="4">
				<label for="emg">
				<input type="checkbox" name="emg" id="emg">&nbsp;긴급
				<input type="hidden" name="emergency" id="emergency">
				<%-- name 전달할 값의 이름, value 전달될 값 --%>
				</label>
			</td>
		</tr>
      
      <tr>
         <th class="edmsView_th" rowspan="2" style="vertical-align: middle;">결재정보</th>
         <td colspan="4">
         	<input type="hidden" name="fk_mid_empno" id="fk_mid_empno" class="form-control" placeholder="중간결재자 정보" value="" readonly />
         	<input type="text" name="fk_mid_empno2" id="fk_mid_empno2" class="form-control" placeholder="중간결재자 정보" value="" readonly />
         </td>
      </tr>
      
      <tr>
         <td colspan="4">
         	<input type="hidden" name="fk_fin_empno" id="fk_fin_empno" class="form-control" placeholder="최종결재자 정보" value="" readonly />
         	<input type="text" name="fk_fin_empno2" id="fk_fin_empno2" class="form-control" placeholder="최종결재자 정보" value="" readonly />
        </td>
      </tr>
      
      <tr>
         <th class="edmsView_th">제목</th>
         <td colspan="4">
            <input type="text" name="title" id="title" size="100" style="width: 100%;" class="form-control" placeholder="제목을 입력하세요" />
         </td>
      </tr>
      <tr>
         <th class="edmsView_th">내용</th>
         <td colspan="4">
            <textarea style="width: 100%; height: 612px;" name="contents" id="contents" class="form-control"></textarea>
         </td>
      </tr>
      
      <tr>
         <th class="edmsView_th"><label for="attach">파일첨부</label></th>
         <td colspan="4">
            <input type="file" name="attach" id="attach" class="form-control-file" size="100" style="width: 100%;" />
         </td>
      </tr>
   </table>
   </div>


   </form>
   
   <div class="divclear"></div>

      
   <%-- ---------------------------------------------------------------------------------------------------- --%>
      
   
   <br/>
   <button class="btn btn-secondary" data-toggle="modal" data-target="#viewModal">결재라인 지정하기</button>
   
   
   <br/>
   <br/>
	<div>
      <button type="button" class="btn btn-secondary mr-3" id="btnWrite">결재요청</button>
      <button type="button" class="btn btn-secondary" onclick="javascript:history.back()">작성취소</button>
   </div>
 </div>
   
   <!-- ------------------------------------------------------- -->
      
      <!-- 결재선 추가 -->
      
      
      <!-- <button class="btn btn-default" data-toggle="modal" data-target="#viewModal">유리한테 줄 조직도 틀</button> -->
   
   <!-- 모달 -->


<div class="modal fade" data-backdrop="static" id="viewModal">
   <div class="modal-dialog" style="max-width: 100%; display: table;">
   <div class="modal-content" style= "height:90%;">
   <div class="modal-header">
   <h4 class="modal-title" id="exampleModalLabel">결재 참조</h4>
   </div>
   
   <div class="modal-body">
      <div id="tbl_one" style="float:left; width:22%;">
         <table style="text-align:center; max-width: 100%;">
            <tr>
               <td><button class="btn btn-default" id="y_team" style="width:150px; border: solid darkgray 2px;">영업팀</button></td>
            </tr>
            <c:forEach var="emp" items="${requestScope.empList}" varStatus="i">
            <c:if test="${emp.ko_depname  eq '영업'}">
            <tr>
            <td>
               <div id="y_teamwon">
                  <label>
                     <input type="checkbox" id="pk_emp_no_${i.count}" name="empno" value="${emp.pk_emp_no}" />
                     <input type="hidden" id="employee_name" name="employee_name" value="${emp.emp_name}" />
                     <input type="hidden" id="employee_rank" name="employee_rank" value="${emp.ko_rankname}" />
                     <input type="hidden" id="employee_dept" name="employee_dept" value="${emp.ko_depname}" />
                     &nbsp;${emp.emp_name}&nbsp;[${emp.ko_rankname}]
                  </label>
               </div>
            </td>
            </tr>
            </c:if>
               </c:forEach>
               
            <tr>
               <td><button class="btn btn-default" id="m_team" style="width:150px; border: solid darkgray 2px;">마케팅팀</button></td>
            </tr>
            <c:forEach var="emp" items="${requestScope.empList}" varStatus="i">
            <c:if test="${emp.ko_depname  eq '마케팅'}">
            <tr>
            <td>
               <div id="m_teamwon">
                  <label>
                     <input type="checkbox" id="pk_emp_no_${i.count}" name="empno" value="${emp.pk_emp_no}" />
                     <input type="hidden" id="employee_name" name="employee_name" value="${emp.emp_name}" />
                     <input type="hidden" id="employee_rank" name="employee_rank" value="${emp.ko_rankname}" />
                     <input type="hidden" id="employee_dept" name="employee_dept" value="${emp.ko_depname}" />
                     &nbsp;${emp.emp_name}&nbsp;[${emp.ko_rankname}]
                  </label>
               </div>
            </td>
            </tr>
            </c:if>
               </c:forEach>
            <tr>
               <td><button class="btn btn-default" id="g_team" style="width:150px; border: solid darkgray 2px;">기획팀</button></td>
            </tr>
            <c:forEach var="emp" items="${requestScope.empList}" varStatus="i">
            <c:if test="${emp.ko_depname  eq '기획'}">
            <tr>
            <td>
               <div id="g_teamwon">
                  <label>
                     <input type="checkbox" id="pk_emp_no_${i.count}" name="empno" value="${emp.pk_emp_no}" />
                     <input type="hidden" id="employee_name" name="employee_name" value="${emp.emp_name}" />
                     <input type="hidden" id="employee_rank" name="employee_rank" value="${emp.ko_rankname}" />
                     <input type="hidden" id="employee_dept" name="employee_dept" value="${emp.ko_depname}" />
                     &nbsp;${emp.emp_name}&nbsp;[${emp.ko_rankname}]
                  </label>
               </div>
            </td>
            </tr>
            </c:if>
               </c:forEach>
            <tr>
               <td><button class="btn btn-default" id="c_team" style="width:150px; border: solid darkgray 2px;">총무팀</button></td>
            </tr>
            <c:forEach var="emp" items="${requestScope.empList}" varStatus="i">
            <c:if test="${emp.ko_depname  eq '총무'}">
            <tr>
            <td>
               <div id="c_teamwon">
                  <label>
                     <input type="checkbox" id="pk_emp_no_${i.count}" name="empno" value="${emp.pk_emp_no}" />
                     <input type="hidden" id="employee_name" name="employee_name" value="${emp.emp_name}" />
                     <input type="hidden" id="employee_rank" name="employee_rank" value="${emp.ko_rankname}" />
                     <input type="hidden" id="employee_dept" name="employee_dept" value="${emp.ko_depname}" />
                     &nbsp;${emp.emp_name}&nbsp;[${emp.ko_rankname}]
                  </label>
               </div>
            </td>
            </tr>
            </c:if>
               </c:forEach>
               
            <tr>
               <td><button class="btn btn-default" id="i_team" style="width:150px; border: solid darkgray 2px;">인사팀</button></td>
            </tr>
            <c:forEach var="emp" items="${requestScope.empList}" varStatus="i">
            <c:if test="${emp.ko_depname  eq '인사'}">
            <tr>
            <td>
               <div id="i_teamwon">
                  <label>
                     <input type="checkbox" id="pk_emp_no_${i.count}" name="empno" value="${emp.pk_emp_no}" />
                     <input type="hidden" id="employee_name" name="employee_name" value="${emp.emp_name}" />
                     <input type="hidden" id="employee_rank" name="employee_rank" value="${emp.ko_rankname}" />
                     <input type="hidden" id="employee_dept" name="employee_dept" value="${emp.ko_depname}" />
                     &nbsp;${emp.emp_name}&nbsp;[${emp.ko_rankname}]
                  </label>
               </div>
            </td>
            </tr>
            </c:if>
               </c:forEach>
            <tr>
               <td><button class="btn btn-default" id="h_team" style="width:150px; border: solid darkgray 2px;">회계팀</button></td>
            </tr>
            <c:forEach var="emp" items="${requestScope.empList}" varStatus="i">
            <c:if test="${emp.ko_depname  eq '회계'}">
            <tr>
            <td>
               <div id="h_teamwon">
                  <label>
                     <input type="checkbox" id="pk_emp_no_${i.count}" name="empno" value="${emp.pk_emp_no}" />
                     <input type="hidden" id="employee_name" name="employee_name" value="${emp.emp_name}" />
                     <input type="hidden" id="employee_rank" name="employee_rank" value="${emp.ko_rankname}" />
                     <input type="hidden" id="employee_dept" name="employee_dept" value="${emp.ko_depname}" />
                     &nbsp;${emp.emp_name}&nbsp;[${emp.ko_rankname}]
                  </label>
               </div>
            </td>
            </tr>
            </c:if>
               </c:forEach>
           </table>
              <!--    중간 결재자 부분 전송 -->
              <input type="hidden" id="emp_no" name="emp_no" />
              <input type="hidden" id="emp_name" name="emp_name" />
              <input type="hidden" id="emp_rank" name="emp_rank" />
              <input type="hidden" id="emp_dept" name="emp_dept" />
              
              <!--    최종 결재자 부분 전송 -->
              <input type="hidden" id="emp_no2" name="emp_no2" />
              <input type="hidden" id="emp_name2" name="emp_name2" />
              <input type="hidden" id="emp_rank2" name="emp_rank2" />
              <input type="hidden" id="emp_dept2" name="emp_dept2" />
              
        </div>
        
        <div id="tbl_two" style="float:left; width:18%;">
           <table>
              <!-- <tr><td><button class="arrow-next_1" onclick="middle_approve();" ></button></td></tr> -->
              <tr><td><button class="btn btn-primary" onclick="middle_approve();" >중간결재자<br/>추가</button></td></tr>
              <!-- <tr><td><button class="arrow-next_2" onclick="last_approve();" style="margin-top:115%;"></button></td></tr> -->
              <tr><td><button class="btn btn-primary" onclick="last_approve();" style="margin-top:115%;">최종결재자<br/>추가</button></td></tr>
           </table>
        </div>
        
        <div id="tbl_three" style="width:50%;">
           <form name="submitFrm">
           <table style="text-align:center; width: 40%;">
              <tr>
                 <td colspan="4">중간 결재&nbsp;<input type="reset" value="삭제" onclick="middle_reset()" style="background-color: #007bff; border: none; color: #fff; border-radius: 10%; margin: 4px;" /></td>
              </tr>
              <tr style="border: solid darkgray 2px; margin-left:2%">
                 <td style="width:0%;"><input type="hidden" id="pk_emp_no_${i.count}" name="pk_emp_no_${i.count}" value="${emp.pk_emp_no}" readonly /></td>
                 <td style="width:13%;"><strong>이름</strong></td>
                 <td style="width:13%;"><strong>직급</strong></td>
                 <td style="width:13%;"><strong>부서</strong></td>
               </tr>
               <tr style="border-bottom: solid darkgray 2px;">
                  <td style="width:0%;"><input type="hidden" id="pk_emp_no_${i.count}" name="pk_emp_no_${i.count}" value="${emp.pk_emp_no}" readonly />
                  <input type="hidden" id="middle_empno" name="middle_empno"  style="border:none; text-align:center; " ></td>
                  <td><input type="text" id="middle_name" name="middle_name"  style="border:none; text-align:center; " ><br></td>
                  <td><input type="text" id="middle_rank" name="middle_rank"  style="border:none; text-align:center;" ><br></td>
                  <td><input type="text" id="middle_dept" name="middle_dept"  style="border:none; text-align:center;"  ><br></td>
               </tr>
         </table>
         <table style="text-align:center; margin-top:30%;">
            <tr><td colspan="4">최종 결재&nbsp;<input type="reset" value="삭제" onclick="last_reset()" style="background-color: #007bff; border: none; color: #fff; border-radius: 10%; margin: 4px;" /></td></tr>
            <tr style="border: solid darkgray 2px; margin-left:2%">
               <td style="width:0%;"><input type="hidden" id="pk_emp_no_${i.count}" name="pk_emp_no_${i.count}" value="${emp.pk_emp_no}" readonly /></td>
               <td style="width:13%;"><strong>이름</strong></td>
               <td style="width:13%;"><strong>직급</strong></td>
               <td style="width:13%;"><strong>부서</strong></td>
            </tr>
            <tr style="border-bottom: solid darkgray 2px;">
               <td style="width:0%;"><input type="hidden" id="pk_emp_no_${i.count}" name="pk_emp_no_${i.count}" value="${emp.pk_emp_no}" readonly />
               <input type="hidden" id="last_empno" name="last_empno"  style="border:none; text-align:center; " ></td>
               <td><input type="text" id="last_name" name="last_name"  style="border:none; text-align:center; " ><br></td>
               <td><input type="text" id="last_rank" name="last_rank"  style="border:none; text-align:center;" ><br></td>
               <td><input type="text" id="last_dept" name="last_dept"  style="border:none; text-align:center;"  ><br></td>
            </tr>
         </table>
         </form>
        </div>
        
        <div id="tbl_right" style="float:left; width:10%;">
        </div>
   </div><!-- modal-body -->
   
   <div class="modal-footer">
   <input type="button" class="btn btn-primary" id="insert_customer_btn" onclick="getAppr()" data-dismiss="modal" value="등록">
   <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
   </div>
   </div>
   </div>
   </div>
   
   
   
   <!-- 문서작성 종료 -->
   

   
   
   