<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String ctxPath = request.getContextPath();
%>   

<style type="text/css">

</style>

<script type="text/javascript">

  $(document).ready(function(){
	  
	 $("button#btnDelete").click(function(){
		  
		 if( "${requestScope.pw}" != $("input#pw").val() ) {
			 alert("글암호가 일치하지 않습니다.");
			 return;
		 } 
		 else {
			// 폼(form)을 전송(submit)
			const frm = document.delFrm;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/board/delEnd.bts";
			frm.submit();
		 }
		 
	 });
	  
  });// end of $(document).ready(function(){})-------------------------------

</script>

<div style="display: flex;">
<div style="margin: auto; padding-left: 3%;">

<h2 style="margin-bottom: 30px;">글삭제</h2>

<form name="delFrm">
	<table style="width: 1024px" class="table table-bordered">
		<tr>
			<th style="width: 15%; background-color: #DDDDDD;">글암호</th>
			<td>
				<input type="password" id="pw" />
				<input type="hidden" name="pk_seq" value="${requestScope.pk_seq}" readonly />
			</td>
		</tr>
	</table>
	
	<div style="margin: 20px;">
		<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnDelete">글삭제완료</button>
		<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">글삭제취소</button>
	</div>
	
</form>   
</div>
</div>    
