<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
	<!-- Content Header (Page header) -->
	<style>
  table {
    width: 100%;
    border-collapse: collapse;
  }

  th, td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
  }

  th {
    background-color: #4CAF50;
    color: white;
  }

  /* 조절할 너비 설정 */
  th:nth-child(1), td:nth-child(1) {
    width: 5%; /* 순번 열의 너비 조절 */
  }

  th:nth-child(2), td:nth-child(2) {
    width: 55%; /* 제목 열의 너비 조절 */
  }

  th:nth-child(3), td:nth-child(3) {
    width: 13%; /* 날짜 열의 너비 조절 */
  }

  th:nth-child(4), td:nth-child(4) {
    width: 8%; /* 조회수 열의 너비 조절 */
  }
</style>
	
	
	<div class="content-header">
		<div class="d-flex align-items-center">
			<div class="me-auto">
				<h3 class="page-title">대나무 숲</h3>
				<div class="d-inline-block align-items-center">
					<nav>
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="#"><i
									class="mdi mdi-home-outline"></i>게시판 사용</a></li>
							<li class="breadcrumb-item" aria-current="page">대나무 숲</li>
						</ol>
					</nav>
				</div>
			</div>

		</div>
	</div>
	
    	<section class="content">
			<div class="row" >
				<div class="col-lg-12">
					<div class="box">
						<div class="box-body">
						<div class="app-menu" style="display: flex; justify-content: flex-end;">
					<div class="search-bx mx-5 col-md-4">
						<form>
							<div class="input-group">
							  <input type="search" class="form-control" placeholder="Search" aria-label="Search" aria-describedby="button-addon2">
							  <div class="input-group-append">
								<button class="btn" type="submit" id="button-addon3"><i class="ti-search"></i></button>
							  </div>
							</div>
						</form>
					</div>
				</div>
							<h4 class="box-title"></h4>
							<div class="table-responsive">
								<table class="table">
									<thead class="bg-primary">
										<tr>
											<th>순번</th>
											<th>제목</th>
											<th>날짜</th>
											<th>조회수</th>
										</tr>
									</thead>
									<c:choose>
										<c:when test="${empty boardList }">
											<tr>
												<td colspan="5">조회하신 게시글이 존재하지 않습니다...</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach items="${boardList }" var="boardVO">
												<tr>
													<td>${boardVO.anonBrdNo}</td>
													<td>
														<a href="/student/anonymousDetail?brdNo=${boardVO.anonBrdNo }">${boardVO.anonBrdTitle}</a> <!--보드디테일  -->
													</td>
													<td>${boardVO.anonWriteDate}</td>
													<td>${boardVO.anonHitCount}</td>
												</tr>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</table>
							</div>
						</div>
					</div>
				</div>
</div>

<!-- 가운데 정렬 -->
<div class="col-sm-12 col-md-7"
	style="float: right; margin-right: 100px">
	<div class="dataTables_paginate paging_simple_numbers"
		id="example1_paginate">
		<ul class="pagination">
			<li class="paginate_button page-item previous disabled"
				id="example1_previous"><a href="#" aria-controls="example1"
				data-dt-idx="0" tabindex="0" class="page-link">Previous</a></li>
			<li class="paginate_button page-item active"><a href="#"
				aria-controls="example1" data-dt-idx="1" tabindex="0"
				class="page-link">1</a></li>
			<li class="paginate_button page-item"><a href="#"
				aria-controls="example1" data-dt-idx="2" tabindex="0"
				class="page-link">2</a></li>
			<li class="paginate_button page-item"><a href="#"
				aria-controls="example1" data-dt-idx="3" tabindex="0"
				class="page-link">3</a></li>
			<li class="paginate_button page-item"><a href="#"
				aria-controls="example1" data-dt-idx="4" tabindex="0"
				class="page-link">4</a></li>
			<li class="paginate_button page-item"><a href="#"
				aria-controls="example1" data-dt-idx="5" tabindex="0"
				class="page-link">5</a></li>
			<li class="paginate_button page-item next" id="example1_next"><a
				href="#" aria-controls="example1" data-dt-idx="6" tabindex="0"
				class="page-link">Next</a></li>
		</ul>
	</div>
</div>
<button type="button" class="waves-effect waves-light btn btn-primary mb-5">등록</button>
