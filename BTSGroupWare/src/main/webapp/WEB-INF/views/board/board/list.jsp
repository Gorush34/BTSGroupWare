<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<% String ctxPath = request.getContextPath(); %>

<style>
a#brd_category{
	color: black;
	margin: 10px;
	text-decoration: none;
	font-size: 15px;
}

a#brd_category:hover{
font-weight: bold;
}

option{
color:black;
}
div#searchDiv{
    text-align: center;
    margin-bottom: 25px;
    margin-top: 10px;
}

form#searchFrm{
 margin-bottom: 25px;
    margin-top: 10px;
}
table#board_table {
  border-collapse: collapse;
  border-spacing: 0;
  width: 100%;
  border: 1px solid #cce4ff;
}

th, td {
  text-align: center;
  padding: 16px;
}

  
.titleStyle {font-weight: bold;
             color: gray;
             cursor: pointer;} 
             
span#head{
color:blue;
margin-right: 20px;
}             

span#write:hover{
font-weight: bold;
cursor: pointer;

}
span#write{
/* border: solid 1px #BDBDBD;
border-radius: 5px; */
margin: 10px;

}
         
             
</style>
<script type="text/javascript">
	$(document).ready(function(){
		
		$("span.title").bind("mouseover", function(event){
			var $target = $(event.target);
			$target.addClass("titleStyle");
		});
		
		$("span.title").bind("mouseout", function(event){
			var $target = $(event.target);
			$target.removeClass("titleStyle");
		});
		
		$("input#searchWord").keyup(function(event){
			if(event.keyCode == 13) {
				// 엔터를 했을 경우 
				goSearch();
			}
		});
		
		//검색시 검색조건 및 검색어 값 유지시키기
		if( ${not empty paraMap} ) {  // 또는 if( ${paraMap != null} ) { 
			$("select#searchType").val("${paraMap.searchType}");
			$("input#searchWord").val("${paraMap.searchWord}");
		}
		
	});//end of $(document).ready(function(){}

	
	function goView(seq) {
			// 현재 페이지 주소를 뷰단으로 넘겨준다.
			var frm = document.goViewFrm;
			frm.seq.value = seq;
			
			
			frm.method = "GET";
			frm.action = "<%= ctxPath%>/noticeView.os";
			frm.submit();
		}// end of function goView(seq){}----------------------------------------------
		
		
		function goSearch() {
			var frm = document.searchFrm;
			frm.method = "GET";
			frm.action = "<%= request.getContextPath()%>/noticeList.os";
			frm.submit();
		}// end of function goSearch() {}-----------------------
	
</script>

<div style="padding: 0 15px !important; margin-right: auto !important; margin-left: auto !important;">
	
	<div class="d-flex align-items-center p-3 my-3 text-white bg-purple rounded shadow-sm" style="background-color: #6F42C1; ">
    <div class="lh-1" style="text-align: center; width: 100%;">
      <h1 class="h6 mb-0 text-white lh-1" style="font-size:22px; font-weight: bold; ">자유게시판</h1>
    </div>
  </div>

	<div style="text-align: center;">
		<a id="brd_category" href="<%= request.getContextPath()%>/notice/list.bts">공지사항</a> 
		<a id="brd_category" href="<%= request.getContextPath()%>/fileboard/list.bts">자료실</a> 
		<a id="brd_category" href="<%= request.getContextPath()%>/board/list.bts" style="font-weight: bold; text-decoration: underline;">자유게시판</a> 
		<br></br>
	</div>
		<span id = "write" onclick="javascript:location.href='<%= request.getContextPath()%>/noticeAdd.bts'">게시물작성
			<i class= "fa  fa-edit" aria-hidden="true"></i>
		</span>
		
		<table class="table table-hover">
		<thead>
			<tr>
				<th scope="col" class="text-center" style="width: 50px;">글번호</th>		
				<th scope="col" class="text-center" style="width: 340px;">제목</th>
				<th scope="col" class="text-center" style="width: 70px;">글쓴이</th>
				<th scope="col" class="text-center" style="width: 150px;">작성일</th>
				<th scope="col" class="text-center" style="width: 50px;">조회수</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="boardvo" items="${requestScope.boardList}" varStatus="status">
			   <tr>
			      <td align="center">
			          ${boardvo.seq}
			      </td>
			      <td align="center">${boardvo.subject}</td>
				  <td align="center">${boardvo.name}</td>
				  <td align="center">${boardvo.regDate}</td>
				  <td align="center">${boardvo.readCount}</td>
			   </tr>
			</c:forEach>
		</tbody>
	</table>

	<%-- === #122. 페이지바 보여주기 === --%>
	<div align="center" style="border: solid 0px gray; width: 70%; margin: 20px auto;">
		${requestScope.pageBar}
	</div>
 
    <%-- === #101. 글검색 폼 추가하기 : 글제목, 글쓴이로 검색을 하도록 한다. === --%>
    <form name="searchFrm" style="margin-top: 20px;">
		<select name="searchType" id="searchType" style="height: 26px;">
			<option value="subject">글제목</option>
			<option value="name">글쓴이</option>
		</select>
		<input type="text" name="searchWord" id="searchWord" size="40" autocomplete="off" /> 
		<input type="text" style="display: none;"/> <%-- form 태그내에 input 태그가 오로지 1개 뿐일경우에는 엔터를 했을 경우 검색이 되어지므로 이것을 방지하고자 만든것이다. --%> 
		<button type="button" class="btn btn-secondary btn-sm" onclick="goSearch()">검색</button>
	</form>
	

	
</div>