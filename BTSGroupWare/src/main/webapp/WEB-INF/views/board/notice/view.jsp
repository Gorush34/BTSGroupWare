<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>    
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  
 <style>

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
	
	
	#mycontent > div > div:nth-child(8) > span{
		font-size: 12pt;
		cursor: pointer;
	}
	
	#mycontent > div > div:nth-child(9) > span{
		cursor: pointer;
		font-size: 12pt;
	}
	
	#mycontent > div > div:nth-child(11) > span{
		cursor: pointer;
		font-size: 12pt;
	}
	
	#mycontent > div > div:nth-child(10) > span{
		cursor: pointer;
		font-size: 12pt;
	}
	
	#mycontent > div > div:nth-child(8) > span:hover{
		font-weight: bold;
	}
	
	#mycontent > div > div:nth-child(11) > span:hover {
		font-weight: bold;
	}
	
	#mycontent > div > div:nth-child(9) > span:hover {
		font-weight: bold;
	}
	
	#mycontent > div > div:nth-child(10) > span:hover {
		font-weight: bold;
	}
	
 </style>
 <script>
 $(document).ready(function(){

		
		$("span.move").hover(function(){
			                   $(this).addClass("moveColor");
		                    }
		                    ,function(){
		                       $(this).removeClass("moveColor");
		                    });

	}); // end of $(document).ready(function(){})----------------
	
	
	// Function Declaration
	    
 </script>
 
 <div style="padding-left: 5%;">

	<hr>
	  <div class="header">
		<div id="smallHeader">	
		<c:if test="${sessionScope.loginuser.fk_rank_id >= 50}">
			<span onclick="javascript:location.href='<%= request.getContextPath()%>/board/write.bts?fk_seq=${requestScope.noticevo.pk_seq}&groupno=${requestScope.noticevo.groupno}&depthno=${requestScope.noticevo.depthno}&subject=${requestScope.noticevo.subject}'"><button type="button" class="btn btn-outline-primary">답글쓰기</button></span>
			<span onclick="javascript:location.href='<%= request.getContextPath()%>/board/del.bts?pk_seq=${requestScope.noticevo.pk_seq}'"><button type="button" class="btn btn-outline-danger">삭제하기</button></span>
			<span onclick="javascript:location.href='<%= request.getContextPath()%>/board/edit.bts?pk_seq=${requestScope.noticevo.pk_seq}'"><button type="button" class="btn btn-outline-warning">수정하기</button></span>
		</c:if>	
			
		</div>
		
		<div id="smallHeader_right">
			<span onclick="javascript:location.href='<%= request.getContextPath()%>${requestScope.gobackURL}'"><button type="button" class="btn btn-outline-success">목록</button></span>
		</div>
	</div>
	 
		
	 <hr>
	 
	 <!-- 게시글 내용 시작-------------------------------------------- -->
	 <div>
	<%-- 	 <span style="font-size: 12pt; margin-left: 10pt;">${noticevo.header}</span> --%>
	 	<h2 style="margin:10px;">${noticevo.subject}</h2>
	 </div>
	 		
	 <div id="boardContentAll">		
	 
	 	<table>
	 		<thead style="font-size: 12pt;">
	 			 <tr >
	 			  	<th>${noticevo.user_name}</th>
	 			</tr>
	 			<tr>
	 				<th style="font-size:9pt;color:#BDBDBD; font-weight:lighter;">${noticevo.write_day}</th>
	 			</tr>
	 			
	
	 	   
	 		</thead>
	 		 
	 		<tbody id="content">
	 			<tr >
	 				<td style="padding-bottom:40px; padding-top:40px; padding-right: 50px;">
						<p  style="word-break: break-all;">${noticevo.content}</p>
					</td>
	 			</tr>	 
	 		</tbody>
	 		
	 		</table>
	 		
	 		<table>
	 		<c:if test="${requestScope.noticevo.org_filename != null}">
		 		<tr>
					<th style="width: 100px;"><p>첨부파일</p></th>
					<td>
						<c:if test="${sessionScope.loginuser != null}">
							<a href="<%= request.getContextPath()%>/file/download.bts?pk_seq=${requestScope.noticevo.pk_seq}">${requestScope.noticevo.org_filename}</a> <p style="font-size: 9pt;">&nbsp;(<fmt:formatNumber value="${requestScope.noticevo.file_size}" pattern="#,###" /> byte)</p>  
						</c:if>
						<c:if test="${sessionScope.loginuser == null}">
							${requestScope.noticevo.org_filename}
						</c:if>
					</td>
				</tr>
			</c:if>
			
			
    		

	 	</table>
	 </div>

	 
	 <div style="font-size: 9pt; margin-left: 10px;">
		 <span>조회수 ${noticevo.read_count} 회 </span>
	 </div>
	 
	 <hr style="1px solid; margin-bottom: 15px;">
	 
	 
	 <c:set var="v_gobackURL" value='${ fn:replace(requestScope.gobackURL, "&", " ") }' />
	 
	 <c:if test="${not empty requestScope.noticevo.previousseq}">
	 		<div style="margin-bottom: 1%; font-size: 9pt;">이전글&nbsp;&nbsp;<span class="move" onclick="javascript:location.href='view_2.bts?pk_seq=${requestScope.noticevo.previousseq}&headerCategory=${requestScope.paraMap.headerCategory}&searchType=${requestScope.paraMap.searchType}&searchWord=${requestScope.paraMap.searchWord}&gobackURL=${v_gobackURL}'">${requestScope.noticevo.previoussubject}</span></div>
 	 </c:if>

	 <c:if test="${not empty requestScope.noticevo.nextseq}">
   		<div style="margin-bottom: 1%; font-size: 9pt;">다음글&nbsp;&nbsp;<span class="move" onclick="javascript:location.href='view_2.bts?pk_seq=${requestScope.noticevo.nextseq}&headerCategory=${requestScope.paraMap.headerCategory}&searchType=${requestScope.paraMap.searchType}&searchWord=${requestScope.paraMap.searchWord}&gobackURL=${v_gobackURL}'">${requestScope.noticevo.nextsubject}</span></div>
    	</c:if>	
	 
</div>
	
	