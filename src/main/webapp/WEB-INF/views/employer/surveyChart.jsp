<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<section class="content row col-12 hold-transition light-skin sidebar-mini theme-primary fixed">
	<div class="col-2 bg-white"></div>
	<div class="col-6 text-center h-80 bg-white" id="chartHead"></div>
	<div class="col-4 bg-white"></div>
	<div class="col-12 text-end h-50 " id="chartInfo"></div>
	<div class="col-2">
	</div>
	<div class="col-6" style="" id="chartBody">
		<%-- <div class="box">
			<div class="box-body">
				<h4 class="box-title">Pie Chart</h4>
				<div>
					<canvas id="pie-chart1" height="200"></canvas>
				</div>
			</div>
		</div> --%>
	</div>
	
	
	<div class="col-4">
		<!-- <button onclick="getViewDate()">test</button> -->
	</div>
</section>

<script src="${pageContext.request.contextPath}/resources/assets/vendor_components/chart.js-master/Chart.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/chat.js"></script>
<script>

var srvNo = parseInt("${srvNo }");
var regLabels = [];
var regData = [];

var srvData = [];

$(function () {
	
	$(document).on("click", "#chartTypeBarBtn", function () {
		console.log("bar");
		createRegChartType("bar");
	})
	
	$(document).on("click", "#chartTypelineBtn", function () {
		createRegChartType("line");
		console.log("line");
	})
	
	$(document).on("click", ".chartTypeBarBtn", function () { changeChart(this, "bar"); })
	
	$(document).on("click", ".chartTypePieBtn", function() { changeChart(this, "pie"); });
	
	$(document).on("click", ".chartTypeDoughnutBtn", function() { changeChart(this, "doughnut"); });
	
	$(document).on("click", ".chartTypePolarAreaBtn", function() { changeChart(this, "polarArea"); });
})



function changeChart(elem, type) {
	
	var chr = $(elem).parent();
	var qstNo = $(chr).attr("idx");
	var qstName = $(chr).find("h4").text().substr(3);
	
	var code = '<div class="box-body">	<h4 class="box-title">'+ qstNo +'. '+ qstName +'</h4>'
		+'<div> <canvas id="pie-chart' + qstNo +'" height="200"></canvas>	</div></div>'
		+ '<button class="btn btn-sm btn-primary-light chartTypeBarBtn">bar</button>'
		+ '<button class="btn btn-sm btn-primary-light chartTypePieBtn">pie</button>'
		+ '<button class="btn btn-sm btn-primary-light chartTypeDoughnutBtn">doughnut</button>'
		+ '<button class="btn btn-sm btn-primary-light chartTypePolarAreaBtn">polarArea</button>'
		
	$($("#chartBody").find(".box")[qstNo]).html(code);
	
	var chartData = srvData[qstNo-1]
	//console.log("data : ", chartData);
	
	var ctx = document.getElementById("pie-chart"+qstNo).getContext("2d");

	var chartLabels = [];
	var srvChartData = [];
	var chartBgColor = [];
	
	for (var i = 0; i < chartData.length; i++) {
		chartLabels.push(chartData[i].chStr);
		srvChartData.push(chartData[i].cnt);
		chartBgColor.push(getRandomColor());
	}
	
	var data = {
		labels: chartLabels,
		datasets: [{
			data: srvChartData,
			backgroundColor: chartBgColor
			//hoverBackgroundColor: []
		}]
	}
	
	new Chart(ctx,{
		type: type,
		data: data,
		options: {
			animation: {
				duration:	1000
			},
			responsive: true,
			legend: {
				labels: {
					fontFamily: "Nunito Sans",
					fontColor:"#878787"
				}
			},
			tooltip: {
				backgroundColor:'rgba(33,33,33,1)',
				cornerRadius:0,
				footerFontFamily:"'Nunito Sans'"
			},
			elements: {
				arc: {
					borderWidth: 0
				}
			},
			scales: {
				yAxes: [{
					ticks: {
						min: 0,
						stepSize : 1,
					}
				}]
			}
		}
	});
}

$(function () {
	
	$.ajax({
		type: "get",
		url : "/DYUniv/surveyDetail.ajax?srvNo="+srvNo,
		contentType : "application/json; charset=utf-8",
		success : function(res){
			//console.log(res);
			
			if(res == null || res.length == 0){
				// alert("일치하는 정보가 없습니다...")
				Swal.fire({
					icon: 'error',
					title: '잘못된 접근입니다.', 
					text: '',
			    });
		 		location.href = "/DYUniv/surveyResult.do";
		 	} else {
		 		$("#chartHead").append('<h2>' + res.srvName + '<h2>');
		 		$("#chartHead").append('<h5> 총 참여 인원 : ' + res.srvRegCount + '명 <h5>');
		 		srvRegChart(res.srvResultList, res.srvQstList.length);
		 		srvChart(res);
		 		//console.log(srvData);
		 	}
		}

	});
	
})

function srvRegChart(regDataList, regMem) {
	//console.log("dateList :", regDataList);
	
	//출력할 날짜 설정
	var dateList = getViewDate();
	
	// 날짜에 맞는 데이터 추가
	for (var i = 0; i < regDataList.length; i++) {
		var dateStr = regDataList[i].svrResDate.substr(0,10);
		
		for (var j = 0; j < dateList.length; j++) {
			if(dateList[j].date == dateStr){
				dateList[j].cnt += 1;
			}
		}
	}
	
	for (var i = 0; i < dateList.length; i++) {
		dateList[i].cnt /= regMem;
	}
	
	console.log("date :", regMem, dateList);
	createLineChart(dateList);
}

function createLineChart(chartData){
	var code = '<div class="box">	<div class="box-body">	<h4 class="box-title">일일 응답자수</h4> '
		+ '<div><canvas id="reg-chart" height="200"></canvas></div></div>'
		+ '<button class="btn btn-sm btn-primary-light" id="chartTypeBarBtn">bar</button>'
		+ '<button class="btn btn-sm btn-primary-light" id="chartTypelineBtn">line</button>'
		+ '</div>';
		
	$("#chartBody").append(code);
	
	regLabels = [];
	regData = [];
	
	for (var i = 0; i < chartData.length; i++) {
		regLabels.push(chartData[i].date);
		regData.push(chartData[i].cnt);
	}
	
	createRegChartType("line");
}

function createRegChartType(type) {
	var regChart = new Chart(document.getElementById("reg-chart"), {
		type: type,
 		data: {
			labels: regLabels,
			datasets: [{ 
				data: regData,
				label: "설문자 수",
				borderColor: "#389f88",
				backgroundColor : "RGBA(127, 255, 255, 0.5)",
				fill: true
			}]
		},
		options: {
			title: {
				display: true,
				text: '응답자',
			},
			scales: {
				yAxes: [{
					ticks: {
						min: 0,
						stepSize : 1,
					}
				}]
			}
		}
	});
}

function getViewDate() {
	var viewDate = [];
	
	var date = new Date();
	//console.log("date origin :",dateFormat(date));
	for (var i = 0; i < 7; i++) {
		var temp = dateFormat(new Date(
				date.getFullYear(),
				date.getMonth(),
				date.getDate() - 6 + i
			)).substr(0,10)
		
		var vd = {
			"date" : temp,
			"cnt" : 0
		}
		viewDate.push(vd);
	}
	return viewDate;
}

function srvChart(srv) {
	
	var qstList = srv.srvQstList;
	var resList = srv.srvResultList;
	var srvRegCount = srv.srvRegCount;
	
	if(resList.length == 1 && resList[0].svrResAns == null){
		// 참여 인원 없음
		return;
	}
	
	for (var i = 0; i < qstList.length; i++) {
		var qst = qstList[i].srvQst;
		var srvQstNo = qstList[i].srvQstNo;
		var chList = qstList[i].srvQstChList
		var qstData = [];
		
		for (var j = 0; j < chList.length; j++) {
			var str = chList[j].chNo +". "+ chList[j].chStr;
			var data = {
					chStr : str,
					cnt : 0
			}
			qstData.push(data);
		}
		
		//console.log("qstData : ", qstData);
		
		//질문마다 데이터 뽑기
		for (var j = 0; j < resList.length; j++) {
			var chStr = resList[j].chList;
			
			if(srvQstNo == resList[j].srvQstNo){
				var ans = resList[j].svrResAns;
				//console.log("ans :", ans);
				qstData[ans-1].cnt += 1;
			}
		}
		
		//console.log("qstData : ", qstData);
		
		// 차트 생성
		qstData.sort((a, b) => parseInt(a.chStr.substr(0,1)) - parseInt(b.chStr.substr(0,1)) );
		srvData.push(qstData);
		createPiChart(qstData, qst, qstList[i].qstNo);
	}
}

function createPiChart(chartData, qstName, qstNo) {
	
	var code = '<div class="box" idx="' + qstNo +'">	<div class="box-body">	<h4 class="box-title">'+ qstNo +'. '+ qstName +'</h4>'
				+'<div> <canvas id="pie-chart' + qstNo +'" height="200"></canvas>	</div></div>'
				+ '<button class="btn btn-sm btn-primary-light chartTypeBarBtn">bar</button>'
				+ '<button class="btn btn-sm btn-primary-light chartTypePieBtn">pie</button>'
				+ '<button class="btn btn-sm btn-primary-light chartTypeDoughnutBtn">doughnut</button>'
				+ '<button class="btn btn-sm btn-primary-light chartTypePolarAreaBtn">polarArea</button>'
				+'</div>'
	$("#chartBody").append(code);
	
	var ctx = document.getElementById("pie-chart"+qstNo).getContext("2d");
				
	var chartLabels = []; 
	var srvChartData = [];
	var chartBgColor = [];
	
	for (var i = 0; i < chartData.length; i++) {
		chartLabels.push(chartData[i].chStr);
		srvChartData.push(chartData[i].cnt);
		chartBgColor.push(getRandomColor());
	}
	
	var data = {
		labels: chartLabels,
		datasets: [
			{
			data: srvChartData,
			backgroundColor: chartBgColor
			//hoverBackgroundColor: []
		}]
	}
	
	//console.log("chart Data : ",data)
	
	new Chart(ctx,{
		type: "pie",
		data: data,
		options: {
			animation: {
				duration:	1000
			},
			responsive: true,
			legend: {
				labels: {
					fontFamily: "Nunito Sans",
					fontColor:"#878787"
				}
			},
			tooltip: {
				backgroundColor:'rgba(33,33,33,1)',
				cornerRadius:0,
				footerFontFamily:"'Nunito Sans'"
			},
			elements: {
				arc: {
					borderWidth: 0
				}
			}
		}
	});
}

function getRandomColor() {
	var color = Math.floor(Math.random() * 127 + 128).toString(16);
	color += Math.floor(Math.random() * 127 + 128).toString(16);
	color += Math.floor(Math.random() * 127 + 128).toString(16);
	return "#"+color;
}
</script>
























