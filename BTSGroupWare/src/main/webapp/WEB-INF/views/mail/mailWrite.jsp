<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
    
<%
    String ctxPath = request.getContextPath();
    //    /bts
%>

<style type="text/css">

/* 테이블 */
  table, th, td, input, textarea {border: solid #a0a0a0 0px;}
  
  #table {border-collapse: collapse;
          width: 1175px;
          }
         
  #table th, #table td{padding: 5px;}
  #table th{ 
  		background-color: #6F808A; 
  		color: white;
  }

/*버튼 */   
  .buttonList {
  		display: inline-block;
  		list-style-type: none; 	
  		size: 10px;	
  }
 
  #buttonGroup {
  		padding: 0px;
  		margin-top: 5px;
  }
  
    button {
  		border-radius: 3px !important;
  } 
  
  /* 파일첨부 */
  /*input="file" 태그 원래 형태 지우기*/

   
</style>


<script src="<%= request.getContextPath()%>/resources/ckeditor/ckeditor.js"></script> 
<script src="<%= request.getContextPath()%>/resources/plugins/bower_components/jquery/dist/jquery.min.js"></script>

<script type="text/javascript">

$(document).ready(function(){
	// 문서가 준비되면 매개변수로 넣은 콜백함수 실행하기
	
	  <%-- === 스마트 에디터 구현 시작 === --%>
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
	
       // 메일쓰기 버튼 클릭 시 event 발생
       $("button#btnMailSend").click(function() {
	  		 <%-- === 스마트 에디터 구현 시작 === --%>
	       	//id가 content인 textarea에 에디터에서 대입
	        	obj.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
	      	 <%-- === 스마트 에디터 구현 끝 === --%>		
	      	 
	      	 // 받는사람 유효성 검사
	      	 
	      	 
	      	 
	      	 // 메일제목 유효성 검사
	      	 
	      	 
	      	 
	      	 // 메일내용 유효성 검사
	 		<%-- === 스마트에디터 구현 시작 === --%>
	        //스마트에디터 사용시 무의미하게 생기는 p태그 제거
	         var contentval = $("textarea#content").val();
	             
	          // === 확인용 ===
	          // alert(contentval); // content에 내용을 아무것도 입력치 않고 쓰기할 경우 알아보는것.
	          // "<p>&nbsp;</p>" 이라고 나온다.
	          
	          // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기전에 먼저 유효성 검사를 하도록 한다.
	          // 글내용 유효성 검사 
	          if(contentval == "" || contentval == "<p>&nbsp;</p>") {
	             alert("글내용을 입력하세요!!");
	             return;
	          }
	          
	          // 스마트에디터 사용시 무의미하게 생기는 p태그 제거하기
	          contentval = $("textarea#content").val().replace(/<p><br><\/p>/gi, "<br>"); //<p><br></p> -> <br>로 변환
	      	/*    
	                  대상문자열.replace(/찾을 문자열/gi, "변경할 문자열");
	          ==> 여기서 꼭 알아야 될 점은 나누기(/)표시안에 넣는 찾을 문자열의 따옴표는 없어야 한다는 점입니다. 
	                            그리고 뒤의 gi는 다음을 의미합니다.

	             g : 전체 모든 문자열을 변경 global
	             i : 영문 대소문자를 무시, 모두 일치하는 패턴 검색 ignore
	      	*/    
	          contentval = contentval.replace(/<\/p><p>/gi, "<br>"); //</p><p> -> <br>로 변환  
	          contentval = contentval.replace(/(<\/p><br>|<p><br>)/gi, "<br><br>"); //</p><br>, <p><br> -> <br><br>로 변환
	          contentval = contentval.replace(/(<p>|<\/p>)/gi, ""); //<p> 또는 </p> 모두 제거시
	      
	          $("textarea#content").val(contentval);
	       
	          // alert(contentval);
	      	<%-- === 스마트에디터 구현 끝 === --%>	      	 
	      	 
	      	 
	      	 
		});
       
   
   <%--    
	// 직원 주소록 자동 검색 (aJax)
		// 받는 사람 이메일 입력 시 포함된 키워드를 통해 재직중인 사원 목록 검색, 결과 없으면 유효한 이메일의 형식만 들어오도록 한다.
		$("receiverInput").autocomplete({
			source : function(request, response) {
				$.ajax({
						type:"get",
						url : "empList.bts",
						dataType : "json",
						data : {
							searchValue:request.term	// input 에 입력되는 value 값
						},
						success : function(data) {							
							response(
								$.map(data, function(item) {
									
								<%--	return {
										label:item.DEPS_depName + " / " + 
									} 
									
								})	
							);
						}
				})
			}
		});
   --%>

});// end of $(document).ready(function (){})--------------------




</script>

<div class="container" style="width: 100%; margin: 50px;">
	<div class="row bg-title" style="border-bottom: solid 1.5px #e6e6e6;">	
		<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
			<h4 class="page-title" style="color: black;">메일 쓰기</h4>
		</div>
	</div>

	<ul id="buttonGroup">
		<li class="buttonList">
			<button type="button" id="btnMailSend" class="btn btn-secondary btn-sm">
			<i class="fa fa-send-o fa-fw" aria-hidden="true"></i>
			보내기
			</button>
		</li>	
		<li class="buttonList">
			<button type="button" id="send" class="btn btn-secondary btn-sm">
			<i class="fa fa-pencil-square-o fa-fw" aria-hidden="true"></i>
			임시저장
			</button>
		</li>	
		<li class="buttonList">
			<button type="button" id="send" class="btn btn-secondary btn-sm">
			<i class="fa fa-refresh fa-fw" aria-hidden="true"></i>
			새로고침
			</button>
		</li>			
	</ul>

	<%-- 메일쓰기 부분 --%>	
	<form name="mailWriteFrm" enctype="multipart/form-data" class="form-horizontal" style="margin-top: 20px;">
		<table id="mailWriteTable">
			<tr>
				<th width="14%">받는사람</th>
				<td width="86%" data-toggle="tooltip" data-placement="top" title="">
					<input type="text" id="receiverInput" style="width: 90%; margin-left:10px; margin-right: 1%; border-radius: 3px; border: 1px solid gray; " />
					<button type="button" class="btn btn-secondary btn-sm">주소록</button>
				</td>
			</tr>
			<tr>
				<th width="14%">
					<span style="margin-right: 40px;">제목</span>
					<input type="checkbox" checked="checked" />&nbsp;&nbsp;중요!
				</th>
				<td width="110%" >
					<input type="text" style="width: 90%; margin-left:10px; margin-right: 1%; border-radius: 3px; border: 1px solid gray; display: inline-block;" />
				</td>
			</tr>		
			<tr>
				<th width="14%">파일첨부</th>
				<td width="86%" style="padding-top: 9px">
					<input type="file" name="mail_attach" id="mail_file_upload" style="width: 30%; margin-left:10px; margin-right: 1%; border-radius: 3px; border: 0px solid gray;" />
			<!--	<label for="mail_file_upload">		
			 		<i class="fa fa-file-o"></i>&nbsp;파일선택</label>
					<input class="upload-name" disabled="disabled" style="border-radius: 3px;" /> -->
				</td>
			</tr>			
		</table>	
		
		<br>
		
		<%-- 메일 내용 시작 (스마트 에디터 사용) --%>
		<table style="border: 0px; width: 1110px;">
			<tr style="border: 0px;">
				<td width="1200px;" style="border: 0px">
					<textarea rows="20" cols="100" style="width: 1090px; border: solid 1px gray; height: 400px;" name="content" id="content" >					
					</textarea>						
				</td>
			</tr>
		</table>
		
		<%-- 예약시간 설정하기 --%>
		<input type="hidden" name="mail_reservation" />
		
		<%-- 메일 내용 끝 --%>
	</form>
	
	<ul id="buttonGroup" style="margin-top: 10px;">
		<li class="buttonList">
			<button type="button" id="reservation" class="btn btn-secondary"
					data-toggle="modal" data-target="$mailResrvationModal">
			<i class="fa fa-clock-o fa-fw" aria-hidden="true"></i>
			발송예약
			</button>
			<span style="margin-left: 20px;"></span>
		</li>	
	</ul>	
</div>

<%-- 발송예약 모달 --%>






