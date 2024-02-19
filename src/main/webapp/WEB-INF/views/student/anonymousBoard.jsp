<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<style>
table {
	text-align: center;
}
.box-header {
	padding: 1rem 3rem;
 	display: flex;
 	justify-content: space-between;
}
.textLeft {
	text-align: left;
}
#searchType {
	width: 70px;
    position: absolute;
    top: 0;
    left: -100px;
    text-align: center;
}
#searchForm{
	display: flex;
	justify-content: end;
	margin-top: 9px;
	position: relative;
}
#example1_paginate {
	position: absolute;
    bottom: 5%;
    left: 50%;
    transform: translate(-50%, 0);
}
</style>

<div class="container-full">
	<div class="content-header">
		<div class="d-flex align-items-center">
			<div class="me-auto">
				<h3 class="page-title">
					<a href="/DYUniv/anonymouseBoard.do">대나무 숲</a>
				</h3>
				<div class="d-inline-block align-items-center">
					<nav>
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="/DYUniv/anonymouseBoard.do"><i
									class="mdi mdi-home-outline"></i>게시판 사용</a></li>
							<li class="breadcrumb-item" aria-current="page">대나무 숲</li>
						</ol>
					</nav>
				</div>
			</div>
		</div>
	</div>
	<section class="content">
		<div class="row">
			<div class="col-lg-12">
				<div class="box">
					<div class="box-header">
						<!-- 서버에 전송하는 버튼 -->
						<button type="button" class="waves-effect waves-light btn btn-primary mb-5" id="listBtn">등록</button>
						
						<!-- 검색 -->
						<div class="app-menu">
							<div class="search-bx">
								<form id="searchForm" action="" method="get">
									<select id="searchType" class="form-control" name="searchType">
										<option value="anonBrdTitle" <c:if test="${searchType eq 'anonBrdTitle' }">selected</c:if>>제목</option>
										<option value="anonBrdCont" <c:if test="${searchType eq 'anonBrdCont' }">selected</c:if>>내용</option>
									</select>
									<div class="col-12" style="margin-top: 4px;">
										<div class="lookup lookup-circle lookup-right">
											<input type="text" id="searchWord" name="searchWord" data-provide="media-search" placeholder="Search">
										</div>
									</div>
									<input type="hidden" id="page" name="page">
								</form>
							</div>
						</div>
					</div>
					<div class="box-body" style="min-height: 585px;">
						<div class="table-responsive">
							<table class="table">
								<thead class="bg-primary">
									<tr>
										<th>순번</th>
										<th width="50%" class="textLeft">제목</th>
										<th>게시일시</th>
										<th>조회수</th>
									</tr>
								</thead>
								<c:set value="${pagingVO.dataList }" var="anonyList" />
								<c:choose>
									<c:when test="${empty anonyList }">
										<tr>
											<td colspan="4">조회하신 게시글이 존재하지 않습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:set var="index" value="${pagingVO.startRow + 1}" />
										<c:set var="index" value="${index - 1}" />
										<c:forEach items="${anonyList }" var="anonyVO">
											<tr>
												<td><strong>${index}</strong></td>
												<c:set var="index" value="${index + 1}" />
												<%-- <td>${anonyVO.anonBrdNo}</td> --%>
												<td class="textLeft">
													<a href="/DYUniv/anonymousDetail.do?anonBrdNo=${anonyVO.anonBrdNo }">${anonyVO.anonBrdTitle}</a>
													<!--보드디테일  -->
												</td>
												<td>${fn:substring(anonyVO.anonWriteDate, 0, 10) }</td>
												<td>${anonyVO.anonHitCount}</td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
							</table>
							<!-- 	<form id="anonymousForm" action="/anonymousInsert.do"
								method="post">
								폼 필드들이 여기에 위치합니다. 예를 들면:
								<input type="text" name="title" required />
								<textarea name="content" required></textarea>
								기타 필요한 입력 필드들...

								<button type="submit"
									class="waves-effect waves-light btn btn-primary mb-5"
									id="listBtn">
									등록</button> 
							</form>
							-->
						</div>
						<div class="dataTables_paginate paging_simple_numbers" id="example1_paginate">${pagingVO.pagingHTML }</div>
					</div>
				</div>
			</div>

			<%-- <div class="row">
				<div class="col-12 text-end">
					<div class="col-sm-12 col-md-6" style="float: right; margin-right: 80px">
						<div class="dataTables_paginate paging_simple_numbers" id="example1_paginate">${pagingVO.pagingHTML }</div>
					</div>
					<div>
						<p>
							총인원 : <span class="text-danger"> ${totalRecord } </span>명
						</p>
					</div>
				</div>
			</div> --%>
		</div>
	</section>
</div>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	/* $(document).ready(function() {
	 $('#listBtn').on('click', function() {
	 // 폼 데이터를 수집합니다.
	 var formData = new FormData($('#anonymousForm')[0]);

	 // AJAX를 통해 서버로 전송합니다.
	 $.ajax({
	 type: 'POST',
	 url: '/anonymousInsert.do',
	 data: formData,
	 processData: false,
	 contentType: false,
	 success: function(data) {
	 // 성공 시 메시지를 보여주고, 상세 페이지로 넘어갑니다.
	 alert('등록이 완료되었습니다!');
	 window.location.href = '/student/anonymousDetail';
	 },
	 error: function(xhr, status, error) {
	 // 에러 발생 시 처리
	 alert('등록에 실패했습니다. 다시 시도해주세요.');
	 }
	 });
	 });
	 }); */
	$("#listBtn").on("click", function() {
		location.href = "/DYUniv/anonymousInsertForm.do";
	})
	$(function() {
		// 순번매기기

		var pagingArea = $("#example1_paginate");
		var searchForm = $("#searchForm");
		/* var newBtn = $("#newBtn"); */

		pagingArea.on("click", "a", function(event) {
			event.preventDefault(); // a태그의 이벤트를  block
			var pageNo = $(this).data("page");

			searchForm.find("#page").val(pageNo);
			console.log("pageNo" + pageNo);
			searchForm.submit();

		});

	});
</script>