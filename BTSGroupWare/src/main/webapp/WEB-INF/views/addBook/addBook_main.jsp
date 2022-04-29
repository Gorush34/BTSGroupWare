<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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

</script>


	<table id="main_tbl">
		<tr>
			<td colspan="6" style="text-align: left;"><br><h2>전체주소록</h2><br><br></td>
			<td>
				  <div class="d-flex align-items-center">
				    <input class="form-control" type="search" placeholder="주소록검색" aria-label="Search">
				    <button id="searchBtn" class="btn btn-outline-success flex-shrink-0" type="submit">검색</button>
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
			<td colspan="5" style="text-align:left;">
				<div id="fassadd_input">
						<input type="text" style="border-radius: 10px;" placeholder="이름">
						<input type="text" style="border-radius: 10px;" placeholder="이메일">
						<input type="text" style="border-radius: 10px;" placeholder="휴대폰">
				</div>
			</td>
		</tr>
		<tr>
		<td colspan="10">
			<ul class="nav nav-pills">
			  <li role="presentation"><button class="btn btn-default" id="mini_btn">전체</button></li>
			  <li role="presentation"><button class="btn btn-default" id="mini_btn">ㄱ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="mini_btn">ㄴ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="mini_btn">ㄷ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="mini_btn">ㄹ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="mini_btn">ㅁ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="mini_btn">ㅂ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="mini_btn">ㅅ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="mini_btn">ㅇ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="mini_btn">ㅈ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="mini_btn">ㅊ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="mini_btn">ㅋ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="mini_btn">ㅌ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="mini_btn">ㅍ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="mini_btn">ㅎ</button></li>
			  <li role="presentation"><button class="btn btn-default" id="mini_btn">a-z</button></li>
			</ul>
		</td>
		</tr>
		<tr style="border: solid darkgray 2px;">
			<td style="width:5%;"><input type="checkbox"></td>
			<td style="width:13%;"><strong>이름</strong></td>
			<td style="width:13%;"><strong>휴대폰</strong></td>
			<td style="width:13%;"><strong>이메일</strong></td>
			<td style="width:13%;"><strong>회사</strong></td>
			<td style="width:13%;"><strong>회사전화</strong></td>
			<td style="width:13%;">
				<select class="form-control" style="margin-left: 20%; width: 50%;">
					<option>선택</option>
					<option>선택1</option>
					<option>선택2</option>
					<option>선택3</option>
					<option>선택4</option>
				</select>
			</td>
		</tr>
        <tr>
           <td colspan="6" style="text-align:center;padding-top: 16%; padding-left: 16%;"><strong>새로운 연락처를 등록하세요</strong><br><br><button class="btn btn-info btn-sm" id="" style="border: solid lightgray 1.5px;" >연락처 추가</button></td>
        </tr>
	</table>
			<div style="text-align:center; margin-top: 18%; ">
			<ul class="nav nav-pills justify-content-center"  >
			  <li role="presentation"><button class="btn btn-default" id="mini_btn"> 맨 앞 </button></li>
			  <li role="presentation"><button class="btn btn-default" id="mini_btn"> 1 </button></li>
			  <li role="presentation"><button class="btn btn-default" id="mini_btn"> 2 </button></li>
			  <li role="presentation"><button class="btn btn-default" id="mini_btn"> 3 </button></li>
			  <li role="presentation"><button class="btn btn-default" id="mini_btn"> 맨 뒤로 </button></li>
			</ul>
			</div>