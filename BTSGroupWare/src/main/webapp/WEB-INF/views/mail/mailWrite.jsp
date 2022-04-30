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

  
  #mail_file_upload + label {
    border: 0px solid gray; /*0px solid #d9e1e8;*/
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
  	
/* 주소록  */
   	.content_layout_address {
   		width: 980px;
   		background-color:#fff;
   
   }
   
   .nav_layer{
   		width:100%;
   		height: 25px;
   		display: block;
   		float: left;
   }
   
   .tab_nav li {
	    float: left;
	    margin: 0 0 -1px 24px;
	    padding: 0;
	    cursor: pointer;
	    height: 40px;
	    line-height: 40px;
	    font-size: 13px;
	    color: #999;   
	    
   		list-style-type: none;		
   }
   
   .tab_nav li:first-child {
   		margin: 0;
   }
   
   .ul_state_active {
   
   	    border-bottom: 1px solid #000;
   } 
   
   .tab_wrap {
   		width: 550px;
   		display: inline-block;
   }
	.tree, .tree ul {
	    margin:0;
	    padding:0;
	    list-style:none
	}
	.tree ul {
	    margin-left:1em;
	    position:relative
	}
	.tree ul ul {
	    margin-left:.5em
	}
	.tree ul:before {
	    content:"";
	    display:block;
	    width:0;
	    position:absolute;
	    top:0;
	    bottom:0;
	    left:0;
	    border-left:1px solid
	}
	.tree li {
	    margin:0;
	    padding:0 1em;
	    line-height:2em;
	    color:#369;
	    font-weight:700;
	    position:relative
	}
	.tree ul li:before {
	    content:"";
	    display:block;
	    width:10px;
	    height:0;
	    border-top:1px solid;
	    margin-top:-1px;
	    position:absolute;
	    top:1em;
	    left:0
	}
	.tree ul li:last-child:before {
	    background:#fff;
	    height:auto;
	    top:1em;
	    bottom:0
	}
	.indicator {
	    margin-right:5px;
	}
	.tree li a {
	    text-decoration: none;
	    color:#369;
	}
	.tree li button, .tree li button:active, .tree li button:focus {
	    text-decoration: none;
	    color:#369;
	    border:none;
	    background:transparent;
	    margin:0px 0px 0px 0px;
	    padding:0px 0px 0px 0px;
	    outline: 0;
	}   
   .father {
   		display: flex;
   }
   .search {
   		width: 338px;
   		border-radius: 3px;
   		border: 2px solid #adb5bd;
   }
   .emp_search {
   		margin-bottom: 0; 
   }
   .search, .btnSearch {
   		height: 32px;   
   } 
   span.btn_bg {
        position: relative;
	    cursor: pointer;
	    padding: 4px 4px 6px;
	    background-color: #fff;
	    border: 1px solid #ddd;
	    text-align: left;
	    margin-bottom: 10px;
   }
   .addArea {
   		margin-top: 147px;
   }
   .addList, li {
   		list-style-type: none;
   }
   div.receive_wrap div.receive_list ul {
	    border: 1px solid #666;
	    height: 105px;
	    overflow-x: hidden;
	    background: #f9f9f9;
	    padding: 0 4px;
   } 
   div.receive_wrap div.receive_list {
	    display: inline-block;
	    margin: 10px 0 0 0;
	    width: 270px;
	    height: 135px;
   }
/* 주소록 CSS 끝 */  	
   
</style>


<script src="<%= request.getContextPath()%>/resources/ckeditor/ckeditor.js"></script> 
<script src="<%= request.getContextPath()%>/resources/plugins/bower_components/jquery/dist/jquery.min.js"></script>

<script type="text/javascript">


</script>

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
					<button type="button" class="btn btn-secondary" style="border: 0px;" data-toggle="modal" data-target="#searchEmpListModal" >주소록</button>					
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
					<input type="file" name="mail_attach" id="mail_file_upload" style="width: 30%; margin-left:10px; margin-right: 1%; border-radius: 3px; border: 0px solid gray;" />
			<!--	<label for="mail_file_upload">		
			 		<i class="fa fa-file-o"></i>&nbsp;파일선택</label>
					<input class="upload-name" disabled="disabled" style="border-radius: 3px;" /> -->
				</td>
			</tr>			
		</table>	
		
		<br>
		
		<%-- 메일 내용 시작 (스마트 에디터 사용) --%>
		<table style="border: 0px; width: 800px;">
			<tr style="border: 0px;">
				<td width="1200px;" style="border: 0px">
					<textarea rows="20" cols="100" style="width: 1098px; border: solid 1px gray; height: 400px;" name="mail_content" >					
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
<%-- Modal --%>
<div id="searchEmpListModal" class="modal fade" role="dialog" data-keyboard="false" data-backdrop="static">
	<div class="modal-dialog" style="width: 1070px;">
	
		<%-- Modal content --%>
		<div class="modal-content">		
			<div class="modal-header" style="height: 60px;">
				<button class="close" data-dismiss="modal" onclick="window.closeModal()"><span style="font-size: 26pt;">&times;</span></button>
				<h3 class="modal-title" style="font-weight: bold">주소록</h3>
			</div>				

			<div class="modal-body">
			<div id="employeeList" style="border: none; width: 100%; height: 470px; ">
				<%-- 조직도(EmpList.jsp) --%>
				<div id="content_address_layout" style="overflow-x:hidden;">
				
					<div class="content">
					
						<div class="content_address_layout" style="margin-left: 60px;">
							<div id="tabArea" style="margin-left: -40px;">
								<ul class="tab_nav nav_layer" style="margin-bottom: 22px;"></ul>
							</div>
							
							<%-- 조직도 시작 --%>
							<div class="tabWrap empListFirst" style="margin-left: -1px; height: 400px;">
								<div class="empListFirst" style="border: solid 1px #999; overflow-y:auto; ">
									<div class="container" style="padding-top: 10px; width:200px; border-right: solid 1px #999;  ">
										<div class="row box" style="width: 200px;">
											<div class="col-md-4">
												<ul id="tree1">
													<li style="width: 130px;">
														<a href="#">BTS그룹</a>
														
														<ul>  
															<li class="orgName"style="width: 120px;" value="1">전략기획팀</li>
															<li class="orgName" value="2">경영지원팀</li>
															<li class="orgName" value="3">인사팀</li>
															<li class="orgName" value="4">회계팀</li>
															<li class="orgName" value="5">영업팀</li>
															<li class="orgName" value="6">마케팅팀</li>
															<li class="orgName" value="7">IT팀</li>
														</ul>
													</li>
												</ul>
											</div>
										</div>
									</div>
								</div>							
							</div>
							<%-- 조직도 끝 --%>
							
							<%-- 사원리스트 시작 --%>
							<div class="content_list box">
								<div class="search_wrap">
									<form class="employee_search">
										<input id="searchWord" class="search" type="text" placeholder="이름">
										<button type="button" id="btnEmpSearch" class="btn btn-secondary" style="border: solid 1px gray; border-radius: 3px;">검색</button>
									</form>
								</div>
								<div class="scroll_wrap" style="height: 360px;">
									<table style="width: 396px; height: 366px; border: 0px; overflow-y:auto;">
										<thead>
											<tr style="text-align: left;">
												<th>
													<input type="checkbox" name="checkAll" id="checkAll">
												</th>
												<th style="padding-left: 2px;">이름</th>
												<th>직위</th>
												<th>부서</th>
												<th>사원이메일</th>
											</tr>
										</thead>
										
										<tbody style="height: 300px;">
											<tr>
												<td>
													<input type="checkbox" name="chkbox">
												</td>
												<td>김민정</td>
												<td>사원</td>
												<td>IT팀</td>
												<td>kimmj@bts.com</td>
											</tr>
										</tbody>
										
									</table>
								</div>
							</div>
							
							<%-- 사원리스트 끝 --%>
							
						</div>

					</div>

				</div>

			</div>

			<div class="modal-footer">
			</div>
			</div>
		</div>	
	</div>	
</div>



<%-- 발송예약 모달 --%>






