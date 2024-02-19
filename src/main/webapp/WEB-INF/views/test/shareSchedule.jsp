<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<div class="col-xl-12 col-lg-12 col-12">
	<div class="box">
		<div class="box-body">
			<div id="calendar"></div>
		</div>
	</div>
</div>
<button id="sch">일정생성</button>

<script>
var sch = ${"#sch"};

sch.on("click", function(){
	calendarSettingObj.events = 
	    {
	        start: '2024-01-12T10:00:00',
	        end: '2014-01-12T16:00:00',
	        display: 'background'
	    };
	
	
});


</script>
