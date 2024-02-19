<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<section class="m-10">
	<div class="row col-12" id="reserveDateForm" >
		<div id="calendar" class="fc fc-unthemed fc-ltr col-7 mx-h-500">
		</div>
		<div class="col-xl-4 col-12">
			<div class="box">
			  <div class="box-header">
				<h4 class="box-title">With <strong>alert</strong></h4>
			  </div>
	
			  <div class="box-body">
				  <div class="alert alert-success alert-dismissible fade show" role="alert">
					<strong>(타이틀)</strong><br> (내용)
				  </div>
	
				
			  </div>
			</div>
		</div>
	</div>
</section>
<script src="${pageContext.request.contextPath}/resources/js/chat.js"></script>
<script>
	var defaultview = "dayGridMonth";
	var calendarSelectType = true;
	
	//날짜 설정 이벤트
	function f_dateSelectEvent(info) {
		//일정 설정
	};
	
	//날짜 클릭 이벤트
	function f_dateClickEvent(info) {
		
	};
	
	//이벤트 클릭 이벤트
	function f_eventClickEvent(info) {
		
	};
	
	/* 
	calendarSettingObj.events = {};
	
	var calendarEl = document.getElementById('calendar');
	
	var calendar = new FullCalendar.Calendar(calendarEl, calendarSettingObj);
	
	calendar.render(); */
</script>