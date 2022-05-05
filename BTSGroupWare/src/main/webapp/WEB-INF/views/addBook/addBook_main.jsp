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


function searchBtn() {
	$.ajax({
		url:"<%= ctxPath%>/addBook/test.bts",
		data:{"search" : $("input#searchText").val()},
		type: "post",
		dataType: 'json',
		success : function(json) {
			console.log(json)
		},
		error: function(request){
			
		}
	});
}
	
		
			
			

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
		<tr>
			<td colspan="6" style="text-align:left;"><button class="btn btn-default" id="fastadd" style="border: solid darkgray 2px;">빠른등록</button>
				<button class="btn btn-default" id="" style="border: solid darkgray 2px;">그룹지정</button>
				<button class="btn btn-default" id="" style="border: solid darkgray 2px;">삭제</button>
				<button class="btn btn-default" id="" style="border: solid darkgray 2px;">주소록복사</button>
				<button class="btn btn-default" id="" style="border: solid darkgray 2px;">더보기</button>
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
		<tr style="border: solid darkgray 2px; margin-left:2%">
			<td style="width:13%;"><strong>이름</strong></td>
			<td style="width:13%;"><strong>직급</strong></td>
			<td style="width:22%;"><strong>휴대폰</strong></td>
			<td style="width:22%;"><strong>이메일</strong></td>
			<td style="width:13%;"><strong>회사</strong></td>
			<td style="width:22%;"><strong>회사전화</strong></td>
		</tr>
		<c:if test="${not empty (requestScope.adbList)}">
        <c:forEach var="adb" items="${requestScope.adbList}">
		<tr>
			<td>${adb.addb_name}</td>
			<td>${adb.ko_rankname}</td>
			<td>${adb.phone}</td>
			<td>${adb.email}</td>
			<td>${adb.companyname}</td>
			<td>${adb.com_tel}</td>
		</tr>
		</c:forEach>
		</c:if>
		<c:if test="${empty (requestScope.adbList)}">
        <tr>
           <td colspan="6" style="text-align:center;padding-top: 16%; padding-left: 16%;"><strong>새로운 연락처를 등록하세요</strong><br><br><button class="btn btn-info btn-sm" id="" style="border: solid lightgray 1.5px;" onclick="location.href='http://localhost:9090/bts/addBook/addBook_telAdd.bts'">연락처 추가</button></td>
        </tr>
        </c:if>
	</table>
	
	
	
			<div style="text-align:center; margin-top: 18%; ">
			<ul class="nav nav-pills justify-content-center"  >
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn"> 맨 앞 </button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn"> 1 </button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn"> 2 </button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn"> 3 </button></li>
			  <li role="presentation"><button class="btn btn-default" id="Main_mini_btn"> 맨 뒤로 </button></li>
			</ul>
			</div>