<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
   String ctxPath = request.getContextPath();

%>


<script type="text/javascript">

	/* 유리 줄 부분 모달꺼 시작  */
	
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
	  
	  
	}); // end of $( document ).ready( function()
	
	/* 유리 줄 부분 모달꺼 끝 */
	

	function goTelAdd() {
		
		const frm = document.telAddFrm;
	    frm.action = "<%=ctxPath%>/addBook/addBook_telAdd_insert.bts"
	    frm.method = "post"
	    frm.submit();
	}
	
/*	
	 function middelapprove(){
	        var obj = $("[name=empno]");
	        var chkArray = new Array(); // 배열 선언
	 
	        $('input:checkbox[name=empno]:checked').each(function() { // 체크된 체크박스의 value 값을 가지고 온다.
	            chkArray.push(this.value);
	        });
	        $('#hiddenEmpno').val(chkArray);
	        
	    }
*/	 
	 function lastapprove(){
	        var obj = $("[name=empno]");
	        var chkArray = new Array(); // 배열 선언
	 
	        $('input:checkbox[name=empno]:checked').each(function() { // 체크된 체크박스의 value 값을 가지고 온다.
	            chkArray.push(this.value);
	        });
	        $('#hiddenEmpno').val(chkArray);
	        
	    }
	 
	 
	 function middelapprove()	{
		 
		 	var obj = $("[name=empno]");
	        var chkArray = new Array(); // 배열 선언
	 
	        $('input:checkbox[name=empno]:checked').each(function() { // 체크된 체크박스의 value 값을 가지고 온다.
	            chkArray.push(this.value);
	        });
	        $('#hiddenEmpno').val(chkArray);
		 
			$.ajax({
				url:"<%= ctxPath%>/addBook/addBook_telAdd_select_ajax.bts",
				data:{"hiddenEmpno" : $("input#hiddenEmpno").val()},
				type: "post",
				dataType: 'json',
				success : function(json) {
					
				},
				error: function(request){
					
				}
			});
		}	


	
	

	
    

</script>

<style type="text/css">

#tbl_telAdd { 
		border-collapse: separate;
		border-spacing: 0 12px;
	}
	
	.arrow-next_1 {
    position: relative;
    float:left;
    width:90px;
    height:90px;
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
    float:left;
    width:90px;
    height:90px;
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

<title>연락처추가페이지</title>

	<div id="telAdd_main_tbl" style="text-align:center;">
	<form name="telAddFrm"> 
	<table id="tbl_telAdd">
		<tr>
			<td><h2>연락처 추가<br><br></h2></td>
		</tr>
		<tr>
			<td><strong>사진</strong></td>
			<td><img src="<%=ctxPath %>/resources/images/addBook_telAdd_sample.jpg" alt="..." class="img-rounded"><button class="btn btn-default" id="telAdd_mini_btn">삭제</button></td>
		</tr>
		<tr>
			<td><strong>이름</strong></td>
			<td><input type="text" class="form-control" id="addb_name" name="addb_name" placeholder="이름"></td>
		</tr>
		<tr>
			<td><strong>부서</strong></td>
			<td>
				<select id="department" name="department" class="form-control">
				  <option selected >--</option>
				  <option value="100">영업</option>
				  <option value="200">마케팅</option>
				  <option value="300">기획</option>
				  <option value="400">총무</option>
				  <option value="500">인사</option>
				  <option value="600">회계</option>
				</select>
			</td>
		</tr>
		<tr>
			<td><strong>직위</strong></td>
			<td>
				<select id="rank" name="rank" class="form-control">
				  <option selected >--</option>
				  <option value="10">사원</option>
				  <option value="20">주임</option>
				  <option value="30">대리</option>
				  <option value="40">과장</option>
				  <option value="50">차장</option>
				  <option value="60">부장</option>
				  <option value="70">전무</option>
				  <option value="80">사장</option>
				</select>
			</td>
		</tr>
		<tr>
			<td><strong>이메일</strong></td>
			<td><input type="text" class="form-control" id="email" name="email" placeholder="이메일"></td>
		</tr>
		<tr>
			<td><strong>휴대폰</strong></td>
			<td><input type="text" class="form-control" id="phone" name="phone" placeholder="휴대폰"></td>
		</tr>
		<tr>
			<td><strong>회사</strong></td>
			<td><input type="text" class="form-control" id="company" name="company" placeholder="회사"></td>
		</tr>
		<tr>
			<td><strong>회사전화번호</strong></td>
			<td><input type="text" class="form-control" id="com_tel" name="com_tel" placeholder="회사전화번호"></td>
		</tr>
		<tr>
			<td><strong>회사주소</strong></td>
			<td><input type="text" class="form-control" id="company_address" name="company_address" placeholder="회사주소" style="width: 120%;"></td>
		</tr>
		<tr>
			<td><strong>메모사항</strong></td>
			<td><input type="text" class="form-control" id="memo" name="memo" placeholder="메모사항" style="width:120%; height: 80px;"></td>
		</tr>
		</table>
		</form>
			<div id="buttonmenu">
				<input type="submit" class="btn btn-info" style="border: solid lightgray 2px;" value="확인" onclick="goTelAdd()" />
				<input type="reset" class="btn btn-default" style="border: solid lightgray 2px;" value="취소"  onclick="location.href='http://localhost:9090/bts/addBook/addBook_main.bts'"  />
			</div>
			
	</div>
	
	
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
					<input type="text" name="hiddenEmpno" id="hiddenEmpno" value="" />
					<td><button class="btn btn-default" id="y_team" style="width:150px; border: solid darkgray 2px;">영업팀</button></td>
				</tr>
				<c:forEach var="emp" items="${requestScope.empList}" varStatus="i">
				<c:if test="${emp.ko_depname  eq '영업'}">
				<tr>
				<td>
					<div id="y_teamwon">
						<label>
							<input type="checkbox" id="pk_emp_no_${i.count}" name="empno" value="${emp.pk_emp_no}" />
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
							&nbsp;${emp.emp_name}&nbsp;[${emp.ko_rankname}]
						</label>
					</div>
				</td>
				</tr>
				</c:if>
		   		</c:forEach>
		  	</table>
	  	</div>
	  	
	  	<div id="tbl_two" style="float:left; width:20%;">
		  	<table>
			  	<tr><td><button class="arrow-next_1" onclick="middelapprove();" ></button></td></tr>
			  	<tr><td><button class="arrow-next_2" onclick="lastapprove();" style="margin-top:115%;"></button></td></tr>
		  	</table>
	  	</div>
	  	
	  	<div id="tbl_three" style="float:left; width:50%;">
		  	<table style="text-align:center;">
		  		<tr><td colspan="7">중간 결재</td></tr>
				<tr style="border: solid darkgray 2px; margin-left:2%">
					<td style="width:0%;"><input type="hidden" id="pk_emp_no_${i.count}" name="pk_emp_no_${i.count}" value="${emp.pk_emp_no}" readonly /></td>
					<td style="width:13%;"><strong>이름</strong></td>
					<td style="width:13%;"><strong>직급</strong></td>
					<td style="width:13%;"><strong>부서</strong></td>
				</tr>
				<tr style="border-bottom: solid darkgray 2px;">
					<td style="width:0%;"><input type="hidden" id="pk_emp_no_${i.count}" name="pk_emp_no_${i.count}" value="${emp.pk_emp_no}" readonly /></td>
					<td><input type="text" id="name" name="name"  style="border:none; text-align:center; " ><br></td>
					<td><input type="text" id="rank" name="rank"  style="border:none; text-align:center;" ><br></td>
					<td><input type="text" id="department" name="department"  style="border:none; text-align:center;"  ><br></td>
				</tr>
			</table>
			<table style="text-align:center; margin-top:30%;">
				<tr><td colspan="7">최종 결재</td></tr>
				<tr style="border: solid darkgray 2px; margin-left:2%">
					<td style="width:0%;"><input type="hidden" id="pk_emp_no_${i.count}" name="pk_emp_no_${i.count}" value="${emp.pk_emp_no}" readonly /></td>
					<td style="width:13%;"><strong>이름</strong></td>
					<td style="width:13%;"><strong>직급</strong></td>
					<td style="width:13%;"><strong>부서</strong></td>
				</tr>
				<tr style="border-bottom: solid darkgray 2px;">
					<td style="width:0%;"><input type="hidden" id="pk_emp_no_${i.count}" name="pk_emp_no_${i.count}" value="${emp.pk_emp_no}" readonly /></td>
					<td><input type="text" id="name" name="name"  style="border:none; text-align:center; " ><br></td>
					<td><input type="text" id="rank" name="rank"  style="border:none; text-align:center;" ><br></td>
					<td><input type="text" id="department" name="department"  style="border:none; text-align:center;"  ><br></td>
				</tr>
			</table>
	  	</div>
	</div><!-- modal-body --> 
	
	<div class="modal-footer">
	<button type="button" class="btn btn-primary" id="insert_customer_btn" onclick="javascript:document.updateFrm.submit()">등록</button>
	<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	</div>
	</div>
	</div>
	</div>
