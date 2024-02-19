<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<style>
	#add-new-events {
		position: fixed;
		left: 0; 
		top: 0;
		width: 100%; 
		height: 100%;
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
	
	.pagination {
	    position: absolute;
	    top: -9px;
	    left: 50%;
	    transform: translate(-50%, 0);
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
						<div>
							<div class="col-12" style="display: flex; justify-content: flex-end; margin-bottom: 15px; width: 98%;">
								<div class="lookup lookup-circle lookup-right">
									<input type="text" data-provide="media-search" placeholder="Search">
								</div>
							</div>
							<div class="table-responsive p-10" style="height: 445px;">
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
														<td>${list.univSchName } </td>
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
						<div style="position: relative;">
							<div class="dataTables_paginate paging_simple_numbers" id="example1_paginate">
								${pagingVO.pagingHTML }
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

var defaultview = "dayGridMonth";
var univScheduleVO = null;	// 수정을 할때 담아둘 객체정보
var univSchNo = 0;

$(function() {
	
	// 일정 출력(캘린더)
	function scheduleList() {
		$.ajax({
			url : "/DYUniv/scheduleList.ajax",
			type : "post",
			success : function(res) {
				//console.log("res", res);
				calendarSettingObj.events = res;
				calendarSettingObj.slotMaxTime = "23:00:00";
				var calendarEl = document.getElementById('calendar');
				var calendar = new FullCalendar.Calendar(calendarEl, calendarSettingObj);				
				calendar.render();
			}
		});
	}
	scheduleList();	
	
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
