<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%
 	String ctxPath = request.getContextPath();
	//     /bts
%>


<style type="text/css">

	span.view:hover {
		cursor: pointer;
	}

</style>

<script type="text/javascript">

  $(document).ready(function(){

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
	  
	$("span.view").click(function(){
		
		var pk_emp_no = $(this).parent().parent().find("input#pk_em").val();
		// console.log(pk_emp_no);
		
		viewEmpDetail(pk_emp_no);
	})
	
	// 체크박스 전체선택 및 해제
	$("input#checkAll").click(function() {
		if($(this).prop("checked")) {
			$("input[name='chkBox']").prop("checked",true);
		}
		else {
			$("input[name='chkBox']").prop("checked",false);
		}
		
	});
	  
  });  // end of  $(document).ready(function(){})--------------  
  
  // Function Declaration
  
  function viewEmpDetail(pk_emp_no) {
		
		location.href="<%= ctxPath%>/emp/viewEmpDetail.bts?pk_emp_no="+pk_emp_no; 
		
  } // end of function viewReport(pk_att_num)-----------------------
  
  function goSearch() {
			
	  const frm = document.allAttListSelectFrm;
	  frm.method = "GET";
	  frm.action = "<%= ctxPath%>/emp/showAllEmp.bts";
	  frm.submit();
		
  }// end of function goSearch() {}-----------------------
  
	// 선택한 사원 탈퇴처리하기 (Ajax)
	function updateHire() {
		// 체크된 갯수 세기
		var chkCnt = $("input[name='chkBox']:checked").length;
		// 배열에 체크된 행의 pk_emp_no 넣기
		var arrChk = new Array();
		
		$("input[name='chkBox']:checked").each(function(){
			
			var pk_emp_no_str = $(this).attr('id');
			arrChk.push(pk_emp_no_str);
			// console.log("arrChk 확인용 : " + arrChk);
			
		});
		
		if(chkCnt == 0) {
			alert("선택된 사원이 없습니다.");
		}
		else {
			
			$.ajax({				
		 	    url:"<%= ctxPath%>/emp/updateHire.bts", 
				type:"POST",
				data: {"pk_emp_no_str":JSON.stringify(arrChk),
					   "cnt":chkCnt
					   },
				dataType:"JSON",
				success:function(json){
					
					var result = json.result;
					
					if(result != 1) {
						alert("재직상태 변경에 실패했습니다.");
						window.location.reload();
					}
					else {
						alert("재직상태 변경에 성공했습니다.");
						window.location.reload();
					}
					
				},
				
				error: function(request, status, error) {
					alert("code:"+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					
				}
				
			});
			
		}
		
	}// end of function updateHire() {}-----------------------------
  
</script>	

<div class="container_myAtt">
	<div class="row">
    	<%-- 출퇴근내역 시작 --%>
        <div class="col-md-12 mx-3">
        	<div id="title"><span style="font-size: 30px; margin-bottom: 20px; font-weight: bold;">전 사원보기</span></div>
        	
        	<div id="vacCnt">
			     <table class="table" id="tbl_allEmp">
					 <thead class="thead-light">
					    <tr style="text-align: center;">
					      <th style="width:4%; text-align: center;">
					      	<input type="checkbox" id="checkAll" />
					      </th>
					      <th style="width:10%; text-align: center;">부서</th>
					      <th style="width:10%; text-align: center;">직급</th>
   					      <th style="width:10%; text-align: center;">이름</th>
					      <th style="width:14%; text-align: center;">연락처</th>
					      <th style="width:14%; text-align: center;">이메일</th>
					      <th style="width:14%; text-align: center;">생년월일</th>
					      <th style="width:14%; text-align: center;">입사일자</th>
   					      <th style="width:10%; text-align: center;">재직상태</th>
   					      <th></th>
					    </tr>
					  </thead>
					  <tbody>
					  	<c:if test="${ not empty requestScope.empList}">
					  	<c:forEach var="emp" items="${requestScope.empList}" varStatus="status">
							<tr style="text-align: center;">
						      <td><input type="checkbox" id="${emp.pk_emp_no}" name="chkBox" class="text-center"/></td>
						      <td style="width:8%; text-align: center;"><span class="view">${emp.ko_depname}</span></td>
						      <td style="width:9%; text-align: center;"><span class="view">${emp.ko_rankname}</span></td>
						      <td style="width:9%; text-align: center;"><span class="view">${emp.emp_name}</span></td>
						      <td style="width:13%; text-align: center;"><span class="view">${emp.uq_phone}</span></td>
						      <td style="width:13%; text-align: center;"><span class="view">${emp.uq_email}</span></td>
						      <td style="width:13%; text-align: center;"><span class="view">${emp.birthyyyy}-${emp.birthmm}-${emp.birthdd}</span></td>
						      <td style="width:13%; text-align: center;"><span class="view">${emp.hire_date}</span></td>
						      <c:if test="${emp.ishired == 1}">
						      	<td style="width:9%; text-align: center;"><span class="view">재직중</span></td>
						      </c:if>
						      <c:if test="${emp.ishired == 0}">
						      	<td style="width:9%; text-align: center;"><span class="view">퇴사</span></td>
						      </c:if>
						      <td><input type="hidden" id="pk_em" name="pk_emp_no" value="${emp.pk_emp_no}" /></td>
						    </tr>
					    </c:forEach>
					    </c:if>
					    <c:if test="${ empty requestScope.empList}">
					    	<td colspan="9" style="width:20%; text-align: center;">조건에 맞는 사원이 없습니다.</td>
					    </c:if>
					  </tbody>
				  </table>
				  
				  <div style="width: 90%;" >
				    <form name="allAttListSelectFrm" style="display: inline;">
						<select class="form-control" id="searchType" name="searchType" style="width:100px;">
							<option value="ko_depname" selected="selected">부서</option>
							<option value="pk_emp_no">사번</option>
							<option value="emp_name">이름</option>
						</select>
						<input id="searchWord" name="searchWord" type="text" class="form-control" style="width:250px;" placeholder="내용을 입력하세요.">
						<button type="button" style="margin-bottom: 5px" id="btnSearch" class="btn btn-secondary" onclick="goSearch();">
							<i class="fa fa-search" aria-hidden="true" style="font-size:15px;"></i>
						</button>
					</form>		
					<button class="btn btn-warning" id="btn_register" style="margin-left: 10px; border:solid 1px gray; float:right; color: white;" onclick="updateHire();">재직상태변경</button>
			     </div>
				  
				  <%-- === #122. 페이지바 보여주기 === --%>
				  <div align="center" style="border: solid 0px gray; width: 70%; margin: 20px auto;">
					  ${requestScope.pageBar}
				  </div>
				  
        	</div>
        </div>
        <%-- 출퇴근내역 끝 --%>
	

	</div>
</div>