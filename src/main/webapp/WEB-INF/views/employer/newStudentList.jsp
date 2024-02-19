<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.2/dist/sweetalert2.all.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.2/dist/sweetalert2.min.css"
	rel="stylesheet">

<style>
.headerStyle {
	display: flex;
	justify-content: space-between;
}
.subTitle {
	font-size: 20px;
	font-weight: 600;
}
</style>

<div class="container-full">
	<div class="content-header">
		<div class="d-flex align-items-center">
			<div class="me-auto">
				<h3 class="page-title">학생 관리</h3>
				<div class="d-inline-block align-items-center">
					<nav>
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="#"><i
									class="mdi mdi-home-outline"></i></a></li>
							<li class="breadcrumb-item" aria-current="page">회원관리</li>
							<li class="breadcrumb-item active" aria-current="page">학생 관리</li>
						</ol>
					</nav>
				</div>
			</div>
		</div>
	</div>

	<section class="content">
		<div class="row">
			<div class="box">
				<div class="box-header">
					<div class="col-12">
						<div class="clearFix">
							<div class="text-end headerStyle">
								<div class="btnBox">
									<button class="btn btn-primary" type="button"
										data-bs-toggle="modal" data-bs-target="#modal-center">
										<span><i class="fa fa-user-circle"></i> 일괄생성</span>
									</button>
									<button id="print2" class="btn btn-primary" type="button"
										onclick="location.href='/DYUniv/employer/createStuIDForm.do'">
										<span><i class="fa fa-user-circle"></i> 개별생성</span>
									</button>
								</div>
								<form id="searchForm" action="" method="get" style="margin: auto 0;">
									<div class="lookup lookup-circle lookup-right">
										<select id="searchType" name="searchType" class="">
											<option value="memId"
												<c:if test="${searchType eq 'memId' }">selected</c:if>>번호</option>
											<option value="memName"
												<c:if test="${searchType eq 'memName' }">selected</c:if>>이름</option>
											<option value="dprtName"
												<c:if test="${searchType eq 'dprtName' }">selected</c:if>>학과</option>
											<option value="학과"
												<c:if test="${searchType eq '' }">selected</c:if>>학과3</option>
										</select> <input type="text" id="searchWord" name="searchWord"
											value="${searchWord}" placeholder=""> <input
											type="hidden" id="page" name="page">
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
				<div class="box-body">
					<div class="row invoice-info">
						<div class="col-6 invoice-col" style="margin: 0 1.5rem 1.5rem;">
							<span class="text-primary subTitle">신입생 목록</span>
						</div>
						<div class="col-md-6 invoice-col text-end"></div>
					</div>
	
					<div class="row">
						<div class="table-responsive">
							<table class="table table-bordered">
								<thead class="bg-primary">
									<tr>
										<th>번호</th>
										<th>이름</th>
										<th>학번</th>
										<th>전화번호</th>
										<th>이메일</th>
									</tr>
								</thead>
								<tbody>
									<c:set value="${pagingVO.dataList }" var="stdList" />
									<c:forEach items="${stdList }" var="member">
										<c:choose>
											<c:when test="${empty member }">
												<tr>
													<td colspan="6">신입생 리스트가 없습니다.</td>
												</tr>
											</c:when>
											<c:otherwise>
												<tr>
													<!-- <td><input type="checkbox" name="" checked="checked" /></td> -->
													<td>${member.memNo }</td>
													<td>${member.memName }</td>
													<td>${member.memId }</td>
													<td>${member.memPh }</td>
													<td>${member.memEmail }</td>
												</tr>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
					<div class="row">
						<div class="col-12 text-end">
							<div class="col-sm-12 col-md-6"
								style="float: right; margin-right: 80px; height: 55px;">
								<div class="dataTables_paginate paging_simple_numbers"
									id="example1_paginate">${pagingVO.pagingHTML }</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>

<!-- 모달 창 부분  -->
<div class="modal center-modal fade" id="modal-center" tabindex="-1"
	style="display: none;" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title"></h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form id="excelUploadForm" name="excelUploadForm"
					enctype="multipart/form-data" method="post"
					action="/DYUniv/studentUpload.do">
					<div class="upload_file">
						<label for="excelFile">Excel 업로드</label><br /> <input type="file"
							id="excelFile" name="excelFile" />
						<button type="button" onclick="save()">업로드</button>
					</div>
				</form>
			</div>
			<div class="modal-footer modal-footer-uniform">
				<button type="button" class="btn btn-danger" data-bs-dismiss="modal">취소
				</button>
				<!-- 	<button type="button" class="btn btn-primary float-end">확인</button> -->
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
function save() {
	
	Swal.fire({
		  title: "업로드 하시겠습니까?",
		  showDenyButton: true,
		  showCancelButton: true,
		  confirmButtonText: "Save",
		  denyButtonText: `Don't save`
		}).then((result) => {
		  /* Read more about isConfirmed, isDenied below */
		  if (result.isConfirmed) {
			  const form = $('#excelUploadForm')[0];
		        const formData = new FormData(form);
		        console.log("file upload")
		        $.ajax({
		            url : "/DYUniv/studentUpload.do",
		            data: formData,
		            cache: false,
		            contentType: false,
		            processData: false,
		            success : function(result) {
		                if(result=="success") {
		                    console.log("data 업로드 성공");
		                    
		                    Swal.fire({             // 비동기라서 
		                    	  title: "저장 성공",
								  icon: 'success',
		                    	  confirmButtonText: "OK",
		                    	}).then((result) => {
		                    	  if (result.isConfirmed) {		
		                             location.href = "/DYUniv/employer/stuList.do";
		                    	  }
		                    	});                    
		                } else {
		                    console.log("data 업로드 실패");
							Swal.fire({
		  							icon: "error",
		  							title: "failed",
		  							text: "Upload 실패 ",
							});
		                }
		            },
		            error : function(request, status, error) {
		                console.log("error");
		            },
		            type : "POST"
		        });
		  } else if (result.isDenied) {
		  	return;
		  }
	});
}
$(function() {
	// 순번매기기
	var pagingArea = $("#example1_paginate");
	var searchForm = $("#searchForm");
	/* var newBtn = $("#newBtn"); */ 

	pagingArea.on("click", "a", function(event) {
		event.preventDefault(); // a태그의 이벤트를  block
		var pageNo = $(this).data("page");
		
		searchForm.find("#page").val(pageNo);
		console.log("pageNo"+pageNo);
		searchForm.submit(); 
		
	});
	
});
</script>







