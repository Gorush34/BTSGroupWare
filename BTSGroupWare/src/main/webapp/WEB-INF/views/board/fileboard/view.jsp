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

	 $("input#pw").keydown(function(event){
			
			if(event.keyCode == 13) { // ????????? ?????? ??????
				 $("button#btnDelete").click();
			}
		});
	 
	 /// ?????????
	 $("button#btnDelete").click(function(){
		  
		 if( "${fileboardvo.pw}" != $("input#pw").val() ) {
			 alert("???????????? ???????????? ????????????.");
			 return;
		 } 
		 else {
			// ???(form)??? ??????(submit)
			const frm = document.delFrm;
			frm.method = "POST";
			frm.action = "<%= ctxPath%>/fileboard/delEnd.bts";
			frm.submit();
		 }
		 
	 });

	 
	 ////////////////////////////////////////////
	 
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
			<span onclick="javascript:location.href='<%= request.getContextPath()%>/fileboard/write.bts?fk_seq=${requestScope.fileboardvo.pk_seq}&groupno=${requestScope.fileboardvo.groupno}&depthno=${requestScope.fileboardvo.depthno}&subject=${requestScope.fileboardvo.subject}'"><button type="button" class="btn btn-outline-primary">????????????</button></span>
			<span data-toggle="modal" data-target="#myModal"><button type="button" class="btn btn-outline-danger">????????????</button></span>
			<span onclick="javascript:location.href='<%= request.getContextPath()%>/fileboard/edit.bts?pk_seq=${requestScope.fileboardvo.pk_seq}'"><button type="button" class="btn btn-outline-warning">????????????</button></span>
			
		</div>
		
		<div id="smallHeader_right">
			<span onclick="javascript:location.href='<%= request.getContextPath()%>${requestScope.gobackURL}'"><button type="button" class="btn btn-secondary">??????</button></span>
		</div>
	</div>
	 
		
	 <hr>
	 
	 <!-- ????????? ?????? ??????-------------------------------------------- -->
	 <div>
	<%-- 	 <span style="font-size: 12pt; margin-left: 10pt;">${fileboardvo.header}</span> --%>
	 	<h2 style="margin:10px;">${fileboardvo.subject}</h2>
	 </div>
	 		
	 <div id="boardContentAll">		
	 <c:if test="${not empty requestScope.fileboardvo}">
	 	<table>
	 		<thead style="font-size: 12pt;">
	 			 <tr >
	 			  	<th>${fileboardvo.user_name}</th>
	 			</tr>
	 			<tr>
	 				<th style="font-size:9pt;color:#BDBDBD; font-weight:lighter;">${fileboardvo.write_day}</th>
	 			</tr>
	 			
	
	 	   
	 		</thead>
	 		 
	 		<tbody id="content">
	 			<tr >
	 				<td style="padding-bottom:40px; padding-top:40px; padding-right: 50px;">
						<p  style="word-break: break-all;">${fileboardvo.content}</p>
					</td>
	 			</tr>	 
	 		</tbody>
	 		
	 		</table>
	 		
	 		<table>
	 		<c:if test="${requestScope.fileboardvo.org_filename != null}">
		 		<tr>
					<th style="width: 100px;"><p>????????????</p></th>
					<td>
						<c:if test="${sessionScope.loginuser != null}">
							<a href="<%= request.getContextPath()%>/file/download_fileboard.bts?pk_seq=${requestScope.fileboardvo.pk_seq}">${requestScope.fileboardvo.org_filename}</a> <p style="font-size: 9pt;">&nbsp;(<fmt:formatNumber value="${requestScope.fileboardvo.file_size}" pattern="#,###" /> byte)</p>  
						</c:if>
						<c:if test="${sessionScope.loginuser == null}">
							${requestScope.fileboardvo.org_filename}
						</c:if>
					</td>
				</tr>
			</c:if>
			
			
    		

	 	</table>
	 	</c:if>
	 	<c:if test="${empty requestScope.fileboardvo}">
    		<div style="padding: 73px 300px; font-size: 16pt; font-weight: bold;" > ?????????????????? ???????????? ?????? ????????????.</div>
  		</c:if>
	 	
	 </div>

	 
	 <div style="font-size: 9pt; margin-left: 10px;">
		 <span>????????? ${fileboardvo.read_count} ??? </span>
	 </div>
	 
	 <hr style="1px solid; margin-bottom: 15px;">
	 
	 
	 <c:set var="v_gobackURL" value='${ fn:replace(requestScope.gobackURL, "&", " ") }' />
	 
	 <c:if test="${not empty requestScope.fileboardvo.previousseq}">
	 		<div style="margin-bottom: 1%; font-size: 9pt;">?????????&nbsp;&nbsp;<span class="move" onclick="javascript:location.href='/bts/fileboard/view_2.bts?pk_seq=${requestScope.fileboardvo.previousseq}&ko_depname=${requestScope.paraMap.ko_depname}&searchType=${requestScope.paraMap.searchType}&searchWord=${requestScope.paraMap.searchWord}&gobackURL=${v_gobackURL}'">${requestScope.fileboardvo.previoussubject}</span></div>
 	 </c:if>

	 <c:if test="${not empty requestScope.fileboardvo.nextseq}">
   		<div style="margin-bottom: 1%; font-size: 9pt;">?????????&nbsp;&nbsp;<span class="move" onclick="javascript:location.href='/bts/fileboard/view_2.bts?pk_seq=${requestScope.fileboardvo.nextseq}&ko_depname=${requestScope.paraMap.ko_depname}&searchType=${requestScope.paraMap.searchType}&searchWord=${requestScope.paraMap.searchWord}&gobackURL=${v_gobackURL}'">${requestScope.fileboardvo.nextsubject}</span></div>
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
		<h3>???????????? ????????????</h3>
		<h3>???????????? ???????????????????</h3>
		<input type="hidden" name="pk_seq" value="${fileboardvo.pk_seq}" readonly />
		<input type="hidden" name="filename" value="${fileboardvo.filename}" readonly />
		<input type="hidden" name="fk_emp_no" value="${fileboardvo.fk_emp_no}" readonly />
		<input type="hidden" name="pw" id="pw" value="${fileboardvo.pw}" readonly />
		<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnDelete">???????????????</button>
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
					<input type="hidden" name="pk_seq" value="${fileboardvo.pk_seq}" readonly />
					<input type="hidden" name="pk_seq" value="${fileboardvo.filename}" readonly />
					<input type="hidden" name="fk_emp_no" value="${fileboardvo.fk_emp_no}" readonly />
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
	
	