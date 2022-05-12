<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
   String ctxPath = request.getContextPath();

%>

<style type="text/css">
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


    
$( document ).ready( function() {
      
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
        
        var employee_no =  $(this).val();
           $("input#emp_no").val(employee_no);
        var employee_name =  $(this).next().val();
           $("input#emp_name").val(employee_name);
           var employee_rank =  $(this).next().next().val();
           $("input#emp_rank").val(employee_rank);
           var employee_dept =  $(this).next().next().next().val();
           $("input#emp_dept").val(employee_dept);
           
     });
     
   }); // end of $( document ).ready( function()
   
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
         
         var emp_no = $("input#emp_no").val();
         var emp_name = $("input#emp_name").val();
         var emp_rank = $("input#emp_rank").val();
         var emp_dept = $("input#emp_dept").val();
         
          $("input#last_empno").val(emp_no);
          $("input#last_name").val(emp_name);
          $("input#last_rank").val(emp_rank);
          $("input#last_dept").val(emp_dept);
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

   
   $(document).on("click", "#insert_customer_btn", function(event){
      if( $("#last_name").val() == ""){
           alert("최종승인자 값이 없습니다");
           return false;
      }
      else if ( $("#last_empno").val() != "" ) {
         const frm = document.submitFrm;
          frm.action = "<%=ctxPath%>/edms/modal.bts"
          frm.method = "post"
          frm.submit();
       }
   });

</script>



<button class="btn btn-default" data-toggle="modal" data-target="#viewModal">유리한테 줄 조직도 틀</button>
   
   <!-- 모달 -->


<div class="modal fade" data-backdrop="static" id="viewModal">
   <div class="modal-dialog">
   <div class="modal-content" style= "height:90%; width:200%;">
   <div class="modal-header">
   <h4 class="modal-title" id="exampleModalLabel">결재 참조</h4>
   </div>
   
   <div class="modal-body">
      <div id="tbl_one" style="float:left; width:22%;">
         <table style="text-align:center;">
            <tr>
               <input type="hidden" name="hiddenEmpno" id="hiddenEmpno" value="" />
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
              <input type="hidden" id="emp_no" name="emp_no" />
              <input type="hidden" id="emp_name" name="emp_name" />
               <input type="hidden" id="emp_rank" name="emp_rank" />
               <input type="hidden" id="emp_dept" name="emp_dept" />
        </div>
        
        <div id="tbl_two" style="float:left; width:20%;">
           <table>
              <tr><td><button class="arrow-next_1" onclick="middle_approve();" ></button></td></tr>
              <tr><td><button class="arrow-next_2" onclick="last_approve();" style="margin-top:115%;"></button></td></tr>
           </table>
        </div>
        
        <div id="tbl_three" style="float:left; width:50%;">
           <form name="submitFrm">
           <table style="text-align:center;">
              <tr><td colspan="7">중간 결재&nbsp;<input type="reset" value="삭제" onclick="middle_reset()"/></td></tr>
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
            <tr><td colspan="7">최종 결재&nbsp;<input type="reset" value="삭제" onclick="last_reset()" /></td></tr>
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
   <input type="button" class="btn btn-primary" id="insert_customer_btn" onclick="" value="등록">
   <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
   </div>
   </div>
   </div>
   </div>







