<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
    
<%
    String ctxPath = request.getContextPath();
    //    /bts
%>

<style type="text/css">

	span.subject
	{cursor: pointer;}
	
	a { text-decoration: none !important}
		
	#btnRecChk {
	border: 1px solid black; background-color: rgba(0,0,0,0); color: black; margin-left: 1px;
	}
	
	#absolute {
    position: absolute;
    top: 80px;
    right: 200px;
    height: 100px;
	}
	
	#btnSearch {
    position: absolute;
    top: 80px;	
    right: 150px;	
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		// 검색타입 및 검색어 유지시키기
		if(${searchWord != null}) {
			// 넘어온 paraMap 이 null 이 아닐 때 (값이 존재할 때)
			$("select#searchType").val("${searchType}");
			$("input#searchWord").val("${searchWord}");
		}
		
		if(${searchWord != null}) {
			$("select#searchType").val("subject");
			$("input#searchWord").val("");
		}
		
		// 체크박스 전체선택 및 해제
		$("input#checkAll").click(function() {
			if($(this).prop("checked")) {
				$("input[name='chkBox']").prop("checked",true);
			}
			else {
				$("input[name='chkBox']").prop("checked",false);
			}
			
		});
		
		<%-- === #107. 검색어 입력 시 자동글 완성하기 2 === --%>
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
					url:"<%= ctxPath%>/mail/wordSearchShow.bts",
					type:"GET",
					data:{"searchType":$("select#searchType").val()
						 ,"searchWord":$("input#searchWord").val()},
					dataType:"JSON",
					success:function(json){
						// json => [{"word":"Korea VS Japan 라이벌 축구대결"},{"word":"JSP 가 뭔가요?"},{"word":"프로그램은 JAVA 가 쉬운가요?"},{"word":"java가 재미 있나요?"},{"word":"MJ 글쓰기 첫번째 연습"}]
						
						<%-- #112. 검색어 입력시 자동글 완성하기 7 --%>
						if(json.length > 0) {
							// 검색된 데이터가 있는 경우임
							let html = "";
							
							$.each(json, function(index, item){
								const word = item.word;
								// word ==> 프로그램은 JAVA 가 쉬운가요?
								
								const idx = word.toLowerCase().indexOf($("input#searchWord").val().toLowerCase());
								// 			word ==> 프로그램은 java 가 쉬운가요?
								// 검색어(JaVa)가 나오는 idx 는 6이 된다. (대문자로 입력했을 때 소문자로 변환됨.)
								
								const len = $("input#searchWord").val().length;
								// 검색어(JaVa)의 길이 len 은 4가 된다.
								
								/*
								console.log("~~~~~~~~~~~~ 시작 ~~~~~~~~~~~~")
								console.log(word.substring(0, idx));	// 검색어(JaVa) 앞까지의 글자 => "프로그램은 "
								console.log(word.substring(idx, idx+len));	// 검색어(JaVa) 글자 => "JAVA"
								console.log(word.substring(idx+len));	// 검색어(JaVa) 뒤부터 끝까지의 글자 => "" 가 쉬운가요?
								console.log("~~~~~~~~~~~~ 끝 ~~~~~~~~~~~~")
								*/
								
								const result = word.substring(0, idx) + "<span style='color:black; font-weight:bold; display:inline-block;'>"+word.substring(idx, idx+len)+"</span>" + word.substring(idx+len)
								
								html += "<span style='cursor:pointer; font-size:14px;' class='result'>"+result+"</span><br>";
							});
							
							const input_width = $("input#searchWord").css("width") // 검색어 input 태그 width 알아오기
							
							$("div#displayList").css({"width":input_width});	// 검색결과 div 의 width 크기를 검색어 입력 input 태그 width 와 일치시키기
							
							$("div#displayList").html(html);	<%-- 자동검색어 기능을 displayList 에 보이도록 한다. --%>
							$("div#displayList").show();

						}
					},
					error: function(request, status, error){
		                  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
		            }
				});
			}
			
		});// end of $("input#searchWord").keyup(function(){}---------------------------
		
				
		<%-- #113. 검색어 입력시 자동글 완성하기 8 --%>
		$(document).on("click", "span.result", function(){
			const word = $(this).text();
			$("input#searchWord").val(word);	// 텍스트 박스에 검색된 결과의 문자열을 입력해준다.
			$("div#displayList").hide();
			gomailSearch();							// 자동글완성 기능 후 검색 함수를 호출한다.
		});
		
	}); // end of $(document).ready(function(){})----------------------------------

	
// function declaration 

	// 검색 버튼 클릭시 동작하는 함수
	function gomailSearch() {
		const frm = document.goSendListSelectFrm;
		frm.method = "GET";
		frm.action = "<%= ctxPath%>/mail/mailSendList.bts";
		frm.submit();	
	}// end of function goMailSearch(){}-------------------------

	// 글제목 클릭 시 글내용 보여주기 (고유한 글번호인 pk_mail_num 를 넘겨준다.)
	function goSendMailView(pk_mail_num) {
		const searchType = $("select#searchType").val();
		const searchWord = $("input#searchWord").val();
		
		location.href = "<%= ctxPath%>/mail/mailSendDetail.bts?pk_mail_num="+pk_mail_num+"&searchType="+searchType+"&searchWord="+searchWord;
<%-- 	<a href="<%= ctxPath%>/mail/mailSendDetail.bts?searchType=${}&searchWord=${}&pk_mail_num=${}">${mailvo.subject}</a> --%>
	}
	

	// 삭제버튼 클릭 시 휴지통으로 이동하기 (ajax)
	function goMailDelRecyclebin() {
		
		// 체크된 갯수 세기
		var chkCnt = $("input[name='chkBox']:checked").length;
		
		// 배열에 체크된 행의 pk_mail_num 넣기
		var arrChk = new Array();
		
		$("input[name='chkBox']:checked").each(function(){
			
			var pk_mail_num = $(this).attr('id');
			arrChk.push(pk_mail_num);
		//	console.log("arrChk 확인용 : " + arrChk);
			
		});
		
		if(chkCnt == 0) {
			alert("선택된 메일이 없습니다.");
		}
		else {
			
			$.ajax({				
		 	    url:"<%= ctxPath%>/mail/MailMoveToRecyclebin.bts", 
				type:"GET",
				data: {"pk_mail_num":JSON.stringify(arrChk),
							   "cnt":chkCnt,
							   "fk_senduser_num":${fk_senduser_num} },
				dataType:"JSON",
				success:function(json){
					
					var result = json.result;
					
					if(result != 1) {
						alert("메일함에서 삭제에 실패했습니다.");
						window.location.reload();
					}
					else {
						alert("메일을 휴지통으로 이동했습니다.");
						window.location.reload();
					}
					
				},
				
				error: function(request, status, error) {
					alert("code:"+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					
				}
				
			});
			
		}
		
	}// end of function goMailDelRecyclebin() {}-----------------------------
	

	// 메일함 목록에서 별모양 클릭 시 중요메일함으로 이동하기 (Ajax)
	function goImportantList(pk_mail_num) {

	//	$("span#importance_star").click(function () {
			// 별모양을 클릭했을 때, importance_star 에 1 값을 준다.
		//	var pk_mail_num = $(this).next().val();
			console.log(pk_mail_num);
				
			$.ajax({				
		 	    url:"<%= ctxPath%>/mail/MailMoveToImportantList.bts", 
				type:"GET",
				data: {"pk_mail_num":pk_mail_num,
					   "isRec":0},
				dataType:"JSON",
				success:function(json){
					
					var result = json.result;
					
					if(result == 1) {
					//	alert("중요메일함 이동에 성공했습니다!!");
						window.location.reload();
					}
					else {
						alert("중요메일함 이동에 실패했습니다.");
						window.location.reload();
					}
					
				},
				
				error: function(request, status, error) {
					alert("code:"+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					
				}
				
			});					
			
		
	//	}); // end of $("span#importance_star").click(function () {}----------		
		
	}// end of function goImportantList() {}----------------------------
	
	
		
</script>

<%-- 보낸 메일함 목록 보여주기 --%>	
<div class="col-xs-10" style="width: 90%; margin: 10px; padding-top: 20px;">
	<div>		
		<div>
			<h4 style="color: black;">보낸 메일함</h4>
		</div>
		<form name="goSendListSelectFrm" style="display: inline-block; padding-left: 1070px;">		
			<div id="absolute">
				<div id="mail_searchType">
					<select class="form-control" id="searchType" name="searchType" style="">
						<option value="subject" selected="selected">제목</option>
						<option value="recempname">받는이</option>
					</select>
				</div>
				
				<div id="mail_serachWord">
					<input id="searchWord" name="searchWord" type="text" class="form-control" placeholder="내용을 입력하세요.">
				</div>
				<%-- === 검색어 입력 시 자동글 완성하기 1 === --%>
				<div id="displayList" style="border: solid 1px gray; border-top: 0px; width:50px; height: 50px; margin-left: 97px; margin-right: 5px; margin-top: -1px; overflow: auto;" >
				</div>						
			</div>			
			<button type="button" style="margin-bottom: 5px" id="btnSearch" class="btn btn-secondary" onclick="gomailSearch()">
				<i class="fa fa-search" aria-hidden="true" style="font-size:15px;"></i>
			</button>
		</form>				
	</div>
	
	<div class="row">
		<div class="col-sm-12">
			<div class="white-box" style="padding-top: 5px;">
				<div id="secondHeader">
					<ul id="secondHeaderGroup" style="padding: 0px; margin-left: -10px;">
						<li class="secondHeaderList">
							<button type="button" id="delTrash" onclick="goMailDelRecyclebin()">
							<i class="fa fa-trash-o fa-fw"></i>
								삭제
							</button>
						</li>
					</ul>
				</div>
				
				<div class="table-responsive" style="color: black;">
					<table class="table">
						<thead>
							<tr>
								<th style="width: 2%;">
									<input type="checkbox" id="checkAll" />
								</th>
								<th style="width: 2%;">
									<span class="fa fa-star-o"></span>
								</th>
								<th style="width: 2%;">
									<span class="fa fa-paperclip"></span>
								</th>
								<th style="width: 10%;" class="text-center">받는이</th>
								<th style="width: 53%;">제목</th>
								<th style="width: 15%;" class="text-left">전송일자</th>
								<th style="width: 40%;">수신확인일자</th>								
							</tr>
						</thead>
						
						<tbody>
						<c:if test="${empty requestScope.sendMailList_recCheck}">
							<tr>
								<td colspan="10" style="text-align: center; width: 1278px;">메일이 존재하지 않습니다.</td>
							</tr>							
						</c:if>
						<c:if test="${not empty requestScope.sendMailList_recCheck}">		
						<c:forEach items="${requestScope.sendMailList_recCheck}" var="sendMailList_recCheck" varStatus="status">
							<tr>
								<td style="width: 40px;">
									<input type="checkbox" id="${sendMailList_recCheck.pk_mail_num}" name="chkBox" class="text-center"/>
								</td>
								<td style="width: 40px;">
									<%-- 별모양(☆) 클릭 시 importance_star를 1(★)로 바꾼다. (중요메일함 = importance_star=1인 목록) --%>
									<c:if test="${sendMailList_recCheck.importance_star_send == '0'}">
										<span class="fa fa-star-o" id="importance_star" style="cursor: pointer;" onclick="goImportantList('${SendMailList.pk_mail_num}')"></span>
									</c:if>
									<c:if test="${sendMailList_recCheck.importance_star_send == '1'}">
										<span class="fa fa-star" id="importance_star" style="cursor: pointer;" onclick="goImportantList('${SendMailList.pk_mail_num}')"></span>
									</c:if>
								</td>
								<td style="width: 40px;">
									<c:if test="${not empty sendMailList_recCheck.filename}">
										<span class="fa fa-paperclip" class="text-center"></span>
									</c:if>
								</td>							
								<td class="text-center">${sendMailList_recCheck.recempname}</td>
								<td>
								<%--
								<a href="<%= ctxPath%>/mail/mailSendDetail.bts?searchType=${}&searchWord=${}&pk_mail_num=${}">${sendMailList.subject}</a>
								--%>
									<span class="subject" onclick="goSendMailView('${sendMailList_recCheck.pk_mail_num}')">
										<c:if test="${sendMailList_recCheck.importance == '1'}">
											<span class="fa fa-exclamation" style="color: red;" class="text-center"></span>
										</c:if>
											<span>${sendMailList_recCheck.subject}</span>
									</span>
								</td>
									<c:if test="${not empty sendMailList_recCheck.reservation_date}">
										<td>${sendMailList_recCheck.reservation_date}</td>
									</c:if>
									<c:if test="${empty sendMailList_recCheck.reservation_date}">
										<td>${sendMailList_recCheck.reg_date}</td>
									</c:if>	
									<c:if test="${not empty sendMailList_recCheck.rec_date}">
										<td style="width: 10%;">${sendMailList_recCheck.rec_date}&nbsp;&nbsp;<i class="fa fa-envelope-open-o" aria-hidden="true"></i></td>	
									</c:if>	
									<c:if test="${empty sendMailList_recCheck.rec_date}">
										<td style="width: 10%;">읽지않음</td>	
									</c:if>							
							</tr>	
						</c:forEach>	
						</c:if>																			
						</tbody>
					</table>
				</div>	
				
				<%-- 페이징 처리하기 --%>
				<div align="center" style="border: solid 0px gray; width: 70%; margin: 20px auto;" >
					${requestScope.pageBar}
				</div>							
			</div>
		</div>	
	</div>
</div>