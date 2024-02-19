<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
#calendar {
	overflow: auto;
	height: 607px;
}

.box-header {
	padding: 1.5rem;
}

th, td {
	text-align: center;
}

.box-header .form-group {
	display: inline-block;
	width: 32%;
}

#addSchBtn {
	display: block;
}

.box-body th {
	color: #0052cc !important;
}
</style>

<div class="content-header">
	<div class="d-flex align-items-center">
		<div class="me-auto">
			<h3 class="page-title">상담 일정 설정</h3>
			<div class="d-inline-block align-items-center">
				<nav>
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="#"><i
								class="mdi mdi-home-outline"></i></a></li>
						<li class="breadcrumb-item" aria-current="page">상담 관리</li>
						<li class="breadcrumb-item" aria-current="page">상담 일정 설정</li>
					</ol>
				</nav>
			</div>
		</div>
	</div>
</div>

<section class="content m-10">
	<div class="box" style="height: 650px; overflow: hidden">
		<div class="box-body">
			<div class="row" id="reserveDateForm" style="flex-direction: row">
				<div id="calendar" class="fc fc-unthemed fc-ltr" style="width: 50%"></div>

				<div style="width: 50%">
					<div class="box b-1 border-secondary" style="height: 610px;">
						<div class="box-header">
							<h4 class="text-primary">상담 일정 추가</h4>
							<div style="display: flex; justify-content: space-between">
								<div class="form-group">
									<label class="form-label">상담 일자</label> <input type="text"
										class="form-control" readonly="readonly" name="counselDate"
										id="counselDate" />
								</div>
								<div class="form-group">
									<label class="form-label">시작 시각</label> <input type="text"
										class="form-control" readonly="readonly" name="startTime"
										id="startTime" />
								</div>
								<div class="form-group">
									<label class="form-label">종료 시각</label> <input type="text"
										class="form-control" readonly="readonly" name="endTime"
										id="endTime" />
								</div>
							</div>
							<button class="btn btn-primary btn-sm" id="addSchBtn"
								style="float: right" onclick="f_addSchedule()">상담 일정 추가</button>

						</div>
						<div class="box-body" style="height: 400px; overflow: auto">
							<h4 class="text-primary">상담 추후 일정</h4>
							<table class="table">
								<tr>
									<th>상담 일자</th>
									<th>시작 시각</th>
									<th>종료 시각</th>
									<th style="width: 32%">예약 내용</th>
									<th>일정 취소</th>
								</tr>
								<tbody id="schListBox"></tbody>
								<!-- <tr>
									<td>2023-02-01</td>
									<td>10:00</td>
									<td>11:00</td>
									<td>김고양 (20220001)</td>
								</tr>
								<tr>
									<td>2023-02-01</td>
									<td>10:00</td>
									<td>11:00</td>
									<td>예약 없음</td>
								</tr> -->
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<script src="${pageContext.request.contextPath}/resources/js/chat.js"></script>

<script>
	var counselDateEle = document.querySelector("#counselDate");
	var startTimeEle = document.querySelector("#startTime");
	var endTimeEle = document.querySelector("#endTime");

	var startDate = "";
	var endDate = "";

	var memNo = "${member.memNo }";
	var calendar;

	$(function() {
		data = {
			"memNo" : memNo
		}

		var html = "";

		$
				.ajax({
					type : "post",
					url : "/DYUniv/counsel/getSchData.do",
					contentType : "application/json; charset=utf-8",
					data : JSON.stringify(data),
					success : function(res) {
						console.log("체크 : ", res);

						calendarSettingObj.events = res;
						var calendarEl = document.getElementById('calendar');
						calendar = new FullCalendar.Calendar(calendarEl,
								calendarSettingObj);
						calendar.render();

						// 현재 날짜
						var currentDate = new Date();

						// 일정이 있는지 확인하는 flag
						var futureSchedulesExist = false;

						for (var i = 0; i < res.length; i++) {
							let rs = res[i];
							let startDateArray = rs.start.split(' ');
							let endDateArray = rs.end.split(' ');
							let startDate = new Date(startDateArray[0]);

							// 현재 날짜보다 이전 일정은 표시하지 않음
							if (startDate >= currentDate) {
								futureSchedulesExist = true;

								html += '<tr><td>'
										+ startDate.toISOString().substr(0, 10)
										+ '</td>';
								html += '<td>' + startDateArray[1].substr(0, 5)
										+ '</td>';
								html += '<td>' + endDateArray[1].substr(0, 5)
										+ '</td>';

								let titleStr = rs.title;
								if (titleStr.indexOf('상담 신청') === -1) {
									html += '<td class="text-light">예약 없음</td>';
								} else {
									let title = titleStr.match(/상담 신청 : (.+)/);

									html += '<td>' + title[1] + '</td>';
								}

								html += '<td><input type="hidden" id="schNo" value="' + rs.id 
							+ '"/><button class="btn btn-warning btn-sm" onclick="f_delete(this)">삭제</button></td></tr>';
							}
						}

						if (!futureSchedulesExist) {
							html += '<tr><td colspan="4" style="text-align: left; color: #878787;">추후 상담 일정이 없습니다.</td></tr>';
						}

						$("#schListBox").html(html);
					}
				});
	});

	function f_dateClickEvent(info) {

		var clickDate = new Date(info.dateStr);
		startDate = dateFormat(clickDate);
		console.log("startDate", startDate);

		endDate = dateFormat(new Date(clickDate.getTime() + 60 * 60 * 1000));
		console.log("endDate", endDate);

		var dateArr = startDate.split(" ");

		var counselDate = dateArr[0];
		var start = dateArr[1];

		console.log("counselDate", counselDate);
		console.log("start", start);

		var endArr = endDate.split(" ");

		var end = endArr[1];

		console.log("end", end);

		counselDateEle.value = counselDate;
		startTimeEle.value = start.substr(0, 5);
		endTimeEle.value = end.substr(0, 5);
	}

	function f_addSchedule() {

		data = {
			schStart : startDate,
			schEnd : endDate
		}

		$.ajax({
			type : "post",
			url : "/DYUniv/counsel/addCounselSchedule",
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(data),
			success : function(res) {
				console.log("result : ", res);

				location.href = "/DYUniv/counsel/counselorSchedule.do";
			}
		});
	}

	function f_delete(e) {
		var deleteComf = confirm("정말로 삭제하시겠습니까? 삭제하면 복구될 수 없습니다.");

		if (deleteComf) {
			var schNo = e.previousElementSibling.value;

			console.log("schNo", schNo);

			data = {
				schDataNo : schNo
			}

			$.ajax({
				type : "post",
				url : "/DYUniv/counsel/deleteCounselSchedule",
				contentType : "application/json; charset=utf-8",
				data : JSON.stringify(data),
				success : function(res) {
					console.log("result : ", res);

					location.href = "/DYUniv/counsel/counselorSchedule.do";
				}
			});
			
		}
	}
</script>
