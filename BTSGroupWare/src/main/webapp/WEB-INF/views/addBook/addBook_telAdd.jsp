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
			<td><input type="text" class="form-control" id="addb_name" name="addb_name" placeholder="이름"></td>
		</tr>
		<tr>
			<td><strong>부서</strong></td>
			<td>
				<select id="department" name="department" class="form-control">
				  <option selected >--</option>
				  <option value="100">영업</option>
				  <option value="200">마케팅</option>
				  <option value="300">기획</option>
				  <option value="400">총무</option>
				  <option value="500">인사</option>
				  <option value="600">회계</option>
				</select>
			</td>
		</tr>
		<tr>
			<td><strong>직위</strong></td>
			<td>
				<select id="rank" name="rank" class="form-control">
				  <option selected >--</option>
				  <option value="10">사원</option>
				  <option value="20">주임</option>
				  <option value="30">대리</option>
				  <option value="40">과장</option>
				  <option value="50">차장</option>
				  <option value="60">부장</option>
				  <option value="70">전무</option>
				  <option value="80">사장</option>
				</select>
			</td>
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
			<td><strong>회사</strong></td>
			<td><input type="text" class="form-control" id="company" name="company" placeholder="회사"></td>
		</tr>
		<tr>
			<td><strong>회사전화번호</strong></td>
			<td><input type="text" class="form-control" id="com_tel" name="com_tel" placeholder="회사전화번호"></td>
		</tr>
		<tr>
			<td><strong>회사주소</strong></td>
			<td><input type="text" class="form-control" id="company_address" name="company_address" placeholder="회사주소" style="width: 120%;"></td>
		</tr>
		<tr>
			<td><strong>메모사항</strong></td>
			<td><input type="text" class="form-control" id="memo" name="memo" placeholder="메모사항" style="width:120%; height: 80px;"></td>
		</tr>
		</table>
		</form>
			<div id="buttonmenu">
				<input type="submit" class="btn btn-info" style="border: solid lightgray 2px;" value="확인" onclick="goTelAdd()" />
				<input type="submit" class="btn btn-info" style="border: solid lightgray 2px;" value="계속 등록" onclick="location.href='http://localhost:9090/bts/addBook/addBook_telAdd.bts'" />
				<input type="button" class="btn btn-default" style="border: solid lightgray 2px;" value="목록으로 이동" onclick="location.href='http://localhost:9090/bts/addBook/addBook_main.bts'" />
				<input type="reset" class="btn btn-default" style="border: solid lightgray 2px;" value="취소"  onclick="location.href='http://localhost:9090/bts/addBook/addBook_main.bts'"  />
			</div>
			
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

