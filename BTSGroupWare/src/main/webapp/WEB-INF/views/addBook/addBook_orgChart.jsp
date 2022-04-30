<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
   String ctxPath = request.getContextPath();
  
%>

<script type="text/javascript">

$( document ).ready( function() {
	
	$( "#tchteam" ).slideToggle().hide();
	$( "#mngteam" ).slideToggle().hide();
	$( "#stuteam" ).slideToggle().hide();
	
	$( "#tchteam_one" ).slideToggle().hide();
	$( "#tchteam_two" ).slideToggle().hide();
	$( "#tchteam_three" ).slideToggle().hide();
	$( "#mngteam_one" ).slideToggle().hide();
	$( "#mngteam_two" ).slideToggle().hide();
	$( "#mngteam_three" ).slideToggle().hide();
	$( "#stuteam_one" ).slideToggle().hide();
	$( "#stuteam_two" ).slideToggle().hide();
	$( "#stuteam_three" ).slideToggle().hide();
	
	$( "#tchteam_one_ssjh" ).slideToggle().hide();
	$( "#tchteam_two_ssjh" ).slideToggle().hide();
	$( "#tchteam_three_ssjh" ).slideToggle().hide();
	$( "#mngteam_one_kdeu" ).slideToggle().hide();
	$( "#mngteam_two_kdeu" ).slideToggle().hide();
	$( "#mngteam_three_kdeu" ).slideToggle().hide();
	$( "#stuteam_one_hmmj" ).slideToggle().hide();
	$( "#stuteam_two_bymg" ).slideToggle().hide();
	$( "#stuteam_three_yrje" ).slideToggle().hide();
	
	
////////////////////////////////////////////////////////////////////	


	$( "#head" ).click( function() {
	    $( "#tchteam" ).slideToggle();
	    $( "#mngteam" ).slideToggle();
	    $( "#stuteam" ).slideToggle();
		    $( "#tchteam_one" ).slideUp();
		    $( "#mngteam_one" ).slideUp();
		    $( "#stuteam_one" ).slideUp();
		    $( "#tchteam_two" ).slideUp();
		    $( "#mngteam_two" ).slideUp();
		    $( "#stuteam_two" ).slideUp();
		    $( "#tchteam_three" ).slideUp();
		    $( "#mngteam_three" ).slideUp();
		    $( "#stuteam_three" ).slideUp();
			    $( "#tchteam_one_ssjh" ).slideUp();
			    $( "#mngteam_one_kdeu" ).slideUp();
			    $( "#stuteam_one_hmmj" ).slideUp();
			    $( "#tchteam_two_ssjh" ).slideUp();
			    $( "#mngteam_two_kdeu" ).slideUp();
			    $( "#stuteam_two_bymg" ).slideUp();
			    $( "#tchteam_three_ssjh" ).slideUp();
			    $( "#mngteam_three_kdeu" ).slideUp();
			    $( "#stuteam_three_yrje" ).slideUp();
	});
	
	$( "#tchteam" ).click( function() {
	    $( "#tchteam_one" ).slideToggle();
	    $( "#tchteam_two" ).slideToggle();
	    $( "#tchteam_three" ).slideToggle();
		    $( "#tchteam_one_ssjh" ).slideUp();
		    $( "#tchteam_two_ssjh" ).slideUp();
		    $( "#tchteam_three_ssjh" ).slideUp();
	});
	
	$( "#mngteam" ).click( function() {
	    $( "#mngteam_one" ).slideToggle();
	    $( "#mngteam_two" ).slideToggle();
	    $( "#mngteam_three" ).slideToggle();
		    $( "#mngteam_one_kdeu" ).slideUp();
		    $( "#mngteam_two_kdeu" ).slideUp();
		    $( "#mngteam_three_kdeu" ).slideUp();
	});
	
	$( "#stuteam" ).click( function() {
	    $( "#stuteam_one" ).slideToggle();
	    $( "#stuteam_two" ).slideToggle();
	    $( "#stuteam_three" ).slideToggle();
		    $( "#stuteam_one_hmmj" ).slideUp();
		    $( "#stuteam_two_bymg" ).slideUp();
		    $( "#stuteam_three_yrje" ).slideUp();
	});
	
	$( "#tchteam_one" ).click( function() {
	    $( "#tchteam_one_ssjh" ).slideToggle();
	});
	$( "#tchteam_two" ).click( function() {
	    $( "#tchteam_two_ssjh" ).slideToggle();
	});
	$( "#tchteam_three" ).click( function() {
	    $( "#tchteam_three_ssjh" ).slideToggle();
	});
	
	$( "#mngteam_one" ).click( function() {
	    $( "#mngteam_one_kdeu" ).slideToggle();
	});
	$( "#mngteam_two" ).click( function() {
	    $( "#mngteam_two_kdeu" ).slideToggle();
	});
	$( "#mngteam_three" ).click( function() {
	    $( "#mngteam_three_kdeu" ).slideToggle();
	});
	
	$( "#stuteam_one" ).click( function() {
	    $( "#stuteam_one_hmmj" ).slideToggle();
	});
	$( "#stuteam_two" ).click( function() {
	    $( "#stuteam_two_bymg" ).slideToggle();
	});
	$( "#stuteam_three" ).click( function() {
	    $( "#stuteam_three_yrje" ).slideToggle();
	});
	

  
}); // end of $( document ).ready( function()

</script>

<title>조직도</title>


<div class="col-sm-8">
<h2>B T S 조직도<br><br></h2>
<ul>
	<li class="list-group-item" id="head">B T S</li>
		<li class="list-group-item" id="tchteam" style="padding-left:100px; background-color:#e6f9ff;">강사팀</li>
			<li class="list-group-item" id="tchteam_one" style="padding-left:150px; background-color:#ccf3ff;">강사1팀</li>
				<li class="list-group-item" id="tchteam_one_ssjh" style="padding-left:200px; background-color:#b3edff;">서순신,서정화</li>
			<li class="list-group-item" id="tchteam_two" style="padding-left:150px; background-color:#ccf3ff;">강사2팀</li>
				<li class="list-group-item" id="tchteam_two_ssjh" style="padding-left:200px; background-color:#b3edff;">영순신,영정화</li>
			<li class="list-group-item" id="tchteam_three" style="padding-left:150px; background-color:#ccf3ff;">강사3팀</li>	
				<li class="list-group-item" id="tchteam_three_ssjh" style="padding-left:200px; background-color:#b3edff;">학순신,학정화</li>
		<li class="list-group-item" id="mngteam" style="padding-left:100px; background-color:#ffe6e6;">매니저팀</li>
			<li class="list-group-item" id="mngteam_one" style="padding-left:150px; background-color:#ffcccc;">매니저1팀</li>
				<li class="list-group-item" id="mngteam_one_kdeu" style="padding-left:200px; background-color:#ffb3b3;">강길동,강이유</li>
			<li class="list-group-item" id="mngteam_two" style="padding-left:150px; background-color:#ffcccc;">매니저2팀</li>
				<li class="list-group-item" id="mngteam_two_kdeu" style="padding-left:200px; background-color:#ffb3b3;">태길동,태이유</li>
			<li class="list-group-item" id="mngteam_three" style="padding-left:150px; background-color:#ffcccc;">매니저3팀</li>
				<li class="list-group-item" id="mngteam_three_kdeu" style="padding-left:200px; background-color:#ffb3b3;">림길동,림이유</li>
		<li class="list-group-item" id="stuteam" style="padding-left:100px; background-color:#e6fff2;">교육생팀</li>
			<li class="list-group-item" id="stuteam_one" style="padding-left:150px; background-color:#ccffe5;">교육1팀</li>
				<li class="list-group-item" id="stuteam_one_hmmj" style="padding-left:200px; background-color:#b3ffd7;">정환모,김민정</li>
			<li class="list-group-item" id="stuteam_two" style="padding-left:150px; background-color:#ccffe5;">교육2팀</li>
				<li class="list-group-item" id="stuteam_two_bymg" style="padding-left:200px; background-color:#b3ffd7;">문병윤,성문길</li>
			<li class="list-group-item" id="stuteam_three" style="padding-left:150px; background-color:#ccffe5;">교육3팀</li>
				<li class="list-group-item" id="stuteam_three_yrje" style="padding-left:200px; background-color:#b3ffd7;">임유리,김지은</li>
</ul>
</div>


   
  
	
	
