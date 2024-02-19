<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
section {
	position: relative;
}

#backBtn {
	position: absolute;
	top: -43px;
	right: 35px;
}

th, td {
	text-align: center;
}

.pagination {
	margin-bottom: 0;
}

.table-responsive .col-sm-12 {
	margin-right: 130px !important;
}
</style>

<div class="content-header">
	<div class="d-flex align-items-center">
		<div class="me-auto">
			<h3 class="page-title">상담 가능 교수 목록</h3>
			<div class="d-inline-block align-items-center">
				<nav>
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="#"><i
								class="mdi mdi-home-outline"></i></a></li>
						<li class="breadcrumb-item" aria-current="page">기타</li>
						<li class="breadcrumb-item" aria-current="page">상담</li>
						<li class="breadcrumb-item" aria-current="page">상담 예약 목록</li>
						<li class="breadcrumb-item active" aria-current="page">상담 예약 신청</li>
					</ol>
				</nav>
			</div>
		</div>
	</div>
</div>

<section class="content m-10">

	<button type="button" class="btn btn-warning" onclick="f_back()" id="backBtn">
		<i class="fa fa-fw fa-arrow-left"></i> 뒤로가기
	</button>

	<div class="box" style="height: 650px; overflow: hidden;">
		<div class="box-body">
			<div class="form-group col-md-4">
				<form id="searchForm" method="post">
					<input type="hidden" name="page" id="page"> <select
						class="form-control" style="width: 30%; display: inline-block;">
						<option selected="selected" disabled="disabled">전체</option>
						<option value="memName"
							<c:if test="${searchType eq 'memName' }">selected</c:if>>교수명</option>
						<option value="dprtName"
							<c:if test="${searchType eq 'dprtName' }">selected</c:if>>학과명</option>
					</select> <input type="text" placeholder="입력하세요" name="searchWord"
						value="${searchWord }" class="form-control"
						style="width: 55%; display: inline-block;">
					<button type="submit" class="btn btn-primary btn-sm">검색</button>
				</form>
			</div>
			<div class="table-responsive mb-15">
				<table class="table">
					<thead class="bg-primary">
						<tr>
							<th>순번</th>
							<th style="width: 25%">교수명</th>
							<th style="width: 25%">학과명</th>
							<th>연락처</th>
							<th>이메일</th>
							<th>상담</th>
						</tr>
					</thead>
					<tbody>
						<c:set value="${pagingVO.dataList }" var="counselorList" />
						<c:choose>
							<c:when test="${empty counselorList }">
								<tr>
									<td colspan="6">상담 가능한 교수님이 없습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:set var="index" value="${pagingVO.startRow + 1}" />
								<c:set var="index" value="${index - 1}" />
								<c:forEach items="${counselorList }" var="counselor">
									<tr>
										<td><strong>${index }</strong></td>
										<td>${counselor.memName }</td>
										<td>${counselor.departmentVO.dprtName }</td>
										<td>${counselor.memPh }</td>
										<td>${counselor.memEmail }</td>
										<td>
											<button type="button" class="btn btn-primary btn-sm counselBtn" idx="${counselor.memNo }" name="${counselor.memName }" >예약</button>
										</td>
									</tr>
									<c:set var="index" value="${index + 1}" />
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
				<div class="col-sm-12 col-md-6"
					style="float: right; margin-right: 80px; margin-top: 12px;">
					<div class="dataTables_paginate paging_simple_numbers"
						id="pagination">${pagingVO.pagingHTML }</div>
				</div>
			</div>
		</div>
	</div>
</section>

<script src="${pageContext.request.contextPath}/resources/js/chat.js"></script>
<script>
	var calendarSelectType = false;
	var counselorList = "${counselorList }";
	var counselBtn = $(".counselBtn");

	// 페이지 + 검색
	$(function() {
		var pagingArea = $("#pagination");
		var searchForm = $("#searchForm");

		pagingArea.on("click", "a", function(event) {
			event.preventDefault();
			var pageNo = $(this).data("page");

			searchForm.find("#page").val(pageNo);
			searchForm.submit();
		});
	});
	
	// 뒤로가기
	function f_back() {
		window.history.back();
	}

	//상담인 선택시
	counselBtn.on("click", function() {
		var memNo1 = $(this).attr("idx");
		var memName1 = $(this).attr("name");

		data = {
			"memNo" : memNo1
		}

		$.ajax({
			type : 'post',
			url : '/DYUniv/counsel/getSchData.do',
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(data),
			success : function(res) {
				console.log(res);

				if (res == null || res == "") {
					alert("상담 가능 시간이 없습니다.");
					return;
				}
				
				location.href = "/DYUniv/counsel/counselReserveForm.do/" + memNo1;
			}
		})
	})

</script>