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
	  
	  <%-- === #166. 스마트 에디터 구현 시작 === --%>
      //전역변수
      var obj = [];
      
      //스마트에디터 프레임생성
      nhn.husky.EZCreator.createInIFrame({
          oAppRef: obj,
          elPlaceHolder: "content",
          sSkinURI: "<%= ctxPath%>/resources/smarteditor/SmartEditor2Skin.html",
          htParams : {
              // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
              bUseToolbar : true,            
              // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
              bUseVerticalResizer : true,    
              // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
              bUseModeChanger : true,
          }
      });
      <%-- === 스마트 에디터 구현 끝 === --%>
	  
	  // 완료버튼
	  $("button#btnUpdate").click(function(){
		  
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

		  <%--
		  // 글내용 유효성 검사
		  const content = $("textarea#content").val().trim();
		  if(content == "") {
			  alert("글내용을 입력하세요!!");
			  return;
		  }
		  --%>
		  
		  
		  <%-- === 스마트에디터 구현 시작 === --%>
	          var contentval = $("textarea#content").val();
	           if(contentval == "" || contentval == "<p>&nbsp;</p>") {
	              alert("글내용을 입력하세요!!");
	              return;
	           }
	           
	           // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기
	           contentval = $("textarea#content").val().replace(/<p><br><\/p>/gi, "<br>"); 

	           contentval = contentval.replace(/<\/p><p>/gi, "<br>"); 
	           contentval = contentval.replace(/(<\/p><br>|<p><br>)/gi, "<br><br>"); 
	           contentval = contentval.replace(/(<p>|<\/p>)/gi, ""); 
	       
	           $("textarea#content").val(contentval);
	        
	           // alert(contentval);
	       <%-- === 스마트에디터 구현 끝 === --%>
		  
		  // 글암호 유효성 검사
		  const pw = $("input#pw").val();
		  if(pw == "") {
			  alert("글암호를 입력하세요!!");
			  return;
		  }
		  
		  // 폼(form)을 전송(submit)
		  const frm = document.editFrm;
		  frm.method = "POST";
		  frm.action = "<%= ctxPath%>/board/editEnd.bts";
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
<h2 id="add">글수정</h2>
</div>
<form name="editFrm">
	<table style="width: 1024px" class="table table-bordered">
		<tr>
			<th style="width: 15%; background-color: #DDDDDD;">성명</th>
			<td>
				<input type="hidden" name="pk_seq" value="${requestScope.boardvo.pk_seq}" />
				${requestScope.boardvo.user_name}
			</td>
		</tr>
		
		<tr>
			<th style="width: 15%; background-color: #DDDDDD;">제목</th>
			<td>
				<input type="text" name="subject" id="subject" size="100" value="${requestScope.boardvo.subject}" /> 
			</td>
		</tr>
		
		<tr>
			<th style="width: 15%; background-color: #DDDDDD;">내용</th>
			<td>
				<textarea style="width: 100%; height: 612px;" name="content" id="content">${requestScope.boardvo.content}</textarea>
			</td>
		</tr>
		
		<tr>
			<th style="width: 15%; background-color: #DDDDDD;">글암호</th>
			<td>
				<input type="password" name="pw" id="pw" /> 
			</td>
		</tr>
	</table>
	
	<div style="margin: 20px;">
		<button type="button" class="btn btn-secondary btn-sm mr-3" id="btnUpdate">완료</button>
		<button type="button" class="btn btn-secondary btn-sm" onclick="javascript:history.back()">취소</button>
	</div>
	
</form>   
</div>
</div>



