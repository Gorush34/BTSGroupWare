<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% String ctxPath = request.getContextPath(); %>
<style type="text/css">

</style>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script type="text/javascript">

$(document).ready(function(){
$("button#edit").click(function(){
		
		// 제목 유효성 검사
		var rname = $("input#rname").val().trim();
        if(rname==""){
			alert("자원명을 입력하세요."); 
			return;
		}
        
        // 분류 선택 유무 검사
		var pk_classno = $("select.pk_classno").val().trim();
		if(pk_classno==""){
			alert("분류를 선택하세요."); 
			return;
		}
		
		// 내용 유효성 검사
		var rinfo = $("textarea#rinfo").val().trim();
        if(rinfo==""){
			alert("자원정보를 입력하세요."); 
			return;
		}
		

		
		var frm = document.resourceEditEndFrm;
		frm.action="<%= ctxPath%>/resource/resourceEditEnd.bts";
		frm.method="post";
		frm.submit();
	
	});
	
});
	// 자원 삭제
	function resourceDel(){
		var bool = confirm("자원을 삭제하시겠습니까?");
		
		if(bool){
			$.ajax({
				url: "<%= ctxPath%>/resource/deleteResource.bts",
				type: "post",
				data: {"pk_rno":$("input#pk_rno").val()},
				dataType: "json",
				success:function(json){
					if(json.n==1){
						alert("자원을 삭제하였습니다.");
					}
					else {
						alert("자원을 삭제하지 못했습니다.");
					}
					
					location.href="<%= ctxPath%>/reservation/reservationAdmin.bts";
				},
				error: function(request, status, error){
		            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		        }
			});
		}
		
	}// end of function delSchedule(scheduleno){}-------------------------
	
</script>

<div id="resourceRegister" >
<h4 style="margin: 0 80px">자산목록 > 자산추가</h4>
	<form name="resourceEditEndFrm">
		<div id="resourceFrm" style="margin:50px auto;">
			<table id="resourceRegisterContent" style="margin-left:auto; margin-right:auto;">
				<c:if test="${not empty requestScope.resourceList}" var="map">
				<c:forEach var="map" items="${requestScope.resourceList}">
				<tr>
					<th>자산명</th>
					<td><input type="text" name="rname" id="rname" value="${map.RNAME}"/><input type="hidden" id="pk_rno" name="pk_rno" value="${map.PK_RNO}"></td>
				</tr>
				<tr> 
					<th>분류</th>
					<td>
						<select class="pk_classno" id="pk_classno" name="pk_classno"> 
	                   	 <option value="">선택하세요</option>
						 <option value="1">3층 회의실</option>
						 <option value="2">자동차</option>
						 <option value="3">빔프로젝터</option>
					    </select>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea rows="10" cols="100" style="height: 200px;" name="rinfo" id="rinfo"  class="form-control">${map.RINFO}</textarea></td>
				</tr>
				</c:forEach>
				</c:if>
			</table>
			<div style="text-align: center; margin-top:30px;">
				<button type="button" class="btn btn-primary btn-sm" id="edit"  >수정</button>
				<button type="button" class="btn btn-danger btn-sm" onclick="resourceDel()" >삭제</button>
				<button type="button" class="btn btn-outline-primary btn-sm" onclick="javascript:location.href='<%= ctxPath%>/reservation/reservationMain.bts'">취소</button>
			</div>
	  </div>
	</form>
</div>