<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
    
<% String ctxPath = request.getContextPath(); %>

<%-- 캘린더(일정) 사이드 tiles 만들기 --%>

<style type="text/css">

td#no{
	text-align: center;
	font-weight: bold;
	color: black !important;
	padding: 20px 0 !important;
	font-size: 13pt;
}

#boardContentAll > table:nth-child(2) > tbody > tr > td > a{
color:black !important;
}

a.nav-link{
margin-right: 20px;
font-size: 15px;
    padding-right: 0.5rem;
    padding-left: 0.5rem;
        display: block;
    padding: 0.5rem 1rem;

}

a#side{
    color: black;
    font-size: 15pt;
    font-weight: bold;
    text-decoration: none;
}


span.subject2{
  display: block;
  max-width: 600px;
  overflow: hidden;
  white-space: nowrap;
  text-overflow: ellipsis;
} 

.commentContentsClosed{
text-overflow: ellipsis; 
white-space: nowrap; 
max-width: 100px;
text-align: left
}

.commentContentsClosed:hover{
font-weight: bold;
}

#bestDisplay > tr:nth-child(1) > td:nth-child(1){
color: red;
}
</style>


<script type="text/javascript">

	$(document).ready(function(){
		
		goReadBest();

		
	});// end of $(document).ready(function(){}-------------------

			
	//Function Declaration



	
function goReadBest() {
	  
	  $.ajax({
		  url:"<%= request.getContextPath()%>/board/readBest.bts",
		  dataType:"JSON",
		  success:function(json){
			  
			  let html = "";
			  if(json.length > 0) {
				  $.each(json, function(index, item){
					  if(item.tblname == "자유게시판"){
						  html += "<tr>";  
						  html += "<td class='board' style='width: 30px; height:30px;'>"+(index+1)+"</td>";
						  html += "<td class='commentContentsClosed'><span onclick='goView_board("+item.pk_seq+")' class='subject2' style='color: black; cursor: pointer;'>"+item.subject+"</span></td>";	 
						  html += "<td class='board' style='width: 70px;'>"+item.user_name+"</td>";		  
						  html += "</tr>";
					  }
					  if(item.tblname == "공지사항"){
						  html += "<tr>";  
						  html += "<td class='board' style='width: 30px; height:30px;'>"+(index+1)+"</td>";
						  html += "<td class='commentContentsClosed'><span onclick='goView_notice("+item.pk_seq+")' class='subject2' style='color: black; cursor: pointer;'>"+item.subject+"</span></td>";				 
						  html += "<td class='board' style='width: 70px;'>"+item.user_name+"</td>";		  
						  html += "</tr>";
						  }
					  if(item.tblname == "자료실"){
						  html += "<tr>";  
						  html += "<td class='board' style='width: 30px; height:30px;'>"+(index+1)+"</td>";
						  html += "<td class='commentContentsClosed'><span onclick='goView_fileboard("+item.pk_seq+")' class='subject2' style='color: black; cursor: pointer;'>"+item.subject+"</span></td>";
						  html += "<td class='board' style='width: 70px;'>"+item.user_name+"</td>";		  
						  html += "</tr>";
						  }
				  });
			  }
			  else {
				  html += "<tr>";
				  html += "<td colspan='3' class='board' id='no'>게시물이 없습니다.</td>";
				  html += "</tr>";
			  }
			  
			  $("tbody#bestDisplay").html(html);
		  },
		  error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		  }
	  });
	  
  }// end of function goReadComment(){}--------------------------
	
	

  
  
	function goView_board(pk_seq) {

			const gobackURL = "${requestScope.gobackURL}"; 
		  
		  location.href="<%= ctxPath%>/board/view.bts?pk_seq="+pk_seq+"&gobackURL="+gobackURL; 
		}// end of function goView(seq){}----------------------------------------------
		
  
	function goView_notice(pk_seq) {

		const gobackURL = "${requestScope.gobackURL}"; 
	  
	  location.href="<%= ctxPath%>/notice/view.bts?pk_seq="+pk_seq+"&gobackURL="+gobackURL; 
	}// end of function goView(seq){}----------------------------------------------
	
	
	function goView_fileboard(pk_seq) {

		const gobackURL = "${requestScope.gobackURL}"; 
	  
	  location.href="<%= ctxPath%>/fileboard/view.bts?pk_seq="+pk_seq+"&gobackURL="+gobackURL; 
	}// end of function goView(seq){}----------------------------------------------	
 
</script>



	<div>
	   <div id="sidebar" style="font-size: 11pt; ">

			


          <div class="dropdown"> 

                    <button style="margin: 15px auto; width:200px; display:block; font-size: 15pt;  height: 50px; font-weight: bold;"  class="btn btn-primary  dropdown-toggle"  data-toggle="dropdown"> 

                    	  게시물 작성

                    </button> 

                    <div class="dropdown-menu"> 
							 <c:if test="${sessionScope.loginuser.fk_rank_id >= 50}">
                             <form class="dropdown-item "  action="<%= ctxPath%>/notice/write.bts" method="post">                    
								<input type="hidden" name="fk_emp_no" value="${sessionScope.loginuser.pk_emp_no}" />
								<input class="dropdown-item" style="border:none;" type="submit" value="공지사항" />
							 </form>
							 </c:if>	
                             <form class="dropdown-item "  action="<%= ctxPath%>/fileboard/write.bts" method="post">                    
								<input type="hidden" name="fk_emp_no" value="${sessionScope.loginuser.pk_emp_no}" />
								<input class="dropdown-item" style="border:none;" type="submit" value="자료실" />
							 </form>

                             <form class="dropdown-item "  action="<%= ctxPath%>/board/write.bts" method="post">                    
								<input type="hidden" name="fk_emp_no" value="${sessionScope.loginuser.pk_emp_no}" />
								<input class="dropdown-item" style="border:none;" type="submit" value="자유게시판" />
							 </form>

                    </div> 

          </div> 

			
			<ul  style="list-style-type: none; padding: 10px; text-align: center;">
				<li  style="margin-bottom: 15px;">
					<a id="side" href="<%= ctxPath%>/board/main.bts">전체글</a>
				</li>
				<li style="margin-bottom: 15px;">
					<a id="side" href="<%= ctxPath%>/notice/list.bts">공지사항</a>
				</li>
				<li style="margin-bottom: 15px;">
					<a id="side" href="<%= ctxPath%>/fileboard/list.bts">자료실</a>
				</li>
				<li >
					<a id="side" href="<%= ctxPath%>/board/list.bts">자유게시판</a>
				</li>
				
			</ul>
			
			<hr style="margin-bottom: 30px;">
			
			<div id="best" class="btn btn-info" style="cursor: unset; margin: 15px auto 10px auto; width: 200px; display: block; font-size: 14pt;  font-weight: bold;">오늘의 인기글</div>
			<table id="table2" style="border-bottom: 1px solid #dee2e6; width: 200px; margin-bottom: 10px; margin-left: 20px;">
				<thead>
				<tr>
				    
				</tr>
				</thead> 

				<tbody id="bestDisplay"></tbody>
				
			</table>		
			
		</div>
		
		
	</div>
	