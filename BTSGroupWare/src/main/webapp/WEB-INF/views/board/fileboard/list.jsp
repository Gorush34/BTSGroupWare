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
			frm.action = "<%= ctxPath%>/fileboard/view.bts";
			frm.submit();
		}// end of function goView(seq){}----------------------------------------------
		
		
		function goSearch() {
			var frm = document.searchFrm;
			frm.method = "GET";
			frm.action = "<%= request.getContextPath()%>/fileboard/list.bts";
			frm.submit();
		}// end of function goSearch() {}-----------------------
	
</script>

<div style="padding: 0 15px !important; margin-right: auto !important; margin-left: auto !important;">
	
<div class="d-flex align-items-center p-3 my-3 text-white bg-purple rounded shadow-sm" style="background-color: #E83E8C; ">
    <div class="lh-1" style="text-align: center; width: 100%;">
      <h1 class="h6 mb-0 text-white lh-1" style="font-size:22px; font-weight: bold; ">자료실</h1>
    </div>
  </div>

	<div style="text-align: center;">
		<a id="brd_category" href="<%= request.getContextPath()%>/notice/list.bts" >공지사항</a> 
		<a id="brd_category" href="<%= request.getContextPath()%>/fileboard/list.bts" style="font-weight: bold; text-decoration: underline;">자료실</a> 
		<a id="brd_category" href="<%= request.getContextPath()%>/board/list.bts">자유게시판</a> 
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

			
	 <c:choose>
		 <c:when test = "${noticeList > 0}">
		<c:forEach var="board" items="${noticeList}" varStatus="status">
			 <tr >
			 	<td style="width: 70px;  text-align: center;">${board.seq}  
			 </td>
			
			 	 <td style="width: 40px;  text-align: left; padding-left: 20px;">
			  
			  <%-- 파일첨부가 없을때 --%>
			    <c:if test="${empty board.fileName}"> 
			 	
					   <c:if test="${board.comment_count > 0}">
					   <span class="title" onclick="goView('${board.seq}')"><span id="head">[ ${board.header} ]</span>${board.title} <span style="vertical-align: super;">[<span style="color: red; font-size: 9pt; font-style: italic; font-weight: bold;">${board.comment_count}</span>]</span> </span> 
					   </c:if>
					   
					   <c:if test="${board.comment_count == 0}">
					   <span class="title" onclick="goView('${board.seq}')"><span id="head">[ ${board.header} ]</span> ${board.title}</span>  
					   </c:if>
				  
				</c:if>   
		
			 <%--파일첨부 없을때 끝 --%>	 
			 	 
			 	 <%-- 첨부파일이 있는 경우 --%>
			 <c:if test="${not empty board.fileName}">
					   <c:if test="${board.commentCount > 0}">
					   <span class="title" onclick="goView('${board.seq}')"><span id="head">[ ${board.header} ]</span> ${board.title} <span style="vertical-align: super;">[<span style="color: red; font-size: 9pt; font-style: italic; font-weight: bold;">${board.comment_count}</span>]</span> </span> &nbsp;<i class="fa fa-file-o"></i>
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
			 	<td colspan="5" style="text-align: center;">${save_count}
			 </td>
			 </tr>


<tr>
			 	<td colspan="5" style="text-align: center;">게시물이 존재하지 않습니다.
			 </td>
			 </tr>
			 
			 <tr>
			 	<td colspan="5" style="text-align: center;">게시물이 존재하지 않습니다.
			 </td>
			 </tr>
         </c:otherwise>
		</c:choose>
		</tbody>
		</table>
		
		<%--페이지 바  --%>
  <!-- 페이징을 지정할 태그에 class에 pagination을 넣으면 자동으로 페이징이 된다.-->
  <!-- 페이징의 크기를 제어할 수 있는데 pagination-lg를 추가하면 페이징 크기가 커지고, pagination-sm를 넣으면 작아진다. -->
  <!-- 큰 페이징 class="pagination pagination-lg", 보통 페이징 class="pagination", 작은 페이징  class="pagination pagination-sm" -->
  <div style="text-align: center;">
	  <ul class="pagination">
	    <!-- li태그의 클래스에 disabled를 넣으면 마우스를 위에 올렸을 때 클릭 금지 마크가 나오고 클릭도 되지 않는다.-->
	    <!-- disabled의 의미는 앞의 페이지가 존재하지 않다는 뜻이다. -->
	    <li class="disabled">
	      <a href="#">
	        <span>«</span>
	      </a>
	    </li>
	    <!-- li태그의 클래스에 active를 넣으면 색이 반전되고 클릭도 되지 않는다. -->
	    <!-- active의 의미는 현재 페이지의 의미이다. -->
	    <li class="active"><a href="#">1</a></li>
	    <li><a href="#">2</a></li>
	    <li><a href="#">3</a></li>
	    <li><a href="#">4</a></li>
	    <li><a href="#">5</a></li>
	    <li>
	      <a href="#">
	        <span>»</span>
	      </a>
	    </li>
	  </ul>
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