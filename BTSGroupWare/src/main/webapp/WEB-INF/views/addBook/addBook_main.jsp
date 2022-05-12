<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
   String ctxPath = request.getContextPath();
  //       /board 
%>
<script type="text/javascript">

$( document ).ready( function() {

	
	$( "div#fassadd_input" ).slideToggle().hide();
	  $( "button#fastadd" ).click( function() {
	    $( "div#fassadd_input" ).slideToggle();
	  });
	  
}); // end of $( document ).ready( function()

	
	function telUpdate(i)	{
		$.ajax({
			url:"<%= ctxPath%>/addBook/addBook_main_telUpdate_select.bts",
			data:{"pk_addbook_no" : $("input#pk_addbook_no_"+i).val()},
			type: "post",
			dataType: 'json',
			success : function(json) {
				$("input#pk_addbook_no").val(json.pk_addbook_no)
				$("input#name").val(json.name)
				$("select#department").selected(json.department)
				$("select#rank").selected(json.rank)
				$("input#email").val(json.email)
				$("input#phone").val(json.phone)
				$("input#company_name").val(json.company_name)
				$("input#company_tel").val(json.company_tel)
				$("input#company_address").val(json.company_address)
				$("input#memo").val(json.memo)
			},
			error: function(request){
				
			}
		});
	}
	
	
	<%-- function updateFrm() {
		
		const frm = document.updateFrm;
	    frm.action = "<%=ctxPath%>/addBook/addBook_main_telUpdate_update.bts"
	    frm.method = "POST"
	    frm.submit();
	} --%>	


</script>


	<table id="Main_main_tbl">
		<tr>
			<td colspan="8" style="text-align: left;"><br><h2>전체주소록</h2><br><br></td>
			<td>
				  <div class="d-flex align-items-center">
				    <input class="form-control" type="search" id="searchText" value="" style="width:115px;" placeholder="주소록검색" aria-label="Search">
				    <button id="searchBtn" class="btn btn-outline-success flex-shrink-0" type="submit" onclick="searchBtn()">검색</button>
				  </div>
			</td>
		</tr>
		<!--  
		<tr>
			<td colspan="6" style="text-align:left;"><button class="btn btn-default" id="fastadd" style="border: solid darkgray 2px;">빠른등록</button>
				<button class="btn btn-default" id="" style="border: solid darkgray 2px;">삭제</button>
			</td>
		</tr>
		<tr>
			<td colspan="7" style="text-align:left;">
				<div id="fassadd_input">
						<input type="text" style="border-radius: 10px; height: 35px;" placeholder="이름">
						<input type="text" style="border-radius: 10px; height: 35px;" placeholder="이메일">
						<input type="text" style="border-radius: 10px; height: 35px;" placeholder="휴대폰">
						<button class="btn btn-default" id="mini_btn" style="background-color:lightgray;">+</button>
						<button class="btn btn-default">상세정보추가</button>
				</div>
			</td>
		</tr>
		<tr>
		<td colspan="10">
			<ul class="nav nav-pills">
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn">전체</button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn">ㄱ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn">ㄴ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn">ㄷ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn">ㄹ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn">ㅁ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn">ㅂ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn">ㅅ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn">ㅇ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn">ㅈ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn">ㅊ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn">ㅋ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn">ㅌ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn">ㅍ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn">ㅎ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn">a-z</button></li>
			</ul>
		</td>
		</tr>
		-->
		<tr style="border: solid darkgray 2px; margin-left:2%">
			<td style="width:5%;"><input type="hidden" id="pk_addbook_no_${i.count}" name="pk_addbook_no${i.count}" value="${adb.pk_addbook_no}" readonly /></td>
			<td style="width:13%;"><strong>이름</strong></td>
			<td style="width:13%;"><strong>직급</strong></td>
			<td style="width:22%;"><strong>휴대폰</strong></td>
			<td style="width:22%;"><strong>이메일</strong></td>
			<td style="width:13%;"><strong>회사</strong></td>
			<td style="width:22%;"><strong>회사전화</strong></td>
		</tr>
		<c:if test="${not empty (requestScope.adbList)}">
        <c:forEach var="adb" items="${requestScope.adbList}" varStatus="i">
		<tr>
			<td><input type="hidden" id="pk_addbook_no_${i.count}" name="pk_addbook_no_${i.count}" value="${adb.pk_addbook_no}" readonly /></td>
			<td><button class="btn btn-default" onclick="telUpdate(${i.count})" data-toggle="modal" data-target="#viewModal" onclick="modal_view('이름','부서','직급','이메일','휴대폰','회사','회사전화번호','회사주소','메모사항');">${adb.addb_name}</button></td>
			<td><button class="btn btn-default" onclick="telUpdate(${i.count})" data-toggle="modal" data-target="#viewModal" onclick="modal_view('이름','부서','직급','이메일','휴대폰','회사','회사전화번호','회사주소','메모사항');" >${adb.ko_rankname}</button></td>
			<td><button class="btn btn-default" onclick="telUpdate(${i.count})" data-toggle="modal" data-target="#viewModal" onclick="modal_view('이름','부서','직급','이메일','휴대폰','회사','회사전화번호','회사주소','메모사항');" >${adb.phone}</button></td>
			<td><button class="btn btn-default" onclick="telUpdate(${i.count})" data-toggle="modal" data-target="#viewModal" onclick="modal_view('이름','부서','직급','이메일','휴대폰','회사','회사전화번호','회사주소','메모사항');" >${adb.email}</button></td>
			<td><button class="btn btn-default" onclick="telUpdate(${i.count})" data-toggle="modal" data-target="#viewModal" onclick="modal_view('이름','부서','직급','이메일','휴대폰','회사','회사전화번호','회사주소','메모사항');" >${adb.companyname}</button></td>
			<td><button class="btn btn-default" onclick="telUpdate(${i.count})" data-toggle="modal" data-target="#viewModal" onclick="modal_view('이름','부서','직급','이메일','휴대폰','회사','회사전화번호','회사주소','메모사항');" >${adb.com_tel}</button></td>
		</tr>
		</c:forEach>
		</c:if>
		<c:if test="${empty (requestScope.adbList)}">
        <tr>
           <td colspan="6" style="text-align:center;padding-top: 16%; padding-left: 16%;"><strong>새로운 연락처를 등록하세요</strong><br><br><button class="btn btn-info btn-sm" id="" style="border: solid lightgray 1.5px;" onclick="location.href='http://localhost:9090/bts/addBook/addBook_telAdd.bts'">연락처 추가</button></td>
        </tr>
        </c:if>
	</table>
	
	
	<%-- === #122. 페이지바 보여주기 === --%>
	<div align="center" style="border: solid 0px gray; width: 70%; margin: 20px auto;">
		${requestScope.pageBar}
	</div>
	
	<!-- 
			<div style="text-align:center; margin-top: 18%; ">
			<ul class="nav nav-pills justify-content-center"  >
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn"> 맨 앞 </button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn"> 1 </button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn"> 2 </button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn"> 3 </button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn"> 맨 뒤로 </button></li>
			</ul>
			</div>
		 -->	

			
	
	<!-- 연락처 수정 모달창 -->	
	<div class="modal fade" data-backdrop="static" id="viewModal">
	<div class="modal-dialog">
	<div class="modal-content">
	<div class="modal-header">
	<h4 class="modal-title" id="exampleModalLabel">연락처 수정</h4>
	</div>
	
	<div class="modal-body">
	<form name="updateFrm" action="<%=ctxPath%>/addBook/addBook_main_telUpdate_update.bts" method="POST" >
		<input type="hidden" class="form-control" id="pk_addbook_no" name="pk_addbook_no">
		
		<div class="form-group">
		<label for="recipient-name" class="control-label"><strong>이름</strong></label>
		<input type="text" class="form-control" id="name" name="name">
		</div>
		
		<div class="form-group">
		<label for="recipient-name" class="control-label"><strong>부서</strong></label>
			<select id="department" name="department" class="form-control">
			  <option selected >--</option>
			  <option value="100">영업</option>
			  <option value="200">마케팅</option>
			  <option value="300">기획</option>
			  <option value="400">총무</option>
			  <option value="500">인사</option>
			  <option value="600">회계</option>
			</select>
		</div>
		
		<div class="form-group">
		<label for="recipient-name" class="control-label"><strong>직급</strong></label>
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
		</div>
		
		<div class="form-group">
		<label for="recipient-name" class="control-label"><strong>이메일</strong></label>
		<input type="text" class="form-control" id="email" name="email">
		</div>
		
		<div class="form-group">
		<label for="recipient-name" class="control-label"><strong>휴대폰</strong></label>
		<input type="text" class="form-control" id="phone" name="phone">
		</div>
		
		<div class="form-group">
		<label for="recipient-name" class="control-label"><strong>회사</strong></label>
		<input type="text" class="form-control" id="company_name" name="company_name">
		</div>
		
		<div class="form-group">
		<label for="recipient-name" class="control-label"><strong>회사전화번호</strong></label>
		<input type="text" class="form-control" id="company_tel" name="company_tel">
		</div>
		
		<div class="form-group">
		<label for="recipient-name" class="control-label"><strong>회사주소</strong></label>
		<input type="text" class="form-control" id="company_address" name="company_address">
		</div>
		
		
		<div class="form-group">
		<label for="recipient-name" class="control-label"><strong>메모사항</strong></label>
		<input type="text" class="form-control" id="memo" name="memo">
		</div>
	</form>
	</div>
	
	<div class="modal-footer">
	<button type="button" class="btn btn-primary" id="insert_customer_btn" onclick="javascript:document.updateFrm.submit()">등록</button>
	<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
	</div>
	</div>
	</div>
	</div>
	



