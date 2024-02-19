<!-- 교직원 공지사항 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="sec" %>

<div class="container-full">
	<!-- Content Header (Page header) -->
	<div class="content-header">
		<div class="d-flex align-items-center">
			<div class="me-auto">
				<h3 class="page-title">공지사항</h3>
				<div class="d-inline-block align-items-center">
					<nav>
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="#"><i
									class="mdi mdi-home-outline"></i></a></li>
							<li class="breadcrumb-item" aria-current="page">게시판</li>
							<li class="breadcrumb-item active" aria-current="page">공지사항</li>
						</ol>
					</nav>
				</div>
			</div>
		</div>
	</div>
	<!-- Main content -->
	<section class="content">
		<div class="row">
			<div class="col-12">
				<div class="box" style="min-height: 610px; height: 550px;">
					<div class="box-body">
						<div class="p-15">
							<div class="row" style="justify-content: space-between;">
								<div class="col-md-4 col-12">
									<button type="button" class="btn btn-primary" onclick="f_createNotice()">공지 추가</button>
								</div>
								<div class="col-md-4 col-12">
									<div class="form-group">
										<form id="searchForm" method="post">
										<input type="hidden" name="page" id="page">
											<select class="form-control"
												style="width: 30%; display: inline-block;">
												<option value="title" <c:if test="${searchType eq 'title' }">selected</c:if>>제목</option>
												<option value="content" <c:if test="${searchType eq 'content' }">selected</c:if>>내용</option>
											</select> 
											<input type="text" name="searchWord" value="${searchWord }" placeholder="입력하세요" class="form-control" style="width: 55%; display: inline-block;">
											<button type="submit" class="btn btn-primary" style="padding: 5px 12px;">검색</button>
										</form>
									</div>
								</div>
							</div>
							<div class="table-responsive">
								<table class="table mb-0" style="text-align: center">
									<thead class="bg-primary">
										<tr>
											<th scope="col" style="width: 5%">순번</th>
											<th scope="col" style="width: 70%; text-align: left;">제목</th>
											<th scope="col">게시일시</th>
											<th scope="col">조회수</th>
										</tr>
									</thead>
									<tbody>
										<c:set value="${pagingVO.dataList }" var="planList" />
										<c:choose>
											<c:when test="${empty planList }">
												<tr>
													<td colspan="5">조회하신 게시글이 존재하지 않습니다.</td>
												</tr>
											</c:when>
											<c:otherwise>
												<c:set var="index" value="${pagingVO.startRow + 1}" />
												<c:set var="index" value="${index - 1}" />
												<c:forEach items="${planList }" var="planBoard">
													<tr>
														<td><strong>${index }</strong></td>
														<td style="text-align: left;"><a href="/DYUniv/noticeBoardDetail.do/${planBoard.brdNo }">${planBoard.brdTitle }</a></td>
														<td>${planBoard.writeDate }</td>
														<td>${planBoard.brdHitCount }</td>
													</tr>
													<c:set var="index" value="${index + 1}" />
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div>
						</div>
						<div class="col-sm-12 col-md-6"
							style="float: right; margin-right: 80px; margin-top: 20px;">
							<div class="dataTables_paginate paging_simple_numbers" id="example1_paginate">
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
		// 순번매기기
		
		var pagingArea = $("#example1_paginate");
		var searchForm = $("#searchForm");
		/* var newBtn = $("#newBtn"); */ 

		pagingArea.on("click", "a", function(event) {
			event.preventDefault(); // a태그의 이벤트를  block
			var pageNo = $(this).data("page");
			
			searchForm.find("#page").val(pageNo);
			searchForm.submit();
		});

	});
	
	function f_createNotice(){
		location.href = "/DYUniv/noticeBoardCreate.do";
	}
</script>