<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="content-header mb-10">
	<div class="d-flex align-items-center">
		<div class="me-auto">
			<h3 class="page-title">교과목 관리</h3>
			<div class="d-inline-block align-items-center">
				<nav>
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="#"><i class="mdi mdi-home-outline"></i></a></li>
						<li class="breadcrumb-item" aria-current="page">교과목 관리</li>
					</ol>
				</nav>
			</div>
		</div>
	</div>
</div>


<ul class="nav nav-tabs" role="tablist">
	<li class="nav-item">
		<a class="nav-link <c:if test="${tap eq 'apply' }">active</c:if>" data-bs-toggle="tab" href="#classApply" role="tab" aria-selected="true">
			<span class="hidden-sm-up"><i class="fa fa-cc"></i></span> 
			<span class="hidden-xs-down">강의 신청 목록</span>
		</a>
	</li>
	<li class="nav-item">
		<a class="nav-link <c:if test="${tap eq 'class' }">active</c:if>" data-bs-toggle="tab" href="#class" role="tab" aria-selected="false">
			<span class="hidden-sm-up"><i class="fa fa-paypal"></i></span> 
			<span class="hidden-xs-down">강의 목록</span>
		</a>
	</li>
	<li class="nav-item">
		<a class="nav-link <c:if test="${tap eq 'lecture' }">active</c:if>" data-bs-toggle="tab" href="#lecture" role="tab" aria-selected="false">
			<span class="hidden-sm-up"><i class="fa fa-paypal"></i></span> 
			<span class="hidden-xs-down">교과목 목록 </span>
		</a>
	</li>
</ul>

<div class="tab-content tabcontent-border p-15 bg-white">

	<div class="tab-pane <c:if test="${tap eq 'apply' }">active</c:if>" id="classApply" role="tabpanel">
		<h3 style="margin: 30px;"><strong>강의 신청 목록</strong></h3>

		<form method="post" class="row" style="justify-content: flex-end;" id="searchForm1">
			<div class="col-md-4 p-15">
			</div>
			<div class="col-md-3">
			</div>
			<div class="col-md-5"> <!-- col-md-5: 부모 너비 값의 절반 사용 -->
				<div class="form-group">
					<select class="form-control" style="width: 25%; display: inline-block;">
						<option selected="selected" disabled="disabled">======선택======</option> <!-- disabled : 선택안됨(select의 제목?) -->
						<option>제목 +작성자</option>
						<option>제목</option>
						<option>작성자</option>
					</select> 
					<input type="text" placeholder="입력하세요" class="form-control" style="width: 55%; display: inline-block;">
					<button type="button" class="btn btn-primary btn-sm">검색</button>
				</div>
			</div>
			<input type="hidden" name="apPage" id="apPage">
			<input type="hidden" name="tap" class="tap" value="apply">
		</form>
		<div class="table-responsive"style="margin: 30px;">
			<table class="table">
				<thead class="bg-primary">
					<tr>
						<th>선택</th>
						<th>번호</th>
						<th width="35%">제목</th>
						<th class="text-center">작성자</th>
						<th class="text-center">학점</th>
						<th class="text-center">총수업시간</th>
						<th class="text-center">강의 주차</th>
						<th class="text-center">허가/반려</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty apPagingVO.dataList }">
							<tr>
								<td colspan="6">신청한 강의 목록이 존재하지 않습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
						<c:set var="apIndex" value="${apPagingVO.totalRecord - (apPagingVO.currentPage -1 ) * apPagingVO.screenSize }"/>
						<c:forEach items="${apPagingVO.dataList }" var="clazz">
							<tr>
								<td>
									<input type="checkbox" id="md_checkbox_${clazz.classNo }" class="filled-in chk-col-primary" value="${clazz.classNo }" /> 
									<label for="md_checkbox_${clazz.classNo }" class="p-0"></label>
								</td>
								<td>${apIndex}</td>
									<c:set var="apIndex" value="${apIndex - 1 }"/>
								<td>${clazz.className }</td>
							 	<td class="text-center">${clazz.memName }</td>
								<td class="text-center">${clazz.lecPoint }</td> 
								<td class="text-center">${clazz.classTotalTime }</td>
								<td class="text-center">${clazz.classWeekCnt }</td>
								<td style="text-align: center;">
									<button type="button" class="btn btn-primary classFormBtn" data-bs-target="#classForm" idx="${clazz.classNo }">
										신청처리
									</button>
								</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		<div class="col-sm-12 col-md-7" style="float: right; margin-right: 100px">
			<div class="dataTables_paginate paging_simple_numbers" id="example1_paginate">
				${apPagingVO.pagingHTML }
			</div>
		</div>
	</div>
</div>
	
	
	
	<div class="tab-pane <c:if test="${tap eq 'class' }">active</c:if>" id="class" role="tabpanel">
		<h3 style="margin: 30px;"><strong>강의 목록</strong></h3>

		<!-- 검색 시작 -->
		<form method="post" id="searchForm2" class="row" style="justify-content: flex-end;">
			<div class="col-md-5"> <!-- col-md-5: 부모 너비 값의 절반 사용 -->
				<div class="form-group">
					<select class="form-control" style="width: 30%; display: inline-block;">
						<option selected="selected" disabled="disabled">======선택======</option> <!-- disabled : 선택안됨(select의 제목?) -->
						<option>제목 +작성자</option>
						<option>제목</option>
						<option>작성자</option>
					</select> 
					<input type="text" placeholder="입력하세요" class="form-control" style="width: 55%; display: inline-block;">
					<button type="button" class="btn btn-primary btn-sm">검색</button>
				</div>
			</div>
			<input type="hidden" name="classPage" id="classPage">
			<input type="hidden" name="tap" class="tap" value="class">
		</form>
		<!-- 검색 끝 -->
		
		<div class="table-responsive"style="margin: 30px;">
			<table class="table">
				<thead class="bg-primary">
					<tr>
						<th>번호</th>
						<th width="35%">강의명</th>
						<th>학점</th>
						<th>최대수강인원</th>
						<th>강의횟수(주차)</th>
						<th>이수구분</th>
						<th>상태</th>
						<th>파일</th>
					</tr>
				</thead>
				<tbody>
				<c:choose>
					<c:when test="${empty classPagingVO.dataList }">
						<tr>
							<td colspan="6">조회하실 게시물이 존재하지 않습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
					<c:set var="classIndex" value="${classPagingVO.totalRecord - (classPagingVO.currentPage -1 ) * classPagingVO.screenSize }"/>
					<c:forEach items="${classPagingVO.dataList }" var="clazz">
						<tr>
						 	<td>${classIndex }</td>
						 	<c:set var="classIndex" value="${classIndex -1 }"/>
							<td>${clazz.className}</td>
							<td>${clazz.lecPoint }</td>
							<td>${clazz.classMaxMem }</td> 
							<td>${clazz.classWeekCnt }</td>
							<td>${clazz.classReqStr }</td>
							<td>${clazz.classStatusStr }</td>
							<td style="text-align: center;">
								<c:if test="${clazz.fileNo ne 0 }">
									<button type="button" class="btn btn-circle btn-xs btn-primary">
										<i class="fa fa-folder-open" style="color: white"></i>
									</button>
								</c:if>
							</td>
							
						</tr> 	
						</c:forEach>
					</c:otherwise>
				</c:choose>
				</tbody>
			</table>
		<div class="col-sm-12 col-md-7" style="float: right; margin-right: 100px">
			<div class="dataTables_paginate paging_simple_numbers"
				id="example2_paginate">
				${classPagingVO.pagingHTML }
			</div>
		</div>
		</div>
	</div>
	
	
	
	<div class="tab-pane <c:if test="${tap eq 'lecture' }">active</c:if>" id="lecture" role="tabpanel">
		<h3 style="margin: 30px;"><strong>교과목</strong></h3>

		<!-- 검색 시작 -->
		<form method="post" id="searchForm3" class="row" style="justify-content: flex-end;">
			<div class="col-md-5"> <!-- col-md-5: 부모 너비 값의 절반 사용 -->
				<div class="form-group">
					<select class="form-control" style="width: 30%; display: inline-block;">
						<option selected="selected" disabled="disabled">======선택======</option> <!-- disabled : 선택안됨(select의 제목?) -->
						<option>제목 +작성자</option>
						<option>제목</option>
						<option>작성자</option>
					</select> 
					<input type="text" placeholder="입력하세요" class="form-control" style="width: 55%; display: inline-block;">
					<button type="button" class="btn btn-primary btn-sm">검색</button>
				</div>
			</div>
			<input type="hidden" name="lecPage" id="lecPage">
			<input type="hidden" name="tap" class="tap" value="lecture">
		</form>
		<!-- 검색 끝 -->
		
		<div class="table-responsive"style="margin: 30px;">
			<table class="table">
				<thead class="bg-primary">
					<tr>
						<th>번호</th>
						<th>학과</th>
						<th>작성일</th>
						<th>조회</th>
						<th>참고사항</th>
					</tr>
				</thead>
				<tbody>
				<c:choose>
					<c:when test="${empty lecPagingVO.dataList }">
				<tr>
					<td colspan="4">조회하실 게시물이 존재하지 않습니다.</td>
				</tr>
			</c:when>
				<c:otherwise>
				<c:set var="lecIndex" value="${lecPagingVO.totalRecord - (lecPagingVO.currentPage -1 ) * lecPagingVO.screenSize }"/>
				<c:forEach items="${lecPagingVO.dataList }" var="lecture">
					<tr>
						<td>${lecIndex}</td>
						<c:set var="lecIndex" value="${lecIndex - 1 }"/>
						<td>${lecture.dprtName }</td>
						<td>${lecture.lecName }</td>
						<td>${lecture.lecPoint }</td> 
						<td style="text-align: center;">
							${lecture.lecNote }
						</td>
						
					</tr> 	
					</c:forEach>
			</c:otherwise>
		</c:choose>
				</tbody>
			</table>
		<div class="col-sm-12 col-md-7" style="float: right; margin-right: 100px">
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
		</div>
	</div>

</div>

<!-- 새 모임 생성 폼 모달 창 시작 -->
							
<div class="modal center-modal fade" id="classForm"
	tabindex="-1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title"> <strong>강의 상세 정보</strong> </h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form action="/DYUniv/lecture/classApplyForm.do" method="post" id="classDetail">
					<div class="row">
						<div class="form-group col-6">
							<label class="form-label">강의 명</label> 
							<input name="className" id="className" 
								type="text" class="form-control" readonly="readonly">
						</div>
						<div class="form-group col-6">
							<label class="form-label">학기</label> 
							<input name="semester" id="semester" 
								type="text" class="form-control" readonly="readonly">
						</div>
						<div class="form-group col-6">
							<label class="form-label">담당 교수</label> 
							<input name="memName" id="memName" 
								type="text" class="form-control" readonly="readonly">
						</div>
						<div class="form-group col-6">
							<label class="form-label">교수 연락처</label> 
							<input name="memPh" id="memPh" 
								type="text" class="form-control" readonly="readonly">
						</div>
						<div class="form-group col-3">
							<label class="form-label">학점</label> 
							<input name="lecPoint" id="lecPoint" 
								type="text" class="form-control" readonly="readonly">
						</div>
						<div class="form-group col-3">
							<label class="form-label">횟수(주차)</label> 
							<input name="classWeekCnt" id="classWeekCnt" 
								type="text" class="form-control" readonly="readonly">
						</div>
						<div class="form-group col-3">
							<label class="form-label">총 강의시간</label> 
							<input name="classTotalTime" id="classTotalTime" 
								type="text" class="form-control" readonly="readonly">
						</div>
						<div class="form-group col-3">
							<label class="form-label">최대수강인원</label> 
							<input name="classMaxMem" id="classMaxMem" 
								type="text" class="form-control" readonly="readonly">
						</div>
						<div class="form-group col-12">
							<label class="form-label">강의 계획서 파일 : </label> 
							<a href="#" id="files" idx="" >강의 계획서 파일</a>
						</div>
					</div>
					<div class="form-group">
						<label class="form-label">사유</label>
						<textarea rows="2" class="form-control" name="classReject" id="classReject" 
								placeholder="반려사유를 입력하세요."></textarea>
					</div>
					<input type="hidden" id="classNo" name="classNo">
					<input type="hidden" id="classStatusCode" name="classStatusCode">
				</form>
			</div>
			<div class="modal-footer modal-footer-uniform">
				<button type="button" class="btn btn-danger" data-bs-dismiss="modal">취소</button>
				<button type="button" class="btn btn-danger-light" id="clTest" >test</button>
				<button type="button" id="clRjBtn" value="clRjBtn"  class="btn btn-danger float-end">반려</button>
				<button type="button" id="clApBtn" value="clApBtn"  class="btn btn-primary float-end">허가</button>
			</div>
		</div>
	</div>
</div>
<!-- 새 모임 생성 폼 모달 창 끝 -->


<script>

var apBtn = $("#clApBtn");
var rejectBtn = $("#clRjBtn");
var classDetail = $("#classDetail");

var pagingArea1 = $("#example1_paginate");
var searchForm1 = $("#searchForm1");
var pagingArea2 = $("#example2_paginate");
var searchForm2 = $("#searchForm2");
var pagingArea3 = $("#example3_paginate");
var searchForm3 = $("#searchForm3");

pagingArea1.on("click", "a", function(event) {
	event.preventDefault(); // a태그의 이벤트를  block
	var pageNo = $(this).data("page");
	
	searchForm1.find("#apPage").val(pageNo);
	searchForm1.submit();
});

pagingArea2.on("click", "a", function(event) {
	event.preventDefault(); // a태그의 이벤트를  block
	var pageNo = $(this).data("page");
	
	searchForm2.find("#classPage").val(pageNo);
	searchForm2.submit();
});

pagingArea3.on("click", "a", function(event) {
	event.preventDefault(); // a태그의 이벤트를  block
	var pageNo = $(this).data("page");
	
	searchForm3.find("#lecPage").val(pageNo);
	searchForm3.submit();
});

apBtn.on("click", function() {
	//CLS003 > 개설 승인 코드
	
	if(confirm("승인 하시겠습니까?")){
		$("#classStatusCode").val("CLS004");
		classDetail.submit();
	}
	
})

rejectBtn.on("click", function () {
	//CLS004 > 개설 반려 코드
	var vrj = $("#classReject").val();
	if(vrj == null || vrj == ""){
		Swal.fire({
			  title: 'error',
			  text: '반려 사유를 입력해주세요',
			  icon: 'warning',
			  confirmButtonText: 'Cool'
			})
		return;
	}
	
	$("#classStatusCode").val("CLS003");
	classDetail.submit();
})

$(function () {
	
	
	
	$(document).on("click", ".classFormBtn", function () {
		var classNo = $(this).attr("idx");
		console.log("idx : " + classNo);
		
		classdata = {
				"classNo" : classNo
		}
		
		$.ajax({
			url: "/DYUniv/lecture/classDetail",
            type: "post",
            data: JSON.stringify(classdata),
            contentType: "application/json; charset=utf-8",
            success: function (res) {
            	console.log("res ",res);
				$("#className").val(res.className);
				$("#semester").val(res.semester);
				$("#memName").val(res.memName);
				$("#memPh").val(res.memPh);
				$("#lecPoint").val(res.lecPoint);
				$("#classWeekCnt").val(res.classWeekCnt);
				$("#classTotalTime").val(res.classTotalTime);
				$("#classMaxMem").val(res.classMaxMem);
				$("#classMaxMem").val(res.classMaxMem);
				$("#classNo").val(classNo);
				$("#files").text(res.fileName).attr("idx", res.fileNo);		//파일
               	$("#classForm").modal("show");
            }
		})
	})
	
	$("#files").on("click", function () {
		fileDownload($(this).attr("idx"),$(this).text());
	})
})

$("#clTest").on("click", function () {
	$("#classReject").val("중복신청된 강의입니다.");
})

</script>



