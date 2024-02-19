<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<style>
	.demo-checkbox label {
		min-width: 60px !important;
	}

</style>
<div class="container-full">
	<!-- Content Header (Page header) -->
	<div class="content-header">
		<div class="d-flex align-items-center">
			<div class="me-auto">
				<h3 class="page-title">내 모임</h3>
				<div class="d-inline-block align-items-center">
					<nav>
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="#"><i
									class="mdi mdi-home-outline"></i></a></li>
							<li class="breadcrumb-item" aria-current="page">모임</li>
							<li class="breadcrumb-item active" aria-current="page">내 모임
							</li>
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
				<div class="box" style="max-height: 47rem;">
					<div class="box-body">
						<!-- Nav tabs -->
						<ul class="nav nav-tabs customtab2" role="tablist">
							<li class="nav-item"><a class="nav-link active" data-bs-toggle="tab" href="#myCommunityApplyList" role="tab">
								<span class="hidden-sm-up"><i class="ion-home"></i></span> 
								<span class="hidden-xs-down">가입된 모임 목록</span></a>
							</li>
							<!-- <li class="nav-item"><a class="nav-link" data-bs-toggle="tab" href="#myCommunityList" role="tab">
								<span class="hidden-sm-up"><i class="ion-email"></i></span> 
								<span class="hidden-xs-down">내가 생성한 모임</span></a>
							</li> -->
						</ul>
						<!-- Tab panes -->
						<div class="tab-content">
							<!-- 가입된 모임 목록 -->
							<div class="tab-pane active" id="myCommunityApplyList" role="tabpanel">
								<div class="p-15">
									<div class="row" style="justify-content: space-between">
										<div class="col-md-6">
											<div class="form-group" style="margin-top: 10px">
												<h4 style="display: inline-block">가입한 모임</h4>
												<p
													style="display: inline-block; line-height: 1.2; color: #0d6efd;">
													총 <span>${fn:length(pagingVO.dataList) }</span>개
												</p>
											</div>
										</div>
										<div class="col-md-4 col-12" style="margin-top: 5px">
											<div class="form-group">
												<select class="form-control"
													style="width: 30%; display: inline-block">
													<option selected="selected">모임분류</option>
													<option>모임명</option>
													<option>마스터</option>
												</select> <input type="text" placeholder="입력하세요" class="form-control"
													style="width: 50%; display: inline-block" />
												<button type="button" class="btn btn-primary"
													style="padding: 5px 12px">검색</button>
											</div>
										</div>
									</div>
									<div class="table-responsive">
										<table class="table mb-0" style="text-align: center">
											<thead class="bg-primary">
												<tr>
													<th scope="col">순번</th>
													<th scope="col">모임분류</th>
													<th scope="col" class="text-start">모임명</th>
													<th scope="col" class="text-start">모임목표</th>
													<th scope="col">마스터</th>
													<!-- <th scope="col">인원</th> -->
													<th scope="col">관리</th>
												</tr>
											</thead>
											<tbody>
												<c:choose>
													<c:when test="${empty pagingVO.dataList }">
														<tr>
															<th colspan="7">가입 목록이 없습니다...</th>
														</tr>
													</c:when>
													<c:otherwise>
														<c:set var="cmIndex" value="${pagingVO.totalRecord - (pagingVO.currentPage -1 ) * pagingVO.screenSize }"/>
														<c:forEach items="${pagingVO.dataList }" var="cmApList">
															<tr>
																<td><strong>${cmIndex }</strong></td>
																<c:set var="cmIndex" value="${cmIndex -1 }"/>
																<td>
																	<c:if test="${cmApList.cmType eq 'CMT001' }">학업</c:if>
																	<c:if test="${cmApList.cmType eq 'CMT002' }">외국어</c:if>
																	<c:if test="${cmApList.cmType eq 'CMT003' }">봉사</c:if>
																	<c:if test="${cmApList.cmType eq 'CMT004' }">예체능</c:if>
																	<c:if test="${cmApList.cmType eq 'CMT005' }">여가</c:if>
																	<c:if test="${cmApList.cmType eq 'CMT006' }">종교</c:if>
																	<c:if test="${cmApList.cmType eq 'CMT007' }">기타</c:if>
																</td>                                            
																<td class="text-start"><a href="/DYUniv/student/community/${cmApList.cmNo }"> ${cmApList.cmName }</a></td>
																<td class="text-start">${cmApList.cmGoal }</td>
																<td>${cmApList.cmMaster }</td>
																<%-- <td><span>${cmApList.cmCount+1 }</span>/<span>${cmApList.cmMaxMem }</span></td> --%>
																<td>
																	<button type="button" class="btn btn-rounded btn-warning-light mb-5 cmLeave"
																		style="font-size: 12px" idx="${cmApList.cmNo }">탈퇴</button>
																</td>
															</tr>
														</c:forEach>
													</c:otherwise>
												</c:choose>
											</tbody>
										</table>
									</div>
								</div>
								<div class="col-sm-12 col-md-7" style="float: right; margin-right: 80px">
									<div class="dataTables_paginate paging_simple_numbers"
										id="example1_paginate">
										${pagingVO.pagingHTML }
									</div>
								</div>
							</div>
							
							<!-- 생성한 모임 목록 -->
							<%-- <div class="tab-pane" id="myCommunityList" role="tabpanel">
								<div class="p-15">
									<div class="row" style="justify-content: space-between">
										<div class="col-md-6">
											<div class="form-group" style="margin-top: 10px">
												<h4 style="display: inline-block">생성한 모임</h4>
												<p
													style="display: inline-block; line-height: 1.2; color: #0d6efd;">
													총 <span>3</span>개
												</p>
											</div>
										</div>
										<div class="col-md-4 col-12" style="margin-top: 5px">
											<div class="form-group">
												<select class="form-control"
													style="width: 30%; display: inline-block">
													<option selected="selected">모임분류</option>
													<option>모임명</option>
													<option>마스터</option>
												</select> <input type="text" placeholder="입력하세요" class="form-control"
													style="width: 50%; display: inline-block" />
												<button type="button" class="btn btn-primary"
													style="padding: 5px 12px">검색</button>
											</div>
										</div>
									</div>
									<div class="table-responsive">
										<table class="table mb-0" style="text-align: center">
											<thead class="bg-primary">
												<tr>
													<th scope="col">순번</th>
													<th scope="col">모임분류</th>
													<th scope="col">모임명</th>
													<th scope="col">모임목표</th>
													<th scope="col">인원</th>
													<th scope="col">관리</th>
												</tr>
											</thead>
											<tbody>
												
												<c:choose>
													<c:when test="${empty myCommunityList }">
														<tr>
															<th colspan="6">가입 목록이 없습니다...</th>
														</tr>
													</c:when>
													<c:otherwise>
														<c:forEach items="${myCommunityList }" var="myCmList">
															<tr>
																<td><strong>1</strong></td>
																<td>
																	<c:if test="${myCmList.cmType eq 'CMT001' }">종교</c:if>
																	<c:if test="${myCmList.cmType eq 'CMT002' }">봉사</c:if>
																	<c:if test="${myCmList.cmType eq 'CMT003' }">예체능</c:if>
																	<c:if test="${myCmList.cmType eq 'CMT004' }">외국어</c:if>
																	<c:if test="${myCmList.cmType eq 'CMT005' }">과학</c:if>
																	<c:if test="${myCmList.cmType eq 'CMT006' }">문학</c:if>
																</td>
																<td class="text-start"><a href="/DYUniv/student/community/${myCmList.cmNo }"> ${myCmList.cmName }</a></td>
																<td>${myCmList.cmGoal }</td>
																<td><span>2(신청인원)</span>/<span>${myCmList.cmMaxMem }</span></td>
																<td><span>${myCmList.cmCount+1 }</span>/<span>${myCmList.cmMaxMem }</span></td>
																<td>
																	<c:if test="${myCmList.cmOpenStatusCode eq 'CMO002' }">
																		<button type="button" class="btn btn-rounded btn-warning-light mb-5 cmClose"
																		style="font-size: 12px" idx="${myCmList.cmNo }">그룹 폐쇄</button>
																	</c:if>
																	<c:if test="${myCmList.cmOpenStatusCode eq 'CMO003' }">
																		<button type="button" class="btn btn-rounded btn-secondary mb-5 "
																		style="font-size: 12px" disabled="disabled">폐쇄</button>
																	</c:if>
																</td>
															</tr>
														</c:forEach>
													</c:otherwise>
												</c:choose>
												
											</tbody>
										</table>
									</div>
								</div>
								<div class="col-sm-12 col-md-7"
									style="float: right; margin-right: 80px">
									<div class="dataTables_paginate paging_simple_numbers"
										id="example1_paginate">
										<ul class="pagination">
											<li class="paginate_button page-item previous disabled"
												id="example1_previous"><a href="#"
												aria-controls="example1" data-dt-idx="0" tabindex="0"
												class="page-link">Previous</a></li>
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
											<li class="paginate_button page-item next" id="example1_next">
												<a href="#" aria-controls="example1" data-dt-idx="6"
												tabindex="0" class="page-link">Next</a>
											</li>
										</ul>
									</div>
								</div>
							</div> --%>
							
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>

<script>

$(function () {

	var cmLeave = $(".cmLeave");	// 그룹 탈퇴
	var cmClose = $(".cmClose");	// 그룹 폐쇄
	
	cmClose.on("click", function () {
		var cmNo = $(this).attr("idx");
		console.log(cmNo);
		
		if(confirm("정말 폐쇄하시겠습니까?")){
			var cmap = {
					"cmNo" : cmNo
			}
			
			//폐쇄용 ajax
			$.ajax({
				url: "/DYUniv/commuStatus",
  	            type: "post",
  	            data: JSON.stringify(cmap),
  	            contentType: "application/json; charset=utf-8",
  	            success: function (res) {
  	            	console.log("res ",res);
  	            	if(res > 0){
  	            		alert("탈퇴하였습니다.");
  	            		location.href = "/DYUniv/student/myCommunity.do";
  	            	} else {
  	            		alert("탈퇴에 실패하였습니다.");
  	            	}
  	            }
			})
		}
	})
	
	cmLeave.on("click", function () {
		var cmNo = $(this).attr("idx");
		console.log(cmNo);
		
		if(confirm("정말 탈퇴하시겠습니까?")){
			
			var cmap = {
					cmNo : cmNo
			}
			
			//탈퇴용 ajax
			$.ajax({
				url: "/DYUniv/student/leaveCommunityForm.do",
  	            type: "post",
  	            data: JSON.stringify(cmap),
  	            contentType: "application/json; charset=utf-8",
  	            success: function (res) {
  	            	console.log("res ",res);
  	            	if(res == "OK"){
  	            		alert("탈퇴하였습니다.");
  	            		location.href = "/DYUniv/student/myCommunity.do";
  	            	} else {
  	            		alert("탈퇴에 실패하였습니다.");
  	            	}
  	            }
			})
		}
	})
})

</script>
