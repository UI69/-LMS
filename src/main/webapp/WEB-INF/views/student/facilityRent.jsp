<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
#add-community-events {
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
	margin: 10% auto;
	width: 35%;
	background-color: white;
	padding: 20px;
}

.link-primary:hover {
	text-decoration: underline;
}

#mOpenBtn {
	width: 70px;
	position: absolute;
	top: 40px;
	right: 30px;
}

.buildingData {
	line-height: 30px;
}

.fc-view-harness {
	height: 516.593px;
}
</style>
<div class="container-full">
	<div class="content-header">
		<div class="d-flex align-items-center">
			<div class="me-auto">
				<h3 class="page-title">시설 예약</h3>
				<div class="d-inline-block align-items-center">
					<nav>
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="#"><i
									class="mdi mdi-home-outline"></i></a></li>
							<li class="breadcrumb-item" aria-current="page">학교 시설 이용</li>
							<li class="breadcrumb-item active" aria-current="page">시설 예약</li>
						</ol>
					</nav>
				</div>
			</div>
		</div>
	</div>
	<section class="content">
		<!-- 시설목록/ 건물/시설 -->
		<div class="row">
			<div style="width: 40%">
				<div class="col-12">
					<div class="box">
						<div class="box-header with-border">
							<h4 class="box-title">건물/시설 목록</h4>
							<%-- <h6 class="box-subtitle">Use default tab with class <code>vtabs &amp; tabs-vertical</code></h6>	 --%>
						</div>
						<div class="box-body" style="height: 220px;">
							<div class="vtabs">
								<ul class="nav nav-tabs tabs-vertical" role="tablist">
									<c:forEach items="${buildingList }" var="building"
										varStatus="status">
										<li class="nav-item"><c:if test="${status.index == 0 }">
												<a class="nav-link active" data-bs-toggle="tab" buildingTab
													href="#${building.buildingName}"
													data-bNo="${building.buildingNo}" role="tab"
													aria-selected="true">
											</c:if> <c:if test="${status.index != 0 }">
												<a class="nav-link" data-bs-toggle="tab" buildingTab
													href="#${building.buildingName}" role="tab"
													data-bNo="${building.buildingNo}" aria-selected="false">
											</c:if> <span class="hidden-sm-up"><i class="ion-home"></i></span> <span
											class="hidden-xs-down">${building.buildingName }</span> </a></li>
									</c:forEach>
								</ul>
								<div class="tab-content">
									<div class="tab-pane active" id="${buildingName}"
										role="tabpanel">
										<div>
											<table class="table" id="facilityTable"
												style="text-align: center; cursor: pointer;">
												<c:forEach items="${buildingList }" var="building" />
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="card h-p250 col-12" style="height: 350px; border: none;">
					<div id="map" class="card-top"
						style="width: auto; height: 550px; margin: 10px 0;"></div>
					<!-- <div class="card-body" style="height: 70px;">
						<li><span class="glyphicon glyphicon-map-marker"></span> <span
							class="glyphicon-class">대육대학교</span></li>
						<h4 class="card-title b-0 px-0" style="text-align: center;">대육대학교</h4>
					</div> -->
				</div>
			</div>
			<div class="box" style="width: 60%">
				<div class="box-header with-border">
					<div class="row">
						<div class="col-10">
							<h4 class="box-title" id="bSelect"></h4>
							<h6 class="box-subtitle">
								<code id="fSelect"></code>
							</h6>
						</div>
						<button onclick="mOpen()" id="mOpenBtn"
							class="btn btn-success pull-right">신청</button>
					</div>
				</div>
				<div class="box-body" style="height: 550px; overflow: auto;">
					<!-- <div class="table-responsive"> -->
					<!-- 일정 캘린더 -->
					<div id="calendar"></div>
				</div>
				<!-- 
							<div class="box-footer">
								<button type="submit" class="btn btn-danger">목록</button>
							</div>
							 -->
				<!-- </div> -->
				<!-- 
						<p style="color=red;">예약 현황(확인용)</p>
						<table class="table" id="facilityTable"	style="text-align: center;">
							<thead class="bg-primary">
								<tr>
									<th>금주 예약현황</th>
								</tr>
							</thead>
							<tbody id="rsStatusTable">
							</tbody>
						</table>
						 -->
			</div>
		</div>
	</section>
</div>
<jsp:include page="/WEB-INF/views/modal_fac.jsp"></jsp:include>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c20acdc95061289b90292de48d5dedce"></script>
<script>
	var defaultview = "dayGridMonth";
	var buildingATags = $("[buildingTab]"); // 건물 리스트
	var facilityTable = $("#facilityTable"); // 시설 리스트
	var bSelect = $("#bSelect"); // 건물 선택
	var brSelect = $("#brSelect"); // 건물 선택(예약)
	var fSelect = $("#fSelect"); // 시설 선택
	var frSelect = $("#frSelect"); // 시설 선택(예약)
	var rsStatusTable = $("#rsStatusTable"); // 시설 예약 현황
	var facResrvBtn = $("#facResrvBtn"); // 시설 예약 저장 버튼
	var facResrvForm = $("#facResrvForm"); // 시설 예약 form
	var addevents = $("#add-community-events"); // 모달 form
	var mOpenBtn = $("#mOpenBtn"); // 모달 open 버튼
	/*var sdate = $("#facRsvDate");			// 시작일 
	var edate = $("#univSchEndDate");		// 종료일  */
	var frText = "";

	// 신청 버튼 비활성화
	mOpenBtn.css("display", "none");

	//모달 열기
	function mOpen() {
		addevents.css("display", "block");
	}
	// 모달 닫기
	function mClose() {
		$('form').each(function() {
			this.reset();
		});
		addevents.css("display", "none");
	}
	mOpenBtn.on("click", mOpen);

	function f_dateClickEvent(info) {
		var date = info.dayEl.dataset.date;
		$("#facRsvDate").val(date);

		addevents.css("display", "block");
	};

	// 건물 선택
	buildingATags
			.on(
					"click",
					function() {
						var buildingNo = this.dataset.bno;

						$
								.ajax({
									type : "get",
									url : "/DYUniv/facility/buildingSelect.ajax/"
											+ buildingNo,
									dataType : "json",
									success : function(res) {
										console.log("res", res);
										console.log("rslenght:",
												res.facilityList.length);
										// 선택된 건물 출력
										var bText = res.buildingName;
										bSelect.empty();
										fSelect.empty();
										bSelect.text(bText);
										brSelect.empty();
										frSelect.empty();
										brSelect.text(bText);
										// 시설 목록 출력
										facilityTable.empty();
										for (var i = 0; i < res.facilityList.length; i++) {
											var facName = res.facilityList[i].facName;
											var facNo = res.facilityList[i].facNo;
											var buildingName = res.buildingName;

											facilityTable
													.append("<tr><td><a class='link-primary buildingData' onclick='facClick(this)' idx='"
															+ facNo
															+ "'>"
															+ facName
															+ "</a></td></tr><br/>");
										}
									}
								})
					})
	$(".nav-link.active").trigger("click"); // 강제 클릭(첫번째 화면)

	// 시설 선택	
	function facClick(pThis) {
		var facNo = $(pThis).attr("idx");
		console.log("facNo", facNo);
		$("#facNo").val(facNo);

		// 신청버튼 활성화
		mOpenBtn.css("display", "block");

		$
				.ajax({
					type : "get",
					url : "/DYUniv/facility/facilitySelect.ajax/" + facNo,
					async : false,
					dataType : "text",
					success : function(res) {
						if (!res) {
							fSelect.html($(pThis).html());
							return;
						}
						res = JSON.parse(res);
						console.log("시설선택res", res);
						// 선택된 시설 출력
						frText = " - " + res.facName;
						fSelect.empty();
						fSelect.text(frText);
						frSelect.empty();
						frSelect.text(frText);

						// 시설 예약 현황 - 확인용
						for (var i = 0; i < res.facilityRentList.length; i++) {
							var memName = res.facilityRentList[i].memName;
							var facRsvStartDate = res.facilityRentList[i].facRsvStartDate;
							var facRsvEndDate = res.facilityRentList[i].facRsvEndDate;
							var facRentStatusCode = res.facilityRentList[i].facRentStatusCode;
							if (facRentStatusCode == 'FAC001') {
								facRentStatusCode = "승인대기";
							}
							if (facRentStatusCode == 'FAC002') {
								facRentStatusCode = "예약완료";
							}
							rsStatusTable.append("<tr><td>" + facRsvStartDate
									+ " ~ " + facRsvEndDate + "<br/>"
									+ facRentStatusCode + "</td></tr>");
						}

						// 선택 정보 저장
						$("#facNo").val(res.facNo);
					}
				})
		rsStatusTable.empty();

		// 예약 현황(캘린더)
		$.ajax({
			url : "/DYUniv/facility/rentListCal.ajax/" + facNo,
			type : "post",
			success : function(res) {
				console.log("cal res => ", res);
				calendarSettingObj.events = res;
				var calendarEl = document.getElementById('calendar');
				var calendar = new FullCalendar.Calendar(calendarEl,
						calendarSettingObj);
				calendar.render();
			}
		})
	}

	$(function() {
		// 시설 예약
		facResrvBtn.on("click", function() {
			var st = $("#facViewStartDate").val();
			var et = $("#facViewEndDate").val();
			var stime = (st < 10 ? "0" + st : st);
			var etime = (et < 10 ? "0" + et : et);

			var sdate = $("#facRsvDate").val() + " " + stime + ":00";
			var edate = $("#facRsvDate").val() + " " + etime + ":00";

			$("#facRsvStartDate").val(sdate);
			$("#facRsvEndDate").val(edate);

			if (etime - stime < 1) {
				alert("종료시간을 수정하세요.");
				return false;
			}

			$("#facResrvForm").submit();
		})
	})

	// 카카오맵 API
	var container = document.getElementById('map');
	var options = {
		center : new kakao.maps.LatLng(36.3653, 127.3439),
		level : 4
	};
	var map = new kakao.maps.Map(container, options);

	// 마커를 표시할 위치와 내용을 가지고 있는 객체 배열입니다 
	var positions = [ {
		content : '<div>운동장</div>',
		latlng : new kakao.maps.LatLng(36.364401, 127.344517)
	}, {
		content : '<div>인재개발원</div>',
		latlng : new kakao.maps.LatLng(36.3660, 127.3458)
	}, {
		content : '<div>공과대학</div>',
		latlng : new kakao.maps.LatLng(36.3666, 127.3444)
	}, {
		content : '<div>사회과학대학</div>',
		latlng : new kakao.maps.LatLng(36.3665, 127.3422)
	} ];

	for (var i = 0; i < positions.length; i++) {
		// 마커 생성
		var marker = new kakao.maps.Marker({
			map : map, // 마커를 표시할 지도
			position : positions[i].latlng
		// 마커의 위치
		});
		// 마커에 표시할 인포윈도우 생성
		var infowindow = new kakao.maps.InfoWindow({
			content : positions[i].content
		// 인포윈도우에 표시할 내용
		});

		// 마커에 mouseover 이벤트와 mouseout 이벤트 등록
		// 이벤트 리스너로는 클로저를 만들어 등록
		// for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록
		kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map,
				marker, infowindow));
		kakao.maps.event.addListener(marker, 'mouseout',
				makeOutListener(infowindow));

		(function(marker, infowindow) {
			// 마커에 클릭이벤트 등록
			kakao.maps.event.addListener(marker, 'click', function() {
				infowindow.open(map, marker);
			});
		})(marker, infowindow);

		//kakao.maps.event.addListener(marker, 'click', makeClickListener(this));
	}
	
	/*
	// 마커 클릭 이벤트
	var iwContent = '<div style="padding:5px;">Hello World!</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
	iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다
	*/

	/*
	//인포윈도우를 생성합니다
	var infowindow = new kakao.maps.InfoWindow({
	content : iwContent,
	removable : iwRemoveable
	});

	//마커에 클릭이벤트를 등록합니다
	kakao.maps.event.addListener(marker, 'click', function() {
	  // 마커 위에 인포윈도우를 표시합니다
	  infowindow.open(map, marker);  
	});
	*/

	//지도에 표시할 원을 생성합니다
	var circle = new kakao.maps.Circle({
		center : new kakao.maps.LatLng(36.36843516266803, 127.3469199901183), // 원의 중심좌표 입니다 
		radius : 55, // 미터 단위의 원의 반지름입니다 
		strokeWeight : 5, // 선의 두께입니다 
		strokeColor : '#75B8FA', // 선의 색깔입니다
		strokeOpacity : 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
		strokeStyle : 'dashed', // 선의 스타일 입니다
		fillColor : '#CFE7FF', // 채우기 색깔입니다
		fillOpacity : 1	// 채우기 불투명도 입니다   
	});

	// 지도에 원을 표시합니다 
	circle.setMap(map);

	/*
	 var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png', // 마커이미지의 주소입니다    
	 imageSize = new kakao.maps.Size(64, 69), // 마커이미지의 크기입니다
	 imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
	
	 //마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
	 var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
	 markerPosition = new kakao.maps.LatLng(36.368019450637476, 127.34654764377414); // 마커가 표시될 위치입니다

	 //마커를 생성합니다
	 var marker = new kakao.maps.Marker({
	 position: markerPosition, 
	 image: markerImage // 마커이미지 설정 
	 });

	 //마커가 지도 위에 표시되도록 설정합니다
	 marker.setMap(map);  
	 */

	// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
	function makeOverListener(map, marker, infowindow) {
		return function() {
			infowindow.open(map, marker);
		};
	}

	// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
	function makeOutListener(infowindow) {
		return function() {
			infowindow.close();
		};
	}

	// 마우스 클릭 이벤트
	/* function makeClickListener(pThis) {
	 return function() {
	
	 };
	 } */
</script>






