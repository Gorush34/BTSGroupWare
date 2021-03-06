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
			
			if(event.keyCode == 13) { // ????????? ?????? ??????
				goAddWrite();	
			}
		});
	 
	 $("input#pw").keydown(function(event){
			
			if(event.keyCode == 13) { // ????????? ?????? ??????
				 $("button#btnDelete").click();
			}
		});
	 
	 
	 /// ?????????
	 $("button#btnDelete").click(function(){
		  
		 if( "${boardvo.pw}" != $("input#pw").val() ) {
			 alert("???????????? ???????????? ????????????.");
			 return;
		 } 
		 else {
			// ???(form)??? ??????(submit)
			const frm = document.delFrm;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/board/delEnd.bts";
			frm.submit();
		 }
		 
	 });

 
	 
	 ////////////////////////////////////////////
	 
	 
	 // goReadComment();  // ??????????????? ?????? ?????? ???????????? 
	     goViewComment(1); // ??????????????? ??? ?????? ???????????? 
		
		$("span.move").hover(function(){
			                   $(this).addClass("moveColor");
		                    }
		                    ,function(){
		                       $(this).removeClass("moveColor");
		                    });

	}); // end of $(document).ready(function(){})----------------
	
	

	
	// Function Declaration
	  
	  // == ???????????? == 
	  function goAddWrite() {
		  
		  const commentContent = $("input#commentContent").val().trim();
		  if(commentContent == "") {
			  alert("?????? ????????? ???????????????!!");
			  return; // ??????
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
					 alert("?????? ?????? ??????");
				 }
				 else {
					 
				     goViewComment(1); // ????????? ????????? ?????? ????????????
				 }
				 
				 $("input#commentContent").val("");
			  },
			  error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		  });
		  
	  }// end of function goAddWrite() {}--------------------
	

	  
	  function goDelComment(pk_seq){
		   
	      
	          if(confirm("?????? ?????????????????????????") == true) {
	             $.ajax({
	                  url:"<%=ctxPath%>/board/delComment.bts",
	                  data:{"pk_seq":pk_seq,
	                	    "fk_seq":"${requestScope.boardvo.pk_seq}"},
	                  dataType:"JSON",
	                  success:function(json){
	                     alert("????????? ?????????????????????.")
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
	  
	  
	  
	  
	  // === #127. Ajax??? ????????? ???????????????  ????????? ?????? ??????  === //
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
							  html += "<td style='text-align: center;' onclick='goDelComment(\""+item.pk_seq+"\")'><span style='cursor: pointer; color: gray; margin-left: 10px;'><i class='bi bi-x-circle'></i></span></td>";
						    } 
						  html += "</tr>";
					  });
				  }
				  else {
					  html += "<tr>";
					  html += "<td colspan='4' class='comment' style='margin-bottom: 25px;'>????????? ????????????</td>";
					  html += "</tr>";
				  }
				  
				  $("tbody#commentDisplay").html(html);
				  
				  // ???????????? ?????? ??????
				  makeCommentPageBar(currentShowPageNo);
				  
			  },
			  error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			  }
		  });
		  
	  }// end of function goViewComment(currentShowPageNo) {}-------------------------
	  
	  // ==== ???????????? ???????????? Ajax??? ????????? ==== //
	  function makeCommentPageBar(currentShowPageNo) {
		  
		  <%-- === ????????? ?????? ????????? totalPage ?????? ??????????????? ??????. ===  --%>
		  $.ajax({
			  url:"<%= request.getContextPath()%>/board/getCommentTotalPage.bts",
			  data:{"fk_seq":"${requestScope.boardvo.pk_seq}",
				    "sizePerPage":"5"},
			  type:"GET",
			  dataType:"JSON",
			  success:function(json){
				 //  console.log("????????? ????????? ?????????????????? : " + json.totalPage);
				 
				 if(json.totalPage > 0) {
					 // ????????? ?????? ?????? 
					 
					 const totalPage = json.totalPage;
					 
					 let pageBarHTML = "<ul style='list-style: none;'>";
					 
					 const blockSize = 10;

					 let loop = 1;

				    

				     if(typeof currentShowPageNo == "string") {
				    	 currentShowPageNo = Number(currentShowPageNo);
				     }
				     

				     let pageNo = Math.floor( (currentShowPageNo - 1)/blockSize ) * blockSize + 1;

				     
					// === [?????????][??????] ????????? === //
					if(pageNo != 1) {
						pageBarHTML += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='javascript:goViewComment(\"1\")'>[?????????]</a></li>";
						pageBarHTML += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='javascript:goViewComment(\""+(pageNo-1)+"\")'>[??????]</a></li>";
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
					
					
					// === [??????][?????????] ????????? === //
					if( pageNo <= totalPage ) {
						pageBarHTML += "<li style='display:inline-block; width:50px; font-size:12pt;'><a href='javascript:goViewComment(\""+pageNo+"\")'>[??????]</a></li>";
						pageBarHTML += "<li style='display:inline-block; width:70px; font-size:12pt;'><a href='javascript:goViewComment(\""+totalPage+"\")'>[?????????]</a></li>"; 
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
			<span onclick="javascript:location.href='<%= request.getContextPath()%>/board/write.bts?fk_seq=${requestScope.boardvo.pk_seq}&groupno=${requestScope.boardvo.groupno}&depthno=${requestScope.boardvo.depthno}&subject=${requestScope.boardvo.subject}'"><button type="button" class="btn btn-outline-primary">????????????</button></span>
			<span data-toggle="modal" data-target="#myModal"><button type="button" class="btn btn-outline-danger">????????????</button></span>
			<span onclick="javascript:location.href='<%= request.getContextPath()%>/board/edit.bts?pk_seq=${requestScope.boardvo.pk_seq}'"><button type="button" class="btn btn-outline-warning">????????????</button></span>
		</div>
		
		<div id="smallHeader_right">
			<span onclick="javascript:location.href='<%= request.getContextPath()%>${requestScope.gobackURL}'"><button type="button" class="btn btn-secondary">??????</button></span>
		</div>
	</div>
	 
		
	 <hr>
	 
	 <!-- ????????? ?????? ??????-------------------------------------------- -->
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
	 				<th style="font-size:9pt;color:#BDBDBD; font-weight:lighter;">${boardvo.write_day} &nbsp;&nbsp;|&nbsp;&nbsp; ????????? ${boardvo.read_count} ??? </th>

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
					<th style="width: 100px;"><p>????????????</p></th>
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
    	<div style="padding: 73px 300px; font-size: 16pt; font-weight: bold;" > ?????????????????? ???????????? ?????? ????????????.</div>
    </c:if>
	<%-- <button style="border:none; background-color: white; font-weight: bold;" type="button" id="like_btn" onclick="updateLike(); return false;">?????????</button>
	<span style="color: white;
    font-size: 15pt;
    font-weight: bold;
    background-color: gray;
    padding: 10pt;
    border-radius: 100%;
    width: 20px !important;
    height: 20px !important;">${boardvo.like_cnt}</span> --%>
    <c:if test="${likevo2.fk_seq > 0}">
    <button type="button" class="btn btn-outline-secondary" id="like_btn" onclick="updateLike(); return false;">?????? ?????? ${boardvo.like_cnt}</button>
    </c:if>
    
    <c:if test="${likevo2.fk_seq <= 0 || likevo2.fk_seq == null}">
    <button type="button" class="btn btn-outline-secondary" id="like_btn" onclick="updateLike(); return false;">?????? ${boardvo.like_cnt}</button>
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
	 <!-- ????????? ?????? ?????????-------------------------------------------- -->
<%-- 	 <div style="padding-left: 41%">
		 <form>
			 <button id="btnLike" type="button"><img src="<%= ctxPath%>/resources/images/board/like.png" style="width:50px;"></button>
			 <button style="margin-left: 30px;" id="btnDislike" type="button"><img src="<%= ctxPath%>/resources/images/board/dislike.png" style="width:50px; "></button>
		 </form>
	 </div> --%>
	 
	 
	
	 <!-- ???????????? ??????------------------------------->
	 
	 <%-- === #83. ???????????? ??? ?????? === --%>
    	<c:if test="${not empty sessionScope.loginuser}">
    	   <form name="addWriteFrm" id="addWriteFrm" style="margin-top: 20px;">
    	      <table class="table" style="width: 1024px">
				
				   <tr style="height: 30px;">
					      <th style="padding-top: 17px !important;padding-left: 40px; font-size: 14pt; font-weight: 550; color: #737373;">??????</th>
				      <td style="width: 91%;">
				        <input type="hidden" name="fk_emp_no" id="fk_emp_no" value="${sessionScope.loginuser.pk_emp_no}" />  
				         <input type="hidden" name="name" id="name" value="${sessionScope.loginuser.emp_name}" readonly />
				         <input type="text" name="content" id="commentContent" size="100" />
				         <input type="text" style="display: none;"/>
				         <%-- ????????? ????????? ???????????? ?????????(???, ????????? ????????? ?????????) --%>
				         <input type="hidden" name="fk_seq" id="fk_seq" value="${requestScope.boardvo.pk_seq}" />
				         <button type="button" class="btn btn-light" onclick="goAddWrite()">????????????</button>
				      </td>
				   </tr>
	   
				   <tr>
				      	

				   </tr>
			  </table>	      
    	   </form>
    	</c:if>
	 
	 

	 
	 <!-- =====  ?????? ?????? ???????????? ===== -->
	<table id="table2" style="border-bottom: 1px solid #dee2e6; width: 1024px; margin-bottom: 20px">
		<thead>
		<tr>
		    
		</tr>
		</thead> 
		<tbody id="commentDisplay"></tbody>
	</table>
	 <!-- ===== ?????? ?????? ???????????? ???===== -->
	
	
    	<%-- ==== ?????? ???????????? ==== --%>
    	<div style="display: flex; margin-bottom: 50px;">
    	   <div id="pageBar" style="width:1024px; text-align: center;"></div>
    	</div>
    	
		<c:set var="v_gobackURL" value='${ fn:replace(requestScope.gobackURL, "&", " ") }' />

	 	<c:if test="${not empty requestScope.boardvo.previousseq}">
	 		<div style="margin-bottom: 1%; font-size: 9pt;">?????????&nbsp;&nbsp;<span class="move" onclick="javascript:location.href='/bts/board/view_2.bts?pk_seq=${requestScope.boardvo.previousseq}&searchType=${requestScope.paraMap.searchType}&searchWord=${requestScope.paraMap.searchWord}&gobackURL=${v_gobackURL}'">${requestScope.boardvo.previoussubject}</span></div>
	 	</c:if>
	
		<c:if test="${not empty requestScope.boardvo.nextseq}">
	   		<div style="margin-bottom: 1%; font-size: 9pt;">?????????&nbsp;&nbsp;<span class="move" onclick="javascript:location.href='/bts/board/view_2.bts?pk_seq=${requestScope.boardvo.nextseq}&searchType=${requestScope.paraMap.searchType}&searchWord=${requestScope.paraMap.searchWord}&gobackURL=${v_gobackURL}'">${requestScope.boardvo.nextsubject}</span></div>
    	</c:if>	
	</div>


<div class="modal fade" id="myModal" role="dialog"> 
<div class="modal-dialog"> 
<div class="modal-content"> 
<div class="modal-header"> 


<h2 class="modal-title">
?????????
</h2> 

<button type="button" class="close" data-dismiss="modal">
??
</button> 

</div> 
<div class="modal-body"> 
<div style="display: flex;">
<div style="margin: auto; padding-left: 3%;">

<c:if test="${sessionScope.loginuser.pk_emp_no == 80000001}">
	<form name="delFrm">
		<h4>???????????? ????????????</h4>
		<h4 style="margin-bottom: 30px;">???????????? ???????????????????</h4>
		
		<input type="hidden" name="pk_seq" value="${boardvo.pk_seq}" readonly />
		<input type="hidden" name="filename" value="${boardvo.filename}" readonly />
		<input type="hidden" name="fk_emp_no" value="${boardvo.fk_emp_no}" readonly />
		<input type="hidden" name="pw" id="pw" value="${boardvo.pw}" readonly />
		<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnDelete" style="margin-right: 30px !important;">???????????????</button>
		<button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">???????????????</button>
	</form>	
</c:if>


<c:if test="${sessionScope.loginuser.pk_emp_no != 80000001}">

	<form name="delFrm">
		<table style="width: 455px" class="table table-bordered">
			<tr>
				<th style="width: 22%; background-color: #DDDDDD;">?????????</th>
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
			<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnDelete">???????????????</button>
			<button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal">???????????????</button>
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
	// ????????? ?????? //
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
				alert("???????????? ????????????.");
			}
			
	 }
	
	


	  $(document).ready(function(){

	    $('[data-toggle="tooltip"]').tooltip();   

	  });


	
	</script>