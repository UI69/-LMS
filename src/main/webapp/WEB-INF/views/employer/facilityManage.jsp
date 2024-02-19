<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="sec"%>

<div class="content-header mb-10">
	<div class="d-flex align-items-center">
		<div class="me-auto">
			<h3 class="page-title">시설 예약 목록</h3>
			<div class="d-inline-block align-items-center">
				<nav>
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="#"><i
								class="mdi mdi-home-outline"></i></a></li>
						<li class="breadcrumb-item" aria-current="page">기타</li>
						<li class="breadcrumb-item" aria-current="page">시설 예약 목록</li>
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
				<div class="box-body">
					<div class="p-15">
						<form id="searchForm">
							<div class="row" style="justify-content: space-between;">
								<%-- <div class="col-md-4">
									<div class="form-group" style="margin-top: 10px">
										<label class="form-label" style="margin-right: 10px;">건물
											목록</label> <select class="form-control" 
											style="width: 30%; display: inline-block;">
											<option selected="selected">전체</option>
											<c:forEach items="${buildingDataList }" var="buildingVO">
												<option value="${buildingVO.buildingName }">${buildingVO.buildingName }</option>
											</c:forEach>
										</select>
									</div>
								</div> --%>
								<div class="col-md-4">
									<div class="form-group" style="margin-top: 10px">
										<input type="hidden" name="page" id="page" /> <select
											class="form-control" name="searchType"
											style="width: 30%; display: inline-block;">
											<option selected="selected">전체</option>
											<option value="facRsvStartDate">예약시작일</option>
											<option value="buildingName">건물명</option>
											<option value="facName">시설명</option>
											<option value="memName">예약자명</option>
										</select> <input type="text" name="searchWord" value="${searchWord }"
											class="form-control"
											style="width: 50%; display: inline-block;" placeholder="검색">
										<button type="submit" value="" class="btn btn-primary"
											style="padding: 5px 12px;">검색</button>
									</div>
								</div>
							</div>
						</form>
						<div class="table-responsive">
							<table class="table mb-0" style="text-align: center">
								<thead class="bg-primary">
									<tr>
										<th scope="col">순번</th>
										<th scope="col">신청일</th>
										<th scope="col">건물</th>
										<th scope="col">시설</th>
										<th scope="col">예약일</th>
										<th scope="col">예약자</th>
										<th scope="col">신청상태</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${empty pagingVO.dataList }">
											<tr>
												<td colspan="7">조회하신 게시글이 존재하지 않습니다.</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:set var="index" value="${pagingVO.startRow + 1}" />
											<c:set var="index" value="${index - 1}" />
											<c:forEach items="${pagingVO.dataList }" var="facilityRentVO">
												<tr>
													<td class="index"><strong>${index }</strong></td>
													<td>${facilityRentVO.facRegDate }</td>
													<td>${facilityRentVO.buildingVO.buildingName }</td>
													<td>${facilityRentVO.facilityVO.facName }</td>
													<td>${facilityRentVO.facRsvStartDate }~ <br>${facilityRentVO.facRsvEndDate }</td>
													<td>${facilityRentVO.memberVO.memRoleStr } /
														${facilityRentVO.memberVO.memName }</td>
													<c:choose>
														<c:when test="${facilityRentVO.facRentStatusStr eq '신청' }">
															<td>
																<button class="btn btn-primary btn-rounded btn-sm replyBtn" data-bs-toggle="modal" data-bs-target="#replyWaiting">${facilityRentVO.facRentStatusStr }</button>
																<input type="hidden" class="facRentNo" value="${facilityRentVO.facRentNo }">
															</td>
														</c:when>
														<c:otherwise>
															<td>${facilityRentVO.facRentStatusStr }</td>
														</c:otherwise>
													</c:choose>
												</tr>
												<c:set var="index" value="${index + 1}" />
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
						</div>
						<div class="col-sm-12 col-md-6"
							style="float: right; margin-right: 80px; margin-top: 20px;">
							<div class="dataTables_paginate paging_simple_numbers"
								id="pagination">${pagingVO.pagingHTML }</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 신청 버튼() 모달 -->
	<div class="modal center-modal fade" id="replyWaiting" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">
							<strong>시설 예약 신청 응답</strong>
						</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form id="replyForm" method="post" action="/DYUniv/updateFacilityResvStatus.do" >
							<input type="hidden" name="facRentNo" value="">
							<div style="display: flex; justify-content: space-around; padding: 20px;" id="radioBox">
								<div>
									<input name="facRentStatusCode" type="radio" id="approve"
										class="radio-col-primary" value="FAC002"/> <label for="approve"
										style="font-weight: bold; font-size: 16px;"
										class="text-primary">승인</label>
								</div>
								<div>
									<input name="facRentStatusCode" type="radio" id="reject"
										class="radio-col-danger" value="FAC003"/> <label for="reject"
										style="font-weight: bold; font-size: 16px;" class="text-danger">반려</label>
								</div>
							</div>
							<div class="form-group" style="padding: 10px 17px 0; display: none" id="rejectReason">
								<label class="form-label"><strong>반려 사유 작성</strong></label>
								<textarea rows="3" class="form-control non-resizable-textarea"
								name="facReject" id="rejectReasonText" placeholder="최대 45자 이하로 입력하세요." maxlength="45" ></textarea>
							</div>
						</form>
					</div>
					<div class="modal-footer modal-footer-uniform">
						<button type="button" class="btn btn-danger"
							data-bs-dismiss="modal">취소</button>
						<span id="msg" style="display: none; font-size: 10px; color: #4d7bc9;">완료 전 선택하십시오.</span>
						<span id="rejectMsg" style="display: none; font-size: 10px; color: #4d7bc9;">반려 선택 시 반려 사유를 작성하세요.</span>
						<button type="button" class="btn btn-primary float-end" id="submitBtn">완료</button>
					</div>
				</div>
			</div>
		</div>
</section>
<script type="text/javascript">
	$(function() {
		var pagingArea = $("#pagination");
		var searchForm = $("#searchForm");
		var reject = $("#reject");
		var rejectReasonText = $("#rejectReasonText");
		var approve = $("#approve");
		var msg = $("#msg");
		var rejectMsg = $("#rejectMsg");

		pagingArea.on("click", "a", function(event) {
			event.preventDefault();
			var pageNo = $(this).data("page");

			searchForm.find("#page").val(pageNo);
			searchForm.submit();
		});
		
		 $(".replyBtn").on("click", function() {
	        var row = $(this).closest("tr");
	        var facRentNo = row.find(".facRentNo").val();

	        $("#replyWaiting").find("input[name='facRentNo']").val(facRentNo);

	        $("#replyWaiting").modal('show');
	    });

		
		reject.on("click", function(){
			$("#rejectReason").css("display", "block");
		});
		
		$("#submitBtn").on("click", function(){
			if(reject.prop("checked") && rejectReasonText.val() == ""){
				 // 거절 시 이유를 작성하지 않은 경우
				rejectReasonText.focus();
				rejectMsg.css("display", "inline-block");
				setTimeout(function() {
					rejectMsg.css("display", "none");
		        }, 5000);
			} else if(!$("input[name='facRentStatusCode']:checked").val()) {
				// 선택된 값이 없는 경우
				msg.css("display", "inline-block");
				setTimeout(function() {
		            msg.css("display", "none");
		        }, 5000);
			} else {
				// 정상적으로 데이터를 입력한 경우
				$("#replyForm").submit();
				$("#replyWaiting").modal('hide');
			}
		});
	});
</script>