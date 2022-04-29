<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
    
<%
    String ctxPath = request.getContextPath();
    //    /bts
%>

<style type="text/css">

<%-- 테이블 --%>
   table, th, td, input, textarea {border: solid #a0a0a0 1px;}
   
   #table {border-collapse: collapse;
          width: 1175px;
          }
   #table th, #table td{padding: 5px;}
   #table th{ 
   		background-color: #6F808A; 
   		color: white;
   }

<%-- 버튼 --%>   
   .buttonList {
   		display: inline-block;
   		list-style-type: none;
   		margin-right: 15px;
   }
  
   #buttonGroup {
   		padding: 0px;
   		margin-top: 5px;
   }
   
     button {
   		border-radius: 3px !important;
   } 
   
<%-- 파일첨부 --%>
   /*input="file" 태그 원래 형태 지우기*/
   #mail_file_upload {
	    width: 0.1px;
		height: 0.1px;
		opacity: 0;
		overflow: hidden;
		position: absolute;
		z-index: -1;   
   }
   
   #mail_file_upload + label {
	    border: 1px solid gray; /*1px solid #d9e1e8;*/
	    background-color: #fff;
	    color: black; /*#2b90d9;*/
	    padding: 6px 12px 0px 12px;
	    font-weight: 400;
	    font-size: 14px;
	    box-shadow: 1px 2px 3px 0px #f2f2f2;
	    outline: none;
	    margin-left: 10px;
	    margin-bottom: 0px;
	    height: 30px;
   }
 
   #mail_file_upload:focus + label,
   #mail_file_upload + label:hover {
    	cursor: pointer;
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
   		-webkit-appearance: none; /*요소 자체구성요소 숨기기*/ 
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


</script>

<%-- 사이드바 부분 시작 --%>
<div class="sidebar">
  <a class="active" href="#home">홈</a>
  <a href="#writeMail">메일쓰기</a>
  <a href="#receiveMail">받은메일함</a>
  <a href="#importantMail">중요메일함</a>
  <a href="#temporaryMail">임시보관함</a>
  <a href="#reserveMail">예약메일함</a>
  <a href="#recyclebinMail">휴지통</a>  
</div>
<%-- 사이드바 부분 끝 --%>

<div class="content">
	<div class="row bg-title" style="border-bottom: solid .025em gray;">	
		<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12">
			<h4 class="page-title" style="color: black;">메일 쓰기</h4>
		</div>
	</div>

	<ul id="buttonGroup">
		<li class="buttonList">
			<button type="button" id="send" class="btn btn-secondary">
			<i class="fa fa-send-o fa-fw" aria-hidden="true"></i>
			보내기
			</button>
		</li>	
		<li class="buttonList">
			<button type="button" id="send" class="btn btn-secondary">
			<i class="fa fa-pencil-square-o fa-fw" aria-hidden="true"></i>
			임시저장
			</button>
		</li>	
		<li class="buttonList">
			<button type="button" id="send" class="btn btn-secondary">
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
				<td width="86%" data-toggle="tooltip" data-placement="top" title="주소록을 이용해주세요.">
					<input type="text" style="width: 89%; margin-left:10px; margin-right: 1%; border-radius: 3px; border: 1px solid gray; " />
					<button type="button" class="btn btn-secondary" style="border: 0px;" data-toggle="modal" data-target="" >주소록</button>					
				</td>
			</tr>
			<tr>
				<th width="14%">
					<span style="margin-right: 60px;">제목</span>
					<input type="checkbox" checked="checked" />&nbsp;&nbsp;중요!
				</th>
				<td width="86%">
					<input type="text" style="width: 89%; margin-left:10px; margin-right: 1%; border-radius: 3px; border: 1px solid gray;" />
				</td>
			</tr>		
			<tr>
				<th width="14%">파일첨부</th>
				<td width="86%" style="padding-top: 9px">
					<input type="file" name="mail_attach" id="mail_file_upload" style="width: 89%; margin-left:10px; margin-right: 1%; border-radius: 3px; border: 1px solid gray;" />
					<label for="mail_file_upload">		
					<i class="fa fa-file-o"></i>&nbsp;파일선택</label>
					<input class="upload-name" disabled="disabled" style="border-radius: 3px;" />
				</td>
			</tr>			
		</table>	
		
		<br>
		
		<%-- 메일 내용 시작 (스마트 에디터 사용) --%>
		<table style="border: 0px; width: 800px;">
			<tr style="border: 0px;">
				<td width="1200px;" style="border: 0px">
					<textarea rows="20" cols="100" style="width: 1150px; height: 400px;" name="mail_content">					
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

<%-- 주소록 모달 --%>




<%-- 발송예약 모달 --%>

</div>