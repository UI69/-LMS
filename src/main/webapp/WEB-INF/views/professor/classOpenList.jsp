<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="sec" %>

<div class="container-full">
	<!-- Content Header (Page header) -->
	<div class="content-header">
		<div class="d-flex align-items-center">
			<div class="me-auto">
				<h3 class="page-title">개설 신청 목록</h3>
				<div class="d-inline-block align-items-center">
					<nav>
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="#"><i
									class="mdi mdi-home-outline"></i></a></li>
							<li class="breadcrumb-item" aria-current="page">강의 관리</li>
							<li class="breadcrumb-item active" aria-current="page">개설 신청 목록</li>
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
				<div class="box">
					<div class="box-body">
						<div class="p-15">
							<div class="row" style="justify-content: space-between;">
								<div class="col-md-4 col-12" style="margin-top: 5px;">
									<div class="form-group">
										<form id="searchForm" class="flex-end">
											<input type="hidden" name="page" id="page">
											<select class="form-control" name="searchType"
												style="width: 30%; display: inline-block;">
												<option value="className" <c:if test="${searchType eq 'className' }">selected</c:if>>강의명</option>
												<option value="lecName" <c:if test="${searchType eq 'lecName' }">selected</c:if>>교과목</option>
												<option value="semester" <c:if test="${searchType eq 'semester' }">selected</c:if>>연도/학기</option>
											</select> 
											<input type="text" name="searchWord" value="${searchWord }" placeholder="입력하세요" class="form-control" style="width: 50%; display: inline-block;">
											<button type="submit" class="btn btn-primary" style="padding: 5px 12px;">검색</button>
										</form>
									</div>
								</div>
								<div class="col-md-1">
									<button type="button" class="btn btn-primary" style="padding: 5px 12px;" onclick="f_newClassOpen()">개설신청</button>
								</div>
							</div>
							<div class="table-responsive">
								<table class="table mb-0" style="text-align: center">
									<thead class="bg-primary">
										<tr>
											<th scope="col">순번</th>
											<th scope="col">강의명</th>
											<th scope="col">연도/학기</th>
											<th scope="col">학과</th>
											<th scope="col">교과목</th>
											<th scope="col">이수구분</th>
											<th scope="col">학점</th>
											<th scope="col">강의횟수/총시간</th>
											<th scope="col">상태</th>
										</tr>
									</thead>
									<tbody>
										<c:set value="${pagingVO.dataList }" var="classOpenList" />
										<c:set var="index" value="${pagingVO.startRow + 1}" />
										<c:set var="index" value="${index - 1}" />
										<c:choose>
											<c:when test="${empty classOpenList }">
												<tr>
													<td colspan="8">조회하신 게시글이 존재하지 않습니다.</td>
												</tr>
											</c:when>
											<c:otherwise>
												<c:forEach items="${classOpenList }" var="classOpen">
													<tr>
														<td><strong>${index }</strong></td>
														<c:set var="index" value="${index + 1}" />
														<td>${classOpen.className }</td>
														<td>${classOpen.semester }</td>
														<td>${classOpen.departmentList[0].dprtName }</td><!-- department 테이블에서 조인해서 씀... -->
														<td>${classOpen.lectureList[0].lecName }</td><!-- lecture 테이브에서 조인 -->
														<td>${classOpen.classReqStr }</td><!-- classReqCode 코드에 따라 값 다시 주기 -->
														<td>${classOpen.lecPoint }</td>
														<td>${classOpen.classWeekCnt } / ${classOpen.classTotalTime }</td>
														<td>${classOpen.classStatusStr }</td><!-- classStatusCode 코드에 따라 값 다시 주깅 -->
													</tr>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div>
						</div>
						<div class="col-sm-12 col-md-6"
							style="float: right; margin-right: 80px">
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
		
		// 등록 버튼 클릭 시, 게시판 등록 페이지로 이동
		/* newBtn.on("click",function(){
			location.href = "/notice/form.do";
		}); */
	});
	
	function f_newClassOpen(){
		console.log("f_newClassOpen");
		location.href = "/DYUniv/professor/newClassOpen.do";
	}
</script>