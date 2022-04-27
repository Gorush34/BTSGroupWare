<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<title>전자결재 홈</title>

<style>
	div.card {
		min-width: 120px;
		max-width: 
	}
	
	div.card-title {
		font-size: 12pt;
		line-height: 12pt;
		text-align: left;
		padding-left: 12px;
		margin-top: 12px;
	}
</style>

<div id="myedms">
	<!-- 나의 현황 시작 -->
	<div id="edms_top">
		<H2>김다우 님의 현황 입니다.</H2>
		<div class="divClear"></div>
		<div class="row">
			<div class="col-3">
				<div class="card">
					<div class="card-body">
						<h5 class="card-title">기안서 제목</h5>
						<h6 class="card-subtitle mb-2 text-muted">진행중</h6>
						<hr>
						<p class="card-text">기안자 성명</p>
						<p class="card-text">기안자 일자</p>
						<p class="card-text">결재양식</p>
						<a href="/bts/test/edmsMydoc.bts" class="stretched-link btn btn-sm text-primary" class="card-link">자세히 보기</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 나의 현황 종료 -->

	
</div>

	