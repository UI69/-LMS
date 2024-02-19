<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js" ></script>

<style>

th {
	text-align: center;
}

tr {
	font-size: 12px;
}

.table > tbody > tr > td {
	padding: 0.7rem;
}

.classMember {
	font-size: 16px;
	font-weight: 600;
	background-color: #ff99200d !important;
}
</style>

<!-- 수강신청 기간이 아닌 경우 뜨는 alert창 시작 -->
<c:if test="">
<script type="text/javascript">
	
</script>
</c:if>
<!-- 수강신청 기간이 아닌 경우 뜨는 alert창 끝 -->


<div class="container-full">
	<!-- Content Header (Page header) -->
	<div class="content-header">
		<div class="d-flex align-items-center">
			<div class="me-auto">
				<h3 class="page-title">수강신청</h3>
				<div class="d-inline-block align-items-center">
					<nav>
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="#"><i
									class="mdi mdi-home-outline"></i></a></li>
							<li class="breadcrumb-item" aria-current="page">수강</li>
							<li class="breadcrumb-item active" aria-current="page">수강신청</li>
						</ol>
					</nav>
				</div>
			</div>

		</div>
	</div>
	
	<!-- Main content -->
	<section class="content">
		<div class="row">
<!-- 		<ul class="nav nav-tabs" role="tablist">
			<li class="nav-item">
				<a class="nav-link active" data-bs-toggle="tab" href="#lectureList" role="tab" aria-selected="true">
					<span class="hidden-sm-up"><i class="fa fa-cc"></i></span> 
					<span class="hidden-xs-down">강의 목록</span>
				</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" data-bs-toggle="tab" href="#reserveList" role="tab" aria-selected="false">
					<span class="hidden-sm-up"><i class="fa fa-paypal"></i></span> 
					<span class="hidden-xs-down">예비 신청 강의목록 </span>
				</a>
			</li>
		</ul>
		<div class="tab-content tabcontent-border bg-white">
			<div class="tab-pane active" id="lectureList" role="tabpanel"> -->
			<!-- 수강가능 강의목록 시작 -->
			<div class="col-12">
				<div class="box" style="min-height: 660px; max-height: 660px;">
					<div class="box-body">
						<!-- 검색 시작 -->
						<form id="searchForm" method="post" class="row" style="justify-content: space-between;">
							<input type="hidden" name="page" id="page">
							<div class="row col-md-6">
								<div class="col-md-4 col-12">
									<div class="form-group">
										<label class="form-label">이수구분</label> <select
											class="form-control select2" style="width: 100%;">
											<option selected="selected">전체 목록</option>
											<option>전공 필수</option>
											<option>전공 선택</option>
											<option>교양 필수</option>
											<option>교양 선택</option>
										</select>
									</div>
								</div>
								<div class="col-md-4 col-12">
									<div class="form-group">
										<label class="form-label">대학 분류</label> <select
											class="form-control select2" style="width: 100%;">
											<option selected="selected">전체 목록</option>
											<option value="DPC001">인문</option>
											<option value="DPC002">사회</option>
											<option value="DPC003">교육</option>
											<option value="DPC004">공학</option>
											<option value="DPC005">자연</option>
											<option value="DPC006">의약</option>
											<option value="DPC007">예체능</option>
										</select>
									</div>
								</div>
								<div class="col-md-4 col-12">
									<div class="form-group">
										<label class="form-label">학과</label> <select
											class="form-control select2" style="width: 100%;">
											<option selected="selected">학과 전체</option>
											<option>경영학과</option>
											<option>경영학과</option>
											<option>경영학과</option>
										</select>
									</div>
								</div>
							</div>
							<div class="col-md-5">
								<div class="col-12">
									<div class="form-group">
										<label class="form-label" style="display: block;">검색어</label>
										<select class="form-control"
											style="width: 30%; display: inline-block;">
											<option selected="selected" disabled="disabled">분류</option>
											<option>학과</option>
											<option>과목명</option>
											<option>담당교수</option>
										</select> <input type="text" placeholder="입력하세요" class="form-control"
											style="width: 40%; display: inline-block;">
										<button type="button" class="btn btn-primary btn-sm">조회</button>
									</div>
								</div>
							</div>
						</form>
						<!-- 검색 끝 -->
						<div class="table-responsive">
							<table id="example1"
								class="table table-bordered b-1 border-primary">
								<thead class="bg-primary">
									<tr>
										<th>번호</th>
										<th>신청</th>
										<th>신청인원 / 정원</th>
										<th>대학</th>
										<th>학과</th>
										<th width="35%">과목명</th>
										<th>이수구분</th>
										<th>학점</th>
										<th>교수</th>
										<th>강의계획서</th>
									</tr>
								</thead>
								<tbody id="classList">
									<c:set var="index" value="${pagingVO.totalRecord - (pagingVO.currentPage -1 ) * pagingVO.screenSize }"/>
									<c:choose>
										<c:when test="${empty pagingVO.dataList }">
											목록이 없습니다...
										</c:when>
										<c:otherwise>
											<c:set var="index" value="${pagingVO.startRow + 1}" />
											<c:set var="index" value="${index - 1}" />
											<c:forEach items="${pagingVO.dataList }" var="clazz">
											
												<c:set var="listeningCheck" value="false"/>
												
												<c:forEach items="${reserveClassList }" var="rvClass">
													<c:if test="${clazz.classNo eq rvClass.classNo }">
														<c:set var="listeningCheck" value="true"/>
													</c:if>
												</c:forEach>
											
												<tr class="listener">
													<td style="text-align: center;">
													<strong>${index }</strong></td>
													<td style="text-align: center;">
														<c:if test="${listeningCheck ne 'true' }">
															<button type="button" class="waves-effect waves-light btn btn-rounded btn-primary-light clsApBtn m-0"
															style="font-size: 12px;" onclick="f_addReservClass(${clazz.classNo })">신청</button>
														</c:if>
													</td>
													<td class="text-end classMember " idx="${clazz.classNo }">
														<span class="text-success">${clazz.totalListener }</span>
														<span> / ${clazz.classMaxMem }</span>
													</td>
													<td>
														<c:if test="${clazz.dprtCategory eq 'DPC001' }">인문</c:if>
														<c:if test="${clazz.dprtCategory eq 'DPC002' }">사회</c:if>
														<c:if test="${clazz.dprtCategory eq 'DPC003' }">교육</c:if>
														<c:if test="${clazz.dprtCategory eq 'DPC004' }">공학</c:if>
														<c:if test="${clazz.dprtCategory eq 'DPC005' }">자연</c:if>
														<c:if test="${clazz.dprtCategory eq 'DPC006' }">의약</c:if>
														<c:if test="${clazz.dprtCategory eq 'DPC007' }">예체능</c:if>
													</td>
													<td>${clazz.dprtName }</td>
													<td>${clazz.className }</td>
													<td>
														<c:if test="${clazz.classReqCode eq 'CLR001' }">전공필수</c:if>
														<c:if test="${clazz.classReqCode eq 'CLR002' }">전공선택</c:if>
														<c:if test="${clazz.classReqCode eq 'CLR003' }">교양필수</c:if>
														<c:if test="${clazz.classReqCode eq 'CLR004' }">교양선택</c:if>
													</td>
													<td class="text-end">${clazz.lecPoint }</td>
													<td>${clazz.memName }</td>
													<td style="text-align: center;">
														<button type="button" idx="${clazz.fileNo }" idn="${clazz.fileName }"
															class="btn btn-circle btn-xs btn-primary classFileBtn">
															<i class="fa fa-folder-open" style="color: white"></i>
														</button>
													</td>
												</tr>
												<c:set var="index" value="${index + 1}" />
											</c:forEach>
										</c:otherwise>
									</c:choose>
									
									
								</tbody>
							</table>
						</div>
						
						<div class="col-sm-12 col-md-6"
							style="float: right; margin-right: 80px;  height: 41px; margin-top: 10px;">
							<div class="dataTables_paginate paging_simple_numbers" id="example1_paginate">
								${pagingVO.pagingHTML }
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<%-- <div class="tab-pane" id="reserveList" role="tabpanel">
			<!-- 수강 예비 신청 목록 시작 -->
			<div class="col-12">
				<div class="box">
					<div class="box-header with-border">
						<h3 class="box-title">수강 예비신청 목록</h3>
					</div>
					<!-- /.box-header -->
					<div class="box-body">
						<!-- 학생 신청 관련 정보 폼 시작 -->
						<div class="row" style="justify-content: space-between;">
							<div class="row col-md-6">
								<div class="col-md-3 col-12">
									<div class="form-group">
										<label class="form-label">신청과목수</label> 
										<input type="text" value="4" class="form-control" readonly="readonly" id="myClassCnt">
									</div>
								</div>
								<div class="col-md-3 col-12">
									<div class="form-group">
										<label class="form-label">총신청학점</label> 
										<input type="text" value="12/24" class="form-control" readonly="readonly" id="myClassPoint">
									</div>
								</div>
								<div class="col-md-3 col-12">
									<div class="form-group">
										<label class="form-label">전공신청학점</label> 
										<input type="text" value="12" class="form-control" readonly="readonly" id="myMojPoint">
									</div>
								</div>
								<div class="col-md-3 col-12">
									<div class="form-group">
										<label class="form-label">교양신청학점</label>
										<input type="text" value="0" class="form-control" readonly="readonly" id="myLibPoint">
									</div>
								</div>
							</div>
							<!-- + 수강신청 남은 시간, + 수강신청하기 -->
							<!-- <div class="row col-md-4">
								<div class="col-md-6 col-12">
									<div class="form-group">
										<label class="form-label">신청 가능 잔여 시간</label> 
										<input type="text" value="2일  05시간 05분" class="form-control no-border"
											readonly="readonly" style="color: #003e99; font-weight: bold; font-size: large;">
									</div>
								</div>
								<div class="form-group col-md-5">
									<button type="button" class="btn btn-primary" style="margin-top: 20px;" id="classListen">
										신청하기 <span class="fc-icon fc-icon-right-single-arrow"
											style="font-size: 0.7em"></span>
									</button>
								</div>
							</div> -->
						</div>
						<!-- 학생 신청 관련 정보 폼 끝 -->
						<div class="table-responsive">
							<table id="example1"
								class="table table-bordered b-1 border-primary">
								<thead class="bg-primary">
									<tr>
										<th>순번</th>
										<th>취소</th>
										<th>대학</th>
										<th>학과</th>
										<th>교과목명</th>
										<th>이수구분</th>
										<th>학점</th>
										<th>교수</th>
										<th>강의일정</th>
										<th>강의계획서</th>
									</tr>
								</thead>
								<tbody id="reserveListTable">
									
									<c:set var="classCnt" value="0"/>
									<c:set var="classPoint" value="0"/>
									<c:set var="mojPoint" value="0"/>
									<c:set var="libPoint" value="0"/>
									
									<c:choose>
										<c:when test="${empty reserveClassList }">
											<tr>
												<td colspan="10">
													목록이 없습니다...
												</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach items="${reserveClassList }" var="rclazz">
												<c:set var="classCnt" value="${classCnt +1 }"/>
												<c:set var="classPoint" value="${classPoint + rclazz.lecPoint }"/>
												<tr>
													<td style="text-align: center;"><strong>1</strong></td>
													<td style="text-align: center;">
														<c:if test="${rclazz.resStatusCode eq 'RES001' }">
															<button type="button" class="btn btn-rounded btn-danger-light mb-5"
															style="font-size: 12px;" onclick="f_cancleReservClass(${rclazz.classNo })">취소</button>
														</c:if>
														<c:if test="${rclazz.resStatusCode eq 'RES002' }">
															<span>신청됨</span> 
														</c:if>
													</td>
													<td>
														<c:if test="${rclazz.dprtCategory eq 'DPC001' }">인문</c:if>
														<c:if test="${rclazz.dprtCategory eq 'DPC002' }">사회</c:if>
														<c:if test="${rclazz.dprtCategory eq 'DPC003' }">교육</c:if>
														<c:if test="${rclazz.dprtCategory eq 'DPC004' }">공학</c:if>
														<c:if test="${rclazz.dprtCategory eq 'DPC005' }">자연</c:if>
														<c:if test="${rclazz.dprtCategory eq 'DPC006' }">의약</c:if>
														<c:if test="${rclazz.dprtCategory eq 'DPC007' }">예체능</c:if>
													</td>
													<td>${rclazz.dprtName }</td>
													<td>${rclazz.className }</td>
													<td>
														<c:if test="${rclazz.classReqCode eq 'CLR001' }">
															전공필수 
															<c:set var="mojPoint" value="${ mojPoint + rclazz.lecPoint }"/>
														</c:if>
														<c:if test="${rclazz.classReqCode eq 'CLR002' }">
															전공선택
															<c:set var="mojPoint" value="${ mojPoint + rclazz.lecPoint }"/>
														</c:if>
														<c:if test="${rclazz.classReqCode eq 'CLR003' }">
															교양필수
															<c:set var="libPoint" value="${ libPoint + rclazz.lecPoint }"/>
														</c:if>
														<c:if test="${rclazz.classReqCode eq 'CLR004' }">
															교양선택
															<c:set var="libPoint" value="${ libPoint + rclazz.lecPoint }"/>
														</c:if>
													</td>
													<td class="text-end">${rclazz.lecPoint } </td>
													<td>(교수이름)</td>
													<td>(강의 일정)
													</td>
													<td style="text-align: center;">
														<button type="button"
															class="btn btn-circle btn-xs btn-primary">
															<i class="fa fa-folder-open" style="color: white"></i>
														</button>
													</td>
												</tr>
											</c:forEach>
											
											${reserveClassList }
											
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
							<form action="/student/lecture/classListenApplyForm.do" method="post" id="classListenForm">
								<input type="hidden" value="${memNo }" name="memNo">
							</form>
						</div>
					</div>
					<!-- /.box-body -->
				</div>
				<!-- /.box -->
			</div>

			<!-- 수강 예비 신청 목록 끝 -->
			</div> --%>
			<!-- </div>
		</div> -->
		</div>
	</section>
	
	<button onclick="console.log(timerList)"></button>
</div>
<script src="${pageContext.request.contextPath}/resources/js/reserveClass.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/chat.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/vendor_components/jquery-toast-plugin-master/src/jquery.toast.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/pages/toastr.js"></script>
<script type="text/javascript">

var maxClassPoint = ${dprtVO.semMaxLecPoint };	// 최대 수강 가능 학점
var memNo = parseInt("${memberVO.memNo }");

var classList = $("#classList");

$(function () {
	var classCnt = "${classCnt }";
	var classPoint = "${classPoint }";
	var mojPoint = "${mojPoint }";
	var libPoint = "${libPoint }";
	
	var classListen = $("#classListen");
	
	var pagingArea = $("#example1_paginate");
	var searchForm = $("#searchForm");
	
	//신청 과목, 학점 표시
	$("#myClassCnt").val(classCnt);
	$("#myClassPoint").val(classPoint + "/" + maxClassPoint);
	$("#myMojPoint").val(mojPoint);
	$("#myLibPoint").val(libPoint);
	
	pagingArea.on("click", "a", function(event) {
		event.preventDefault(); // a태그의 이벤트를  block
		var pageNo = $(this).data("page");
		
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
	
	classListen.on("click", function() {
		if($("#myClassCnt").val() == 0){
			alert("신청할 목록이 없습니다.")
		} else {
			console.log("listen add...");
			
			if(confirm("선택한 강의를 신청 하시겠습니까?")){
				$("#classListenForm").submit();
			}
			
		}
	})
	
})

//소켓 설정
var sock = new SockJS("/class");

//소켓 연결
sock.onopen = function(){
	console.log("연결완료");	
}

//소켓 메시지 수신
sock.onmessage = function(res){
	var data = JSON.parse(res.data);
	
	console.log(data);
	
	if(data.applyType == "duplicate"){
		console.log("duplicate");
		toastr.warning('중복된 신청입니다.');
	} else if(data.applyType == "over"){
		console.log("over");
		toastr.warning('신청 인원이 초과되었습니다.');
	} else if(data.applyType == "failed") {
		console.log("failed");
		toastr.warning('등록에 실패하였습니다.');
	}else if(data.applyType == "success") {
		console.log("success");
		
		if(memNo == data.memNo){
			toastr.success('등록에 성공하였습니다.');
		}
		
		var listener = classList.find(".listener");
		for (var i = 0; i < listener.length; i++) {
			var classMember = $(listener[i]).find(".classMember");
			var idx = $(classMember).attr("idx");
			if(idx == data.classNo){
				
				var memTotCountSpan = '<span class="text-danger">' + data.totalMember + '</span>'
					+ '<span> / ' + data.classMaxMem + '</span>'
				$(classMember).empty();
				$(classMember).append(memTotCountSpan);
				if(memNo == data.memNo){
					$(listener[i]).find(".clsApBtn").remove();
				}
				
				lookOut($(classMember).find("span")[0], idx);
				
				
			}
		}
		//f_updateReservClass();
	}
}

//소켓 연결 종료
sock.onclose = function(){
	console.log("연결 종료");
}

var timerList = [];
function lookOut(sp, id) {
	
	for(var i=0; i<timerList.length; i++){
		if(timerList[i].id == id){		//타이머 작동중일 경우
			clearTimeout(timer);
			timer = setTimeout(()=> {
				console.log(sp);
				$(sp).removeClass("text-danger");
				$(sp).addClass("text-success");
			}, 1000);
			return;
		}	
	}
	
	var timer = setTimeout(()=> {
		console.log(sp);
		$(sp).removeClass("text-danger");
		$(sp).addClass("text-success");
	}, 1000);
	timerList.push({timer, id});
}

function f_addReservClass(classNo) {
	
	//강의 목록과 비교
	
	var data = {
			"applyType" : "add",
			"classNo" : classNo
	}
	
	sock.send(JSON.stringify(data));
	
	/* console.log("classNo :",classNo);
	
	var data = {
			"memNo" : memNo,
			"classNo" : classNo
	}
	
	//console.log("data :",data)
	
	$.ajax({
		 type : 'post',
		 url : '/DYUniv/lecture/lectureReserveAdd.do',
		 contentType : "application/json; charset=utf-8",
		 data : JSON.stringify(data),
		 success : function(res) { // 결과 성공 콜백함수       
			console.log(res);
		 
		 	if(res == "duplicated") {
		 		alert("중복신청은 불가능합니다.")
		 	} else if (res == "success") {
		 		alert("신청 성공");
		 		
		 		//예비목록 업데이트
		 		f_updateReservClass(memNo);
		 		
		 	} else {
		 		alert("예비 신청에 실패")
		 	}
		 }
	}) */
}

$(document).on("click", ".classFileBtn", function () {
	fileDownload($(this).attr("idx"), $(this).attr("idn"));
})

/* function f_cancleReservClass(classNo) {
	console.log(classNo);
	
	var data = {
			"memNo" : memNo,
			"classNo" : classNo
	}
	
	//console.log("data :",data)
	
	$.ajax({
		 type : 'post',
		 url : '/DYUniv/lecture/lectureReserveRemove.do',
		 contentType : "application/json; charset=utf-8",
		 data : JSON.stringify(data),
		 success : function(res) { // 결과 성공 콜백함수       
			 console.log(res);
			 f_updateReservClass(memNo);
		 }
	})
} */

function f_updateReservClass() {
	
	var reserveListTable = $("#reserveListTable");
	
	$.ajax({
		 type : 'post',
		 url : '/DYUniv/lecture/lectureReserveUpdate.do',
		 contentType : "application/json; charset=utf-8",
		 success : function(res) { // 결과 성공 콜백함수       
			console.log("update : " + res);
		 
			var classCnt = 0;
	 		var classPoint = 0;
	 		var mojPoint = 0;
	 		var libPoint = 0;
		 
		 	if(res == null || res == ""){
		 		reserveListTable.html("<tr><td colspan='10'>목록이 없습니다...</td></tr>");
		 	} else {
		 		var code = "";
		 		
		 		$.each (res, function (i, v) {
		 			console.log(v);
		 			
		 			classCnt = classCnt+1;
			 		classPoint = classPoint + v.lecPoint;
		 			
		 			var commoncodetext = "";
		 			if(v.classReqCode == 'CLR001'){
		 				commoncodetext = "전공필수";
		 				mojPoint = mojPoint + v.lecPoint;
		 			} else if(v.classReqCode == 'CLR002'){
		 				commoncodetext = "전공선택";
		 				mojPoint = mojPoint + v.lecPoint;
		 			} else if(v.classReqCode == 'CLR003'){
		 				commoncodetext = "교양필수";
		 				libPoint = libPoint + v.lecPoint;
		 			} else if(v.classReqCode == 'CLR004'){
		 				commoncodetext = "교양선택";
		 				libPoint = libPoint + v.lecPoint;
		 			}
		 			
					code += 
						'<tr>                                                                                         '
						+'	<td style="text-align: center;"><strong>1</strong></td>                                    '
						+'	<td style="text-align: center;">                                                           '
						
					if(v.resStatusCode == 'RES001'){
						code +=
						'		<button type="button"                                                                  '
						+'			class="btn btn-rounded btn-danger-light mb-5"                                      '
						+'			style="font-size: 12px;" onclick="f_cancleReservClass(' + v.classNo + ')">취소</button>'
						
					} else {
						code += '신청됨'
					}
						code +=
						
						'	</td>                                                                                      '
						+'	<td>(~~대학)</td>                                                                          '
						+'	<td>(~~학과)</td>                                                                          '
						+'	<td> '+ v.className +'</td>                                                                   '
						+'	<td>' + commoncodetext +'</td>                                                                 '
						+'	<td>' + v.lecPoint +'</td>                                                                    '
						+'	<td>(교수이름)</td>                                                                        '
						+'	<td>(강의 일정)                                                                            '
						+'	</td>                                                                                      '
						+'	<td style="text-align: center;">                                                           '
						+'		<button type="button"                                                                  '
						+'			class="btn btn-circle btn-xs btn-primary">                                         '
						+'			<i class="fa fa-folder-open" style="color: white"></i>                             '
						+'		</button>                                                                              '
						+'	</td>                                                                                      '
						+'</tr>                                                                                        '
				});
		 		
		 		reserveListTable.html(code);
		 	}
		 	
		 	$("#myClassCnt").val(classCnt);
	 		$("#myClassPoint").val(classPoint + "/" + maxClassPoint);
	 		$("#myMojPoint").val(mojPoint);
	 		$("#myLibPoint").val(libPoint);
		 }
	})
}

</script>
