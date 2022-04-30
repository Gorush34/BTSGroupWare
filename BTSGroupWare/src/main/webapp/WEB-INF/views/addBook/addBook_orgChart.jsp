<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
   String ctxPath = request.getContextPath();
  
%>



<script type="text/javascript">

$( document ).ready( function() {
	
	
	$( "#D_allteam" ).slideToggle().hide();
	$( "#BD_allteam" ).slideToggle().hide();
	
	
	
	$( "#All_head" ).click( function() {
	    $( "#D_allteam" ).slideToggle();
	    $( "#BD_allteam" ).slideToggle();
	});
	  
	
	
  	$( "#D_head" ).click( function() {
    	$( "#D_allteam" ).slideToggle();
  	});
  
	$( "#BD_head" ).click( function() {
	  $( "#BD_allteam" ).slideToggle();
	});
  
  
  
  
}); // end of $( document ).ready( function()

</script>

<title>조직도</title>


<table>
	
	
<div class="treeview-colorful w-20 border border-secondary mx-4 my-4" >
  <h2 class="pt-3 pl-3">조직도</h2>
  <hr>
  
  <ul class="treeview-colorful-list mb-3">
    <li class="treeview-colorful-items">
        <div id="All_head"><i class="fas fa-plus-circle">쌍용그룹</i></div>
        <div id="ALL_team">
	      <ul class="nested">
	    <li class="treeview-colorful-items">
	        <div id="D_head"><i class="fas fa-plus-circle">대면본부</i></div>
	      	<div id="D_allteam">
		      <ul class="nested">
		        <li>
		          	대면강사팀
		        </li>
		        <li>
		          	대면매니저팀
		        </li>
		        <li>대면교육팀
		          <ul class="nested">
		            <li>
		              	대면1팀
		            </li>
		            <li>
		              	대면2팀
		            </li>
		            <li>
		              	대면3팀
		            </li>
		          </ul>
		        </li>
		      </ul>
	      </div>
	    </li>
	    
	    <li class="treeview-colorful-items">
	        <div id="BD_head"><i class="fas fa-plus-circle">비대면본부</i></div>
	      	<div id="BD_allteam">
		      <ul class="nested">
		        <li>
		          	비대면강사팀
		        </li>
		        <li>
		          	비대면매니저팀
		        </li>
		        <li>비대면교육팀
		          <ul class="nested">
		            <li>
		              	비대면1팀
		            </li>
		            <li>
		              	비대면2팀
		            </li>
		            <li>
		              	비대면3팀
		            </li>
		          </ul>
		        </li>
		      </ul>
	      </div>
	    </li>
	    </ul>
	    </div>
	 </li>
	 </ul>
</div>
	 
   
  
	
	
</table>