<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<%
	String ctxPath = request.getContextPath();
%>   

<style type="text/css">

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
	  
	  <%-- === #166. 스마트 에디터 구현 시작 === --%>
      //전역변수
      var obj = [];
      
      //스마트에디터 프레임생성
      nhn.husky.EZCreator.createInIFrame({
          oAppRef: obj,
          elPlaceHolder: "content",
          sSkinURI: "<%= ctxPath%>/resources/smarteditor/SmartEditor2Skin.html",
          htParams : {
              bUseToolbar : true,            
              bUseVerticalResizer : true,    
              bUseModeChanger : true,
          }
      });
      <%-- === 스마트 에디터 구현 끝 === --%>
	  
	  // 글쓰기버튼
	  $("button#btnWrite").click(function(){
		  
		  <%-- === 스마트 에디터 구현 시작 === --%>
          //id가 content인 textarea에 에디터에서 대입
           obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
         <%-- === 스마트 에디터 구현 끝 === --%>
		  
		  // 글제목 유효성 검사
		  const subject = $("input#subject").val().trim();
		  if(subject == "") {
			  alert("글제목을 입력하세요!!");
			  return;
		  }
		  
		  
		  <%-- === 스마트에디터 구현 시작 === --%>
	          var contentval = $("textarea#content").val();

	           if(contentval == "" || contentval == "<p>&nbsp;</p>") {
	              alert("글내용을 입력하세요!!");
	              return;
	           }
	           
	           // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기
	           contentval = $("textarea#content").val().replace(/<p><br><\/p>/gi, "<br>"); //<p><br></p> -> <br>로 변환

	           contentval = contentval.replace(/<\/p><p>/gi, "<br>"); //</p><p> -> <br>로 변환  
	           contentval = contentval.replace(/(<\/p><br>|<p><br>)/gi, "<br><br>"); //</p><br>, <p><br> -> <br><br>로 변환
	           contentval = contentval.replace(/(<p>|<\/p>)/gi, ""); //<p> 또는 </p> 모두 제거시
	       
	           $("textarea#content").val(contentval);
	        
	       <%-- === 스마트에디터 구현 끝 === --%>
		  
		  // 글암호 유효성 검사
		  const pw = $("input#pw").val();
		  if(pw == "") {
			  alert("글암호를 입력하세요!!");
			  return;
		  }
		  const gobackURL = "${requestScope.gobackURL}"; 
		  // 폼(form)을 전송(submit)
		  const frm = document.addFrm;
		  frm.method = "POST";
		  frm.action = "<%= ctxPath%>/board/tmp_end.bts";
		  frm.submit();
	  });
	  
	  // 임시저장 버튼
	  $("button#btnSave").click(function(){
		  
		  // 글제목 유효성 검사
		  const subject = $("input#subject").val().trim();
		  if(subject == "") {
			  alert("글제목을 입력하세요!!");
			  return;
		  }
		  
		  <%-- === 스마트 에디터 구현 시작 === --%>
          //id가 content인 textarea에 에디터에서 대입
           obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
         <%-- === 스마트 에디터 구현 끝 === --%>
		  
		  
		  <%-- === 스마트에디터 구현 시작 === --%>
	         //스마트에디터 사용시 무의미하게 생기는 p태그 제거
	          var contentval = $("textarea#content").val();
	              
	           if(contentval == "" || contentval == "<p>&nbsp;</p>") {
	              alert("글내용을 입력하세요!!");
	              return;
	           }
	           
	           // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기
	           contentval = $("textarea#content").val().replace(/<p><br><\/p>/gi, "<br>"); //<p><br></p> -> <br>로 변환

	           contentval = contentval.replace(/<\/p><p>/gi, "<br>"); //</p><p> -> <br>로 변환  
	           contentval = contentval.replace(/(<\/p><br>|<p><br>)/gi, "<br><br>"); //</p><br>, <p><br> -> <br><br>로 변환
	           contentval = contentval.replace(/(<p>|<\/p>)/gi, ""); //<p> 또는 </p> 모두 제거시
	       
	           $("textarea#content").val(contentval);
	        
	           // alert(contentval);
	       <%-- === 스마트에디터 구현 끝 === --%>
		  
	       const gobackURL = "${requestScope.gobackURL}"; 
		  // 폼(form)을 전송(submit)
		  const frm = document.addFrm;
		  frm.method = "POST";
		  frm.action = "<%= ctxPath%>/board/write_save.bts";
		  frm.submit();
	  });
	  
  });// end of $(document).ready(function(){})-------------------------------

  
  
  
</script>

<div style="display: flex;">
<div style="margin: auto; padding-left: 3%; min-height: 1200px;
    position: relative;
    padding-top: 40px;
    background-color: #F2F2F2;
    float: right;
    padding: 20px;">
<div style="border-bottom: solid 3px #000060;
    margin-bottom: 20px;">
<%--
	<h2 style="margin-bottom: 30px;">글쓰기</h2>
 --%>
		<h2 id="add" style="margin-bottom: 30px;">글쓰기</h2>
</div>		
<%-- 	
	<form action="<%= ctxPath%>/board/temp_list.bts" method="post" style="text-align: right;">
			<input type="hidden" name="fk_emp_no" value="${sessionScope.loginuser.pk_emp_no}" />
			<input style="color: gray; border:none; background-color: white;" type="submit" value="임시저장 글" />
		</form>
	
	 --%>
<form name="addFrm" enctype="multipart/form-data">
	<table style="width: 1024px" class="table table-bordered">
		<tr>
			<th style="width: 15%; background-color: #DDDDDD;">성명</th>
			<td>
				<input type="hidden" name="pk_seq" value="${boardvo.pk_seq}" />
				<input type="hidden" name="fk_emp_no" value="${sessionScope.loginuser.pk_emp_no}" />
				<input type="text" name="user_name" value="${sessionScope.loginuser.emp_name}" readonly />
			</td>
		</tr>
		
		<tr>
			<th style="width: 15%; background-color: #DDDDDD;">제목</th>
			<td>
			 <%-- == 원글쓰기 인 경우 == --%>
				<input type="text" name="subject" id="subject" size="100"  value="${boardvo.subject}"/> 
				
			</td>
		</tr>
		
		<tr>
			<th style="width: 15%; background-color: #DDDDDD;">내용</th>
			<td>
				<textarea style="width: 100%; height: 612px;" name="content" id="content">${boardvo.content}</textarea>
			</td>
		</tr>
		
		<%-- === #149. 파일첨부 타입 추가하기 ===  --%>
		<tr>
			<th style="width: 15%; background-color: #DDDDDD;">파일첨부</th>
			<td>
				<input type="file" name="attach" /> 
			</td>
		</tr>
		
		
		<tr>
			<th style="width: 15%; background-color: #DDDDDD;">글암호</th>
			<td>
				<input type="password" name="pw" id="pw" /> 
			</td>
		</tr>
	</table>
	
	<%-- == #143. 답변글쓰기가 추가된 경우 시작=== --%>
	<input type="hidden" name="fk_seq" value="${requestScope.fk_seq}" />
	<input type="hidden" name="groupno" value="${requestScope.groupno}" />
	<input type="hidden" name="depthno" value="${requestScope.depthno}" />
	<%-- === 답변글쓰기가 추가된 끝 === --%>
	
	
	<div style="margin: 20px;">
		<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnWrite">글쓰기</button>
		<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnSave">임시저장</button>
		<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">취소</button>
	</div>
	
	
</form>   
</div>
</div>


