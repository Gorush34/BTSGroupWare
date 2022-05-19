<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<style type="text/css">

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		// ==== 종일체크박스에 체크를 할 것인지 안할 것인지를 결정하는 것 시작 ==== //
		// 시작 시 분
		var str_startdate = $("span#startdate").text();
	 // console.log(str_startdate); 
		// 2021-12-01 09:00
		var target = str_startdate.indexOf(":");
		var start_min = str_startdate.substring(target+1);
	 // console.log(start_min);
		// 00
		var start_hour = str_startdate.substring(target-2,target);
	 //	console.log(start_hour);
		// 09
		
		// 종료 시 분
		var str_enddate = $("span#enddate").text();
	//	console.log(str_enddate);
		// 2021-12-01 18:00
		target = str_enddate.indexOf(":");
		var end_min = str_enddate.substring(target+1);
	 // console.log(end_min);
	    // 00 
		var end_hour = str_enddate.substring(target-2,target);
	 //	console.log(end_hour);
		// 18
		
		if(start_hour=='00' && start_min=='00' && end_hour=='23' && end_min=='59' ){
			$("input#allDay").prop("checked",true);
		}
		else{
			$("input#allDay").prop("checked",false);
		}
		// ==== 종일체크박스에 체크를 할 것인지 안할 것인지를 결정하는 것 끝 ==== //
	
		$("input#comment").keydown(function(event){
			
			if(event.keyCode == 13) { // 엔터를 했을 경우
				commentInput();	
			}
		});
		
		getScheduleComment();
		
	}); // end of $(document).ready(function(){}----------------------------------------------------------------------

	
	// ********** Function Declaration ************//
	
	// 댓글 입력
	function commentInput(){
		const comment = $("input#comment").val().trim();
		if(comment == ""){
			alert("댓글 내용을 입력하세요!!");
			return; // 종료
		}
		
		$.ajax({
			url:"<%= ctxPath%>/calendar/commentInput.bts",
			data:{"fk_emp_no":"${sessionScope.loginuser.pk_emp_no}"
				 ,"emp_name":"${sessionScope.loginuser.emp_name}"
				 ,"content":$("input#comment").val()
				 ,"pk_schno":$("input#pk_schno").val()},
			dataType:"json",
			type:"POST",
			success:function(json){
				
				if(json.n == 0){
					alert("댓글 작성 실패");
				}
				else{
					getScheduleComment()
				}
				
				$("input#comment").val("");
				
			},
			  error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	}// end of function commentInput(){}--------------------------------
	
	// 댓글 보여주기
	function getScheduleComment(){
		$.ajax({
			url:"<%= ctxPath%>/calendar/getScheduleComment.bts",
			data:{"pk_schno":$("input#pk_schno").val()},
			dataType:"json",
			success:function(json){
				let html = "";
				if(json.length > 0){
					$.each(json, function(index, item){
						var writeuser = item.FK_EMP_NO;
						var loginuser = "${sessionScope.loginuser.pk_emp_no}";
						  
						  html += "<tr class='commentDetail'>";
						  html += "<td class='comment_name' style='padding-top: 15px; padding-left:20px;'>"+item.NAME+"&nbsp;&nbsp;"+item.REGDATE+"</td>";
						  html += "</tr>";
						  html += "<tr>";
						  html += "<td class='comment_content' style='font-size: 13pt; padding-left:28px;'>"+item.CONTENT+"</td>";
						  if( writeuser == loginuser ) {
							  html += "<td style='text-align: center;' onclick='delComment(\""+item.PK_SCHECONO+"\")'><span style='cursor: pointer; color: gray; margin-left: 10px;'><i class='bi bi-x-circle'></i></span><input type='hidden' value='"+item.PK_SCHECONO+"' id='forDelNo' /></td>";
						    } 
						  html += "</tr>";
					});
				}
				else{
					html += "<tr>";
					html += "<td colspan='4' class='comment' style='padding-top: 30px; padding-left: 120px;'>댓글이 없습니다</td>";
					html += "</tr>";
				}
				
				$("tbody#commentBody").html(html);
				
			},
			  error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});
	}// end of function getScheduleComment(){}-------------------
	
	// 댓글 수정
	
	// 댓글 삭제
	function delComment(pk_schecono){
	
	console.log(pk_schecono);
	var pk_schno = $("input#pk_schno").val();	
	var bool = confirm("댓글을 삭제하시겠습니까?");
		
		if(bool){
			$.ajax({
				url: "<%= ctxPath%>/calendar/delComment.bts",
				type: "post",
				data: {"pk_schecono":pk_schecono},
				dataType: "json",
				success:function(json){
					if(json.n==1){
						alert("댓글을 삭제하였습니다.");
						getScheduleComment();
					}
					else {
						alert("댓글을 삭제하지 못했습니다.");
					}
					
				},
				error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }
			});
		}
	}// end of function delComment(pk_schecono){-----------------------------------------
	
	// 일정 삭제하기
	function delSchedule(pk_schno){
	
		var bool = confirm("일정을 삭제하시겠습니까?");
		
		if(bool){
			$.ajax({
				url: "<%= ctxPath%>/calendar/deleteSchedule.bts",
				type: "post",
				data: {"pk_schno":pk_schno},
				dataType: "json",
				success:function(json){
					if(json.n==1){
						alert("일정을 삭제하였습니다.");
					}
					else {
						alert("일정을 삭제하지 못했습니다.");
					}
					
					location.href="<%= ctxPath%>/calendar/calenderMain.bts";
				},
				error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }
			});
		}
		
	}// end of function delSchedule(scheduleno){}-------------------------


	// 일정 수정하기
	function editSchedule(pk_schno){
		var frm = document.goEditFrm;
		frm.pk_schno.value = pk_schno;
		
		frm.action = "<%= ctxPath%>/calendar/editSchedule.bts";
		frm.method = "post";
		frm.submit();
	}

</script>

<div id="detailSchedule">
<div class="d-flex align-items-center p-3 my-3 text-white bg-purple shadow-sm" style="background-color: #6F42C1;">
    <div class="lh-1" style="text-align: center; width: 100%;">
      <h1 class="h6 mb-0 text-white lh-1" style="font-size:22px; font-weight: bold; ">일정상세</h1>
    </div>
  </div>
	<div class="detailContainer" style="margin:50px 100px;">
	  <div>
			<div style="margin-bottom: 30px;">
				<span id="subject" style="font-weight: bold; font-size: 16pt; color: #007acc;">${requestScope.map.SUBJECT}</span>&nbsp;&nbsp;<input type="hidden" id="pk_schno" value="${requestScope.map.PK_SCHNO}" />
			</div>
			<hr />
			<table id="detailScheduleContent" class="table table-striped" style="font-size: 14pt;">
				<tr>
					<th>일자</th>
					<td>
						<span id="startdate">${requestScope.map.STARTDATE}</span>&nbsp;~&nbsp;<span id="enddate">${requestScope.map.ENDDATE}</span>&nbsp;&nbsp;  
						<input type="checkbox" id="allDay" disabled/>&nbsp;종일
					</td>
				</tr>
				<tr>
					<th>캘린더</th>
					<td>
						<c:if test="${requestScope.map.FK_LGCATGONO eq '2'}">
							사내 캘린더&nbsp;&nbsp;&#58;&nbsp;&nbsp;${requestScope.map.CALNAME}
						</c:if>
						<c:if test="${requestScope.map.FK_LGCATGONO eq '1'}">
							내 캘린더&nbsp;&nbsp;&#58;&nbsp;&nbsp;${requestScope.map.CALNAME}
						</c:if>
					</td>
				</tr>
				<tr>
					<th>참석자</th>
					<td>
					${requestScope.map.JOINUSER}
					</td>
				</tr>
				<tr>
					<th>장소</th>
					<td>${requestScope.map.PLACE}</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>${requestScope.map.CONTENT}</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>${requestScope.map.EMP_NAME}</td>
				</tr>
			</table>
		</div>
		<div id="commentView" style="float: right; margin-left: 30px; padding-left:20px; border-left: 1px solid;">
			<div style="margin: 10px 3px 10px 3px;">댓글</div>
			<div style="margin-top: 20px; vertical-align: bottom;">
			<img src="/bts/resources/images/mu.png" id="memberProfile" style="margin-right: 10px; margin-left: 10px;border: 1px solid #0083b0;">
			<input type="hidden" id="fk_emp_no" value="${sessionScope.loginuser.pk_emp_no}" />
			<input type="hidden" id="emp_name" value="${sessionScope.loginuser.emp_name}" />
			<input type="text" id="comment" style="margin-left: 3px;"/>
			<button type="button"  id="commentInput" onclick="commentInput()"><i class="bi bi-arrow-up-circle-fill"></i></button>
			
			</div>
			<div class="content-body">
				<table>
					<tbody id="commentBody">
					</tbody>
				</table>
			</div>
		</div>
			
	<input type="hidden" value="${sessionScope.loginuser.pk_emp_no}" />
	<input type="hidden" value="${requestScope.map.FK_LGCATGONO}" />
	
	<c:set var="v_fk_emp_no" value="${requestScope.map.FK_EMP_NO}" />
	<c:set var="v_fk_lgcatgono" value="${requestScope.map.FK_LGCATGONO}"/>
	<c:set var="v_loginuser_emp_no" value="${sessionScope.loginuser.pk_emp_no}"/>

	<div style="margin: 40px; text-align: center;">
		<c:if test="${not empty requestScope.listgobackURL_schedule}">
			<c:if test="${v_fk_lgcatgono eq '2' && sessionScope.loginuser.gradelevel == 1 }">
				<button type="button" id="edit" class="btn btn-outline-primary" style="margin-right: 8px;" onclick="editSchedule('${requestScope.map.PK_SCHNO}')">수정</button>
				<button type="button" class="btn_normal" style="margin-right: 8px;"  onclick="delSchedule('${requestScope.map.PK_SCHNO}')">삭제</button>
			</c:if>
			<c:if test="${v_fk_lgcatgono eq '1' && v_fk_emp_no eq v_loginuser_emp_no}">
				<button type="button" id="edit" class="btn btn-outline-primary" style="margin-right: 8px;"  onclick="editSchedule('${requestScope.map.PK_SCHNO}')">수정</button>
				<button type="button" class="btn_normal" style="margin-right: 8px;"  onclick="delSchedule('${requestScope.map.PK_SCHNO}')">삭제</button>
			</c:if>
				<button type="button" id="cancel" class="btn btn-primary"  style="margin-right: 8px;"  onclick="javascript:location.href='<%= ctxPath%>/${requestScope.listgobackURL_schedule}'">취소</button> 
		</c:if>
	
		<c:if test="${empty requestScope.listgobackURL_schedule}">
	        <c:if test="${v_fk_lgcatgono eq '2' && sessionScope.loginuser.gradelevel == 1 }">
				<button type="button" id="edit" class="btn btn-outline-primary"  style="margin-right: 8px;" onclick="editSchedule('${requestScope.map.PK_SCHNO}')">수정</button>
				<button type="button" class="btn btn-outline-primary"  style="margin-right: 8px;" onclick="delSchedule('${requestScope.map.PK_SCHNO}')">삭제</button>
			</c:if>
			<c:if test="${v_fk_lgcatgono eq '1' && v_fk_emp_no eq v_loginuser_emp_no}">
				<button type="button" id="edit" class="btn btn-outline-primary"  style="margin-right: 8px;" onclick="editSchedule('${requestScope.map.PK_SCHNO}')">수정</button>
				<button type="button" class="btn btn-outline-primary"  style="margin-right: 8px;" onclick="delSchedule('${requestScope.map.PK_SCHNO}')">삭제</button>
			</c:if>
				<button type="button" id="cancel" class="btn btn-primary" style="margin-right: 8px;" onclick="javascript:location.href='<%= ctxPath%>/calendar/detailSchedule.bts'">캘린더로 돌아가기</button> 
		</c:if>
		
	</div>

</div>
	


</div>
<form name="goEditFrm">
	<input type="hidden" name="pk_schno"/>
	<input type="hidden" name="gobackURL_ds" value="${requestScope.gobackURL_ds}"/>
</form>
		