<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
   String ctxPath = request.getContextPath();
  //       /board 
%>
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
			
		  
	}); // end of $( document ).ready( function()

</script>

<style type="text/css">

	#tbl_depName { 
		border-collapse: separate;
		border-spacing: 0 12px;
	}

</style>

<title>부서상세정보</title>

<h1>조직도</h1>
<br>

<ul class="nav nav-tabs">
  <li class="nav-item">
    <a class="nav-link active" data-toggle="tab" href="#depName">부서정보</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" data-toggle="tab" href="#depInfo">부서원 목록</a>
  </li>
</ul>
<div class="tab-content">
  <div class="tab-pane fade show active" id="depName">
    <table id="tbl_depName">
    	<tr>
    		<td style="dispay:inline;">
	    		<p style="font-size:25pt;"><strong>영업팀</strong><p>
			    <p style="font-size:11pt;">영업팀 입니다</p>
			</td>
		</tr>
		<tr>
    		<td style="dispay:inline-block;">
	    		<p style="font-size:25pt;"><strong>마케팅팀</strong><p>
			    <p style="font-size:11pt;">마케팅팀 입니다</p>
			</td>
		</tr>
		<tr>
    		<td style="dispay:inline-block;">
	    		<p style="font-size:25pt;"><strong>기획팀</strong><p>
			    <p style="font-size:11pt;">기획팀 입니다</p>
			</td>
		</tr>
		<tr>
    		<td style="dispay:inline-block;">
	    		<p style="font-size:25pt;"><strong>총무팀</strong><p>
			    <p style="font-size:11pt;">총무팀 입니다</p>
			</td>
		</tr>
		<tr>
    		<td style="dispay:inline-block;">
	    		<p style="font-size:25pt;"><strong>인사팀</strong><p>
			    <p style="font-size:11pt;">인사팀 입니다</p>
			</td>
		</tr>
		<tr>
    		<td style="dispay:inline-block;">
	    		<p style="font-size:25pt;"><strong>회계팀</strong><p>
			    <p style="font-size:11pt;">회계팀 입니다</p>
			</td>
		</tr>
	</table>
  </div>
  
  <!-- 부서원 목록  -->
  <div class="tab-pane fade" id="depInfo">
  
	  <table style="float:left;">
			<tr>
				<td><button class="btn btn-default" id="y_team" style="width:150px; border: solid darkgray 2px;">영업팀</button></td>
			</tr>
			<tr>
			<td>
				<div id="y_teamwon">
						<p style="text-align:center;">홍길동 <br>[부장]</p>
						<p style="text-align:center;">홍길동 <br>[부장]</p>
						<p style="text-align:center;">홍길동 <br>[부장]</p>
						<p style="text-align:center;">홍길동 <br>[부장]</p>
						<p style="text-align:center;">홍길동 <br>[부장]</p>
				</div>
			</td>
			</tr>
			<tr>
				<td><button class="btn btn-default" id="m_team" style="width:150px; border: solid darkgray 2px;">마케팅팀</button></td>
			</tr>
			<tr>
			<td>
				<div id="m_teamwon">
						<p style="text-align:center;">홍길동 <br>[부장]</p>
						<p style="text-align:center;">홍길동 <br>[부장]</p>
						<p style="text-align:center;">홍길동 <br>[부장]</p>
						<p style="text-align:center;">홍길동 <br>[부장]</p>
						<p style="text-align:center;">홍길동 <br>[부장]</p>
				</div>
			</td>
			</tr>
			<tr>
				<td><button class="btn btn-default" id="g_team" style="width:150px; border: solid darkgray 2px;">기획팀</button></td>
			</tr>
			<tr>
			<td>
				<div id="g_teamwon">
						<p style="text-align:center;">홍길동 <br>[부장]</p>
						<p style="text-align:center;">홍길동 <br>[부장]</p>
						<p style="text-align:center;">홍길동 <br>[부장]</p>
						<p style="text-align:center;">홍길동 <br>[부장]</p>
						<p style="text-align:center;">홍길동 <br>[부장]</p>
				</div>
			</td>
			</tr>
			<tr>
				<td><button class="btn btn-default" id="c_team" style="width:150px; border: solid darkgray 2px;">총무팀</button></td>
			</tr>
			<tr>
			<td>
				<div id="c_teamwon">
						<p style="text-align:center;">홍길동 <br>[부장]</p>
						<p style="text-align:center;">홍길동 <br>[부장]</p>
						<p style="text-align:center;">홍길동 <br>[부장]</p>
						<p style="text-align:center;">홍길동 <br>[부장]</p>
						<p style="text-align:center;">홍길동 <br>[부장]</p>
				</div>
			</td>
			</tr>
			<tr>
				<td><button class="btn btn-default" id="i_team" style="width:150px; border: solid darkgray 2px;">인사팀</button></td>
			</tr>
			<tr>
			<td>
				<div id="i_teamwon">
						<p style="text-align:center;">홍길동 <br>[부장]</p>
						<p style="text-align:center;">홍길동 <br>[부장]</p>
						<p style="text-align:center;">홍길동 <br>[부장]</p>
						<p style="text-align:center;">홍길동 <br>[부장]</p>
						<p style="text-align:center;">홍길동 <br>[부장]</p>
				</div>
			</td>
			</tr>
			<tr>
				<td><button class="btn btn-default" id="h_team" style="width:150px; border: solid darkgray 2px;">회계팀</button></td>
			</tr>
			<tr>
			<td>
				<div id="h_teamwon">
						<p style="text-align:center;">홍길동 <br>[부장]</p>
						<p style="text-align:center;">홍길동 <br>[부장]</p>
						<p style="text-align:center;">홍길동 <br>[부장]</p>
						<p style="text-align:center;">홍길동 <br>[부장]</p>
						<p style="text-align:center;">홍길동 <br>[부장]</p>
				</div>
			</td>
			</tr>
  	</table>
  	
  
	 <div id="telAdd_main_tbl" style="text-align:center;">
		<table>
			<tr>
				<td><h2>개인정보</h2></td>
			</tr>
			<tr>
				<td><strong>사진</strong></td>
				<td><img src="<%=ctxPath %>/resources/images/addBook_perInfo_sample.jpg" class="img-rounded"><button class="btn btn-default" id="telAdd_mini_btn">삭제</button></td>
			</tr>
			<tr>
				<td><strong>이름</strong></td>
				<td><input type="text" class="form-control" placeholder="문병윤" readonly><br></td>
			</tr>
			<tr>
				<td><strong>회사</strong></td>
				<td><input type="text" class="form-control" placeholder="쌍용그룹" readonly><br></td>
			</tr>
			<tr>
				<td><strong>부서</strong></td>
				<td><input type="text" class="form-control" placeholder="BTS" readonly><br></td>
			</tr>
			<tr>
				<td><strong>직위</strong></td>
				<td><input type="text" class="form-control" placeholder="쫄병" readonly><br></td>
			</tr>
			<tr>
				<td><strong>이메일</strong></td>
				<td><input type="text" class="form-control" placeholder="mby0225@naver.com" readonly><br></td>
			</tr>
			<tr>
				<td><strong>휴대폰</strong></td>
				<td><input type="text" class="form-control" placeholder="010-4646-4376" readonly><br></td>
			</tr>
			<tr>
				
				<td><strong>주소</strong></td>
				<td><input type="text" class="form-control" placeholder="서울시 용산구 후암로 22길 24, 101동 202호" style="width: 140%;" readonly><br></td>
				
			</tr>
			<tr>
				<td><strong>메모사항</strong></td>
				<td><input type="text" class="form-control" placeholder="오타를 내지말자" style="width:150%; height: 50px;" readonly></td>
			</tr>
			
			<tr>
				<td></td>
				<td colspan="10" style="text-align:center; padding-top: 18%; ">
					<button class="btn btn-info" id="" style="border: solid lightgray 2px;" >저장</button>
					<button class="btn btn-default" id="" style="border: solid lightgray 2px;">취소</button>
				</td>
			</tr>
		</table>
	</div>
	</div>
</div>