<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
   String ctxPath = request.getContextPath();
  
%>



<script type="text/javascript">

$( document ).ready( function() {
	
	$( "#D_head" ).slideToggle().hide();
	
	$( "#D_tchteam" ).slideToggle().hide();
	$( "#D_mngteam" ).slideToggle().hide();
	$( "#D_stuteam" ).slideToggle().hide();
	
	$( "#D_tchteam_one" ).slideToggle().hide();
	$( "#D_tchteam_two" ).slideToggle().hide();
	$( "#D_tchteam_three" ).slideToggle().hide();
	$( "#D_mngteam_one" ).slideToggle().hide();
	$( "#D_mngteam_two" ).slideToggle().hide();
	$( "#D_mngteam_three" ).slideToggle().hide();
	$( "#D_stuteam_one" ).slideToggle().hide();
	$( "#D_stuteam_two" ).slideToggle().hide();
	$( "#D_stuteam_three" ).slideToggle().hide();
	
	$( "#D_tchteam_one_ssjh" ).slideToggle().hide();
	$( "#D_tchteam_two_ssjh" ).slideToggle().hide();
	$( "#D_tchteam_three_ssjh" ).slideToggle().hide();
	$( "#D_mngteam_one_kdeu" ).slideToggle().hide();
	$( "#D_mngteam_two_kdeu" ).slideToggle().hide();
	$( "#D_mngteam_three_kdeu" ).slideToggle().hide();
	$( "#D_stuteam_one_hmmj" ).slideToggle().hide();
	$( "#D_stuteam_two_bymg" ).slideToggle().hide();
	$( "#D_stuteam_three_yrje" ).slideToggle().hide();
	
$( "#BD_head" ).slideToggle().hide();
	
	$( "#BD_tchteam" ).slideToggle().hide();
	$( "#BD_mngteam" ).slideToggle().hide();
	$( "#BD_stuteam" ).slideToggle().hide();
	
	$( "#BD_tchteam_one" ).slideToggle().hide();
	$( "#BD_tchteam_two" ).slideToggle().hide();
	$( "#BD_tchteam_three" ).slideToggle().hide();
	$( "#BD_mngteam_one" ).slideToggle().hide();
	$( "#BD_mngteam_two" ).slideToggle().hide();
	$( "#BD_mngteam_three" ).slideToggle().hide();
	$( "#BD_stuteam_one" ).slideToggle().hide();
	$( "#BD_stuteam_two" ).slideToggle().hide();
	$( "#BD_stuteam_three" ).slideToggle().hide();
	
	$( "#BD_tchteam_one_ssjh" ).slideToggle().hide();
	$( "#BD_tchteam_two_ssjh" ).slideToggle().hide();
	$( "#BD_tchteam_three_ssjh" ).slideToggle().hide();
	$( "#BD_mngteam_one_kdeu" ).slideToggle().hide();
	$( "#BD_mngteam_two_kdeu" ).slideToggle().hide();
	$( "#BD_mngteam_three_kdeu" ).slideToggle().hide();
	$( "#BD_stuteam_one_hmmj" ).slideToggle().hide();
	$( "#BD_stuteam_two_bymg" ).slideToggle().hide();
	$( "#BD_stuteam_three_yrje" ).slideToggle().hide();
	
//////////////////////////////////////////////////////////////	

	$( "#ALL_head" ).click( function() {
	    $( "#D_head" ).slideToggle();
	});    

	$( "#D_head" ).click( function() {
	    $( "#D_tchteam" ).slideToggle();
	    $( "#D_mngteam" ).slideToggle();
	    $( "#D_stuteam" ).slideToggle();
	});
	
	$( "#D_tchteam" ).click( function() {
	    $( "#D_tchteam_one" ).slideToggle();
	    $( "#D_tchteam_two" ).slideToggle();
	    $( "#D_tchteam_three" ).slideToggle();
	});
	
	$( "#D_mngteam" ).click( function() {
	    $( "#D_mngteam_one" ).slideToggle();
	    $( "#D_mngteam_two" ).slideToggle();
	    $( "#D_mngteam_three" ).slideToggle();
	});
	
	$( "#D_stuteam" ).click( function() {
	    $( "#D_stuteam_one" ).slideToggle();
	    $( "#D_stuteam_two" ).slideToggle();
	    $( "#D_stuteam_three" ).slideToggle();
	});
	
	$( "#D_tchteam_one" ).click( function() {
	    $( "#D_tchteam_one_ssjh" ).slideToggle();
	});
	$( "#D_tchteam_two" ).click( function() {
	    $( "#D_tchteam_two_ssjh" ).slideToggle();
	});
	$( "#D_tchteam_three" ).click( function() {
	    $( "#D_tchteam_three_ssjh" ).slideToggle();
	});
	
	$( "#D_mngteam_one" ).click( function() {
	    $( "#D_mngteam_one_kdeu" ).slideToggle();
	});
	$( "#D_mngteam_two" ).click( function() {
	    $( "#D_mngteam_two_kdeu" ).slideToggle();
	});
	$( "#D_mngteam_three" ).click( function() {
	    $( "#D_mngteam_three_kdeu" ).slideToggle();
	});
	
	$( "#D_stuteam_one" ).click( function() {
	    $( "#D_stuteam_one_hmmj" ).slideToggle();
	});
	$( "#D_stuteam_two" ).click( function() {
	    $( "#D_stuteam_two_bymg" ).slideToggle();
	});
	$( "#D_stuteam_three" ).click( function() {
	    $( "#D_stuteam_three_yrje" ).slideToggle();
	});
	
	
	
	$( "#ALL_head" ).click( function() {
	    $( "#BD_head" ).slideToggle();
	});    

	$( "#BD_head" ).click( function() {
	    $( "#BD_tchteam" ).slideToggle();
	    $( "#BD_mngteam" ).slideToggle();
	    $( "#BD_stuteam" ).slideToggle();
	});
	
	$( "#BD_tchteam" ).click( function() {
	    $( "#BD_tchteam_one" ).slideToggle();
	    $( "#BD_tchteam_two" ).slideToggle();
	    $( "#BD_tchteam_three" ).slideToggle();
	});
	
	$( "#BD_mngteam" ).click( function() {
	    $( "#BD_mngteam_one" ).slideToggle();
	    $( "#BD_mngteam_two" ).slideToggle();
	    $( "#BD_mngteam_three" ).slideToggle();
	});
	
	$( "#BD_stuteam" ).click( function() {
	    $( "#BD_stuteam_one" ).slideToggle();
	    $( "#BD_stuteam_two" ).slideToggle();
	    $( "#BD_stuteam_three" ).slideToggle();
	});
	
	$( "#BD_tchteam_one" ).click( function() {
	    $( "#BD_tchteam_one_ssjh" ).slideToggle();
	});
	$( "#BD_tchteam_two" ).click( function() {
	    $( "#BD_tchteam_two_ssjh" ).slideToggle();
	});
	$( "#BD_tchteam_three" ).click( function() {
	    $( "#BD_tchteam_three_ssjh" ).slideToggle();
	});
	
	$( "#BD_mngteam_one" ).click( function() {
	    $( "#BD_mngteam_one_kdeu" ).slideToggle();
	});
	$( "#BD_mngteam_two" ).click( function() {
	    $( "#BD_mngteam_two_kdeu" ).slideToggle();
	});
	$( "#BD_mngteam_three" ).click( function() {
	    $( "#BD_mngteam_three_kdeu" ).slideToggle();
	});
	
	$( "#BD_stuteam_one" ).click( function() {
	    $( "#BD_stuteam_one_hmmj" ).slideToggle();
	});
	$( "#BD_stuteam_two" ).click( function() {
	    $( "#BD_stuteam_two_bymg" ).slideToggle();
	});
	$( "#BD_stuteam_three" ).click( function() {
	    $( "#BD_stuteam_three_yrje" ).slideToggle();
	});
	
	
	
	
	
	
  
  
}); // end of $( document ).ready( function()

</script>

<title>조직도</title>


<div class="col-sm-7">
<h2>Collapsed<br><br></h2>
<ul>
	<li class="list-group-item" id="ALL_head">쌍용그룹</li>
		<li class="list-group-item" id="D_head" style="padding-left:50px;">대면본부</li>
			<li class="list-group-item" id="D_tchteam" style="padding-left:100px;">대면강사팀</li>
				<li class="list-group-item" id="D_tchteam_one" style="padding-left:150px;">강사1팀</li>
					<li class="list-group-item" id="D_tchteam_one_ssjh" style="padding-left:200px;">서순신,서정화</li>
				<li class="list-group-item" id="D_tchteam_two" style="padding-left:150px;">강사2팀</li>
					<li class="list-group-item" id="D_tchteam_two_ssjh" style="padding-left:200px;">영순신,영정화</li>
				<li class="list-group-item" id="D_tchteam_three" style="padding-left:150px;">강사3팀</li>	
					<li class="list-group-item" id="D_tchteam_three_ssjh" style="padding-left:200px;">학순신,학정화</li>
			<li class="list-group-item" id="D_mngteam" style="padding-left:100px;">대면매니저팀</li>
				<li class="list-group-item" id="D_mngteam_one" style="padding-left:150px;">매니저1팀</li>
					<li class="list-group-item" id="D_mngteam_one_kdeu" style="padding-left:200px;">강길동,강이유</li>
				<li class="list-group-item" id="D_mngteam_two" style="padding-left:150px;">매니저2팀</li>
					<li class="list-group-item" id="D_mngteam_two_kdeu" style="padding-left:200px;">태길동,태이유</li>
				<li class="list-group-item" id="D_mngteam_three" style="padding-left:150px;">매니저3팀</li>
					<li class="list-group-item" id="D_mngteam_three_kdeu" style="padding-left:200px;">림길동,림이유</li>
			<li class="list-group-item" id="D_stuteam" style="padding-left:100px;">대면교육생팀</li>
				<li class="list-group-item" id="D_stuteam_one" style="padding-left:150px;">교육1팀</li>
					<li class="list-group-item" id="D_stuteam_one_hmmj" style="padding-left:200px;">정환모,김민정</li>
				<li class="list-group-item" id="D_stuteam_two" style="padding-left:150px;">교육2팀</li>
					<li class="list-group-item" id="D_stuteam_two_bymg" style="padding-left:200px;">문병윤,성문길</li>
				<li class="list-group-item" id="D_stuteam_three" style="padding-left:150px;">교육3팀</li>
					<li class="list-group-item" id="D_stuteam_three_yrje" style="padding-left:200px;">임유리,김지은</li>
					
		
		<li class="list-group-item" id="BD_head" style="padding-left:50px;">비대면본부</li>
			<li class="list-group-item" id="BD_tchteam" style="padding-left:100px;">비대면강사팀</li>
				<li class="list-group-item" id="BD_tchteam_one" style="padding-left:150px;">강사1팀</li>
					<li class="list-group-item" id="BD_tchteam_one_ssjh" style="padding-left:200px;">서순신,서정화</li>
				<li class="list-group-item" id="BD_tchteam_two" style="padding-left:150px;">강사2팀</li>
					<li class="list-group-item" id="BD_tchteam_two_ssjh" style="padding-left:200px;">영순신,영정화</li>
				<li class="list-group-item" id="BD_tchteam_three" style="padding-left:150px;">강사3팀</li>	
					<li class="list-group-item" id="BD_tchteam_three_ssjh" style="padding-left:200px;">학순신,학정화</li>
			<li class="list-group-item" id="BD_mngteam" style="padding-left:100px;">비대면매니저팀</li>
				<li class="list-group-item" id="BD_mngteam_one" style="padding-left:150px;">매니저1팀</li>
					<li class="list-group-item" id="BD_mngteam_one_kdeu" style="padding-left:200px;">강길동,강이유</li>
				<li class="list-group-item" id="BD_mngteam_two" style="padding-left:150px;">매니저2팀</li>
					<li class="list-group-item" id="BD_mngteam_two_kdeu" style="padding-left:200px;">태길동,태이유</li>
				<li class="list-group-item" id="BD_mngteam_three" style="padding-left:150px;">매니저3팀</li>
					<li class="list-group-item" id="BD_mngteam_three_kdeu" style="padding-left:200px;">림길동,림이유</li>
			<li class="list-group-item" id="BD_stuteam" style="padding-left:100px;">비대면교육생팀</li>
				<li class="list-group-item" id="BD_stuteam_one" style="padding-left:150px;">교육1팀</li>
					<li class="list-group-item" id="BD_stuteam_one_hmmj" style="padding-left:200px;">정환모,김민정</li>
				<li class="list-group-item" id="BD_stuteam_two" style="padding-left:150px;">교육2팀</li>
					<li class="list-group-item" id="BD_stuteam_two_bymg" style="padding-left:200px;">문병윤,성문길</li>
				<li class="list-group-item" id="BD_stuteam_three" style="padding-left:150px;">교육3팀</li>
					<li class="list-group-item" id="BD_stuteam_three_yrje" style="padding-left:200px;">임유리,김지은</li>			
</ul>
</div>


   
  
	
	
