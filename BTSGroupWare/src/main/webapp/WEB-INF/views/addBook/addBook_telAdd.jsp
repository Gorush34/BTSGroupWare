<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
   String ctxPath = request.getContextPath();

%>


<script type="text/javascript">

	

	function goTelAdd() {
		
		const frm = document.telAddFrm;
	    frm.action = "<%=ctxPath%>/addBook/addBook_telAdd_insert.bts"
	    frm.method = "post"
	    frm.submit();
	}



</script>

<style type="text/css">

#tbl_telAdd_ { 
		border-collapse: separate;
		border-spacing: 0 12px;
	}

</style>

<title>연락처추가페이지</title>

	<div id="telAdd_main_tbl" style="text-align:center;">
	<form name="telAddFrm"> 
	<table id="tbl_telAdd_">
		<tr>
			<td><h2>연락처 추가<br><br></h2></td>
		</tr>
		<tr>
			<td><strong>사진</strong></td>
			<td><img src="<%=ctxPath %>/resources/images/addBook_telAdd_sample.jpg" alt="..." class="img-rounded"><button class="btn btn-default" id="telAdd_mini_btn">삭제</button></td>
		</tr>
		<tr>
			<td><strong>이름</strong></td>
			<td><input type="text" class="form-control" id="name" name="name" placeholder="이름"></td>
		</tr>
		<tr>
			<td><strong>회사</strong></td>
			<td><input type="text" class="form-control" id="company" name="company" placeholder="회사"></td>
		</tr>
		<tr>
			<td><strong>부서</strong></td>
			<td><input type="text" class="form-control" id="department" name="department" placeholder="부서"></td>
		</tr>
		<tr>
			<td><strong>직위</strong></td>
			<td><input type="text" class="form-control" id="rank" name="rank" placeholder="직위"></td>
		</tr>
		<tr>
			<td><strong>이메일</strong></td>
			<td><input type="text" class="form-control" id="email" name="email" placeholder="이메일"></td>
		</tr>
		<tr>
			<td><strong>휴대폰</strong></td>
			<td><input type="text" class="form-control" id="phone" name="phone" placeholder="휴대폰"></td>
		</tr>
		<tr>
			
			<td><strong>회사주소</strong></td>
			<td><input type="text" class="form-control" id="company_address" name="company_address" placeholder="회사주소" style="width: 110%;"></td>
			
		</tr>
		<tr>
			<td><strong>메모사항</strong></td>
			<td><input type="text" class="form-control" id="memo" name="memo" placeholder="메모사항" style="width:120%; height: 80px;"></td>
		</tr>
		
		<tr>
			<td></td>
			<td colspan="10" style="text-align:center; padding-top: 18%; ">
				<input type="submit" class="btn btn-info" style="border: solid lightgray 2px;" value="확인" onclick="location.href='http://localhost:9090/bts/addBook/addBook_main.bts'" />
				<input type="submit" class="btn btn-info" style="border: solid lightgray 2px;" value="계속 등록" onclick="location.href='http://localhost:9090/bts/addBook/addBook_telAdd.bts'" />
				<input type="button" class="btn btn-default" style="border: solid lightgray 2px;" value="목록으로 이동" onclick="location.href='http://localhost:9090/bts/addBook/addBook_main.bts'" />
				<input type="reset" class="btn btn-default" style="border: solid lightgray 2px;" value="취소"  onclick="location.href='http://localhost:9090/bts/addBook/addBook_main.bts'"  />
			</td>
		</tr>
	</table>
	</form>
	</div>
	


	<!-- 모달 -->
	<!--  
	<div class="modal fade" id="myModal" role="dialog"> 
		<div class="modal-dialog"> 
			<div class="modal-content"> 
				<div class="modal-header"> 
					<h4 class="modal-title">모달 제목</h4> 
					</div> 
					<div class="modal-body"> 
					<p>팝업 내용</p> 
					</div> 
					<div class="modal-footer"> 
					<button type="button" class="close" data-dismiss="modal">×</button>  
				</div> 
			</div> 
		</div> 
	</div>
	-->

