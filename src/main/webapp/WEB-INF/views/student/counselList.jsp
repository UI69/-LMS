<!-- 학생 상담 예약 내역 목록 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<style>
td, th {
	text-align: center;
}
</style>

<div class="content-header">
	<div class="d-flex align-items-center">
		<div class="me-auto">
			<h3 class="page-title">상담 예약 목록</h3>
			<div class="d-inline-block align-items-center">
				<nav>
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="#"><i
								class="mdi mdi-home-outline"></i></a></li>
						<li class="breadcrumb-item" aria-current="page">기타</li>
						<li class="breadcrumb-item active" aria-current="page">상담</li>
						<li class="breadcrumb-item active" aria-current="page">상담 예약
							목록</li>
					</ol>
				</nav>
			</div>
		</div>
	</div>
</div>

<section class="content m-10">
	<div class="box">
		<div class="box-body" style="height: 650px; overflow: hidden;">
			<div class="table-responsive">
				<div id="complex_header_wrapper"
					class="dataTables_wrapper container-fluid dt-bootstrap4">
					<div class="row">
						<div class="col-sm-12 col-md-6">
							<div class="col-4">
								<a class="btn btn-primary-light" href="/DYUniv/counsel/counselReserve.do"> 상담 예약 신청 >> </a>
							</div>
							<div class="dataTables_length" id="complex_header_length"></div>
						</div>
						<div class="col-sm-12 col-md-6">
							<div id="complex_header_filter" class="dataTables_filter col-8">
								<label>Search: <input type="search"
									class="form-control form-control-sm" placeholder=""
									aria-controls="complex_header">
								</label>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12">
							<div class="table-responsive">
								<table class="table">
									<thead class="bg-primary">
										<tr>
											<th>순번</th>
											<th>담당자</th>
											<th>신청일</th>
											<th>예약일</th>
											<th>예약 시간</th>
											<th>타입</th>
											<th>상담</th>
										</tr>
									</thead>
									<tbody>
										<c:choose>
											<c:when test="${empty counselList }">
												<tr>
													<td colspan="7" style="text-align: left;">예약된 상담 일정이 없습니다.</td>
												</tr>
											</c:when>
											<c:otherwise>
												<c:set var="cnt" value="1" />
												<c:forEach items="${counselList }" var="counsel">
													<tr
														<c:if test="${counsel.cnslNo eq '14' }">class="bg-primary-light ${counsel.cnslNo }"</c:if>
													>
														<td><strong>${cnt }</strong>
														<c:set var="cnt" value="${cnt+1 }" /></td>
														<td>${counsel.memName1 }</td>
														<td id="regDate">${fn:substring(counsel.cnslRegDate, 0, 10) }</td>
														<td class="cnslDate">${fn:substring(counsel.cnslStartDate, 0, 10) }</td>
														
														<td>${fn:substring(counsel.cnslStartDate, 11, 16) }~
															${fn:substring(counsel.cnslEndDate, 11, 16) }</td>
														<td><c:if test="${counsel.cnslType == 'CNT001' }">대면</c:if>
															<c:if test="${counsel.cnslType == 'CNT002' }">비대면(화상)</c:if>
															<c:if test="${counsel.cnslType == 'CNT003' }">비대면(채팅)</c:if>
														</td>
														<td>
															<c:if test="${counsel.cnslType == 'CNT002' }">
																<button class="btn btn-primary chatBtn" data-cnslNo="${counsel.cnslNo}" data-cnslType="${counsel.cnslType}">
																	<i class="fa fa-fw fa-camera ">&nbsp;</i>화상 >>
																</button>
															</c:if> <c:if test="${counsel.cnslType == 'CNT003' }">
																<button class="btn btn-primary chatBtn" data-cnslNo="${counsel.cnslNo}" data-cnslType="${counsel.cnslType}">
																	<i class="fa fa-fw fa-wechat">&nbsp;</i>채팅 >>
																</button>
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
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<script>
// 예약일이 지난 상담 채팅방 입장 금지
$(".chatBtn").on("click", function(){
    var counselNo = this.dataset.cnslno;
	var cnslType = this.dataset.cnsltype;
	//alert(counselNo);
	var regDateStr = $(this).parent().parent().find(".cnslDate").html();
	var regDate = new Date(regDateStr);
	
	console.log("regDate : ", regDateStr,",", regDate); // 2024-01-09
	
	var currentDate = new Date();
    currentDate.setHours(0, 0, 0, 0);
    
    if (regDate < currentDate) {
    	alert("이미 지난 예약입니다.");
    	return;
    }
	
	if(cnslType == "CNT002"){
    	f_videoCounsel(counselNo);
	}else{
    	f_inCounsel(counselNo);
	}
});

// 일반 채팅 입장
function f_inCounsel(counselNo) {
	console.log(counselNo);
	location.href = "/DYUniv/counsel/csRoom/"+counselNo;
}

// 화상 채팅 입장
function f_videoCounsel(counselNo){
	location.href = "/DYUniv/counsel/vsRoom/"+counselNo;
} 
</script>