<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    
<% String ctxPath = request.getContextPath(); %>

<%-- 캘린더(일정) 사이드 tiles 만들기 --%>

<style type="text/css">


</style>


<script type="text/javascript">

	$(document).ready(function(){
		
		$( "div#y_teamwon" ).slideToggle().hide();
		  $( "button#y_team" ).click( function() {
		      $( "div#y_teamwon" ).slideToggle();
		    });
		
		
	});// end of $(document).ready(function(){}-------------------

			
	
			
</script>

	<div>
	   <div id="sidebar" style="font-size: 11pt;">
		 <h4><br>주소록</h4>
		 
	
		 
			<button type="button" class="btn btn-outline-primary btn-lg " style="margin: 15px auto; width:200px; display:block;" onclick="location.href='<%= ctxPath%>/addBook/addBook_telAdd.bts'">주소록 추가</button>
			<button type="button" class="btn btn-outline-primary btn-lg " style="margin: 15px auto; width:200px; display:block;" onclick="location.href='<%= ctxPath%>/addBook/addBook_main.bts'">주소록 목록</button>
							
		<h4><br>조직도</h4>
		 
			<div class="treeview-animated w-20 border mx-4 my-4">
		  		<ul class="treeview-animated-list mb-3">
		    	<li class="treeview-animated-items">Mail</li>
		          <ul class="nested">
		            <li>a</li>
		            <li>b</li>
		            <li>c</li>
		          </ul>
		        </li>
		      </ul>
		    </li>
		    <ul class="nested">
		    <li class="treeview-animated-items">
		        Inbox
		      	<ul class="nested">
		        <li>ab
		        </li>
		        <li>
		          abc
		        </li>
		        <li>
		          abcd
		        </li>
		        <li>
		          abcde
		        </li>
		      </ul>
		    
		      
		</div>
			
			
		</div>
	</div>
	