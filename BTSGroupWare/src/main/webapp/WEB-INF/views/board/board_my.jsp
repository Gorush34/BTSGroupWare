<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<% String ctxPath = request.getContextPath(); %>

<style>


#mycontent > div > form > button {
background-color: white;
}
#searchWord {
margin: 0 6px;
}
#mycontent > div > form:nth-child(3) > input[type=submit]:nth-child(3):hover {
	font-weight: bold;
}

    .subjectStyle {font-weight: bold;
    			   color: navy;
    			   cursor: pointer;}
	
	#mycontent > div > div:nth-child(5) > ul > li > a {
		color: black;
	}

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
		
		
		$("span.subject").bind("mouseover", function(event){
			var $target = $(event.target);
			$target.addClass("subjectStyle");
		});
		
		$("span.subject").bind("mouseout", function(event){
			var $target = $(event.target);
			$target.removeClass("subjectStyle");
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

	// 체크박스 전체선택 및 해제
	$("input#checkAll").click(function() {
		if($(this).prop("checked")) {
			$("input[name='chkBox']").prop("checked",true);
		}
		else {
			$("input[name='chkBox']").prop("checked",false);
		}
		
	});	
	// 삭제버튼 클릭 시 휴지통으로 이동하기 (ajax)
	function goselctDel() {
		
		// 체크된 갯수 세기
		var chkCnt = $("input[name='chkBox']:checked").length;
		
		// 배열에 체크된 행의 pk_mail_num 넣기
		var arrChk = new Array();
		
		$("input[name='chkBox']:checked").each(function(){
			
			var pk_seq = $(this).attr('id');
			arrChk.push(pk_seq);
		//	console.log("arrChk 확인용 : " + arrChk);
			
		});
		
		if(chkCnt == 0) {
			alert("선택된 메일이 없습니다.");
		}
		else {
			
			$.ajax({				
		 	    url:"<%= ctxPath%>/board/selectDel.bts", 
				type:"GET",
				data: {"pk_seq":JSON.stringify(arrChk),
							   "cnt":chkCnt},
				dataType:"JSON",
				success:function(json){
					
					var result = json.result;
					
					if(result != 1) {
						alert("메일 삭제에 실패했습니다.");
						window.location.reload();
					}
					else {
						alert("메일 삭제에 성공했습니다.");
						window.location.reload();
					}
					
				},
				
				error: function(request, status, error) {
					alert("code:"+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					
				}
				
			});
			
		}
		
	}// end of function goMailDelRecyclebin() {}-----------------------------	
	
	function goView(pk_seq) {
		
		  const gobackURL = "${requestScope.gobackURL}"; 
		  
		  const searchType = $("select#searchType").val();
		  const searchWord = $("input#searchWord").val();
		
		  location.href="<%= ctxPath%>/board/view.bts?pk_seq="+pk_seq+"&gobackURL="+gobackURL+"&searchType="+searchType+"&searchWord="+searchWord; 
		}// end of function goView(seq){}----------------------------------------------
		
	function goView_notice(pk_seq) {
		
		  const gobackURL = "${requestScope.gobackURL}"; 
		  
		  const searchType = $("select#searchType").val();
		  const searchWord = $("input#searchWord").val();
		
		  location.href="<%= ctxPath%>/notice/view.bts?pk_seq="+pk_seq+"&gobackURL="+gobackURL+"&searchType="+searchType+"&searchWord="+searchWord; 
		}// end of function goView(seq){}----------------------------------------------
	
	function goView_fileboard(pk_seq) {
		
		  const gobackURL = "${requestScope.gobackURL}"; 
		  
		  const searchType = $("select#searchType").val();
		  const searchWord = $("input#searchWord").val();
		
		  location.href="<%= ctxPath%>/fileboard/view.bts?pk_seq="+pk_seq+"&gobackURL="+gobackURL+"&searchType="+searchType+"&searchWord="+searchWord; 
		}// end of function goView(seq){}----------------------------------------------
		
		

		
		function goSearch() {
			
			const frm = document.searchFrm;
			  frm.method = "GET";
			  frm.action = "<%= ctxPath%>/board/my.bts";
			  frm.submit();
			
		}// end of function goSearch() {}-----------------------
	
</script>

<div style="padding: 0 15px !important; margin-right: auto !important; margin-left: auto !important;">

	<div class="d-flex align-items-center p-3 my-3 text-white bg-purple rounded shadow-sm" style="background-color: #6F42C1; ">
    <div class="lh-1" style="text-align: center; width: 100%;">
      <h1 class="h6 mb-0 text-white lh-1" style="font-size:22px; font-weight: bold; ">${sessionScope.loginuser.emp_name} 님의 작성글</h1>
    </div>
  </div>
<!-- 			
		<button type="button" id="delTrash" onclick="goselctDel()">
								영구삭제
		</button>
		 -->
		<table class="table table-hover" style="width: 85%; margin-left: auto; margin-right: auto; margin-top: 30px;">
		<thead>
			<tr>
<!-- 			<th style="width: 2%;">
									<input type="checkbox" id="checkAll" />
								</th> -->
				<th scope="col" class="text-center" style="width: 90px;">번호</th>	
				<th scope="col" class="text-center" colspan="4" style="width: 200px;">제목</th>
				<th scope="col" class="text-center" style="width: 120px;">글쓴이</th>
				<th scope="col" class="text-center" style="width: 250px;">작성일</th>
				<th scope="col" class="text-center" style="width: 100px;">조회수</th>
			</tr>
		</thead>
		<tbody>
		
	
		<c:if test="${requestScope.boardList.size() == 0 }">	
			<tr>
				<td colspan="8" style="height: 200px; font-size: 17pt;">작성한 글이 존재하지 않습니다.</td>	
			</tr>
		</c:if>
		
			<c:forEach var="boardvo" items="${requestScope.boardList}" varStatus="status">
			   <tr>
		<%-- 	   <td style="width: 20px;">
					<input type="checkbox" id="${boardvo.pk_seq}" name="chkBox" class="text-center"/>
					<input type="checkbox" id="${boardvo.tblname}" name="chkBox" class="text-center"/>
					
				</td> --%>
			   
			      <td align="center">
			          ${boardvo.pk_seq}
			          
			          
			      </td>
		
				  <td style="width: 25px;">
			         <c:if test="${not empty boardvo.filename}">
			         <img style="width: 12px;" src="<%= ctxPath%>/resources/images/disk.gif" />	
			         </c:if>          
			      </td>
		
				  <td style="width: 25px;">
				  <c:set var="text" value="${boardvo.content}"/>

				  <c:if test="${fn:contains(text, 'img src')}">
						<img src="<%= ctxPath%>/resources/images/board/img.PNG" />
				  </c:if>
				  </td>
		
					<td style="width: 115px;" align="center">
						<span style="font-size: 9pt; color: gray;">[${boardvo.tblname}]</span>
					</td>
		
		
					<td style="text-align: left;">
					
					
					<c:if test="${boardvo.tblname eq '공지사항'}">
						<span class="subject" onclick="goView_notice('${boardvo.pk_seq}')">${boardvo.subject}</span>
					</c:if>
					
					
					<c:if test="${boardvo.tblname eq '자유게시판'}">
						 <c:if test="${boardvo.read_count > 10}">
						      	 <c:if test="${boardvo.comment_count > 0}">
						      	 	<span style="color:red; font-size: 9pt;">HIT&nbsp;&nbsp;</span><span class="subject" onclick="goView('${boardvo.pk_seq}')">${boardvo.subject} <span style="vertical-align: super;"><span style="color: #a6a6a6; font-size: 9pt; font-weight: bold;">[${boardvo.comment_count}]</span></span></span>    
						      	 </c:if>
						      	 
						      	 <c:if test="${boardvo.comment_count == 0}">
						      	 	<span style="color:red; font-size: 9pt;">HIT&nbsp;&nbsp;</span><span class="subject" onclick="goView('${boardvo.pk_seq}')">${boardvo.subject}</span>
						      	 </c:if> 	      	 
				      	 </c:if>
				      	 
				      	 
				      	 <c:if test="${boardvo.read_count <= 10}">
						      	 <c:if test="${boardvo.comment_count > 0}">
						      	 	<span class="subject" onclick="goView('${boardvo.pk_seq}')">${boardvo.subject} <span style="vertical-align: super;"><span style="color: #a6a6a6; font-size: 9pt; font-weight: bold;">[${boardvo.comment_count}]</span></span></span>  
						      	 </c:if>
						      	 
						      	 <c:if test="${boardvo.comment_count == 0}">
						      	 	<span class="subject" onclick="goView('${boardvo.pk_seq}')">${boardvo.subject}</span>
						      	 </c:if> 	      	 
				      	 </c:if>
			      	 </c:if>
			      	 
			      	 
			      <c:if test="${boardvo.tblname eq '자료실'}">
						 <span class="subject" onclick="goView_fileboard('${boardvo.pk_seq}')">${boardvo.subject}</span>
			      	 </c:if>	 
			      	 
			      	 
			      </td> 	 


				  <td align="center">${boardvo.user_name} 
				 	 <c:if test="${boardvo.fk_emp_no != 80000001}">
					 	 <c:if test="${boardvo.tblname ne '공지사항'}">
					 		 ${boardvo.ko_rankname}
					 	 </c:if>
				 	 </c:if>	 
				  </td>
				  
				  <td align="center">${boardvo.write_day}</td>
				  <td align="center">${boardvo.read_count}</td>
			   </tr>
			</c:forEach>
		</tbody>
	</table>

	<%-- === #122. 페이지바 보여주기 === --%>
	<div align="center" style="border: solid 0px gray; width: 70%; margin: 20px auto;">
		${requestScope.pageBar}
	</div>
 
    <%-- === #101. 글검색 폼 추가하기 : 글제목, 글쓴이로 검색을 하도록 한다. === --%>
    <form name="searchFrm" style="margin-top: 20px; text-align: center;">
		<select name="searchType" id="searchType" style="height: 26px;">
			<option value="subject">글제목</option>
			<option value="user_name">글쓴이</option>
		</select>
		<input type="text" name="searchWord" id="searchWord" size="40" autocomplete="off" /> 
		<input type="text" style="display: none;"/> <%-- form 태그내에 input 태그가 오로지 1개 뿐일경우에는 엔터를 했을 경우 검색이 되어지므로 이것을 방지하고자 만든것이다. --%> 
		<button type="button" style="width: 30px; border:none;" onclick="goSearch()">
		<i class="fa fa-search fa-fw" aria-hidden="true"></i>
		</button>
	</form>
	

	
</div>