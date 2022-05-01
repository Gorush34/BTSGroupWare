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
  		color: ;
  }

/*버튼 */   
  .buttonList {
  		display: inline-block;
  		list-style-type: none; 		
  }
 
  #buttonGroup {
  		padding: 0px;
  		margin-top: 5px;
  }
  
    button {
  		border-radius: 3px !important;
  } 
  
    ul#mailReceiveDetailGroup, .detailList {
  	 list-style-type: none;
  }

</style>

<script src="<%= request.getContextPath()%>/resources/ckeditor/ckeditor.js"></script> 
<script src="<%= request.getContextPath()%>/resources/plugins/bower_components/jquery/dist/jquery.min.js"></script>

<script type="text/javascript">

$(document).ready(function (){
	// 문서가 준비되면 매개변수로 넣은 콜백함수 실행하기
	
	
});

</script>

<div class="container" style="width: 80%;">
		<div class="row" style="border-bottom: solid 1.5px #e6e6e6;">	
			<div class="col-lg-3 col-md-4 col-sm-4 col-xs-12" style="padding: 0px;">
				<h4 class="page-title" style="color: black;">받은 메일함</h4>
			</div>	
			<div id="goList">
				<button type="button" id="btnGoList" onclick="javascript:location.href='${goBackURL}'" style="margin-left: 940px; margin-bottom:10px ">
				<i class="fa fa-reorder"></i>
				목록
				</button>
			</div>	
		</div>	
	
	<div class="mailDetailWrap" style="width: 80%;">
		<div class="" style="margin-left: -50px">
			<ul class="mailReceiveDetailGroup">
				<li id="title" class="detailList">
					<h5 style="font-weight: bold; padding:10px 0 20px 0">제목 : 그룹웨어 메일내용 보기 테스트입니다.</h5>
				</li>
				<li id="sender" class="detailList">
					<span>보낸 사람 : </span>
					<span>임유리 < limyl@bts.com > </span>
				</li>
				<li id="receiver" class="detailList">
					<span>받는 사람 : </span>
					<span>김민정 < kimmj@bts.com > </span>
				</li>
				<li id="sendDate" class="detailList">
					<span>보낸 날짜 :</span>
					<span>2022-05-01 23:25</span>
				</li>	
				<li id="attachFile" class="detailList">
					<span>첨부 파일 : </span>
					<span>조직도.jpg</span>
				</li>													
			</ul>
		</div>
		<br>
		<div style=>
			<div style="width: 1000px; margin-left: -10px; margin-top: 20px; border-top: solid 1.5px #e6e6e6;">
				반갑습니다람쥐
			</div>
		</div>	
	</div>
</div>

<%-- 이전글, 다음글 영역 --%>


