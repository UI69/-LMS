<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <div class="container-full">
   <section class="content">  
   <div class="content-header">
		<div class="d-flex align-items-center">
			<div class="me-auto">
				<h3 class="page-title">시설 예약</h3><br/>
				<div class="d-inline-block align-items-center">
					<nav>
						<ol class="breadcrumb">
							<li class="breadcrumb-item">
								<a href="#"><i class="mdi mdi-home-outline"></i></a>
							</li>
							<li class="breadcrumb-item" aria-current="page">학교 시설 이용</li>
							<li class="breadcrumb-item active" aria-current="page">시설 예약 목록</li>
						</ol>
					</nav>
				</div>
			</div>
		</div>
	</div>   
	<div class="col-lg-15">
		<div class="box">
			<div class="box-body">
				<h4 class="box-title">시설예약 목록</h4>
				<h6 class="box-subtitle mb-20"></h6>
				<form action="" id="searchForm" method="get">
				<div class="lookup lookup-circle lookup-right">
					<input type="hidden" id="page" name="page" >
				</div>
				</form>
				<div class="table-responsive">
					<table class="table">
						<thead class="bg-primary">
							<tr>
								<th>번호</th>
								<th>건물</th>
								<th>시설</th>
								<th>신청일</th>
								<th>예약일시</th>
								<th>상태</th>
								<th>-</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${pagingVO.dataList }" var="list" varStatus="status">						
								<tr>
									<td>${status.count }</td>
									<td>${list.buildingVO.buildingName }</td>
									<td>${list.facilityVO.facName }</td>
									<td>${list.facRegDate }</td>
									<td>
										<span>${list.facRsvStartDate }</span> ~ 
										<span>${list.facRsvEndDate }</span>
									</td>
									<c:if test="${list.facRentStatusStr eq '승인'}">
										<td>
											${list.facRentStatusStr }
										</td>
										<td>
											-
										</td>
									</c:if>
									<c:if test="${list.facRentStatusStr eq '신청'}">
										<td>
											${list.facRentStatusStr }
										</td>
										<td>
											<button class="btn btn-primary btn-outline btn-sm rentCancle" idx="${list.facRentNo }">취소</button>
										</td>
										
									</c:if>
									<c:if test="${list.facRentStatusStr eq '반려'}">
										<td>
											${list.facRentStatusStr }
										</td>
										<td>
											${list.facReject }
										</td>
									</c:if>
									<c:if test="${list.facRentStatusStr eq '취소'}">
										<td>
											${list.facRentStatusStr }
										</td>
										<td>
											-
										</td>
									</c:if>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</section>
</div>
<!--  -->		
<div class="col-sm-12 col-md-6" style="float: right; margin-right: 80px">
	<div class="dataTables_paginate paging_simple_numbers" id="example1_paginate">
		${pagingVO.pagingHTML }
	</div>
</div>
<!--  -->	



<!-- 모달 창  -->
<div class="modal center-modal fade" id="modal-center" tabindex="-1" style="display: none;" aria-hidden="true">
  <div class="modal-dialog">
	<div class="modal-content">
	  <div class="modal-header">
		<h5 class="modal-title"></h5>
		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	  </div>
	  <div class="modal-body">
		<form class="form">
			<div class="box-body">
				<h4 class="box-title text-info mb-0"><i class="ti-user me-15"></i> 예약현황 </h4>
				<hr class="my-15">

				<h4 class="box-title text-info mb-0 mt-20"><i class="ti-envelope me-15"></i>반려 사유</h4>
			<hr class="my-15">
			<div class="form-group">
				  <label class="form-label">반려 사유 :</label>
				  <textarea rows="4" class="form-control" placeholder=""></textarea>
				</div>
			</div>
			</form>
		 </div>
	  <div class="modal-footer modal-footer-uniform">
		<button type="button" class="btn btn-danger" data-bs-dismiss="modal">취소 </button>
		<button type="button" class="btn btn-primary float-end">확인</button>
	  </div>
	</div>
  </div>
</div>

<form action="/DYUniv/facility/facilityRentCancle.do" method="post" id="rentCancleForm">
	<input type="hidden" name="rentCancleNo" id="rentCancleNo">
</form>

<script>
$(function(){
	var pagingArea = $("#example1_paginate");
	var searchForm = $("#searchForm");
	
	$(".rentCancle").on("click", function () {
		console.log($(this).attr("idx"));
		var facRentNo = $(this).attr("idx");
		
		if(confirm("취소 하시겠습니까?")){
			$("#rentCancleNo").val(facRentNo);
			$("#rentCancleForm").submit();
		}
		
	})
	
	pagingArea.on("click", "a", function(event) {
		event.preventDefault(); // a태그의 이벤트를  block
		var pageNo = $(this).data("page");
		
		searchForm.find("#page").val(pageNo);
		console.log("pageNo"+pageNo);
		searchForm.submit();
		
	});
	
	
	
	
	
	
})
</script>