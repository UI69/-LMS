<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
table, th, td {
	background-color: white;
    border: 1px solid black;
    border-collapse: collapse;
    text-align: center;
    width : 100px;
    height: 51px;
}
th {
    text-align: center;
}
</style>

<h3 style="text-align: center; font-weight: bold;">2024년도 2학기 강의 시간표</h3><br/>
<div class="table-responsive">
	<c:set var="schedule" value="${classScheduleList }" />
	<div style="padding-left: 200px; padding-right: 200px">
	<table class="table table-bordered mb-0" id="schTable">
        <thead>
            <tr>
                <th scope="col"></th>
                <th scope="col">Monday</th>
                <th scope="col">Tuesday</th>
                <th scope="col">Wednesday</th>
                <th scope="col">Thursday</th>
                <th scope="col">Friday</th>
                <th scope="col">Saturday</th>                
            </tr>
        </thead>
        <tbody>
            <tr class="9">
                <th scope="row">9</th>
                <td class="Monday"></td>
                <td class="Tusday"></td>
                <td class="Wendsday"></td>
                <td class="Thursday"></td>
                <td class="Friday"></td>
                <td class="Saturday"></td>
            </tr>
            <tr class="10">
                <th scope="row">10</th>
                <td class="Monday"></td>
                <td class="Tusday"></td>
                <td class="Wendsday"></td>
                <td class="Thursday"></td>
                <td class="Friday"></td>
                <td class="Saturday"></td>
            </tr>
            <tr class="11">
                <th scope="row">11</th>
                <td class="Monday"></td>
                <td class="Tusday"></td>
                <td class="Wendsday"></td>
                <td class="Thursday"></td>
                <td class="Friday"></td>
                <td class="Saturday"></td>
            </tr>
            <tr class="12">
                <th scope="row">12</th>
                <td class="Monday"></td>
                <td class="Tusday"></td>
                <td class="Wendsday"></td>
                <td class="Thursday"></td>
                <td class="Friday"></td>
                <td class="Saturday"></td>
            </tr>
            <tr class="13">
                <th scope="row">13</th>
                <td class="Monday"></td>
                <td class="Tusday"></td>
                <td class="Wendsday"></td>
                <td class="Thursday"></td>
                <td class="Friday"></td>
                <td class="Saturday"></td>
            </tr>
            <tr class="14">
                <th scope="row">14</th>
                <td class="Monday"></td>
                <td class="Tusday"></td>
                <td class="Wendsday"></td>
                <td class="Thursday"></td>
                <td class="Friday"></td>
                <td class="Saturday"></td>
            </tr>
            <tr class="15">
                <th scope="row">15</th>
                <td class="Monday"></td>
                <td class="Tusday"></td>
                <td class="Wendsday"></td>
                <td class="Thursday"></td>
                <td class="Friday"></td>
                <td class="Saturday"></td>
            </tr>
            <tr class="16">
                <th scope="row">16</th>
                <td class="Monday"></td>
                <td class="Tusday"></td>
                <td class="Wendsday"></td>
                <td class="Thursday"></td>
                <td class="Friday"></td>
                <td class="Saturday"></td>
            </tr>
            <tr class="17">
                <th scope="row">17</th>
                <td class="Monday"></td>
                <td class="Tusday"></td>
                <td class="Wendsday"></td>
                <td class="Thursday"></td>
                <td class="Friday"></td>
                <td class="Saturday"></td>
            </tr>
            <tr class="18">
                <th scope="row">18</th>
                <td class="Monday"></td>
                <td class="Tusday"></td>
                <td class="Wendsday"></td>
                <td class="Thursday"></td>
                <td class="Friday"></td>
                <td class="Saturday"></td>
            </tr>
            <tr class="19">
                <th scope="row">19</th>
                <td class="MONDAY"></td>
                <td class="Tusday"></td>
                <td class="Wendsday"></td>
                <td class="Thursday"></td>
                <td class="Friday"></td>
                <td class="Saturday"></td>
            </tr>
            <tr class="20">
                <th scope="row">20</th>
               	<td class="Monday"></td>
                <td class="Tusday"></td>
                <td class="Wendsday"></td>
                <td class="Thursday"></td>
                <td class="Friday"></td>
                <td class="Saturday"></td>
            </tr>
        </tbody>
    </table>
    </div>
<%--     
    <h3 style="color: red;">학생List(확인용)</h3>
    <table>
    	<tr>
    		<td>memNo</td>
    		<td>memName</td>
    	</tr>	
   		<c:forEach items="${memberSutList }" var="stuList">
    		<tr>
		   		<td>${stuList.memNo }</td>		
		   		<td>${stuList.memName }</td>
	   		</tr>	
   		</c:forEach>
    </table>
     --%>
<%--     
    <h3 style="color: red;">확인용</h3>
    <div id="test" style="display: ;">
	    <table>
			<tr>
			    <th>memNo</th>
			    <td>lecSchNo</td>
			    <td>강의명</td>
			    <td>강의 시작일</td>
			    <td>강의 종료일</td>
			    <td>시작 시간</td>
			    <td>종료 시간</td>
			    <td>요일</td>
			    <td>강의실</td>
			</tr>
			<c:forEach items="${classScheduleList }" var="schedule">
				<tr>
				    <td>${schedule.memNo }</td>
				    <td>${schedule.lecSchNo }</td>
				    <td>${schedule.className}</td>
				    <td>${schedule.lecStartDate }</td>
				    <td>${schedule.lecEndDate }</td>
				    <td>${schedule.lecStartTime }</td>
				    <td>${schedule.lecEndTime }</td>
				    <td>${schedule.lecDowCode}</td>
				    <td>${schedule.roomNo }</td> 
				</tr>
			</c:forEach>
		</table>
	</div>
	 --%>
</div>

<script>
var backColor = ["RGB(210,200,240)","RGB(250,210,220)","RGB(205,230,255)","RGB(230,230,230)","RGB(255,255,145)"];
var fontColor = "RGB(110,110,110)";
var colorIndex = 0;

$(function(){			

	$.ajax({
		type:"get",
		url:"/DYUniv/student/class/classSchedule.ajax",
		dataType:"json",
		success:function(res){
			console.log("res", res);
			
			for(var i=0; i< res.length; i++){
				var bColor = backColor[colorIndex];
				var fColor = fontColor;
				colorIndex++;
				//console.log("res[i]", res[i]);
				for(var j = parseInt(res[i].lecStartTime); j <= parseInt(res[i].lecEndTime); j++){
					/* $("tr[class=" + data[i].lecDowCode]" td[class=" + j +"]")
						.text(data[i].className); */
						
	                if(res[i].lecDowCode == 'LDW001') { dow = "Monday"; }
	                if(res[i].lecDowCode == 'LDW002') { dow = "Tusday"; }
	                if(res[i].lecDowCode == 'LDW003') { dow = "Wendsday"; }
	                if(res[i].lecDowCode == 'LDW004') { dow = "Thursday"; }
	                if(res[i].lecDowCode == 'LDW005') { dow = "Friday"; }
	                if(res[i].lecDowCode == 'LDW006') { dow = "Saturday"; }
					
					var findPath = "." + (j+8) +" ." + dow;
					var ch = $(findPath);
					
					///////////////////////// 수정할것(같은강의=같은색상) ////////////////////////
					for(var k=0; k<ch.length; k++){
						if(ch[k].className == res[i].className){
							ch.css("backgroundColor", bColor);
						}
						ch.css("backgroundColor", bColor).css("color", fColor).css("font-weight", "bold");			
					}
					ch.html(res[i].className);
				}
			}
		}
	});
	
	
	
	
	
	
	

	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
/*
var table = document.getElementById('schTable');
var rowList = table.rows;

	for(i=1; i<rowList.length; i++){
	var row = rowList[i];
	var classNum = row.childElementCount;
	console.log("classNum : ", classNum);
	
	for(j=1; j<classNum; j++){
		var classSch = row.cells[j];
		console.log("classSch", classSch);		
	}
} */		

/* 	classTime = document.querySelectorAll('.9');
console.log("classTime",classTime); */	
	
/* for(var i=0; data.length; i++){
	for(var j=data[i].starttime; j<=data[i].endtime; j++)
		$("tr[class=" + data[i].lecDowCode]" td[class=" + j +"]")
			.text(data[i].className);
} */	
		
/*
	for(var i=0; i< res.length; i++){
	//console.log(res[i].);
	for(var j=res[i].lecStartTime; j<=res[i].lecEndTime; j++){
		//	$("tr[class=" + res[i].lecDowCode]" td[class=" + j +"]")
		//	.text(res[i].className);
			
            if(res[i].lecDowCode == 'LDW001') { dow = "Monday"; }
            if(res[i].lecDowCode == 'LDW002') { dow = "Tusday"; }
            if(res[i].lecDowCode == 'LDW003') { dow = "Wendsday"; }
            if(res[i].lecDowCode == 'LDW004') { dow = "Thursday"; }
            if(res[i].lecDowCode == 'LDW005') { dow = "Friday"; }
            if(res[i].lecDowCode == 'LDW006') { dow = "Saturday"; }
			
			var findPath = "." + j +" ." + dow;
			var ch = $(findPath);
			console.log("findPath", findPath);
			
			code = "";
			
			ch.html(res[i].className);
	}
}  
 */	
	
	
/*
 <c:forEach items="${classScheduleList }" var="schedule">
	<c:if test="${schedule.lecDowCode eq 'LDW001' and schedule.lecStartTime eq 9}">
		<c:out value="${schedule.className }"/>
	</c:if>
</c:forEach> 
 
 */
	
/* 	
	// 9시의 값
	var class9 = document.querySelector('.9');
	// 데이터 예시
	var data9 = {
        Monday: "Value1",
        Tuesday: "Value2",
        Wednesday: "Value3",
        Thursday: "Value4",
        Friday: "Value5",
        Saturday: "Value6"
    };
	console.log("data9", data9);
	// 데이터 넣기
	if (class9) {  
        class9.querySelector('.Monday').textContent = data9.Monday;
        class9.querySelector('.Tuesday').textContent = data9.Tuesday;
        class9.querySelector('.Wednesday').textContent = data9.Wednesday;
        class9.querySelector('.Thursday').textContent = data9.Thursday;
        class9.querySelector('.Friday').textContent = data9.Friday;
        class9.querySelector('.Saturday').textContent = data9.Saturday;
	}
	 */
	 
	 /* 
	function f_click(){
		console.log("t")
		//$("#test").css("display","block");
		$("#test").show();
	}
	  */
	 
})

</script>







