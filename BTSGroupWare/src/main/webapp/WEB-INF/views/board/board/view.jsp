<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
 <style>
 
	#table, #table2 {border-collapse: collapse;
	 		         width: 100%;}
	hr{
	color: gray;
	margin:10px;
	}
	.header{
	display: flex;
	}
	div#smallHeader{
	width: 40%;
	text-align: left;
	 
	}
	div#smallHeader_right{
	display: inline-block; 
	width: 47%;
	text-align: right;
	 
	}
	
	div#smallHeader{
	width: 50%;
	}
	
	
	div#smallHeader>span{
	/* border:solid 1px red; */
	 margin-left: 10px;
	}
	div#smallHeader_right>span{
	/* border:solid 1px red; */
	 margin-left: 10px;
	}
	
	
	div#boardContentAll{
	margin: 10px;
	}
	  
	  
	thead#tbl_header{
	
	margin:0 0 0 20px;
	
	}  
	th{
	margin-left: 2px;
	}
	 
	 
	#btnComment{
	border: none;
	width: 90px;
	border-radius:3px;
	}
	
	button#btnComment{
	background-color:#0F4C81;
	color:white;
	}	  
	input{
	width:80%;
	}  
	
	commentFrm{
	margin-left:10px;
	}
	td.commentContent{
	text-align: center;
	align-content: center;

	}
	td.comment{
	display: block;
	width:200px;
	}	 
	
	tbody#commentDisplay{
	display: block;
	}
	
	tr#comment{
	margin-bottom: 10px;
	display: block;
	} 
	
	
	td#commentContent{
	display: flex;
	
	}
	
 </style>
 <script>
 $(document).ready(function(){
		
	 // goReadComment();  // 페이징처리 안한 댓글 읽어오기 
	     goViewComment(1); // 페이징처리 한 댓글 읽어오기 
		
		$("span.move").hover(function(){
			                   $(this).addClass("moveColor");
		                    }
		                    ,function(){
		                       $(this).removeClass("moveColor");
		                    });

	}); // end of $(document).ready(function(){})----------------
	
	

	
	

	
 </script>
 
 <div style="padding-left: 5%;">
		
	<hr>
	  <div class="header">
		<div id="smallHeader">	
			<span onclick="javascript:location.href='#'"><button type="button" class="btn btn-outline-primary">답글쓰기</button></span>
			<span onclick="javascript:location.href='#'"><button type="button" class="btn btn-outline-danger">삭제하기</button></span>
			<span onclick="javascript:location.href='#'"><button type="button" class="btn btn-outline-warning">수정하기</button></span>
		</div>
		
		<div id="smallHeader_right">
			<span onclick="javascript:location.href='#'"><button type="button" class="btn btn-outline-success">목록</button></span>
		</div>
	</div>
	 
		
	 <hr>
	 
	 <!-- 게시글 내용 시작-------------------------------------------- -->
	 <div>
	 	<h2 style="margin:10px;">${boardvo.subject}</h2>
	 </div>
	 		
	 <div id="boardContentAll">		
	 
	 	<table>
	 		<thead style="font-size: 12pt;">
	 			 <tr >
	 			  	<th>${boardvo.name}</th>
	 			</tr>
	 			<tr>
	 				<th style="font-size:9pt;color:#BDBDBD; font-weight:lighter;">${boardvo.regDate}</th>
	 			</tr>
	 			
	 	<!-- 첨부파일이 있다면 보여준다. -->		
	 	  <c:if test="${boardvo.orgFilename != null}">
	 		<tr>
				<th style="font-size:9pt;">첨부파일</th>
				<td style="font-size:9pt;">
				
					<c:if test="${sessionScope.loginemp != null}">
						<a href="<%= request.getContextPath()%>/download.os?seq=${boardvo.seq}">${boardvo.orgFilename}</a> 
					<span style="font-size:10pt;color:#BDBDBD;">
					<fmt:formatNumber value="${boardvo.fileSize}" pattern="#,###" />bytes
					</span>	
					</c:if>
					
					<c:if test="${sessionScope.loginemp == null}">
						${boardvo.orgFilename}
						<fmt:formatNumber value="${boardvo.fileSize}" pattern="#,###" />bytes
					</c:if>
				</td>
			</tr>
			 
	 	  </c:if>
	 	<!-- 첨부파일이 있다면 보여주기 끝  -->		
	 	   
	 		</thead>
	 		 
	 		<tbody id="content">
	 			<tr >
	 				<td style="padding-bottom:40px; padding-top:40px;">
						<p  style="word-break: break-all;">${boardvo.content}</p>
					</td>
	 			</tr>	 
	 		</tbody>
	 	</table>
	 </div>
	 <!-- 게시글 내용 시작끝-------------------------------------------- -->
	 <div style="font-size: 9pt; margin-left: 10px;">
		 <span>댓글 ${boardvo.commentCount}개   | </span>
		 <span>조회수 ${boardvo.readCount} </span>
	 </div >
	 
	 <hr>
	 <!-- 아래부터 댓글------------------------------->
	 
	 
	 <!-- =====  댓글 내용 보여주기 ===== -->
	<table id="table2" style="margin-top: 2%; margin-bottom: 3%;">
		<thead>
		<tr>
		    
		</tr>
		</thead> 
		<tbody id="commentDisplay"></tbody>
	</table>
	 <!-- ===== 댓글 내용 보여주기 끝===== -->
	
	<!-- 댓글 작성 폼 ---------------------------------------------------------------------->	
	  <div id="commentFrm">
	  <span></span>
			<form name="addWriteFrm" style="margin-top: 20px; text-align: center;">
				      <input type="hidden" name="fk_emp_no" value="${sessionScope.loginemp.emp_no}" /> 
				      <input type="hidden" name="name" value="${sessionScope.loginemp.emp_name}" /> 
				
				<input id="commentContent" type="text" name="content" class="long" /> 
				
				<%-- 댓글에 달리는 원게시물 글번호(즉, 댓글의 부모글 글번호) --%>
				<input type="hidden" name="parentSeq" value="${boardvo.seq}" />
				<button id="btnComment" type="button" onclick="goAddWrite()">댓글 작성</button> 
			</form>
	 </div>
		<!-- 댓글 작성 폼끝 ---------------------------------------------------------------------->	

	
	<%-- ==== #136. 댓글 페이지바 ==== --%>
	<div id="pageBar" style="border:solid 0px gray; width: 90%; margin: 10px auto; text-align: center;"></div>
 
 	</div>
 	
 	<div style="margin-bottom: 1%;">이전글&nbsp;&nbsp;<span class="move" onclick="javascript:location.href='view_2.bts?seq=${requestScope.boardvo.previousseq}&searchType=${requestScope.paraMap.searchType}&searchWord=${requestScope.paraMap.searchWord}&gobackURL=${v_gobackURL}'">${requestScope.boardvo.previoussubject}</span></div>
    <div style="margin-bottom: 1%;">다음글&nbsp;&nbsp;<span class="move" onclick="javascript:location.href='view_2.bts?seq=${requestScope.boardvo.nextseq}&searchType=${requestScope.paraMap.searchType}&searchWord=${requestScope.paraMap.searchWord}&gobackURL=${v_gobackURL}'">${requestScope.boardvo.nextsubject}</span></div>
    	