<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>    
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
 <style>
#commentContent{
    width: 86%;
    margin-right: 17px;
}
	#pageBar > ul > li > a {
		color: black;
	}

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
	    padding-left: 400px;
	}
	
	td.comment_index{
	color: gray;
    font-size: 10pt;
	width: 50px;
	text-align: center;
	padding: 25px 0 ;
	}	 
	
	td.comment_content{
	min-width:690px;
	max-width:690px;
	word-break:break-all;
	padding-right: 25px;
	}	 
	
	td.comment_name{
	color: gray;
    font-size: 10pt;
    padding-right: 18px;
	}	 
	
	td.comment_regDate{
	color: gray;
    font-size: 10pt;
	}
	
	tbody#commentDisplay{
	display: block;
	padding-left: 20px;
	}
	
	tr#comment{
	margin-bottom: 10px;
	display: block;
	} 
	
	
	td#commentContent{
	display: flex;
	
	}
	
	#mycontent > div:nth-child(3) > div:nth-child(8) > span{
		font-size: 12pt;
		cursor: pointer;
	}
	
	#mycontent > div:nth-child(3) > div:nth-child(8) > span:hover{
		font-weight: bold;
	}
	
	#mycontent > div > div:nth-child(9) > span{
		font-size: 12pt;
		cursor: pointer;
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
	
	#mycontent > div > div:nth-child(10) > span{
		cursor: pointer;
		font-size: 12pt;
	}
	
	#mycontent > div > div:nth-child(10) > span:hover{
		font-weight: bold;
	}
	
	#mycontent > div > div:nth-child(9) > span:hover{
		font-weight: bold;
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
		
	 $("input#commentContent").keydown(function(event){
			
			if(event.keyCode == 13) { // 엔터를 했을 경우
				goAddWrite();	
			}
		});
	 
	 $("input#pw").keydown(function(event){
			
			if(event.keyCode == 13) { // 엔터를 했을 경우
				 $("button#btnDelete").click();
			}
		});
	 
	 
	 /// 글삭제
	 $("button#btnDelete").click(function(){
		  
		 if( "${boardvo.pw}" != $("input#pw").val() ) {
			 alert("글암호가 일치하지 않습니다.");
			 return;
		 } 
		 else {
			// 폼(form)을 전송(submit)
			const frm = document.delFrm;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/board/delEnd.bts";
			frm.submit();
		 }
		 
	 });

 
	 
	 ////////////////////////////////////////////
	 
	 
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
				   ,"name":$("input#name").val() 
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
	

	  
	  function goDelComment(pk_seq){
		   
	      
	          if(confirm("정말 삭제하시겠습니까?") == true) {
	             $.ajax({
	                  url:"<%=ctxPath%>/board/delComment.bts",
	                  data:{"pk_seq":pk_seq,
	                	    "fk_seq":"${requestScope.boardvo.pk_seq}"},
	                  dataType:"JSON",
	                  success:function(json){
	                     alert("댓글이 삭제되었습니다.")
	                     goViewComment("1");
	                  },
	                  error: function(request, status, error){
	                     alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	                  }
	               });     
	            }
	            else {
	               return;
	            }                 
	       
	    
	      
	      goViewComment("1");
	      
	   }
	  
	  
	  
	  
	  // === #127. Ajax로 불러온 댓글내용을  페이징 처리 하기  === //
	  function goViewComment(currentShowPageNo) {
		  
		  $.ajax({
			  url:"<%= request.getContextPath()%>/board/commentList.bts",
			  data:{"fk_seq":"${requestScope.boardvo.pk_seq}",
				    "currentShowPageNo":currentShowPageNo},
			  dataType:"JSON",
			  success:function(json){
				/*   
				  let writeuserid = item.fk_emp_no;
	              let loginuserid = "${sessionScope.loginuser.pk_emp_no}";
				   */
				  let html = "";
				  if(json.length > 0) {

					  $.each(json, function(index, item){
						  var writeuser = item.fk_emp_no;
						  var loginuser = "${sessionScope.loginuser.pk_emp_no}";
						  
						  html += "<tr>";
						  html += "<td class='comment_index'>"+(index+1)+"</td>";
						  html += "<td class='comment_content'>"+item.content+"</td>";
						  html += "<td class='comment_name'>"+item.name+" "+item.ko_rankname+"</td>";
						  html += "<td class='comment_regDate'>"+item.regDate+"</td>";
						  if( writeuser == loginuser ) {
							  html += "<td style='text-align: center;' onclick='goDelComment(\""+item.pk_seq+"\")'><span style='cursor: pointer; color: gray; margin-left: 10px;'>X</span></td>";
						    } 
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

					 let loop = 1;

				    

				     if(typeof currentShowPageNo == "string") {
				    	 currentShowPageNo = Number(currentShowPageNo);
				     }
				     

				     let pageNo = Math.floor( (currentShowPageNo - 1)/blockSize ) * blockSize + 1;

				     
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
			<span data-toggle="modal" data-target="#myModal"><button type="button" class="btn btn-outline-danger">삭제하기</button></span>
			<span onclick="javascript:location.href='<%= request.getContextPath()%>/board/edit.bts?pk_seq=${requestScope.boardvo.pk_seq}'"><button type="button" class="btn btn-outline-warning">수정하기</button></span>
		</div>
		
		<div id="smallHeader_right">
			<span onclick="javascript:location.href='<%= request.getContextPath()%>${requestScope.gobackURL}'"><button type="button" class="btn btn-secondary">목록</button></span>
		</div>
	</div>
	 
		
	 <hr>
	 
	 <!-- 게시글 내용 시작-------------------------------------------- -->
	  <div id="boardContentAll">		
	 <c:if test="${not empty requestScope.boardvo}">
	 <div>
	 	<h2 style="margin:10px;">${boardvo.subject}</h2>
	 </div>
	 		
	
	 
	 	<table>
	 		<thead style="font-size: 12pt;">
	 			 <tr >
	 			  	<th>${boardvo.user_name} 
	 			  	<c:if test="${boardvo.fk_emp_no != 80000001}">
				 		 ${boardvo.ko_rankname}
				 	 </c:if>
				 	 </th>
	 			</tr>
	 			<tr>
	 				<th style="font-size:9pt;color:#BDBDBD; font-weight:lighter;">${boardvo.write_day} &nbsp;&nbsp;|&nbsp;&nbsp; 조회수 ${boardvo.read_count} 회 </th>

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
	 		
	 		<table>
	 		<c:if test="${requestScope.boardvo.org_filename != null}">
		 		<tr>
					<th style="width: 100px;"><p>첨부파일</p></th>
					<td>
						<c:if test="${sessionScope.loginuser != null}">
							<a href="<%= request.getContextPath()%>/file/download_board.bts?pk_seq=${requestScope.boardvo.pk_seq}">${requestScope.boardvo.org_filename}</a> <p style="font-size: 9pt;">&nbsp;(<fmt:formatNumber value="${requestScope.boardvo.file_size}" pattern="#,###" /> byte)</p>  
						</c:if>
						<c:if test="${sessionScope.loginuser == null}">
							${requestScope.boardvo.org_filename}
						</c:if>
					</td>
				</tr>
			</c:if>
			
	 	</table>
	</c:if>
	<c:if test="${empty requestScope.boardvo}">
    	<div style="padding: 73px 300px; font-size: 16pt; font-weight: bold;" > 삭제되었거나 존재하지 않는 글입니다.</div>
    </c:if>
	<%-- <button style="border:none; background-color: white; font-weight: bold;" type="button" id="like_btn" onclick="updateLike(); return false;">좋아요</button>
	<span style="color: white;
    font-size: 15pt;
    font-weight: bold;
    background-color: gray;
    padding: 10pt;
    border-radius: 100%;
    width: 20px !important;
    height: 20px !important;">${boardvo.like_cnt}</span> --%>
    <c:if test="${likevo2.fk_seq > 0}">
    <button type="button" class="btn btn-outline-secondary" id="like_btn" onclick="updateLike(); return false;">추천 완료 ${boardvo.like_cnt}</button>
    </c:if>
    
    <c:if test="${likevo2.fk_seq <= 0 || likevo2.fk_seq == null}">
    <button type="button" class="btn btn-outline-secondary" id="like_btn" onclick="updateLike(); return false;">추천 ${boardvo.like_cnt}</button>
    </c:if>
    
	<span style="width: 800px; margin-left: 5px;">
		<c:forEach var="likevo" items="${requestScope.likeList}" varStatus="status">
				   <tr>
				      <td align="center">
				          <a data-toggle="tooltip" title="${likevo.emp_name}&nbsp;${likevo.ko_ranknam}"><img src="<%= ctxPath%>/resources/images/board/heart2.png" style="width:20px;"></a> 
				      	  
				      </td>  
				</tr>
		</c:forEach>
	</span>
	
	
<%--  	 <span>${likevo.pk_seq}</span>
	 <span>${likevo.fk_seq}</span> 
	 <span>${likevo.fk_emp_no}</span> --%>

	 </div>
	 <!-- 게시글 내용 시작끝-------------------------------------------- -->
<%-- 	 <div style="padding-left: 41%">
		 <form>
			 <button id="btnLike" type="button"><img src="<%= ctxPath%>/resources/images/board/like.png" style="width:50px;"></button>
			 <button style="margin-left: 30px;" id="btnDislike" type="button"><img src="<%= ctxPath%>/resources/images/board/dislike.png" style="width:50px; "></button>
		 </form>
	 </div> --%>
	 
	 
	
	 <!-- 아래부터 댓글------------------------------->
	 
	 <%-- === #83. 댓글쓰기 폼 추가 === --%>
    	<c:if test="${not empty sessionScope.loginuser}">
    	   <form name="addWriteFrm" id="addWriteFrm" style="margin-top: 20px;">
    	      <table class="table" style="width: 1024px">
				
				   <tr style="height: 30px;">
					      <th style="padding-top: 17px !important;padding-left: 40px; font-size: 14pt; font-weight: 550; color: #737373;">댓글</th>
				      <td style="width: 91%;">
				        <input type="hidden" name="fk_emp_no" id="fk_emp_no" value="${sessionScope.loginuser.pk_emp_no}" />  
				         <input type="hidden" name="name" id="name" value="${sessionScope.loginuser.emp_name}" readonly />
				         <input type="text" name="content" id="commentContent" size="100" />
				         <input type="text" style="display: none;"/>
				         <%-- 댓글에 달리는 원게시물 글번호(즉, 댓글의 부모글 글번호) --%>
				         <input type="hidden" name="fk_seq" id="fk_seq" value="${requestScope.boardvo.pk_seq}" />
				         <button type="button" class="btn btn-light" onclick="goAddWrite()">댓글쓰기</button>
				      </td>
				   </tr>
	   
				   <tr>
				      	

				   </tr>
			  </table>	      
    	   </form>
    	</c:if>
	 
	 

	 
	 <!-- =====  댓글 내용 보여주기 ===== -->
	<table id="table2" style="border-bottom: 1px solid #dee2e6; width: 1024px; margin-bottom: 20px">
		<thead>
		<tr>
		    
		</tr>
		</thead> 
		<tbody id="commentDisplay"></tbody>
	</table>
	 <!-- ===== 댓글 내용 보여주기 끝===== -->
	
	
    	<%-- ==== 댓글 페이지바 ==== --%>
    	<div style="display: flex; margin-bottom: 50px;">
    	   <div id="pageBar" style="width:1024px; text-align: center;"></div>
    	</div>
    	
		<c:set var="v_gobackURL" value='${ fn:replace(requestScope.gobackURL, "&", " ") }' />

	 	<c:if test="${not empty requestScope.boardvo.previousseq}">
	 		<div style="margin-bottom: 1%; font-size: 9pt;">이전글&nbsp;&nbsp;<span class="move" onclick="javascript:location.href='/bts/board/view_2.bts?pk_seq=${requestScope.boardvo.previousseq}&searchType=${requestScope.paraMap.searchType}&searchWord=${requestScope.paraMap.searchWord}&gobackURL=${v_gobackURL}'">${requestScope.boardvo.previoussubject}</span></div>
	 	</c:if>
	
		<c:if test="${not empty requestScope.boardvo.nextseq}">
	   		<div style="margin-bottom: 1%; font-size: 9pt;">다음글&nbsp;&nbsp;<span class="move" onclick="javascript:location.href='/bts/board/view_2.bts?pk_seq=${requestScope.boardvo.nextseq}&searchType=${requestScope.paraMap.searchType}&searchWord=${requestScope.paraMap.searchWord}&gobackURL=${v_gobackURL}'">${requestScope.boardvo.nextsubject}</span></div>
    	</c:if>	
	</div>


<div class="modal fade" id="myModal" role="dialog"> 
<div class="modal-dialog"> 
<div class="modal-content"> 
<div class="modal-header"> 


<h2 class="modal-title">
글삭제
</h2> 

<button type="button" class="close" data-dismiss="modal">
×
</button> 

</div> 
<div class="modal-body"> 
<div style="display: flex;">
<div style="margin: auto; padding-left: 3%;">

<c:if test="${sessionScope.loginuser.pk_emp_no == 80000001}">
	<form name="delFrm">
		<h4>관리자의 권한으로</h4>
		<h4 style="margin-bottom: 30px;">글삭제를 하시겠습니까?</h4>
		
		<input type="hidden" name="pk_seq" value="${boardvo.pk_seq}" readonly />
		<input type="hidden" name="filename" value="${boardvo.filename}" readonly />
		<input type="hidden" name="fk_emp_no" value="${boardvo.fk_emp_no}" readonly />
		<input type="hidden" name="pw" id="pw" value="${boardvo.pw}" readonly />
		<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnDelete" style="margin-right: 30px !important;">글삭제완료</button>
		<button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">글삭제취소</button>
	</form>	
</c:if>


<c:if test="${sessionScope.loginuser.pk_emp_no != 80000001}">

	<form name="delFrm">
		<table style="width: 455px" class="table table-bordered">
			<tr>
				<th style="width: 22%; background-color: #DDDDDD;">글암호</th>
				<td>
					<input style="width: 100%;" type="password" id="pw" />
					<input type="text" style="display: none;"/>
					<input type="hidden" name="pk_seq" value="${boardvo.pk_seq}" readonly />
					<input type="hidden" name="filename" value="${boardvo.filename}" readonly />
					<input type="hidden" name="fk_emp_no" value="${boardvo.fk_emp_no}" readonly />
				</td>
			</tr>
		</table>
		
		<div style="margin: 20px;">
			<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnDelete">글삭제완료</button>
			<button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">글삭제취소</button>
		</div>
		
	</form>   
</c:if>


</div>
</div>    
</div> 
</div> 
</div> 
</div>

	
	
	<script>
	// 좋아요 기능 //
	 function updateLike(){ 
			if(${sessionScope.loginuser.pk_emp_no >= 1} ){
				 $.ajax({
					  url:"<%= request.getContextPath()%>/board/updateLike.bts",
					  data:{"fk_emp_no":$("input#fk_emp_no").val() 
						   ,"fk_seq":$("input#fk_seq").val()},
					  type:"POST",
					  dataType:"JSON",
					  success:function(likeCheck){
						 
						  if(likeCheck == 0){
		                  	location.reload();
		                  }
		                  else {
		                  	location.reload();
		                  }
					  },
					  error: function(request, status, 	error){
							alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					  }
				  });
			}
			else {
				alert("로그인을 해주세요.");
			}
			
	 }
	
	


	  $(document).ready(function(){

	    $('[data-toggle="tooltip"]').tooltip();   

	  });


	
	</script>