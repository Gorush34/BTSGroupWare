<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath();%>

<style type="text/css">
 
#table td{padding: 5px;
margin:0 10 5 0px;}

#table {border-collapse: collapse;
        width: 100%;
        }
          
input#title{
width:60%;
height:30px;
}          
select{
width:11%;
height:30px;

}          
td#boardButton{
text-align: center;
/* border:solid 1px red; */
padding: 20px;
}

button{
border: none;
width: 90px;
height:50px;
border-radius:5px;
}

button#boardWrite{
background-color:#0F4C81;
color:white;
}
button#save{
background-color:#D8D8D8;
}


   /*input file의 기본 모습을 제거*/
   #board_fileupload {
	    width: 0.1px;
		height: 0.1px;
		opacity: 0;
		overflow: hidden;
		position: absolute;
		z-index: -1;   
   }
    /* named upload */ 
   .upload-name { 
   		display: inline-block; 
   		padding: .5em .75em;
   		font-size: inherit; 
   		font-family: inherit; 
   		line-height: normal; 
   		vertical-align: middle; 
   		background-color: #f5f5f5; 
   		border: 1px solid #ebebeb; 
   		border-bottom-color: #e2e2e2; 
   		-webkit-appearance: none; /* 네이티브 외형 감추기 */ 
   		-moz-appearance: none; 
   		appearance: none; 
   		height: 30px;
   		margin-bottom: .30em;
   		width: 250px;
   	}
 
</style>
<script src="<%= request.getContextPath()%>/resources/ckeditor/ckeditor.js"></script> 
<script src="<%= request.getContextPath()%>/resources/plugins/bower_components/jquery/dist/jquery.min.js"></script>  
<script type="text/javascript">
 $(document).ready(function(){
	   
	   <%-- ===스마트 에디터 구현 시작 === --%>
		
	    <%-- === 스마트 에디터 구현 끝 === --%>
	    
	 	// 선택된  파일에서 파일명만 추출
		var fileTarget = $('#board_fileupload'); 
		fileTarget.on('change', function(){ // 값이 변경되면 
		
			//alert("파일 선택 완료");	
			if(window.FileReader){ //window에 읽을 파일이 있다면. 
				var filename = $(this)[0].files[0].name;  // 첫번째 파일명
			} 
			else { // old IE 
				var filename = $(this).val().split('/').pop().split('\\').pop(); // 파일명만 추출 
			} // 추출한 파일명 삽입 
			
			$(this).siblings('.upload-name').val(filename);  
			 //#board_fileupload 아래에 있는 upload-name의 값에 filename을 추출한것을 넣어준다. 
	    });   
	    /////////////////////////////////////////////////////
	    
	    
	    //글쓰기 등록 버튼을 눌렀을때.
	    $("button#boardWrite").click(function(){
	    	
	    //게시판 선택을 하지 않았을때의 유효성 검사.
	    var selectBoard = $("select#header option:selected").val().trim();
	    if(selectBoard==""){
	    	alert("작성할 게시판을 선택해주세요!");
	    	return false;
	    }
	    //글제목 유효성 검사
	    var title = $("input#title").val().trim();
	    if(title==""){
	    	alert("글 제목을 입력해주세요!");
	    	return false;
	    }
	 /*    //글 내용 유효성 검사
	    var boardContent = $("textarea#boardContent").val().trim();
	    if(boardContent==""){
	    	alert("글 내용을 입력해주세요!");
	    	alert(boardContent);
	    	return false;
	    }
	     */
	     //에디터가 있는 유효성 검사.
        if(CKEDITOR.instances.content.getData() == '' 
            || CKEDITOR.instances.content.getData().length == 0) {
         alert("글 내용을 입력해주세요!");
         return false;
      }
	    
	    var frm = document.boardAddFrm;
	    frm.method="POST";
	    frm.action="<%=ctxPath%>/noticeAddEnd.os";
	    frm.submit(); 
	    });//글쓰기 등록버튼 끝---------------------------------------------------------------
	    
 });// $(document).ready(function(){}----------------------------------------------
</script>

<div style="padding-left: 5%;">
	<h2>글쓰기</h2>
		<form name="boardAddFrm" enctype="multipart/form-data">
			<table id="table">
				<thead></thead>
				<tbody>
					<tr>
						<td>게시판</td>
							<td>
								<select id="header" name="header">
									<option value="" selected disabled hidden>==게시판 선택==</option>	
									<option value="알려드립니다">알려드립니다</option>				 								
									<option value="인사이동">인사이동</option>				 								
									<option value="부고">부고</option>				 					 
								</select>
							</td>						
					</tr>
					<tr>
						<td>파일첨부</td>
							<td>
								<div class="file_text_area">
								     <input type="file" name="file" id="board_fileupload" style="width:97%; margin-left:10px;" /> 
             						 <label for='board_fileupload'>
            						 <i class="fa fa-file-o"></i>&nbsp;파일선택</label>
          							 <input class="upload-name" value="선택된 파일이 없습니다." disabled="disabled" />
								</div>
							</td>
					</tr>
					<tr>
						<td>제목</td>
							<td>
								<input type="hidden" name="fk_emp_no" id="fk_emp_no" value="${sessionScope.loginemp.emp_no}" /> 
								<input type="hidden" name="name" id="name" value="${sessionScope.loginemp.emp_name }" />
								
								<input type="text" name="title" id="title" class="title" />    
							</td>
					</tr>
					<tr>
							<td style="margin:0;padding:0;"></td>
							<td id=textarea>
								<textarea style="width: 95%; height: 500px;" rows="10" cols="100" name="content" id="content"></textarea>       
							     <script>CKEDITOR.replace('content');</script>  
							</td>
					</tr>
				     
      			    <tr>
      			    	<td></td>
      			    	
	      			    	<td id="boardButton">
	      			    		<button type="button" id="boardWrite">등록</button>
	      			    		<button type="button" id="save" onclick="javascript:history.back()">취소</button>
	      			    	</td>
      			    </tr>
				 </tbody>
			</table>
			 		
      
		</form>
</div>