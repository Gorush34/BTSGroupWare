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
			frm.action = "<%= ctxPath%>/notice/view.bts";
			frm.submit();
		}// end of function goView(seq){}----------------------------------------------
		
		
		function goSearch() {
			var frm = document.searchFrm;
			frm.method = "GET";
			frm.action = "<%= request.getContextPath()%>/notice/list.bts";
			frm.submit();
		}// end of function goSearch() {}-----------------------
	
</script>

<div style="padding: 0 15px !important; margin-right: auto !important; margin-left: auto !important;">
	
	<div class="d-flex align-items-center p-3 my-3 text-white bg-purple rounded shadow-sm" style="background-color: #007BFF; ">
    <div class="lh-1" style="text-align: center; width: 100%;">
      <h1 class="h6 mb-0 text-white lh-1" style="font-size:22px; font-weight: bold; ">공지사항</h1>
    </div>
  </div>
	<div style="text-align: center;">
		<a id="brd_category" href="<%= request.getContextPath()%>/notice/list.bts" style="font-weight: bold; text-decoration: underline;">공지사항</a> 
		<a id="brd_category" href="<%= request.getContextPath()%>/fileboard/list.bts">자료실</a> 
		<a id="brd_category" href="<%= request.getContextPath()%>/board/list.bts">자유게시판</a> 
		<br></br>
	</div>
		<span id = "write" onclick="javascript:location.href='<%= request.getContextPath()%>/noticeAdd.bts'">공지작성
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

			
	 <c:choose>
		 <c:when test = "${noticeList > 0}">
		<c:forEach var="board" items="${noticeList}" varStatus="status">
			 <tr>
			 	<td style="width: 70px;  text-align: center;">${board.seq}  
			 </td>
			
			 	 <td style="width: 40px;  text-align: left; padding-left: 20px;">
			  
			  <%-- 파일첨부가 없을때 --%>
			    <c:if test="${empty board.filename}"> 
			 	
					   <c:if test="${board.commentCount > 0}">
					   <span class="title" onclick="goView('${board.seq}')"><span id="head">[ ${board.header} ]</span>${board.title} <span style="vertical-align: super;">[<span style="color: red; font-size: 9pt; font-style: italic; font-weight: bold;">${board.commentCount}</span>]</span> </span> 
					   </c:if>
					   
					   <c:if test="${board.commentCount == 0}">
					   <span class="title" onclick="goView('${board.seq}')"><span id="head">[ ${board.header} ]</span> ${board.title}</span>  
					   </c:if>
				  
				</c:if>   
		
			 <%--파일첨부 없을때 끝 --%>	 
			 	 
			 	 <%-- 첨부파일이 있는 경우 --%>
			 <c:if test="${not empty board.filename}">
					   <c:if test="${board.commentCount > 0}">
					   <span class="title" onclick="goView('${board.seq}')"><span id="head">[ ${board.header} ]</span> ${board.title} <span style="vertical-align: super;">[<span style="color: red; font-size: 9pt; font-style: italic; font-weight: bold;">${board.commentCount}</span>]</span> </span> &nbsp;<i class="fa fa-file-o"></i>
					   </c:if>
					   
					   <c:if test="${board.commentCount == 0}">
					   <span class="title" onclick="goView('${board.seq}')"><span id="head">[ ${board.header} ]</span> ${board.title}</span> &nbsp;<i class="fa fa-file-o"></i>
					   </c:if>			   
			 </c:if>		
		    <%-- 파일첨부가 있을때끝 --%> 			 
					</td> 
				  
			 	<td style="width: 70px;  text-align: center;">${board.name}</td>			
			 	<td style="width: 70px;  text-align: center;" > ${board.writeDay}</td>
			 	<td style="width: 70px;  text-align: center;" >${board.readCount}</td>
			 	
			 </tr>

		</c:forEach>	 
			</c:when>
			
			<c:otherwise>
        		 <tr>
			 	<td colspan="5" style="text-align: center;">공지사항이 존재하지 않습니다.
			 </td>
			 </tr>
			 
         </c:otherwise>
		</c:choose>
		</tbody>
		</table>
		
		<%--페이지 바  --%>
		<div align="center" style="width: 70%; border: solid 0px gray; margin: 20px auto;">        
		${pageBar}
	    </div>
		
	<%--검색 폼--%>
 <div id="searchDiv">
	<form name="searchFrm" id="searchFrm">
	
		<select name="searchType" id="searchType" style="height: 26px;">
			<option value="title">글제목</option>
			<option value="name">작성자</option>
		</select>
		
		<input type="text" placeholder="검색" name="searchWord" id="searchWord" size="20" autocomplete="off" /> 
		<button type="button" style="width: 30px" onclick="goSearch()">
		<i class="fa fa-search fa-fw" aria-hidden="true"></i>
		</button>
	</form>
	
	
	<%--글제목 클릭후 상세보기를 한 다음에 목록보기를 봤을때
	 돌아갈 페이지를 알려주기 위해서 현재 페이지 주소를 뷰단으로 넘겨준다. --%>
 </div>	
		<form name="goViewFrm">
		   <input type="hidden" name="seq" />
		   <input type="hidden" name="gobackURL" value="${gobackURL}" />
	    </form>
		
</div>	