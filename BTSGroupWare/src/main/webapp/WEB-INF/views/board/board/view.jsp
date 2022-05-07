<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>    
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
 <style>
 
 
 	button#btnDislike{
 		border:none;
 		background-color: white;
 	}
 	
 	button#btnLike{
 		border:none;
 		background-color: white;
 	}
 	
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
	
	#mycontent > div > div:nth-child(11) > span{
		font-size: 12pt;
		cursor: pointer;
	}
	
	#mycontent > div > div:nth-child(12) > span{
		cursor: pointer;
		font-size: 12pt;
	}
	
	#mycontent > div > div:nth-child(13) > span{
		cursor: pointer;
		font-size: 12pt;
	}
	
	
	#mycontent > div > div:nth-child(11) > span:hover {
		font-weight: bold;
	}
	
	#mycontent > div > div:nth-child(12) > span:hover {
		font-weight: bold;
	}
	
	#mycontent > div > div:nth-child(13) > span:hover {
		font-weight: bold;
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
	
	
	// Function Declaration
	  
	  // == 댓글쓰기 == 
	  function goAddWrite() {
		  
		  const commentContent = $("input#commentContent").val().trim();
		  if(commentContent == "") {
			  alert("댓글 내용을 입력하세요!!");
			  return; // 종료
		  }
		  
		  $.ajax({
			  url:"<%= request.getContextPath()%>/board/addComment.bts",
			  data:{"fk_emp_no":$("input#fk_emp_no").val() 
				   ,"user_name":$("input#user_name").val() 
				   ,"content":$("input#commentContent").val() 
				   ,"fk_seq":$("input#fk_seq").val()},
   
			  type:"POST",
			  dataType:"JSON",
			  success:function(json){
				 
				 const n = json.n;
				 if(n == 0) {
					 alert("댓글 작성 실패");
				 }
				 else {
				     goViewComment(1); // 페이징 처리한 댓글 읽어오기
				 }
				 
				 $("input#commentContent").val("");
			  },
			  error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		  });
		  
	  }// end of function goAddWrite() {}--------------------
	
	
	  

	  // === 페이징 처리 안한 댓글 읽어오기  === //
	  function goReadComment() {
		  
		  $.ajax({
			  url:"<%= request.getContextPath()%>/board/readComment.bts",
			  data:{"fk_seq":"${requestScope.boardvo.pk_seq}"},
			  dataType:"JSON",
			  success:function(json){
	
				  
				  let html = "";
				  if(json.length > 0) {
					  $.each(json, function(index, item){
						  html += "<tr>";
						  html += "<td class='comment'>"+(index+1)+"</td>";
						  html += "<td>"+item.content+"</td>";
						  html += "<td class='comment'>"+item.name+"</td>";
						  html += "<td class='comment'>"+item.regDate+"</td>";
						  html += "</tr>";
					  });
				  }
				  else {
					  html += "<tr>";
					  html += "<td colspan='4' class='comment'>댓글이 없습니다</td>";
					  html += "</tr>";
				  }
				  
				  $("tbody#commentDisplay").html(html);
			  },
			  error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		  });
		  
	  }// end of function goReadComment(){}--------------------------
	  
	  
	  
	  // === #127. Ajax로 불러온 댓글내용을  페이징 처리 하기  === //
	  function goViewComment(currentShowPageNo) {
		  
		  $.ajax({
			  url:"<%= request.getContextPath()%>/board/commentList.bts",
			  data:{"fk_seq":"${requestScope.boardvo.pk_seq}",
				    "currentShowPageNo":currentShowPageNo},
			  dataType:"JSON",
			  success:function(json){
				  
				  let html = "";
				  if(json.length > 0) {
					  $.each(json, function(index, item){
						  html += "<tr>";
						  html += "<td class='comment'>"+(index+1)+"</td>";
						  html += "<td>"+item.content+"</td>";
						  html += "<td class='comment'>"+item.user_name+"</td>";
						  html += "<td class='comment'>"+item.write_day+"</td>";
						  html += "</tr>";
					  });
				  }
				  else {
					  html += "<tr>";
					  html += "<td colspan='4' class='comment'>댓글이 없습니다</td>";
					  html += "</tr>";
				  }
				  
				  $("tbody#commentDisplay").html(html);
				  
				  // 페이지바 함수 호출
				  makeCommentPageBar(currentShowPageNo);
			  },
			  error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		  });
		  
	  }// end of function goViewComment(currentShowPageNo) {}-------------------------
	  
	// ==== 댓글내용 페이지바 Ajax로 만들기 ==== //
	  function makeCommentPageBar(currentShowPageNo) {
		  
		  <%-- === 원글에 대한 댓글의 totalPage 수를 알아오려고 한다. ===  --%>
		  $.ajax({
			  url:"<%= request.getContextPath()%>/board/getCommentTotalPage.bts",
			  data:{"fk_seq":"${requestScope.boardvo.pk_seq}",
				    "sizePerPage":"5"},
			  type:"GET",
			  dataType:"JSON",
			  success:function(json){
				 //  console.log("확인용 댓글의 전체페이지수 : " + json.totalPage);
				 
				 if(json.totalPage > 0) {
					 // 댓글이 있는 경우 
					 
					 const totalPage = json.totalPage;
					 
					 let pageBarHTML = "<ul style='list-style: none;'>";
					 
					 const blockSize = 10;
				     
					// === [맨처음][이전] 만들기 === //
					if(pageNo != 1) {
						pageBarHTML += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='javascript:goViewComment(\"1\")'>[맨처음]</a></li>";
						pageBarHTML += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='javascript:goViewComment(\""+(pageNo-1)+"\")'>[이전]</a></li>";
					}
					
					while( !(loop > blockSize || pageNo > totalPage) ) {
						
						if(pageNo == currentShowPageNo) {
							pageBarHTML += "<li style='display:inline-block; width:30px; font-size:12pt; border:solid 1px gray; color:red; padding:2px 4px;'>"+pageNo+"</li>";  
						}
						else {
							pageBarHTML += "<li style='display:inline-block; width:30px; font-size:12pt;'><a href='javascript:goViewComment(\""+pageNo+"\")'>"+pageNo+"</a></li>"; 
						}
						
						loop++;
						pageNo++;
						
					}// end of while-----------------------
					
					
					// === [다음][마지막] 만들기 === //
					if( pageNo <= totalPage ) {
						pageBarHTML += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='javascript:goViewComment(\""+pageNo+"\")'>[다음]</a></li>";
						pageBarHTML += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='javascript:goViewComment(\""+totalPage+"\")'>[마지막]</a></li>"; 
					}
					 
					pageBarHTML += "</ul>";
					 
					$("div#pageBar").html(pageBarHTML);
				 }// end of if(json.totalPage > 0){}-------------------------------
				  
			  },
			  error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }    
		  });
		  
	  }// end of function makeCommentPageBar(currentShowPageNo) {}--------------------
	
 </script>
 
 <div style="padding-left: 5%;">

	<hr>
	  <div class="header">
		<div id="smallHeader">	
			<span onclick="javascript:location.href='<%= request.getContextPath()%>/board/write.bts?fk_seq=${requestScope.boardvo.pk_seq}&groupno=${requestScope.boardvo.groupno}&depthno=${requestScope.boardvo.depthno}&subject=${requestScope.boardvo.subject}'"><button type="button" class="btn btn-outline-primary">답글쓰기</button></span>
			<span onclick="javascript:location.href='<%= request.getContextPath()%>/board/del.bts?pk_seq=${requestScope.boardvo.pk_seq}'"><button type="button" class="btn btn-outline-danger">삭제하기</button></span>
			<span onclick="javascript:location.href='<%= request.getContextPath()%>/board/edit.bts?pk_seq=${requestScope.boardvo.pk_seq}'"><button type="button" class="btn btn-outline-warning">수정하기</button></span>
		</div>
		
		<div id="smallHeader_right">
			<span onclick="javascript:location.href='<%= request.getContextPath()%>${requestScope.gobackURL}'"><button type="button" class="btn btn-outline-success">목록</button></span>
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
	 			  	<th>${boardvo.user_name}</th>
	 			</tr>
	 			<tr>
	 				<th style="font-size:9pt;color:#BDBDBD; font-weight:lighter;">${boardvo.write_day}</th>
	 			</tr>
	 			
	
	 	   
	 		</thead>
	 		 
	 		<tbody id="content">
	 			<tr >
	 				<td style="padding-bottom:40px; padding-top:40px; padding-right: 50px;">
						<p  style="word-break: break-all;">${boardvo.content}</p>
					</td>
	 			</tr>	 
	 		</tbody>
	 	</table>
	 </div>
	 <!-- 게시글 내용 시작끝-------------------------------------------- -->
	 <div style="padding-left: 41%">
		 <form>
			 <button id="btnLike" type="button"><img src="<%= ctxPath%>/resources/images/board/like.png" style="width:50px;"></button>
			 <button style="margin-left: 30px;" id="btnDislike" type="button"><img src="<%= ctxPath%>/resources/images/board/dislike.png" style="width:50px; "></button>
		 </form>
	 </div>
	 
	 <div style="font-size: 9pt; margin-left: 10px;">
		 <span>댓글 ${boardvo.comment_count} 개   | </span>
		 <span>조회수 ${boardvo.read_count} 회 </span>
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
	
	<%-- === #83. 댓글쓰기 폼 추가 === --%>
    	<c:if test="${not empty sessionScope.loginuser}">
    	   <form name="addWriteFrm" id="addWriteFrm" style="margin-top: 20px;">
    	      <table class="table" style="width: 1024px">
				   <tr style="height: 30px;">
				      <th width="10%">성명</th>
				      <td>
				         <input type="text" name="fk_emp_no" id="fk_emp_no" value="${sessionScope.loginuser.pk_emp_no}" />  
				         <input type="text" name="user_name" id="user_name" value="${sessionScope.loginuser.emp_name}" readonly />
				      </td>
				   </tr>
				   <tr style="height: 30px;">
					      <th>댓글내용</th>
				      <td>
				         <input type="text" name="content" id="commentContent" size="100" />
				         
				         <%-- 댓글에 달리는 원게시물 글번호(즉, 댓글의 부모글 글번호) --%>
				         <input type="text" name="fk_seq" id="fk_seq" value="${requestScope.boardvo.pk_seq}" />
				      </td>
				   </tr>
	   
				   <tr>
				      <th colspan="2">
				      	<button type="button" class="btn btn-success btn-sm mr-3" onclick="goAddWrite()">댓글쓰기 확인</button>
				      	<button type="reset" class="btn btn-success btn-sm">댓글쓰기 취소</button>
				      </th>
				   </tr>
			  </table>	      
    	   </form>
    	</c:if>
    	
    	
 		

 	

	 	<c:if test="${not empty requestScope.boardvo.previousseq}">
	 		<div style="margin-bottom: 1%; font-size: 9pt;">이전글&nbsp;&nbsp;<span class="move" onclick="javascript:location.href='view_2.bts?pk_seq=${requestScope.boardvo.previousseq}&searchType=${requestScope.paraMap.searchType}&searchWord=${requestScope.paraMap.searchWord}&gobackURL=${v_gobackURL}'">${requestScope.boardvo.previoussubject}</span></div>
	 	</c:if>
	
		<c:if test="${not empty requestScope.boardvo.nextseq}">
	   		<div style="margin-bottom: 1%; font-size: 9pt;">다음글&nbsp;&nbsp;<span class="move" onclick="javascript:location.href='view_2.bts?pk_seq=${requestScope.boardvo.nextseq}&searchType=${requestScope.paraMap.searchType}&searchWord=${requestScope.paraMap.searchWord}&gobackURL=${v_gobackURL}'">${requestScope.boardvo.nextsubject}</span></div>
    	</c:if>	
	</div>