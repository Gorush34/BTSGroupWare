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
      
      <%-- === 스마트 에디터 구현 시작 === --%>
      //전역변수
      var obj = [];   
      
      //스마트에디터 프레임생성
      nhn.husky.EZCreator.createInIFrame({
         oAppRef: obj,
         elPlaceHolder: "contents",
         sSkinURI: "<%= ctxPath%>/resources/smarteditor/SmartEditor2Skin.html",
         htParams : {
            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseToolbar : true,
            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
            bUseVerticalResizer : false,
            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
            bUseModeChanger : false,
         }
      });
      <%-- === 스마트 에디터 구현 끝 === --%>
      
      
      
<%--    
      // 결재선 지정하기
      $("input#apprMidEmpDep").bind("keyup", function() {
         var apprMidEmpDep = $(this).val();
         console.log("확인용 apprMidEmpDep : " + apprMidEmpDep);
         $.ajax({
            url:"<%= ctxPath%>/edms/insertSchedule/searchJoinUserList.action",
            data:{"joinUserName":joinUserName},
            dataType:"json",
            success : function(json){
               var joinUserArr = [];
         
         //      console.log("이:"+json.length);
               if(json.length > 0){
                  
                  $.each(json, function(index,item){
                     var name = item.name;
                     if(name.includes(joinUserName)){ // name 이라는 문자열에 joinUserName 라는 문자열이 포함된 경우라면 true , 
                                                     // name 이라는 문자열에 joinUserName 라는 문자열이 포함되지 않은 경우라면 false 
                        joinUserArr.push(name+"("+item.userid+")");
                     }
                  });
                  
                  $("input#joinUserName").autocomplete({  // 참조 https://jqueryui.com/autocomplete/#default
                     source:joinUserArr,
                     select: function(event, ui) {       // 자동완성 되어 나온 공유자이름을 마우스로 클릭할 경우 
                        add_joinUser(ui.item.value);    // 아래에서 만들어 두었던 add_joinUser(value) 함수 호출하기 
                                                        // ui.item.value 이  선택한이름 이다.
                        return false;
                       },
                       focus: function(event, ui) {
                           return false;
                       }
                  }); 
                  
               }// end of if------------------------------------
            }// end of success-----------------------------------
         });
         
      });
--%>
      
      // 글쓰기 버튼
      $("button#btnWrite").click(function() {
      
         <%-- === 스마트 에디터 구현 시작 === --%>
         //id가 contents인 textarea에 에디터에서 대입
         obj.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
         <%-- === 스마트 에디터 구현 끝 === --%>
         
         
         // 문서양식 선택여부 검사
         const docform = $("select#fk_appr_sortno").val();
         console.log("양식선택 확인 : " + docform);
         
         // 카테고리를 선택하지 않은 경우 에러 메시지 출력
         // if ($("select#docform option:selected").length == 0) {
         if(docform == "" || docform == null) {
            alert("양식을 입력하세요!!");
            return;
         }
                  
         // 카테고리 선택값 받아오기
         /* $("select#fk_appr_sortno").on("change", function() {      // select문의 이벤트는 change라는 것을 기억하자!   
               const docform = $(this).val();
            // let docform = $("select#docform > option:selected").attr("value");
             $("input#docformName").val(docform);
            
            });//end of $("select#docform").on("change", function()  */
         
         
          /* 
          	오류 잘못된 코드
          	
          	$("input#emg").click(function () {
             
             // 긴급버튼 체크 시 값 전달(긴급이면 1을, 아니면 0을 전달, default값은 0이다.) 
            let flag = $('input:checkbox[name="emg"]').is(':checked');
            
             let emergency = "";
             // 여기서 값이 넘어가지 않음 - 
             
            if (flag == true) { // 체크된 경우
               console.log("true");
               emergency = "1";
            } else {         // 안된 경우
               console.log("false");
               emergency = "0";
            }
            
            $("input#emergency").val(emergency);
             console.log($("input#emergency").val());
          }) */
          
          
           <input type="checkbox" name="emg" id="emg">&nbsp;긴급
         <input type="hidden" name="emergency" id="emergency"> */
          
          
         // 제목 유효성 검사
         const title = $("input#title").val().trim();
         if(title == "") {
            alert("글제목을 입력하세요!!");
            return;
         }
         
         // 내용 유효성 검사(스마트 에디터 사용 안 할 시)
         <%--
         const contents = $("textarea#contents").val().trim();
         if(contents == "") {
            alert("글내용을 입력하세요!!");
            return;
         }
         --%>
         
         <%-- === 스마트에디터 구현 시작 === --%>
         // 스마트에디터 사용시 무의미하게 생기는 p태그 제거
         var contentval = $("textarea#contents").val();
                 
         // === 확인용 ===
         // alert(contentval); // content에 내용을 아무것도 입력치 않고 쓰기할 경우 알아보는것.
         // "<p>&nbsp;</p>" 이라고 나온다.
              
         // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기전에 먼저 유효성 검사를 하도록 한다.
         // 글내용 유효성 검사 
         if(contentval == "" || contentval == "<p>&nbsp;</p>") {
            alert("내용을 입력하세요!!");
            return;
         }
              
         // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기
         contentval = $("textarea#contents").val().replace(/<p><br><\/p>/gi, "<br>"); //<p><br></p> -> <br>로 변환
         
         /*    
		            대상문자열.replace(/찾을 문자열/gi, "변경할 문자열");
		            ==> 여기서 꼭 알아야 될 점은 나누기(/)표시안에 넣는 찾을 문자열의 따옴표는 없어야 한다는 점입니다. 
		            그리고 뒤의 gi는 다음을 의미합니다.
            
            g : 전체 모든 문자열을 변경 global
            i : 영문 대소문자를 무시, 모두 일치하는 패턴 검색 ignore
          */    

         contentval = contentval.replace(/<\/p><p>/gi, "<br>"); //</p><p> -> <br>로 변환  
         contentval = contentval.replace(/(<\/p><br>|<p><br>)/gi, "<br><br>"); //</p><br>, <p><br> -> <br><br>로 변환
         contentval = contentval.replace(/(<p>|<\/p>)/gi, ""); //<p> 또는 </p> 모두 제거시
          
         $("textarea#contents").val(contentval);
           
         // alert(contentval);
         <%-- === 스마트에디터 구현 끝 === --%>         
         
         
         // 긴급버튼 체크 시 값 전달(긴급이면 1을, 아니면 0을 전달, default값은 0이다.) ////////////// 
         let flag = $('input:checkbox[name="emg"]').is(':checked');
         
         let emergency = "";
         // 여기서 값이 넘어가지 않음 - 
            
         if (flag == true) { // 체크된 경우
            console.log("true");
            emergency = "1";
         } else {         // 안된 경우
            console.log("false");
            emergency = "0";
         }
         
         $("input#emergency").val(emergency);
            console.log($("input#emergency").val());
                   
          
          
         
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
           
           var employee_no =  $(this).val();
              $("input#emp_no").val(employee_no);
           
      //      $("input#fk_mid_empno").val(employee_no);   ////////////////////////////////////////////////////////////////      

      
              $("input#emp_no2").val(employee_no);
      //      $("input#fk_fin_empno").val(employee_no);   
              
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
      
      
      
   }); // end of $(document).ready(function(){}) --------------------
   
   // 체크박스 하나만 선택되게 하는 함수 시작

   function checkOnlyOne(element) {
     
     const checkboxes 
         = document.getElementsByName("empno");
     
     checkboxes.forEach((cb) => {
       cb.checked = false;
     })
     
     element.checked = true;
   }      
   // 체크박스 하나만 선택되게 하는 함수 끝
   
   function middle_approve(){
      
      var emp_no = $("input#emp_no").val();
      var emp_name = $("input#emp_name").val();
      var emp_rank = $("input#emp_rank").val();
      var emp_dept = $("input#emp_dept").val();
      
      $("input#middle_empno").val(emp_no);
       $("input#middle_name").val(emp_name);
       $("input#middle_rank").val(emp_rank);
       $("input#middle_dept").val(emp_dept);
   }
       
   function last_approve(){
         
         var emp_no2 = $("input#emp_no2").val();
         var emp_name2 = $("input#emp_name2").val();
         var emp_rank2 = $("input#emp_rank2").val();
         var emp_dept2 = $("input#emp_dept2").val();
         
          $("input#last_empno").val(emp_no2);
          $("input#last_name").val(emp_name2);
          $("input#last_rank").val(emp_rank2);
          $("input#last_dept").val(emp_dept2);
      }
    
   
   function middle_reset() {
      
      $("input#middle_empno").val("");
       $("input#middle_name").val("");
       $("input#middle_rank").val("");
       $("input#middle_dept").val("");
   
   }
   
   function last_reset() {
      
      $("input#last_empno").val("");
       $("input#last_name").val("");
       $("input#last_rank").val("");
       $("input#last_dept").val("");
   
   }
   
   
   function getAppr() {
      $(document).on("click", "#insert_customer_btn", function(event){
         if( $("#last_name").val() == ""){
              alert("최종승인자 값이 없습니다");
              return false;
         } // end of if
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

            $("input#fk_mid_empno").val(emp_name+"("+emp_no+")");
            $("input#fk_fin_empno").val(emp_name2+"("+emp_no2+")");
            
             // 값 input
             
          } // end of else if
      }); // $(document).on("click", "#insert_customer_btn", function(event)
   } // end of getAppr()
   

</script>




<%-- layout-tiles_edms.jsp의 #mycontainer 과 동일하므로 굳이 만들 필요 X --%>

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
             <td colspan="4">
            <select name="fk_appr_sortno" id="fk_appr_sortno">
               <option value="">양식선택</option>
               <%-- ApprVO에서 가져오나 ApprSortVO에서 가져오나? --%>
               <%-- 오류  <c:forEach var="map" items="${requestScope.fk_appr_sortno}" var="form"> var 가 2번 쓰여서! --%>
               <%-- <c:forEach var="apprsort" items="${requestScope.apprsortList}"> --%>
               <%-- var="이름" items="${컨트롤러에 선언된 list명}" --%>
                  <%-- <option value="${apprsort.apprsortList}">어쩌고</option> --%>
               <%-- </c:forEach> --%>
               <!-- <option name="fk_appr_sortno" value="9">업무기안서</option> -->
               <option value="1">업무기안서</option>
               <option value="2">증명서신청</option>
               <option value="3">사유서</option>
               <option value="4">휴가신청서</option>
            </select>
         </td>
      </tr>
      
      <tr>
         <th class="edmsView_th">작성자</th>
             <td colspan="4">
                <!-- EmployeeVO 가 아닌 ApprVO 에서 가져오는 것이다! 근데 왜 굳이 EmployeeVO를 놔두고? 모르겠음 -->
                <%-- 이 view단은 어차피 로그인해야지만 볼 수 있는 곳이기 때문에 sessionScope을 사용한다 / 컨트롤러에서 loginuser에 userid라고 저장해줬으니까 이렇게?--%>
                <%-- EmployeeVO에서 가져와야 하므로  userid가 아니라 get 뒤의 ~를 가져와야 함 --%>
            <input type="hidden" name="fk_emp_no" value="${sessionScope.loginuser.pk_emp_no}" />
            <input type="text" class="form-control-plaintext" name="name" value="${sessionScope.loginuser.emp_name}" readonly />
            
         </td>
      </tr>
      <tr>
         <th class="edmsView_th">긴급</th>
         <td colspan="4">
            <label class="switch-button">
               <input type="checkbox" name="emg" id="emg">&nbsp;긴급
               <input type="text" name="emergency" id="emergency">
               <%-- name 전달할 값의 이름, value 전달될 값 --%>
            </label>
         </td>
      </tr>
      
      <tr>
         <th class="edmsView_th" rowspan="2">결재정보</th>
         <td style="width: 20%;">중간결재자</td>
         <td><input type="text" name="fk_mid_empno" id="fk_mid_empno" class="form-control" placeholder="중간결재자 정보" value="" readonly /></td>
      </tr>
      
      <tr>
         <td style="width: 20%;">최종결재자</td>
         <td><input type="text" name="fk_fin_empno" id="fk_fin_empno" class="form-control" placeholder="최종결재자 정보" value="" readonly /></td>
      </tr>
   

<!--      
      <tr>
         <th class="edmsView_th">시행일자</th>
         <td colspan="4">
            <input type="text" id="datepicker" name="">
         </td>
      </tr>
-->
      
      <tr>
         <th class="edmsView_th">제목</th>
         <td colspan="4">
            <input type="text" name="title" id="title" size="100" style="width: 100%;" class="form-control" placeholder="제목을 입력하세요"/>
         </td>
      </tr>
      <tr>
         <th class="edmsView_th">내용</th>
         <td colspan="4">
            <textarea style="width: 100%; height: 612px;" name="contents" id="contents">내용/휴가신청서</textarea>
         </td>
      </tr>
      

      <tr>
         <th class="edmsView_th">파일첨부</th>
         <td colspan="4">
            <input type="file" name="attach" id="attach" size="100" style="width: 100%;" />
         </td>
      </tr>
   </table>
   </div>

   <div>
      <button type="button" class="btn btn-secondary btn-sm mr-3" id="btnWrite">결재요청</button>
      <button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">작성취소</button>
   </div>
   </form>
   
   
   
   
      
      

      
   <!-- ---------------------------------------------------------------------------------------------------- -->
      
   
   
   <button class="btn btn-default" data-toggle="modal" data-target="#viewModal">결재선 지정</button>
   <!-- ------------------------------------------------------- -->
      
      <!-- 결재선 추가 -->
      
      
      <!-- <button class="btn btn-default" data-toggle="modal" data-target="#viewModal">유리한테 줄 조직도 틀</button> -->
   
   <!-- 모달 -->


<div class="modal fade" data-backdrop="static" id="viewModal">
   <div class="modal-dialog" style="max-width: 100%; width: auto; display: table;">
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
              <tr><td><button class="arrow-next_1" onclick="middle_approve();" ></button></td></tr>
              <tr><td><button class="arrow-next_2" onclick="last_approve();" style="margin-top:115%;"></button></td></tr>
           </table>
        </div>
        
        <div id="tbl_three" style="float:left; width:60%;">
           <form name="submitFrm">
           <table style="text-align:center; max-width: 100%;">
              <tr>
                 <td colspan="4">중간 결재&nbsp;<input type="reset" value="삭제" onclick="middle_reset()"/></td>
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
            <tr><td colspan="4">최종 결재&nbsp;<input type="reset" value="삭제" onclick="last_reset()" /></td></tr>
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
   </div><!-- modal-body -->
   
   <div class="modal-footer">
   <input type="button" class="btn btn-primary" id="insert_customer_btn" onclick="getAppr()" data-dismiss="modal" value="등록">
   <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
   </div>
   </div>
   </div>
   </div>
   
   
   
   <!-- 문서작성 종료 -->
   
   
   
   
   