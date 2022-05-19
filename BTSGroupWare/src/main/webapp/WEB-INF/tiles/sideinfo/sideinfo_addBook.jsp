<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    
<% String ctxPath = request.getContextPath(); %>

<%-- 캘린더(일정) 사이드 tiles 만들기 --%>

<style type="text/css">


</style>

		 <h3><br>주소록<br></h3>
		 
			<button type="button" class="btn btn-outline-primary btn-lg " style="margin: 15px auto; width:200px; display:block;" onclick="location.href='<%= ctxPath%>/addBook/addBook_telAdd.bts'">주소록 추가</button>
			<button type="button" class="btn btn-outline-primary btn-lg " style="margin: 15px auto; width:200px; display:block;" onclick="location.href='<%= ctxPath%>/addBook/addBook_main.bts'">주소록 목록</button>
						
		 <h3><br>직급 구성<br></h3>
		 
			<table style="float:left; text-align:left; margin-left:16%;">
			
			<tr>
				<td><input type="button" class="btn btn-default" id="top_team" style="width:150px; border-bottom:1px solid lightgray; float:center; font-size:17pt; color:#4da6ff;" value="임원진"></td>
			</tr>
				<tr>
					<td><input type="button" class="btn btn-default" id="ceo" style="width:200px; float:center;" value="└ [사장]"></td>
				</tr>
				<c:forEach var="emp" items="${requestScope.empList}" varStatus="i">
				<c:if test="${emp.ko_rankname  eq '사장'}">
				<tr>
				<td>
					<div id="emp_ceo">
						<input type="text" style="border:none; text-align:center; float:right; width:120px;" value="└ ${emp.emp_name}" readonly>
					</div>
				</td>
				</tr>
				</c:if>
		   		</c:forEach>
				<tr>
					<td><input type="button" class="btn btn-default" id="exe_director" style="width:200px; float:center;" value="└ [전무]"></td>
				</tr>
				<c:forEach var="emp" items="${requestScope.empList}" varStatus="i">
				<c:if test="${emp.ko_rankname  eq '전무'}">
				<tr>
				<td>
					<div id="emp_exe_director">
						<input type="text" style="border:none; text-align:center; float:right; width:120px;" value="└ ${emp.emp_name}" readonly>
					</div>
				</td>
				</tr>
				</c:if>
		   		</c:forEach>
		   	<tr>
				<td><input type="button" class="btn btn-default" id="mid_team" style=" width:150px; border-bottom:1px solid lightgray; float:center; font-size:17pt; color:#4da6ff;" value="중간관리자"></td>
			</tr>	
				<tr>
					<td><input type="button" class="btn btn-default" id="dep_manager" style="width:200px; float:center;" value="└ [부장]"></td>
				</tr>
				<c:forEach var="emp" items="${requestScope.empList}" varStatus="i">
				<c:if test="${emp.ko_rankname  eq '부장'}">
				<tr>
				<td>
					<div id="emp_dep_manager">
						<input type="text" style="border:none; text-align:center; float:right; width:120px;" value="└ ${emp.emp_name}" readonly>
					</div>
				</td>
				</tr>
				</c:if>
		   		</c:forEach>
				<tr>
					<td><input type="button" class="btn btn-default" id="gen_manager" style="width:200px; float:center;" value="└ [차장]"></td>
				</tr>
				<c:forEach var="emp" items="${requestScope.empList}" varStatus="i">
				<c:if test="${emp.ko_rankname  eq '차장'}">
				<tr>
				<td>
					<div id="emp_gen_manager">
						<input type="text" style="border:none; text-align:center; float:right; width:120px;" value="└ ${emp.emp_name}" readonly>
					</div>
				</td>
				</tr>
				</c:if>
		   		</c:forEach>
				<tr>
					<td><input type="button" class="btn btn-default" id="sec_manager" style="width:200px; float:center;" value="└ [과장]"></td>
				</tr>
				<c:forEach var="emp" items="${requestScope.empList}" varStatus="i">
				<c:if test="${emp.ko_rankname  eq '과장'}">
				<tr>
				<td>
					<div id="emp_sec_manager">
						<input type="text" style="border:none; text-align:center; float:right; width:120px;" value="└ ${emp.emp_name}" readonly>
					</div>
				</td>
				</tr>
				</c:if>
		   		</c:forEach>
		   	<tr>
				<td><input type="button" class="btn btn-default" id="bottom_team" style="width:150px; border-bottom:1px solid lightgray; float:center; font-size:17pt; color:#4da6ff;" value="실무자"></td>
			</tr>	
				<tr>
					<td><input type="button" class="btn btn-default" id="ast_manager" style="width:200px; float:center;" value="└ [대리]"></td>
				</tr>
				<c:forEach var="emp" items="${requestScope.empList}" varStatus="i">
				<c:if test="${emp.ko_rankname  eq '대리'}">
				<tr>
				<td>
					<div id="emp_ast_manager">
						<input type="text" style="border:none; text-align:center; float:right; width:120px;" value="└ ${emp.emp_name}" readonly>
					</div>
				</td>
				</tr>
				</c:if>
		   		</c:forEach>
		   		<tr>
					<td><input type="button" class="btn btn-default" id="ast_employee" style="width:200px; float:center;" value="└ [주임]"></td>
				</tr>
				<c:forEach var="emp" items="${requestScope.empList}" varStatus="i">
				<c:if test="${emp.ko_rankname  eq '주임'}">
				<tr>
				<td>
					<div id="emp_ast_employee">
						<input type="text" style="border:none; text-align:center; float:right; width:120px;" value="└ ${emp.emp_name}" readonly>
					</div>
				</td>
				</tr>
				</c:if>
		   		</c:forEach>
		   		<tr>
					<td><input type="button" class="btn btn-default" id="employee" style="width:200px; float:center;" value="└ [사원]"></td>
				</tr>
				<c:forEach var="emp" items="${requestScope.empList}" varStatus="i">
				<c:if test="${emp.ko_rankname  eq '사원'}">
				<tr>
				<td>
					<div id="emp_employee">
						<input type="text" style="border:none; text-align:center; float:right; width:120px;" value="└ ${emp.emp_name}" readonly>
					</div>
				</td>
				</tr>
				</c:if>
		   		</c:forEach>
  		</table>
		      
<script type="text/javascript">

	$(document).ready(function(){
		
		// ------------- 데이터 ------------- //
		
		$( "div#emp_ceo" ).slideUp();
		$( "div#emp_exe_director" ).slideUp();
		$( "div#emp_dep_manager" ).slideUp();
		$( "div#emp_gen_manager" ).slideUp();
		$( "div#emp_sec_manager" ).slideUp();
		$( "div#emp_ast_manager" ).slideUp();
		$( "div#emp_ast_employee" ).slideUp();
		$( "div#emp_employee" ).slideUp();
		
		// ------------- 데이터 ------------- //
		
		// ------------- 버튼 ------------- //
		
		$( "#ceo" ).slideUp();
	    $( "#exe_director" ).slideUp();
	    $( "#dep_manager" ).slideUp();
	    $( "#gen_manager" ).slideUp();
	    $( "#sec_manager" ).slideUp();
	    $( "#ast_manager" ).slideUp();
	    $( "#ast_employee" ).slideUp();
	    $( "#employee" ).slideUp();
	    
		 // ------------- 버튼 ------------- //
		
		$( "#top_team" ).click( function() {
		      
			$( "#ceo" ).slideToggle();
		      $( "#exe_director" ).slideToggle();
		      
		      $( "div#emp_ceo" ).slideUp();
		      $( "div#emp_exe_director" ).slideUp();
		});
		 
		 
		$( "#mid_team" ).click( function() {
		      $( "#dep_manager" ).slideToggle();
		      $( "#gen_manager" ).slideToggle();
		      $( "#sec_manager" ).slideToggle();
		      
		      $( "div#emp_dep_manager" ).slideUp();
		      $( "div#emp_gen_manager" ).slideUp();
		      $( "div#emp_sec_manager" ).slideUp();
		});
		
		
		$( "#bottom_team" ).click( function() {
		      $( "#ast_manager" ).slideToggle();
		      $( "#ast_employee" ).slideToggle();
		      $( "#employee" ).slideToggle();
		      
		      $( "div#emp_ast_manager" ).slideUp();
		      $( "div#emp_ast_employee" ).slideUp();
		      $( "div#emp_employee" ).slideUp();
		}); 
		 
		 
		 
		 
		 
		  	$( "input#ceo" ).click( function() {
		      $( "div#emp_ceo" ).slideToggle();
		    });
		  	
	  	
		  	$( "input#exe_director" ).click( function() {
		      $( "div#emp_exe_director" ).slideToggle();
		    });
	  	
	  	
		  	$( "input#dep_manager" ).click( function() {
		      $( "div#emp_dep_manager" ).slideToggle();
			});
		  	
	  	
		  	$( "input#gen_manager" ).click( function() {
		      $( "div#emp_gen_manager" ).slideToggle();
			});
		  	
	  	
		  	$( "input#sec_manager" ).click( function() {
		      $( "div#emp_sec_manager" ).slideToggle();
			}); 
		  	
	  	
		  	$( "input#ast_manager" ).click( function() {
		      $( "div#emp_ast_manager" ).slideToggle();
			});
		  	
	  	
		  	$( "input#ast_employee" ).click( function() {
		      $( "div#emp_ast_employee" ).slideToggle();
			});
		  	
	  	
		  	$( "input#employee" ).click( function() {
		      $( "div#emp_employee" ).slideToggle();
			});
			  
		
	});// end of $(document).ready(function(){}-------------------
			
	$( "#top_team" ).click( function() {
	      $( "div#ceo" ).slideToggle();
	      $( "div#exe_director" ).slideToggle();
	    });		
			
</script>			
			
	