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

	function formChange(obj){	
			obj.submit(); //obj자체가 form이다.
		}

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
			$("select#ko_depname").val("${paraMap.ko_depname}");
			$("select#searchType").val("${paraMap.searchType}");
			$("input#searchWord").val("${paraMap.searchWord}");
		}
		
	

		
	});//end of $(document).ready(function(){}

	
	function goView(pk_seq) {

			const gobackURL = "${requestScope.gobackURL}"; 
		  
//		  alert(gobackURL);
		  
		  const searchType = $("select#searchType").val();
		  const searchWord = $("input#searchWord").val();
		
		  location.href="<%= ctxPath%>/fileboard/view.bts?pk_seq="+pk_seq+"&gobackURL="+gobackURL+"&ko_depname="+ko_depname+"&searchType="+searchType+"&searchWord="+searchWord; 
		}// end of function goView(seq){}----------------------------------------------
		
		

		
		function goSearch() {
			const frm = document.searchFrm;
			  frm.method = "GET";
			  frm.action = "<%= ctxPath%>/fileboard/list.bts";
			  frm.submit();
			
		}// end of function goSearch() {}-----------------------
	
</script>

<div style="padding: 0 15px !important; margin-right: auto !important; margin-left: auto !important;">

	<div class="d-flex align-items-center p-3 my-3 text-white bg-purple rounded shadow-sm" style="background-color: #E83E8C; ">
    <div class="lh-1" style="text-align: center; width: 100%;">
      <h1 class="h6 mb-0 text-white lh-1" style="font-size:22px; font-weight: bold; ">자료실</h1>
    </div>
  </div>

	<form name="ko_depname" style="float: right; margin-right: 8%; margin-bottom: 10px; margin-top: 10px;">
		<select name="ko_depname" id="ko_depname"  onchange="formChange(this.form)" style="height: 26px;">
				<option value="" selected disabled>ㅡ부서 선택ㅡ</option>	
				<option value="">전체</option>	
				<option value="공통">공통</option>
				<option value="영업">영업</option>				 								
				<option value="마케팅">마케팅</option>				 								
				<option value="기획">기획</option>	
				<option value="총무">총무</option>	
				<option value="인사">인사</option>	
				<option value="회계">회계</option>	
		</select>
	</form>		

		
		<table class="table table-hover" style="width: 85%; margin-left: auto; margin-right: auto;">
		<thead>
			<tr>
				<th scope="col" class="text-center" style="width: 90px;">번호</th>	
				<th scope="col" class="text-center" colspan="4" style="width: 200px;">제목</th>
				<th scope="col" class="text-center" style="width: 120px;">글쓴이</th>
				<th scope="col" class="text-center" style="width: 250px;">작성일</th>
				<th scope="col" class="text-center" style="width: 100px;">조회수</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="fileboardvo" items="${requestScope.fileboardlist}" varStatus="status">
			   <tr>
			      <td align="center">
			          ${fileboardvo.pk_seq}
			      </td>
		
				  <td align="center" style="width: 25px;">
			         <c:if test="${not empty fileboardvo.filename}">
			         <img style="width: 12px;" src="<%= ctxPath%>/resources/images/disk.gif" />	
			         </c:if>          
			      </td>
		
				  <td align="center" style="width: 25px;">
				  <c:set var="text" value="${fileboardvo.content}"/>

				  <c:if test="${fn:contains(text, 'img src')}">
						<img src="<%= ctxPath%>/resources/images/board/img.PNG" />
				  </c:if>
				  </td>
		
					<td align="center" style="font-size: 9pt; color: gray; width: 60px; ">[${fileboardvo.ko_depname}]</td>
		
					<td style="text-align: left;">
						
					<span class="subject" onclick="goView('${fileboardvo.pk_seq}')">${fileboardvo.subject}</span>      	
					  	 
	
				      	 <c:if test="${fileboardvo.depthno > 0}">
					      	 	<span class="subject" onclick="goView('${fileboardvo.pk_seq}')"><span style="color: red; font-style: italic; padding-left: ${fileboardvo.depthno * 20}px;">┗Re&nbsp;</span>${fileboardvo.subject}</span>
					     </c:if> 	 
   	 
			      </td> 	 

				  <td align="center">${fileboardvo.user_name} 
				 	 <c:if test="${fileboardvo.fk_emp_no != 80000001}">
				 	 ${fileboardvo.ko_rankname}
				 	 </c:if>	 
				  </td>
				  <td align="center">${fileboardvo.write_day}</td>
				  <td align="center">${fileboardvo.read_count}</td>
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
	    <select name="ko_depname" id="ko_depname" style="height: 26px;">
					<option value="" selected disabled>부서</option>	
					<option value="">전체</option>
					<option value="공통">공통</option>
					<option value="영업">영업</option>				 								
					<option value="마케팅">마케팅</option>				 								
					<option value="기획">기획</option>	
					<option value="총무">총무</option>	
					<option value="인사">인사</option>	
					<option value="회계">회계</option>	
		</select>
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