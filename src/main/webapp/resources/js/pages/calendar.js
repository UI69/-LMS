//[calendar Javascript]

//Project:	EduAdmin - Responsive Admin Template
//Primary use:   Used only for the event calendar


var headerToolbar = {
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth,timeGridWeek'
}

var calendarSettingObj = {
	eventMinHeight : 15,
	slotDuration : '00:30:00',		// 주간 시간표의 슬롯 간격
  	initialView: defaultview,	// 기본 랜더 뷰
  	slotEventOverlap : false,
  	slotMinTime : "08:00:00",		// 주간시간표 표시 시작시간
  	slotMaxTime	: "21:00:00",		// 주간시간표 표시 끝시간
  	headerToolbar: headerToolbar,	// 헤더 버튼
  	themeSystem: 'bootstrap5',
    allDaySlot : false,
    selectable : calendarSelectType,
    events: {},
    select : function(info){
    	f_dateSelectEvent(info);
    },
    dateClick : function(info){
    	f_dateClickEvent(info);
    },
    eventClick : function(info) {
    	f_eventClickEvent(info);
    }
}

document.addEventListener('DOMContentLoaded', function() {
	var calendarEl = document.getElementById('calendar');
	
	var calendar = new FullCalendar.Calendar(calendarEl, calendarSettingObj);
	
	calendar.render();
});
