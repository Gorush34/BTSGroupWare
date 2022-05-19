<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
 	String ctxPath = request.getContextPath();
%>

<script type="text/javascript">

	$(document).ready(function(){
	
		$("div#plusTodo").hide();
		
	});// end of $(document).ready(function(){}-------------------------------------------------
	
	// function declaration
	function plusTodo(){
		$("i.bi-plus-square-dotted").hide();
		$("div#plusTodo").show();
	}
	
	function reset(){
		$("i.bi-plus-square-dotted").show();
		$("div#plusTodo").hide();
	}
	
	// 투두 소분류 추가 
	function todoPlus(){
		
		$.ajax({
			url:"<%= ctxPath%>/todo/todoPlus.bts",
			data:{"todoSubject":$("input#todoSubject").val()},
			dataType:"JSON",
			success:function(json){
				var html ="";

					if(json.n == 1){
						alert("일정을 추가하였습니다.");
						html+="<div class='content1'>";
						html+="<div id='delpart' style='float:right;'><button onclick='delTodo()'><i class='bi bi-backspace'></i></button></div>";
						html+="<div class='content-header'>";
						html+="<p>"+$("input#todoSubject").val()+"</p>";
						html+="</div>";
						html+="<div class='content-body'></div>";
						html+="<div class='content-enter'>";
						html+="<input type='text' id='text-input' class='text-input' />";
						html+="</div>";
						html+="<div class='content-footer'>";
						html+="<button id='clickOn'><i class='bi bi-send-plus-fill'></i></button>";
						html+="</div>";
						html+="</div>";
					}
				
				$("div.contentIN").html(html);
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
		});
		
		
	}
			
</script>

<div id="todolistMain">
	<div class="content">
	<div id="delpart" style="float:right;"><button onclick="delTodo()"><i class="bi bi-backspace"></i></button></div>
		<div class="content-header">
			<p>대기</p>
		</div>
		<div class="content-body"></div>
		<div class="content-enter">
			<input type="text" id="text-input" class="text-input" />
		</div>
		<div class="content-footer">
			<button id="clickOn"><i class="bi bi-send-plus-fill"></i></button>
		</div>
	</div>
	<div class="content">
		<div id="delpart" style="float:right;"><button onclick="delTodo()"><i class="bi bi-backspace"></i></button></div>
		<div class="content-header">
			<p>진행</p>
		</div>
		<div class="content-body"></div>
		<div class="content-enter">
			<input type="text" id="text-input" class="text-input" />
		</div>
		<div class="content-footer">
			<button id="clickOn"><i class="bi bi-send-plus-fill"></i></button>
		</div>
	</div>
	<div class="content">
		<div id="delpart" style="float:right;"><button onclick="delTodo()"><i class="bi bi-backspace"></i></button></div>
		<div class="content-header">
			<p>완료</p>
		</div>
		<div class="content-body"></div>
		<div class="content-enter">
			<input type="text" id="text-input" class="text-input" />
		</div>
		<div class="content-footer">
			<button id="clickOn"><i class="bi bi-send-plus-fill"></i></button>
		</div>
	</div>
	<div class="contentIN"></div>
	<div class="content">
		<div class="content-header">
			<button onclick="plusTodo()"><i class="bi bi-plus-square-dotted"></i></button>
			<div id="plusTodo" style="padding-top: 2px;">
				<input type="text" id="todoSubject" size=24 maxlength=20 />
				<button type="button" onclick="todoPlus()">저장</button>
				<button type="reset" id="reset" onclick="reset()">취소</button>
			</div>
		</div>
	</div>
</div>	