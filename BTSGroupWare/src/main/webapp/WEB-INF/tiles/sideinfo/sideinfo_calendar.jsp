<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    
<% String ctxPath = request.getContextPath(); %>

<link rel="stylesheet" type="text/css" href="<%=ctxPath %>/resources/css/style_calendar.css" />
<%-- 캘린더(일정) 사이드 tiles 만들기 --%>

<style type="text/css">


</style>


<script type="text/javascript">

	$(document).ready(function(){
		
		// 캘린더 클릭시 일정 체크 박스 보이기, 숨기기
	//	$("div.slideTogglebox").hide();
		
		$("div#calenderbtn1").click(function(){
			$("div#slideTogglebox1").slideToggle();
		})
		
		$("div#calenderbtn2").click(function(){
			$("div#slideTogglebox2").slideToggle();
		})
		
		// 일정 체크 박스 추가
		
	
		
		
		
	});// end of $(document).ready(function(){}-------------------

			
	//Function Declaration
	
	// 일정 체크 박스 추가
	function goAddCheckbox(){
		
		const cal_name = $("input#cal_name").val().trim();
		if(addSche == ""){
			alert("추가할 일정을 입력하세요");
			return; 
		}
<%--		else{
			$.ajax({
				url:"<%= ctxPath%>/addCalenderName.bts",
				data:{"cal_name":$("input#cal_name").val()
					, "fk_사원번호":($"input#fk_사원번호").val()},
				type:"POST",
				dataType:"JSON",
				success:function(json){
					
				},
				error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }
			});
		} --%>
	}// end of function goAddCheckbox()------------------------------------------------
			
</script>

	<div>
	   <div id="sidebar" style="font-size: 11pt;">
		 <h4>캘린더</h4>
			<button type="button" class="btn btn-outline-primary btn-lg" style="margin: 15px 10px 15px 10px;" onclick="<%= ctxPath%>/schedualRegister.bts">일정등록</button>
			<ul style="list-style-type: none;">
				<li style="margin-bottom: 15px;">
					<div id="calenderbtn1" class="calenderbtn">내 캘린더</div>
						<div id="slideTogglebox1"  class="slideTogglebox">
							<table>
								<tbody>
									<tr id="schecheck">
										<td><input type="checkbox" name="mySche" id="mySche" style="vertical-align: top;"/></td>
					   					<td><label for="mySche"><span style="margin-left: 5px;">내 일정</span></label></td>
					   				</tr>	
				   				</tbody>	
			   				</table>	
						</div>
						<span id="addmyschedual" data-toggle="modal" data-target="#addMyScheModal">&nbsp;&nbsp;+ 내 캘린더 추가</span>
							
							<%-- 모달로 추가창 띄우기 --%>
							  <div class="modal fade" id="addMyScheModal" data-backdrop="static">
							  	<div class="modal-dialog modal-dialog-centered">
							  		<div class="modal-content">
									  <div class="modal-header">
								        <h5 class="modal-title">내 캘린더 추가</h5>
								        <button type="button" class="close" data-dismiss="modal">&times;</button>
								      </div>
								      <div class="modal-body">
								      	<input type="hidden" name="fk_사원번호" id="fk_사원번호"/>
								        <input type="text" name="cal_name" id="cal_name"/>
								      </div>
								      <div class="modal-footer">
								        <button type="button" class="btn btn-primary btn-sm" onclick="goAddCheckbox()">확인</button>
								        <button type="button" class="btn btn-outline-primary btn-sm" data-dismiss="modal">취소</button>
								      </div>
								    </div>
						   		</div>
					    	 </div>
				</li>
				<li style="margin-bottom: 15px;">
					<div id="calenderbtn2" class="calenderbtn">관심 캘린더</div>
						<div id="slideTogglebox2"  class="slideTogglebox">	
							<table>
								<tbody>
									<tr id="schecheck">
										<td><input type="checkbox" name="allSche" id="allSche" style="vertical-align: top;"/></td>
			   							<td><label for="allSche"><span style="margin-left: 5px;">전체</span></label></td>
			   						</tr>	
				   				</tbody>	
			   				</table>				
						</div>
						
						<span id="addschedual" data-toggle="modal" data-target="#addScheModal">&nbsp;&nbsp;+ 관심 캘린더 추가</span>
							
							<%-- 모달로 추가창 띄우기 : --%>
							  <div class="modal fade" id="addScheModal" data-backdrop="static">
							  	<div class="modal-dialog modal-dialog-centered">
							  		<div class="modal-content">
									  <div class="modal-header">
								        <h5 class="modal-title">관심 캘린더 추가</h5>
								        <button type="button" class="close" data-dismiss="modal">&times;</button>
								      </div>
								      <div class="modal-body">
								        <input type="text" name="searchMember" id="searchMember" autocomplete="off" placeholder="이름/아이디/부서/직책/이메일/전화"/>
								        <div >
								        </div>
								      </div>
								      <div class="modal-footer">
								        <button type="button" class="btn btn-primary btn-sm" onclick="goAddCheckbox()">확인</button>
								        <button type="button" class="btn btn-outline-primary btn-sm" data-dismiss="modal">취소</button>
								      </div>
								    </div>
						   		</div>
					    	 </div>	
				</li>
			</ul>
			<hr>
			
			<table>
				<tbody>
					<tr id="schecheck">
						<td><input type="checkbox" name="comSche" id="comSche" style="vertical-align: top;"/></td>
	   					<td style="vertical-align: middle;"><label for="comSche"><span style="margin-left: 5px;">전사일정</span></label></td>
	   				</tr>
	   				<tr id="schecheck">
						<td><input type="checkbox" name="excSche" id="excSche" style="vertical-align: top;"/></td>
	   					<td><label for="excSche"><span style="margin-left: 5px;">임원일정</span></label></td>
	   				</tr>	
   				</tbody>	
  			</table>	
			
			
		</div>
	</div>
	