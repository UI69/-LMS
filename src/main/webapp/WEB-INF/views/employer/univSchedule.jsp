<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<style>
	#add-new-events {
		position: fixed;
		left: 0; top: 0;
		width: 100%; height: 100%;
		background-color: rgba(170, 170, 170, 0.5);
		z-index: 10000; 
		display: none;
	}
	#mContent {
		margin:10% auto;
		width: 30%;
		background-color: white;
		padding: 20px;
	}
	#add-community-events {
	display: none;
	}
</style>
<div class="container-full">
	<!-- Content Header (Page header) -->
	<div class="content-header">
		<div class="d-flex align-items-center">
			<div class="me-auto">
				<h3 class="page-title">학사일정</h3>
				<div class="d-inline-block align-items-center">
					<nav>
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="#"><i
									class="mdi mdi-home-outline"></i></a></li>
							<li class="breadcrumb-item" aria-current="page">관리 정보</li>
							<li class="breadcrumb-item active" aria-current="page">학사일정</li>
						</ol>
					</nav>
				</div>
			</div>
		</div>
	</div>

	<!-- Main content -->
	<section class="content">
		<div class="row">
			<!-- 일정 캘린더 -->
			<div class="col-xl-6">
				<div class="box">
					<div class="box-body">
						<div id="calendar"></div>
					</div>
				</div>
			</div>
			<!-- 일정 목록 -->
			<div class="col-xl-6">
				<div class="box no-border no-shadow" style="height: 655px;">
					<div class="box-header with-border">
						<h4 class="box-title">학사일정 목록</h4>
					</div>
					<div class="box-body p-20">
						<div class="row">
							<div class="col-lg-6 col-12">
								<c:choose>
	 								<c:when test="${member.memRole eq 'ROL003' }">
										<button onclick="mOpen()" id="mOpenBtn" class="btn btn-primary">
											<i class="ti-plus"></i> 일정추가
										</button>
									</c:when>
								</c:choose>			
							</div>
							<div class="text-end col-lg-6 col-12">
								<div class="lookup lookup-circle lookup-right">
									<input type="text" data-provide="media-search" placeholder="Search">
								</div>
							</div>
							<div class="table-responsive p-10" style="height: 445px; "><!-- overflow: auto; -->
								<table class="table mb-0 b-1 border-primary"
									style="text-align: center">
									<thead class="bg-primary">
										<tr>
											<th scope="col">순번</th>
											<th scope="col">학사일정</th>
											<th scope="col">학기</th>
											<th scope="col">시작일자</th>
											<th scope="col">종료일자</th>
											<th scope="col">등록자</th>
										</tr>
									</thead>
									<tbody>
										<c:set var="index" value="${pagingVO.startRow + 1}" />
										<c:set var="index" value="${index - 1}" />
										<%-- <c:forEach items="${univScheduleList }" var="list"> --%>
										<c:forEach items="${pagingVO.dataList }" var="list">
											<c:choose>
												<c:when test="${empty list }">
													<tr>
														<td colspan="5">생성된 일정이 없습니다.</td>
													</tr>
												</c:when>
												<c:otherwise>
													<tr>
														<td><strong>${index }</strong></td>
														<!-- 페이징이 되어야 1부터 시작합니당! -->
														<c:set var="index" value="${index + 1}" />
														<%-- <td>${list.univSchNo }</td> --%>
														<td>
															<a href="#" onclick="f_detailModal('${list.univSchNo }','${list.univSchName }','${list.univSchCont}',
																								'${list.univSchSem }','${list.univSchStartDate }',
																								'${list.univSchEndDate }', '${list.univSchReg }')">
															${list.univSchName }</a>
														</td>
														<td>${list.univSchSem }</td>
														<td>${fn:substring(list.univSchStartDate,0,10) }</td>
														<td>${fn:substring(list.univSchEndDate,0,10) }</td>
														<td>${list.univSchReg }</td>
													</tr>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div><br/>
						<!-- 페이징 -->
						<div class="col-sm-12 col-md-7"
							style="float: right; margin-right: 100px">
							<div class="dataTables_paginate paging_simple_numbers"
								id="pagination">${pagingVO.pagingHTML }</div>
								<!-- 
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
									<li class="paginate_button page-item next" id="example1_next"><a
										href="#" aria-controls="example1" data-dt-idx="6" tabindex="0"
										class="page-link">Next</a></li>
								</ul>
								 -->
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 일정 목록 -->
		</div>
	</section>
</div>


<c:if test="${not empty message }">
	<script type="text/javascript">
		alert("${message }");
		<c:remove var="message" scope="request"/>
		<c:remove var="message" scope="session"/>
	</script>
</c:if>

<jsp:include page="/WEB-INF/views/modal.jsp"></jsp:include>

<!-- Vendor JS -->
<script src="${pageContext.request.contextPath}/resources/assets/vendor_components/perfect-scrollbar-master/perfect-scrollbar.jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/chat.js"></script>
<!-- <script src='fullcalendar/dist/index.global.js'></script> -->

<script>

var sNo = $("[name=univSchNo]");		// 번호
var sTitle = $("#univSchName");			// 제목
var sCont = $("#univSchCont");			// 내용
var sSem = $("#univSchSem");			// 학기
var sdate = $("#univSchStartDate");		// 시작일 
var edate = $("#univSchEndDate");		// 종료일 
var viewEndDate = $("#viewEndDate");	// 종료표현
var sReg = $("#univSchReg");			// 등록자
var addevents = $("#add-new-events");	// 모달 form
var closeBtn = $("#closeBtn");   		// 모달 close 버튼
var mOpenBtn = $("#mOpenBtn");			// 모달 open 버튼
var scheduleForm = $("#scheduleForm");	// 일정 등록/수정/삭제 From
var addBtn = $("#addBtn"); 				// 일정 등록 버튼
var deleteBtn = $("#deleteBtn"); 		// 일정 삭제 버튼
var defaultview = "dayGridMonth";
var univScheduleVO = null;	// 수정을 할때 담아둘 객체정보
var univSchNo = 0;


//모달 열기
function mOpen(){
	addevents.css("display","block");
}
// 모달 닫기
function mClose(){
	$('form').each(function() {
		  this.reset();
	});
	addevents.css("display","none");
}

closeBtn.on("click",mClose);
mOpenBtn.on("click",mOpen);


//모달 시작,종료일 지정
function f_dateSelectEvent(info) {	
	
	var si = new Date(info.start);			// 시작일
	var ei = new Date(info.end);			// 종료일
	
	var viewEd =  new Date(info.end);		// 종료일 -1시간
	viewEd.setHours(viewEd.getHours() -1);
	viewEndDate.val(dateFormat(viewEd).substring(0,10));
	
	// 적용
	sdate.val(dateFormat(si).substring(0,10));
	edate.val(dateFormat(ei).substring(0,10));	
	
	addevents.css("display","block");
};

// 디테일 모달창
function f_detailModal(uNo,uName,uCont,uSem,uStar,uEnd,uReg){
	
	var myForm = document.forms.scheduleForm;
	console.log("form111", myForm.univSchNo);
	
	console.log("uNo",uNo,"uName",uName,"uCont",uCont,"uSem",uSem,"uStar",uStar,"uEnd",uEnd,"uReg",uReg);
	sNo.val(uNo);
	sTitle.val(uName);
	sCont.val(uCont);
	sSem.val(uSem);
	sdate.val(uStar.toLocaleString().split(' ')[0]);
	edate.val(uEnd.toLocaleString().split(' ')[0]);
	sReg.val(uReg);
	
	var vd = new Date(uEnd);
	vd.setHours(vd.getHours());
	viewEndDate.val(dateFormat(vd).substring(0,10));
	
	addevents.css("display","block");
	console.log("sdate",uStar);
	console.log("edate",uEnd);
	
	var scheduleForm = document.forms.scheduleForm;
	console.log("scheduleForm", scheduleForm)
	
	for(i=0; i < scheduleForm.length; i++){
		var result = scheduleForm[i];
	}
	
	univScheduleVO={
		univSchNo : uNo,
		univSchName : uName,
		univSchStartDate : uStar,
		univSchEndDate : uEnd,
		univSchCont : uCont,
		univSchSem : uSem,
		univSchReg : uReg
	}
	
	document.getElementById("addBtn").innerText = "update";
	univSchNo = uNo;
	
	console.log("univScheduleVO", univScheduleVO);
}


$(function() {
	var myForm = document.forms.scheduleForm;
	console.log("form", myForm.univSchNo);
	
	// 일정 저장 이벤트 (등록도 가능하고 수정도 가능)
	addBtn.on("click", function() {
		var scheduleTitle = sTitle.val(); // 제목
		var univSchCont = sCont.val(); // 내용
		var univSchSem = sSem.val(); // 학기
		var startDate = sdate.val(); // 시작일자
		var endDate = edate.val(); // 종료일자
		
		// option:checked
		if (scheduleTitle == null || scheduleTitle == "") {
			alert("제목을 입력해주세요");
			scheduleTitle.focus();
			return false;
		}
		if (univSchSem == "none") {
			console.log("univSchSem", univSchSem);
			alert("학기를 선택해주세요");
			return false;
		}
		if (startDate == null || startDate == "") {
			alert("시작 일자를 설정해주세요.");
			return false;
		}
		if (endDate == null || endDate == "") {
			alert("종료 일자를 설정해주세요.");
			return false;
		}
		if (startDate > endDate) {
			alert("시작일자는 종료일자보다 클 수 없습니다.")
			return false;
		}
		
		if($(this).text() == "update"){	
			$("#univSchNo").attr("disabled", false);
			$("#univSchNo").val(univSchNo);
			scheduleForm.attr("action", "/DYUniv/employer/updateSchedule.do");	
		}else{
			$("#univSchNo").attr("disabled", true);
		}
		scheduleForm.submit();
	});
	
	
	deleteBtn.on("click", function(){
		var aschNo = document.forms.scheduleForm.univSchNo.value;
		console.log("aschNo",aschNo);
		
		$.ajax({
 			url : "/DYUniv/employer/deleteSchedule/" + aschNo,
 			type : "delete",
 			dataType:"text",
 			success : function(res) {
 				console.log("res", res);
 				if(res==1){
 					alert("일정이 삭제되었습니다.");
					// 주소 표시줄 제어는 window.location
					//location.href = location.href; // 브라우져 캐쉬 기능 때문에 새로 고침이 될 수도 있고 안 될 수도 있음
					location.replace(location.href);  // 항상 서버에 새로 데이터를 요청
 				}
 			}
 		});
	});
	

	
	// 일정 출력(캘린더)
	function scheduleList() {
		$.ajax({
			url : "/DYUniv/scheduleList.ajax",
			type : "post",
			success : function(res) {
				console.log("res", res);
				calendarSettingObj.events = res;
				calendarSettingObj.slotMaxTime = "23:00:00";
				var calendarEl = document.getElementById('calendar');
				var calendar = new FullCalendar.Calendar(calendarEl, calendarSettingObj);				
				calendar.render();
			}
		});
	}
	scheduleList();
	
	// 페이징
	var pagingArea = $("#pagination");
	var searchForm = $("#searchForm");

	pagingArea.on("click", "a", function(event) {
		event.preventDefault();
		var pageNo = $(this).data("page");

		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
		
	
});






































//if($(this).text() == "update"){
	// 		$.ajax({
	// 			url : "/employer/updateSchedule.do",
	// 			type : "put",
	// 			contentType:"application/json;charset=utf-8",
	// 			data:JSON.stringify(univScheduleVO),
	// 			dataType:"text",
	// 			success : function(res) {
	// 				console.log("res", res);
	// 				if(res==1){
	// 					alert("수정 완료");
	// 				}
	// 			}
	// 		});


/*
	// 시작일
var startDate = info.startStr;		

// 종료일
var end = new Date(info.endStr);
var eyear = end.getFullYear();	// 년
end.setMonth(end.getMonth()+1);	// 월
end.setDate(end.getDate()-1);	// 일	
var endDate = eyear  + "-" + ("00"+((end.toLocaleString()).split(".")[1].trim()-1)).slice(-2)
					 + "-" + ("00"+(end.toLocaleString()).split(".")[2].trim()).slice(-2);	
*/
 
 



////////////////////////calendar.js => editable : true
////////////////////////calendar.js => selectable : true(default)
//addevents.modal('show');

/*
 // ajax => addSchedule
 const scheduleForm = document.forms[0];

 function faddSchedule(){
	 let scheduleVO = {
	 scheduleTitle : scheduleForm.scheduleTitle.value,
	 scheduleCont : scheduleForm.scheduleCont.value,
	 currentSem : scheduleForm.currentSem.value,
	 startDate : scheduleForm.startDatee.value,
	 endDate : scheduleForm.endDate.value
 	}
}
 */
	
/* 	
	// 2024.01.11 지현
	// 해당 페이지를 로드할때 일정에 등록된 일정 데이터를 캘린더에 출력한다.
	function scheduleList() {
		$.ajax({
			url : "/scheduleList.do",
			type : "post",
			success : function(res) {
				calendarEl = document.getElementById('calendar');
				calendar = new FullCalendar.Calendar(calendarEl, {
				//timeZone : 'UTC',
				//initialView : 'dayGridMonth',
				events : res,
				editable : true,
				selectable : true
				});
				calendar.render();
			}
		});
	}
	scheduleList();
*/
	
</script>
<!-- <script>
	var calendarType = "month";
</script> -->
