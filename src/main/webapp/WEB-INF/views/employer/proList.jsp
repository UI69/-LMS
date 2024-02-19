<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

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
	<!-- Content Header (Page header) -->
	<div class="content-header">
		<div class="d-flex align-items-center">
			<div class="me-auto">
				<h3 class="page-title">교수 관리</h3>
				<div class="d-inline-block align-items-center">
					<nav>
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="#"><i
									class="mdi mdi-home-outline"></i></a></li>
							<li class="breadcrumb-item" aria-current="page">수업 및 교직 관리</li>
							<li class="breadcrumb-item active" aria-current="page">교수 관리</li>
						</ol>
					</nav>
				</div>
			</div>
		</div>
	</div>

	<!-- Main content -->
	<section class="invoice printableArea">
		<div class="row">
			<div class="col-12">
				<div class="page-header">
					<h2 class="d-inline">
						<strong class="fs-30">교수 조회</strong>
					</h2>
					<div class="col-12">
						<div class="bb-1 clearFix">
							<div class="text-end pb-15">
								<button class="btn btn-primary" type="button" data-bs-toggle="modal" data-bs-target="#modal-center">
									<span><i class="fa fa-user-circle"></i> 일괄생성</span>
								</button>
								<button id="print2" class="btn btn-primary" type="button" onclick="location.href='/DYUniv/employer/createProIDForm.do'">
									<span><i class="fa fa-user-circle"></i> 개별생성</span>
								</button>
								<br> <br>

								<form id="searchForm" action="" method="get">
									<div class="lookup lookup-circle lookup-right">
										<select id="searchType" name="searchType" class="">
											<option value="memId" <c:if test="${searchType eq 'memId' }">selected</c:if>>번호</option>
											<option value="memName" <c:if test="${searchType eq 'memName' }">selected</c:if>>이름</option>
											<option value="dprtName" <c:if test="${searchType eq 'dprtName' }">selected</c:if>>학과</option>
											<option value="학과" <c:if test="${searchType eq '' }">selected</c:if>>학과3</option>
										</select> 
										<input type="text" id="searchWord" name="searchWord"  value="${searchWord}" placeholder="" >
										<input type="hidden" id="page" name="page" >
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- /.col -->
		</div>
		<div class="row invoice-info">
			<div class="col-md-6 invoice-col">
				<span class="text-primary subTitle">학과 교수 목록</span>
			</div>
			<!-- /.col -->
			<div class="col-md-6 invoice-col text-end">
				<strong>To</strong>
			</div>
		</div>
		<br />
		<div class="row">
			<div class="col-12 table-responsive">
				<table class="table table-bordered">
					<tbody>
						<tr>
						     <th>선택</th>
		                     <th>번호</th>
		                     <th>ID</th>
		                     <th>이름</th>
		                     <th>학과No</th>
		                     <th>전화번호</th>
		                     <th>이메일</th>
		                     <th>성별</th>
						</tr>
							<c:set value="${pagingVO.dataList }" var="proList" />
							<c:choose>
								<c:when test="${empty proList }">
									<tr>
										<td colspan="6">교수 리스트가 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach items="${proList }" var="member">
										<tr>
											<td><!-- <input type="checkbox" name="" checked="checked" /> --></td>
										    <td>${member.memNo }</td>
			                                 <td>${member.memId }</td>
			                                 <td>${member.memName }</td>
			                                 <td>${member.dprtNo }(학과이름)</td>
			                                 <td>${member.memPh }</td>
			                                 <td>${member.memEmail }</td>
			                                 <td>${member.memGen }</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
					</tbody>
				</table>
			</div>
			<!-- /.col -->
		</div>
	
		<div class="row">
			<div class="col-12 text-end">
				<div class="col-sm-12 col-md-6" style="float: right; margin-right: 80px">
					<div class="dataTables_paginate paging_simple_numbers" id="example1_paginate">
						${pagingVO.pagingHTML }
					</div>
				</div>
				<div>
					<p>
						<%-- 총인원 : <span class="text-danger"> ${totalRecord } </span>명 --%>
					</p>
				</div>
			</div>
			<!-- /.col -->
		</div>
	</section>
	<!-- /.content -->
</div>

<!--  -->

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
					enctype="multipart/form-data" method="post" action="/DYUniv/excelUpload.do">
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
    if(confirm("업로드 여부")) {
        const form = $('#excelUploadForm')[0];
        const formData = new FormData(form);
        console.log("file upload")
        $.ajax({
            url : "/DYUniv/excelUpload.do",
            data: formData,
            cache: false,
            contentType: false,
            processData: false,
            success : function(result) {
                if(result=="success") {
                    console.log("data 업로드 성공");
                    alert(result);
                    location.href = "/DYUniv/employer/proList.do";
                    $('#modal-center').modal('hide'); // 모달 창 닫기
                } else {
                    console.log("data 업로드 실패");
                    alert(result);
                }
            },
            error : function(request, status, error) {
                console.log("error");
                alert("code : " + request.status + "\n" + "message : " + request.responseText + "\n" + "error : " + error);    
            },
            type : "POST"
        });
    }
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
