<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<% String ctxPath = request.getContextPath(); %>

<style>

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
		
		<%-- === #107. 검색어 입력시 자동글 완성하기 2 === --%>
		  $("div#displayList").hide();
		  
		  $("input#searchWord").keyup(function(){
			  
			  const wordLength = $(this).val().trim().length;
			  // 검색어의 길이를 알아온다.
			  
			  if(wordLength == 0) {
				  $("div#displayList").hide();
				  // 검색어가 공백이거나 검색어 입력후 백스페이스키를 눌러서 검색어를 모두 지우면 검색된 내용이 안 나오도록 해야 한다. 
			  }
			  else {
				  $.ajax({
					  url:"<%= ctxPath%>/wordSearchShow.bts",
					  type:"GET",
					  data:{"searchType":$("select#searchType").val()
						   ,"searchWord":$("input#searchWord").val()},
					  dataType:"JSON",
					  success:function(json){
						 // json ==> [{"word":"Korea VS Japan 라이벌 축구대결"},{"word":"JSP 가 뭔가요?"},{"word":"프로그램은 JAVA 가 쉬운가요?"},{"word":"java가 재미 있나요?"}]  
						 
						 <%-- === #112. 검색어 입력시 자동글 완성하기 7 === --%>
						 if(json.length > 0) {
							 // 검색된 데이터가 있는 경우임
							 
							 let html = "";
							 
							 $.each(json, function(index, item){
								 const word = item.word;
								 // word ==> 프로그램은 JAVA 가 쉬운가요? 
								 
								 const idx = word.toLowerCase().indexOf($("input#searchWord").val().toLowerCase());	 
								 //          word ==> 프로그램은 java 가 쉬운가요?	
								 // 검색어(JaVa)가 나오는 idx 는 6 이 된다.
								 
								 const len = $("input#searchWord").val().length;
								 // 검색어(JaVa)의 길이 len 은 4 가 된다.
								 
								/* 
								 console.log("~~~~~~~~ 시작 ~~~~~~~~~~~~");
								 console.log(word.substring(0, idx));       // 검색어(JaVa) 앞까지의 글자 => "프로그램은 "
								 console.log(word.substring(idx, idx+len)); // 검색어(JaVa) 글자 => "JAVA"
								 console.log(word.substring(idx+len));      // 검색어(JaVa) 뒤부터 끝까지 글자 => " 가 쉬운가요?"
								 console.log("~~~~~~~~ 끝 ~~~~~~~~~~~~");		 
								*/ 
								 
								 const result = word.substring(0, idx) + "<span style='color:blue;'>"+word.substring(idx, idx+len)+"</span>" + word.substring(idx+len); 
								
								 html += "<span style='cursor:pointer;' class='result'>"+result+"</span><br>";
							 });
							 
							 const input_width = $("input#searchWord").css("width"); // 검색어 input 태그 width 알아오기
							 
							 $("div#displayList").css({"width":input_width}); // 검색결과 div 의 width 크기를 검색어 입력 input 태그 width 와 일치시키기  
							 
							 $("div#displayList").html(html);
							 $("div#displayList").show();
						 }
					  },
					  error: function(request, status, error){
							alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					  }
				  });
			  }
			  
		  }); // end of $("input#searchWord").keyup -----------------------
		  
		  <%-- == #113. 검색어 입력시 자동글 완성하기 8 === --%>
		  $(document).on("click", "span.result", function(){
			  const word = $(this).text();
			  $("input#searchWord").val(word); // 텍스트박스에 검색된 결과의 문자열을 입력해준다.
			  $("div#displayList").hide();
			  goSearch();
		  });
		
	});//end of $(document).ready(function(){}

	
	function goView(pk_seq) {

			const gobackURL = "${requestScope.gobackURL}"; 
		  
//		  alert(gobackURL);
		  
		  const searchType = $("select#searchType").val();
		  const searchWord = $("input#searchWord").val();
		
		  location.href="<%= ctxPath%>/board/view.bts?pk_seq="+pk_seq+"&gobackURL="+gobackURL+"&searchType="+searchType+"&searchWord="+searchWord; 
		}// end of function goView(seq){}----------------------------------------------
		
		
		function goSearch() {
			
			const frm = document.searchFrm;
			  frm.method = "GET";
			  frm.action = "<%= ctxPath%>/board/list.bts";
			  frm.submit();
			
		}// end of function goSearch() {}-----------------------
	
</script>

<div style="padding: 0 15px !important; margin-right: auto !important; margin-left: auto !important;">
	
	<div class="d-flex align-items-center p-3 my-3 text-white bg-purple rounded shadow-sm" style="background-color: #6F42C1; ">
    <div class="lh-1" style="text-align: center; width: 100%;">
      <h1 class="h6 mb-0 text-white lh-1" style="font-size:22px; font-weight: bold; ">자유게시판</h1>
    </div>
  </div>

	<div style="text-align: center;">
		<a id="brd_category" href="<%= request.getContextPath()%>/notice/list.bts">공지사항</a> 
		<a id="brd_category" href="<%= request.getContextPath()%>/fileboard/list.bts">자료실</a> 
		<a id="brd_category" href="<%= request.getContextPath()%>/board/list.bts" style="font-weight: bold; text-decoration: underline;">자유게시판</a> 
		<br></br>
	</div>
		<span id = "write" onclick="javascript:location.href='<%= request.getContextPath()%>/board/write.bts'">게시물작성
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
			<c:forEach var="boardvo" items="${requestScope.boardList}" varStatus="status">
			   <tr>
			      <td align="center">
			          ${boardvo.pk_seq}
			      </td>
		
					<td>
				      	 <c:if test="${boardvo.comment_count ne 10}">
				      	 	<span class="subject" onclick="goView('${boardvo.pk_seq}')">${boardvo.subject} <span style="vertical-align: super;"></span></span>  
				      	 </c:if>
				     </td> 	 


				  <td align="center">${boardvo.user_name}</td>
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
			<option value="name">글쓴이</option>
		</select>
		<input type="text" name="searchWord" id="searchWord" size="40" autocomplete="off" /> 
		<input type="text" style="display: none;"/> <%-- form 태그내에 input 태그가 오로지 1개 뿐일경우에는 엔터를 했을 경우 검색이 되어지므로 이것을 방지하고자 만든것이다. --%> 
		<button type="button" style="width: 30px" onclick="goSearch()">
		<i class="fa fa-search fa-fw" aria-hidden="true"></i>
		</button>
	</form>
	

	
</div>