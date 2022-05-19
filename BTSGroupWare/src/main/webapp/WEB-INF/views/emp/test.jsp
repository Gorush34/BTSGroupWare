<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
    
<%
    String ctxPath = request.getContextPath();
    //    /bts
%>
<style type="text/css">
#tbl_telAdd { 
      border-collapse: separate;
      border-spacing: 0 12px;
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
	
   	// 체크박스 선택 뒤 모달 중간버튼 누를 때		
	$("button#set_mid").click(function () {
		mid_cnt = $("input[name='uq_email']:checked").length;
		console.log(mid_cnt);
		
	      	var empMailArr = new Array();
       $("input[name='uq_email']:checked").each(function() {
       	// console.log($(this).val());
       	
      	        	empMailArr.push($(this).val());
       });
       if(mid_cnt == 0){
           alert("선택된 제품이 없습니다.");
           return;
       }
       
       
       console.log( $("input#input_mid").val());
       
       middle_approve();
       
	});
			
}); // end of $( document ).ready( function()------------------------------------------

//--------------------------- 중간결재자 버튼 시작 ---------------------------// 
 function middle_approve(){ // 모달 중간버튼 클릭시 오른쪽으로 클릭한 값 넘겨주기
    
    var empno = [];
    var name = [];
    var rank = [];
    var dept = [];
     $("input[name='uq_email']:checked").each(function() {
         id = $(this).attr('id')
         empno.push($(this).val());
         name.push($(this).next().val());
         rank.push($(this).next().next().val());
         dept.push($(this).next().next().next().val());
     });
     
     $("#mid_emp").empty()
     
     for(var i=0; i<empno.length; i++){
        
        var html = ""
        html += '<tr><td><input type="hidden" value = ' + empno[i] + '></td>'
        html += '<td><input type="text" style="text-align:center; border:none;" id="mid_text_name_' + i + '"  readonly value = ' + name[i] + '></td>'
        html += '<td><input type="text" style="text-align:center; border:none;" id="mid_text_rank_' + i + '" readonly value = ' + rank[i] + '></td>'
        html += '<td><input type="text" style="text-align:center; border:none;" id="mid_text_dept_' + i + '" readonly value = ' + dept[i] + '></td></tr>'
        
        $("#tbl_middle > tbody:last").append(html);
     }
 }   
//--------------------------- 중간결재자 버튼 끝 ---------------------------//        

//--------------------------- 등록 버튼 시작 ---------------------------//
function goApprove() { // 모달 등록버튼 클릭시
  var mid_list = $("input#input_mid").val();
  $("input#save_mid").val(mid_list);
  
  $('.modal').modal('hide');
}
//--------------------------- 등록 버튼 끝 ---------------------------//   
<%-- // 관심상품에서 선택한 제품을 장바구니로 넘기기
function  wishToCartSelect(cnt, wishNoStr) {
	$.ajax({
		url:"<%= ctxPath%>/product/wishToCartSelect.book",
		type:"POST",
		data:{"cnt":cnt,
			  "wishNoStr":wishNoStr}, 
		dataType:"JSON",
		success:function(json) {
			if(json.wishToCartSelect == 1) {
				alert("선택한 제품이 장바구니에 담겼습니다.");
				location.reload();
			}else{
				alert("오류발생"); 
			}
		},
		error: function(request, status, error){
			//alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		
			if(request.responseText.match("로그인")){
				if(!alert(request.responseText)) document.location = "<%= ctxPath%>/login/join.book";
			}else{
				alert(request.responseText);
				location.reload();
			}
			
		}
	});//end of $.ajax
}//end of function  wishToCartSelect(cnt, wishNoStr)-------- --%>

</script>

<title>조직도 틀 샘플</title>
<div>
<input type="text" id="save_mid" name="save_mid" style="width:700px;" />
</div>

<!-- 모달 -->
<button class="btn btn-default" data-toggle="modal" data-target="#viewModal">민정에게 줄 주소록 틀</button>
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
          <td><button class="btn btn-default" id="y_team" style="width:150px; border: solid darkgray 2px;">영업팀</button></td>
       </tr>
       <c:forEach var="emp" items="${requestScope.empList}" varStatus="i">
       <c:if test="${emp.ko_depname  eq '영업'}">
       <tr>
       <td>
          <div id="y_teamwon">
             <label>
                <input type="checkbox" id="uq_email" name="uq_email" value="${emp.uq_email}" />
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
                <input type="checkbox" id="uq_email" name="uq_email" value="${emp.uq_email}" />
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
                <input type="checkbox" id="uq_email" name="uq_email" value="${emp.uq_email}" />
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
                <input type="checkbox" id="uq_email" name="uq_email" value="${emp.uq_email}" />
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
                <input type="checkbox" id="uq_email" name="uq_email" value="${emp.uq_email}" />
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
                <input type="checkbox" id="uq_email" name="uq_email" value="${emp.uq_email}" />
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
   </div>
   
   <div id="tbl_two" style="float:left; width:20%; margin-top:7%;">
      <table>
         <tr><td><button class="form-control" style="height:70px;" id="set_mid">중간결재<br>추가  / 삭제</button></td></tr>
      </table>
   </div>
   
   <div id="tbl_three" style="float:left; width:50%;">
      <form name="submitFrm">
      <table id = "tbl_middle" style="text-align:center;">
         <tr><td colspan="7">중간 결재</td></tr>
       <tr style="border: solid darkgray 2px; margin-left:2%">
          <td style="width:0%;"><input type="hidden" id="pk_emp_no_${i.count}" name="pk_emp_no_${i.count}" value="${emp.pk_emp_no}" readonly /></td>
          <td style="width:13%;"><strong>이름</strong></td>
          <td style="width:13%;"><strong>직급</strong></td>
          <td style="width:13%;"><strong>부서</strong></td>
          <td><input type="hidden" id="input_mid"  name="input_mid" /></td>
       </tr>
       <tbody id = "mid_emp">
          <tr style="border-bottom: solid darkgray 2px;">
             <td style="width:0%;"><input type="hidden" id="pk_emp_no_${i.count}" name="pk_emp_no_${i.count}" value="${emp.pk_emp_no}" readonly />
             <input type="hidden" id="middle_empno" name="middle_empno"  style="border:none; text-align:center; " ></td>
             <td><input type="text" id="middle_name" name="middle_name"  style="border:none; text-align:center; " ><br></td>
             <td><input type="text" id="middle_rank" name="middle_rank"  style="border:none; text-align:center;" ><br></td>
             <td><input type="text" id="middle_dept" name="middle_dept"  style="border:none; text-align:center;"  ><br></td>
          </tr>
       </tbody>
    </table>
    </form>
   </div>
</div><!-- modal-body -->

<div class="modal-footer">
<input type="button" class="btn btn-primary" id="insert_customer_btn" data-dismiss="modal" onclick="goApprove()" value="등록">
<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
</div>
</div>
</div>
</div>