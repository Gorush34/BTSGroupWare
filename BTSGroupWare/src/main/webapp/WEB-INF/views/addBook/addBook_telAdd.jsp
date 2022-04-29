<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
   String ctxPath = request.getContextPath();

%>


<script type="text/javascript">


</script>

<title>연락처추가페이지</title>

	<div id="telAdd_main_tbl" style="text-align:center;">
	<table>
		<tr>
			<td><h2>연락처 추가</h2></td>
		</tr>
		<tr>
			<td><strong>사진</strong></td>
			<td><img src="<%=ctxPath %>/resources/images/addBook_telAdd_sample.jpg" alt="..." class="img-rounded"><button class="btn btn-default" id="telAdd_mini_btn">삭제</button></td>
		</tr>
		<tr>
			<td><strong>성</strong></td>
			<td><input type="text" class="form-control" placeholder="성"></td>
		</tr>
		<tr>
			<td><strong>이름</strong></td>
			<td><input type="text" class="form-control" placeholder="이름"></td>
		</tr>
		<tr>
			<td><strong>영문이름</strong></td>
			<td><input type="text" class="form-control" placeholder="영문이름"></td>
		</tr>
		<tr>
			<td><strong>회사</strong></td>
			<td><input type="text" class="form-control" placeholder="회사"></td>
		</tr>
		<tr>
			<td><strong>부서</strong></td>
			<td><input type="text" class="form-control" placeholder="부서"></td>
		</tr>
		<tr>
			<td><strong>직위</strong></td>
			<td><input type="text" class="form-control" placeholder="직위"></td>
		</tr>
		<tr>
			<td><strong>그룹</strong></td>
			<td><button class="btn btn-default" data-toggle="modal" data-target="#myModal">+그룹추가</button></td>
			
		</tr>
		<tr>
			<td><strong>이메일</strong></td>
			<td><input type="text" class="form-control" placeholder="이메일"></td>
		</tr>
		<tr>
			<td><strong>휴대폰</strong></td>
			<td><input type="text" class="form-control" placeholder="휴대폰"></td>
		</tr>
		<tr>
			
			<td><strong>회사주소</strong></td>
			<td><input type="text" class="form-control" placeholder="회사주소" style="width: 110%;"></td>
			
		</tr>
		<tr>
			<td><strong>메모사항</strong></td>
			<td><input type="text" class="form-control" placeholder="메모사항" style="width:120%; height: 80px;"></td>
		</tr>
		<tr>
			<td><strong>항목추가</strong></td>
			<td>
				<select class="form-control" style="width: 120%;">
					<option>추가할 항목을 선택하세요</option>
					<option>생일</option>
					<option>집전화</option>
					<option>집주소</option>
					<option>등등</option>
				</select>
			</td>
		</tr>
		<tr>
			<td></td>
			<td colspan="10" style="text-align:center; padding-top: 18%; ">
				<button class="btn btn-info" id="" style="border: solid lightgray 2px;" >저장</button>
				<button class="btn btn-info" id="" style="border: solid lightgray 2px;" >계속 등록</button>
				<button class="btn btn-default" id="" style="border: solid lightgray 2px;">목록으로 이동</button>
				<button class="btn btn-default" id="" style="border: solid lightgray 2px;">취소</button>
			</td>
		</tr>
	</table>
	</div>
	


	<!-- 모달 -->
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

