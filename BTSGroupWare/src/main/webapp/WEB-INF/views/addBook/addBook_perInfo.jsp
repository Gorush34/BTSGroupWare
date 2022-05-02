<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<%
   String ctxPath = request.getContextPath();

%>


<script type="text/javascript">


</script>

<title>상세개인정보페이지</title>

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
	


