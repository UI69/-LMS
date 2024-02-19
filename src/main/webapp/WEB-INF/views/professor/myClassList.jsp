<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
th, td {
	text-align: center;
}
.pageStyle {
	position: relative;
}
.pagination {
	position: absolute;
    top: 8px;
    left: 50%;
    transform: translate(-50%, 0);
}
.searchStyle > * {
	display: inline-block;
}
</style>

<div class="container-full">
	<div class="content-header">
		<div class="d-flex align-items-center">
			<div class="me-auto p-10">
				<h3 class="page-title">내 강의 목록</h3>
				<div class="d-inline-block align-items-center">
					<nav>
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="#"><i class="mdi mdi-home-outline"></i></a></li>
							<li class="breadcrumb-item" aria-current="page">수업관리</li>
							<li class="breadcrumb-item active" aria-current="page">수업목록</li>
						</ol>
					</nav>
				</div>
			</div>
		</div>
	</div>	
	<section class="content">
		<div class="row">
			<div class="col-12">
				<div class="box">
					<div id="example_wrapper" class="box-header" style="display: flex; justify-content: flex-end;">
						<form id="searchForm" method="post" class="searchStyle" style="width: 30%;">
							<input type="hidden" name="page" id="page" />
							<select name="status" class="form-select" data-placeholder="Select status" style="width: 30%;">
								<option selected="selected" disabled="disabled">- 선택 -</option>
								<option value="semester" <c:if test="${searchType eq 'semester' }">selected</c:if>>년도/학기</option>
								<option value="classReqCode" <c:if test="${searchType eq 'classReqCode' }">selected</c:if>>이수구분</option>
							</select> 
							<input type="text" placeholder="입력하세요" name="searchWord" value="${searchWord }" class="form-control" style="width: 50%;">
							<button type="submit" class="waves-effect waves-light btn btn-dark btn-sm" style="height: 33px;">조회</button>
						</form>
					</div>
					<div class="box-body">
						<div class="table-responsive">
							<table class="table">
								<thead class="bg-primary">
									<tr>
										<th>년도/학기</th>
										<th style="width: 17%;">과목명</th>
										<th>강의시간</th>
										<th>이수구분</th>
										<th>수강인원</th>
									</tr>
								</thead>
								<tbody>
									<c:set var="index" value="${pagingVO.startRow + 1}" />
									<c:set var="index" value="${index - 1}" />
									<c:forEach items="${myClassList}" var="mylist">
										<tr>
											<td>${mylist.semester}</td>
											<td><a href="/DYUniv/managementClassRoom/${mylist.classNo}">${mylist.className}</a></td>
											<td>${mylist.classTotalTime}</td>
											<td><c:if test="${mylist.classReqCode eq 'CLR001'}">전공필수</c:if>
												<c:if test="${mylist.classReqCode eq 'CLR002'}">전공선택</c:if> <c:if
													test="${mylist.classReqCode eq 'CLR003'}">교양필수</c:if> <c:if
													test="${mylist.classReqCode eq 'CLR004'}">교양선택</c:if></td>
											<td>${mylist.classMaxMem}</td>
										</tr>
										<c:set var="index" value="${index + 1}" />
									</c:forEach>
								</tbody>
							</table>
						</div>
						<div class="col-sm-12" style="display: block; height: 70px;">
							<div class="dataTables_paginate paging_simple_numbers pageStyle" id="example1_paginate">
								${pagingVO.pagingHTML }
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>	
	
<script type="text/javascript">
	$(function() {

		/* 페이징 */
		var pagingArea = $("#example1_paginate");
		var searchForm = $("#searchForm");

		pagingArea.on("click", "a", function(event) {
			event.preventDefault(); // a 태그의 기본 이벤트 동작 방지
			var pageNo = $(this).data("page");
			searchForm.find("#page").val(pageNo);

			searchForm.submit();
		});

	});
</script>