<%@page import="kr.or.ddit.vo.CalendarVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
section {
	position: relative;
}
#backBtn  {
	position: absolute;
	top: -43px;
    right: 35px;
}
#calendar {
    overflow: auto;
    height: 527px;
}
.box-header, .box-footer {
    padding: 1rem;
}
</style>

<div class="content-header">
	<div class="d-flex align-items-center">
		<div class="me-auto">
			<h3 class="page-title">상담 예약 신청</h3>
			<div class="d-inline-block align-items-center">
				<nav>
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="#"><i class="mdi mdi-home-outline"></i></a></li>
						<li class="breadcrumb-item" aria-current="page">기타</li>
						<li class="breadcrumb-item" aria-current="page">상담</li>
						<li class="breadcrumb-item" aria-current="page">상담 예약 목록</li>
						<li class="breadcrumb-item" aria-current="page">상담 예약 신청</li>
						<li class="breadcrumb-item active" aria-current="page">상담 예약 신청 폼</li>
					</ol>
				</nav>
			</div>
		</div>
	</div>
</div>

<section class="content m-10">

	<button type="button" class="btn btn-warning" onclick="f_back()" id="backBtn">
		<i class="fa fa-fw fa-arrow-left"></i> 뒤로가기
	</button>

	<div class="box" style="height: 570px; overflow: hidden;">
		<div class="box-body">
			<div class="row" id="reserveDateForm">
				<!-- 캘린더 -->
				<div id="calendar" class="fc fc-unthemed fc-ltr col-8 mx-h-400"></div>

				<div class="col-4">
					<div class="box b-1 border-info">
						<div class="box-header">
							<h4 class="box-title text-info mb-0">
								<i class="ti-user me-15"></i> 상담 신청 폼
							</h4>
						</div>
						<form class="form" action="/DYUniv/counsel/counselReservForm.do" method="post" id="couselReserveForm">
							<div class="box-body">
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label class="form-label">상담자 이름</label> 
											<input type="text" class="form-control" 
											readonly="readonly" id="memName1" name="memName1" value="${counsorMap.counsorName }">
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group">
											<label class="form-label">신청자</label> 
											<input type="text" class="form-control" 
											readonly="readonly" id="memName2" name="memName2" value="${member.memName }">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label class="form-label">상담 일자</label> 
											<input type="text" class="form-control" placeholder="상담 일자" readonly="readonly" id="counselDate" name="">
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group">
											<label class="form-label">시간</label> 
											<input type="text" class="form-control" placeholder="시간" readonly="readonly" id="counselTime" name="">
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group">
											<label class="form-label">상담 형식</label> <select
												class="form-select" id="cnslType" name="cnslType">
												<option value="" selected="selected" >선택</option>
												<option value="CNT001">대면 상담</option>
												<option value="CNT002">비대면 화상</option>
												<option value="CNT003">비대면 채팅</option>
											</select>
										</div>
									</div>
								</div>
								<div class="form-group">
									<label class="form-label">상담 신청 내용</label>
									<textarea rows="5" class="form-control" placeholder="상담하고 싶은 내용" id="cnslReason" name="cnslReason"></textarea>
								</div>
							</div>
							 <input type="hidden" id="memNo1" name="memNo1" value="${counsorMap.memNo }"> <input
								type="hidden" id="memNo2" name="memNo2" value="${member.memNo }"> <input
								type="hidden" id="cnslStartDate" name="cnslStartDate"> <input
								type="hidden" id="cnslEndDate" name="cnslEndDate"> <input
								type="hidden" id="schDataNo" name="schDataNo">

							<div class="box-footer">
								<button type="button" class="btn btn-warning me-1 btn-sm" onclick="f_formClear()">
									<i class="ti-trash"></i> Cancel
								</button>
								<button type="button" class="btn btn-primary btn-sm" id="couselReserveBtn">
									<i class="ti-save-alt"></i> 상담 신청하기
								</button>
								<button type="button" class="btn btn-danger-light btn-sm" id="couselReserveTest">
									test
								</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

</section>
<script>
var calendarList =[];
var testStr = '${calListJson}';
console.log("ywStr",JSON.parse(testStr));
</script>
<c:forEach items="${calendarList }" var="cal" varStatus="status">
	<script>
		var cal ={
				id: parseInt("${cal.id}"),
				title: "${cal.title}",
				start: "${cal.start}",
				end: "${cal.end}",
				className: "${cal.className}"
		}
		
		calendarList.push(cal);
	</script>
</c:forEach>
<script src="${pageContext.request.contextPath}/resources/js/chat.js"></script>
<script>
	var calendarSelectType = false;
	
	console.log("calendarList : ", calendarList);

	$(function() {
		var reserveDateForm = $("#reserveDateForm");
		var counselBtn = $(".counselBtn");
		var couselReserveForm = $("#couselReserveForm");
		var couselReserveBtn = $("#couselReserveBtn");

		calendarSettingObj.events = calendarList.map(function(item) {
			return {
				id: item.id,
				title: item.title,
				start: item.start,
				end: item.end,
				className: item.className
			};
		});

		calendarSettingObj.events = calendarList;
		
		var calendarEl = document.getElementById('calendar');
		var calendar = new FullCalendar.Calendar(calendarEl, calendarSettingObj);
		calendar.render();

		couselReserveBtn.on("click", function() {
			var cnr = $("#memName1").val();
			var reason = $("#cnslReason").val();
			var type = $("#cnslType").val();

			if (cnr == null || cnr == "") {
				alert("상담자를 선택해 주세요");
				return;
			}
			if (reason == null || reason == "") {
				alert("상담 사유를 입력해 주세요");
				return;
			}
			if (type == null || type == "") {
				alert("상담 형식을 선택해 주세요");
				return;
			}

			if (confirm("이렇게 상담을 신청 하시겠습니까?")) {
				couselReserveForm.submit();
			}
		})
	})

	//일정 선택시
	function f_eventClickEvent(info) {

		var sd = info.event.startStr;
		var ed = info.event.endStr;

		if (info.event.classNames[0] == 'bg-info') {
			// 상담 신청 폼에 데이터 추가
			$("#counselDate").val(sd.substring(0, 10));
			$("#counselTime").val(sd.substring(11, 16) + "~" + ed.substring(11, 16));
			$("#cnslStartDate").val(dateFormat(new Date(sd)));
			$("#cnslEndDate").val(dateFormat(new Date(ed)));
			$("#schDataNo").val(info.event.id);
		}
	}

	function f_formClear() {

		//모든 이벤트 삭제
		calendarSettingObj.events = {};
		var calendarEl = document.getElementById('calendar');
		var calendar = new FullCalendar.Calendar(calendarEl, calendarSettingObj);
		calendar.render();

		//입력폼 초기화
		$("#memName1").val("");
		$("#counselDate").val("");
		$("#counselTime").val("");

		$("#cnslType").val("");
		$("#cnslStartDate").val("");
		$("#cnslEndDate").val("");
		$("#schDataNo").val("");
	}
	
	function f_back(){
		window.history.back();
	}
	
	$("#couselReserveTest").on("click", function () {
		$("#cnslType").val("CNT002");
		$("#cnslReason").val("어학연수를 가고 싶습니다.");
	})
</script>