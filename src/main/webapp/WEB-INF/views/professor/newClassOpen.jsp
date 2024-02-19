<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
.box {
	max-height: 580px;
	/* overflow: auto; */
}

ul.box > li {
	list-style: none;
}

section {
	position: relative;
}

.po {
	position: absolute;
	top: 20px;
	right: 25px;
}

.inst {
	width: 20%;
	display: inline-block;
}

.margin * {
	margin-right: 20px;
}
</style>
<div class="container-full">
	<!-- Content Header (Page header) -->
	<div class="content-header">
		<div class="d-flex align-items-center">
			<div class="me-auto">
				<h3 class="page-title">개설 신청 양식</h3>
				<div class="d-inline-block align-items-center">
					<nav>
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="#">
								<i class="mdi mdi-home-outline"></i></a>
							</li>
							<li class="breadcrumb-item" aria-current="page">강의 관리</li>
							<li class="breadcrumb-item active" aria-current="page">개설 신청 목록</li>
							<li class="breadcrumb-item active" aria-current="page">개설 신청 양식</li>
						</ol>
					</nav>
				</div>
			</div>
		</div>
	</div>
	<!-- Main content -->
	<section class="content">
		<div class="row">
			<div class="col-12">
				<div class="box">
					<form action="/professor/newClassOpen.do" method="post" id="classOpenForm">
						<div class="box-body" style="display: flex">
							<div class="col-lg-6 col-12">
								<div class="box-body">
									<h4 class="box-title text-info mb-0">
										<i class="ti-user me-15"></i> 개설 강의 정보
									</h4>
									<hr class="my-15" />
									<div class="row">
										<div class="col-md-6">
											<div class="form-group">
												<label class="form-label">대학</label> 
												<input type="text" class="form-control bg-lightest" readonly="readonly" value="${professorInfoVO.departmentVO.dprtCategoryStr }" name="dprtCategoryStr" />
												<!-- department 테이블 -->
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group">
												<label class="form-label">학과</label> 
												<input type="text" class="form-control bg-lightest" readonly="readonly" value="${professorInfoVO.departmentVO.dprtName }" name="dprtName" />
												<!-- department 테이블 -->
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6">
											<div class="form-group">
												<label class="form-label">교과목</label> 
												<select class="form-control bg-lightest" id="selectLecture" name="lecNo">
													<option value="">===선택===</option>
													<c:if test="${!empty lectureList }">
														<c:forEach var="lecture" items="${lectureList }">
															<option value="${lecture.lecNo }" ixp="${lecture.lecPoint }">${lecture.lecName }</option>
														</c:forEach>
													</c:if>
												</select>
												<!-- lecture 테이블 -->
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group">
												<div class="form-group">
													<label class="form-label">개설학기</label> 
													<select class="form-select" name="semester" id="semester">
														<option value="">===선택===</option>
														<option value="2024/03" id="testOp">2024년 1학기</option>
														<option value="2024/06">2024년 여름학기</option>
														<option value="2024/09">2024년 2학기</option>
														<option value="2024/12">2023년 겨울학기</option>
													</select>
												</div>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-6">
											<div class="form-group">
												<label class="form-label">개설강의명</label> 
												<input type="text" class="form-control" placeholder="개설할 강의명을 입력" id="class_name_set" name="className" value="" />
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group">
												<label class="form-label">이수구분</label> 
												<select class="form-select" name="classReqCode">
													<option value="CLR001">전공필수</option>
													<option value="CLR002">전공선택</option>
													<option value="CLR003">교양필수</option>
													<option value="CLR004">교양선택</option>
												</select>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-3">
											<div class="form-group">
												<label class="form-label"> 학점 (최대 5)</label> <input type="number" class="form-control" placeholder="최대 5" max="5" min="0" name="lecPoint" id="lecPoint" value="0" readonly="readonly"/>
											</div>
										</div>
										<div class="col-md-3">
											<div class="form-group">
												<label class="form-label">수강인원(최대 50명)</label> <input type="number" class="form-control" placeholder="최대 50" max="50" min="0" name="classMaxMem" value="30" />
											</div>
										</div>
										<div class="col-md-3">
											<div class="form-group">
												<label class="form-label">총 강의 시간 (최대 100) </label> 
												<input type="number" class="form-control" placeholder="최대 100" max="100" min="0" name="classTotalTime" id="classTotalTime" value="0" readonly="readonly"/>
											</div>
										</div>
										<div class="col-md-3">
											<div class="form-group">
												<label class="form-label">총 횟수(주차)</label> 
												<input type="number" class="form-control" max="" min="0" name="classWeekCnt" id="classWeekCnt" value="" readonly="readonly"/>
											</div>
										</div>
									</div>
									<div class="row" style="justify-content: space-evenly">
										<div class="col-md-3">
											<div class="form-group">
												<label class="">요일</label> 
												<select class="form-select" name="lecDowCode" id="lecDowCode">
													<option value="LDW001">월</option>
													<option value="LDW002">화</option>
													<option value="LDW003">수</option>
													<option value="LDW004">목</option>
													<option value="LDW005">금</option>
													<option value="LDW006">토</option>
													<option value="LDW007">일</option>
												</select>
												<!-- lecture_schedule 테이블 -->
											</div>
										</div>
										<div class="col-md-3">
											<div class="form-group">
												<label class="">시작 교시</label> 
												<select class="form-select" name="lecStartTime" id="lecStartTime">
													<option value="LET001">1</option>
													<option value="LET002">2</option>
													<option value="LET003">3</option>
													<option value="LET004">4</option>
													<option value="LET005">5</option>
													<option value="LET006">6</option>
													<option value="LET007">7</option>
													<option value="LET008">8</option>
													<option value="LET009">9</option>
												</select>
											</div>
										</div>
										<div class="col-md-3">
											<div class="form-group">
												<label class="">종료 교시</label> 
												<select class="form-select" name="lecEndTime" id="lecEndTime">
													<option value="LET002">2</option>
													<option value="LET003">3</option>
													<option value="LET004">4</option>
													<option value="LET005">5</option>
													<option value="LET006">6</option>
													<option value="LET007">7</option>
													<option value="LET008">8</option>
													<option value="LET009">9</option>
													<option value="LET010">10</option>
												</select>
											</div>
										</div>
										<div class="col-md-1" style="line-height: 50px">
											<div class="form-group">
												<button type="button" class="btn btn-primary btn-sm btn-circle" onclick="f_plusSchedule()" id="plusSch">+</button>
											</div>
										</div>
									</div>
									<div class="row">
										<div class="col-md-12">
											<ul class="box" id="scheduleBox" style="border: 1px solid #ccc; padding: 15px 20px; max-height: 57px; overflow: auto;"></ul>
										</div>
									</div>
									<!-- <p class="text-mute">
										* 계산된 주간 총 강의 시간은 <span class="text-success"
											id="calculatedTime">0</span>, 총 담은 강의 시간은 <span
											class="text-danger" id="myTime">0</span>으로 <span
											class="text-danger" id="answerTime">충분</span>합니다.
									</p> -->
								</div>
							</div>
							<div class="col-lg-6 col-12">
								<div class="box-body">
									<h4 class="box-title text-info mb-0">
										<i class="ti-settings me-15"></i> 강의 비율 조정
									</h4>
									<hr class="my-15" />
									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<label class="form-label">학점 비율 : </label>
												<div style="display: flex; justify-content: space-between">
													<select class="form-select" name="valueType" style="width: 30%" id="valueType">
														<option disabled selected="selected">선택하세요</option>
														<c:forEach items="${ScoreValueList }" var="scoreValueVO">
															<option value="${scoreValueVO.valueType }">${scoreValueVO.valueType }</option>
														</c:forEach>
													</select> 
													<input type="number" class="form-control inst" placeholder="A" min="0" max="100" step="5" name="gradeA" id="gradeA" value="" readonly="readonly" />
													<input type="number" class="form-control inst" placeholder="B" min="0" max="100" step="5" name="gradeB" id="gradeB" value="" readonly="readonly" />
													<input type="number" class="form-control inst" placeholder="C" min="0" max="100" step="5" name="gradeC" id="gradeC" value="" readonly="readonly" />
												</div>
											</div>
										</div>
									</div>

									<div class="row">
										<p>전체 평가 비율 (100%) :</p>
										<div class="col-md-4">
											<div class="form-group">
												<label class="form-label">시험 (%)</label> 
												<input type="number" class="form-control" max="100" min="0" step="5" name="examProprion" id="examProprion" value="" />
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group">
												<label class="form-label">과제 (%)</label> 
												<input type="number" class="form-control" max="100" min="0" step="5" name="hwPropotion" id="hwPropotion" value="" />
											</div>
										</div>
										<div class="col-md-4">
											<div class="form-group">
												<label class="form-label">출석 (%)</label> 
												<input type="number" class="form-control" max="100" min="0" step="5" name="atPropotion" id="atPropotion" value="" />
											</div>
										</div>
									</div>
									<br />
									<h4 class="box-title text-info mb-0">
										<i class="ti-clip me-15"></i> 기타 참고 사항
									</h4>
									<hr class="my-15" />
									<div class="form-group">
										<label class="form-label">강의계획서 업로드 : </label> 
										<label class="file"> 
											<input type="file" id="file" name="fileName" />
										</label>
									</div>
									<div class="form-group margin">
										<label class="form-label">기타 참고사항</label>
										<textarea rows="5" class="form-control" placeholder="참고서, 강의 자료 등..." style="height: 117px" maxlength="200" name="classNote">아무 갑시낭</textarea>
									</div>
								</div>
							</div>
						</div>
						<div class="po">
							<button type="button" class="btn btn-danger-light me-1" onclick="f_test()">
								<i class=""></i> test
							</button>
							<button type="button" class="btn btn-warning me-1" onclick="f_back()">
								<i class="ti-trash"></i> 취소
							</button>
							<button type="button" id="submitBtn" class="btn btn-primary">
								<i class="ti-save-alt"></i> 신청
							</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</section>
</div>
<script type="text/javascript">
	function showEffect() {}
	function f_test() {
		$('#semester').val('2024/03');
		$("#classWeekCnt").val("16");
		setSem();
		$("#class_name_set").val("통신의 이해");
		$("#lecPoint").val("3");
		
		$("#lecDowCode").val("LDW004");
		$("#lecStartTime").val("LET003");
		$("#lecEndTime").val("LET006");
		
		$("#valueType").val("상대평가(기본1)").trigger('change');
		$("#gradeA").val("20");
		$("#gradeB").val("50");
		$("#gradeC").val("100");
		
		$("#examProprion").val("50");
		$("#hwPropotion").val("40");
		$("#atPropotion").val("10");
		
		$("#plusSch").trigger("click");
	} 


	var lecDowCodeVal; // 입력 요일 값
	var lecStartTimeVal; // 입력 강의 시작 교시
	var lecEndTimeVal; // 입력 강의 종료 교시

	var lecStartDate; // 시작일자
	var lecEndDate; // 종료일자

	var semesterVal;
	var semesterArr;

	var staMonth;
	var endMonth;
	var startDate;
	var endDate;

	var classTotalTime; // 입력 총 강의시간
	var classWeekCnt; // 입력 총 주차횟수
	var classWeekCntVal;
	var calculatedTotalWeekClassTime; // 계산된 총 주간 강의시간
	var myTotalWeekClassTime = 0; // 본인이 담은 총 주간 강의시간

	var addTime; // 담은 강의 시간 (추가하면 +, 빼면 -)

	var valueTypeVal = $("#valueType").val();
	var gradeA = document.querySelector("#gradeA");
	var gradeB = document.querySelector("#gradeB");
	var gradeC = document.querySelector("#gradeC");

	var lecScheduleList = []; // 배열로 선언
	var dayList = [];
	
	var selectLecture = $("#selectLecture");
	const class_name_set = $("#class_name_set");
	
	selectLecture.on("change", function () {
		console.log($(this).find("option:selected"));
		
		class_name_set.val($(this).find("option:selected").text())
		$("#lecPoint").val($(this).find("option:selected").attr("ixp"));
	})

	$("#valueType").on("change", function() {
		valueTypeVal = $(this).val();

		if (valueTypeVal === "상대평가(기본1)") {
			gradeA.value = "20";
			gradeB.value = "50";
			gradeC.value = "100";
		} else if (valueTypeVal === "상대평가(기본2)") {
			gradeA.value = "25";
			gradeB.value = "50";
			gradeC.value = "100";
		} else if (valueTypeVal === "상대평가(기본3)") {
			gradeA.value = "15";
			gradeB.value = "40";
			gradeC.value = "100";
		} else if (valueTypeVal === "절대평가(기본1)") {
			gradeA.value = "100";
			gradeB.value = "100";
			gradeC.value = "100";
		}
	});

	$(function() {
		scheduleBox = document.querySelector("#scheduleBox");
		classTotalTime = document.querySelector("#classTotalTime");
		classWeekCnt = document.querySelector("#classWeekCnt");

		// 주의문의 span
		myTime = document.querySelector("#myTime");
		calculatedTime = document.querySelector("#calculatedTime");
		answerTime = document.querySelector("#answerTime");
		

	});

	// 학기에 따른 강의 시작일자와 종료일자 계산 메소드
	$("#semester").on("change", function(){
		setSem();
	})
	
	function setSem() {
		semesterVal = $("#semester").val();
		semesterArr = semesterVal.split('/');

		// "2024-01-02 12:30:00"
		if(semesterArr[1] == "03") { // 1학기
			staMonth = "03";
			endMonth = "06";
			// classWeekCnt = 16주 있음
			classWeekCnt.value = "16";
			classWeekCnt.setAttribute("max", "16");
		} else if(semesterArr[1] == "06") { // 여름학기
			staMonth = "06";
			endMonth = "08";
			// classWeekCnt = 12주 있음
			classWeekCnt.value = "12";
			classWeekCnt.setAttribute("max", "12");
		} else if(semesterArr[1] == "09") { // 2학기
			staMonth = "09";
			endMonth = "12";
			// classWeekCnt = 16주 있음
			classWeekCnt.value = "16";
			classWeekCnt.setAttribute("max", "16");
		} else if(semesterArr[1] == "12") { // 겨울학기
			staMonth = "12";
			endMonth = "01";
			// classWeekCnt = 8주 있음
			classWeekCnt.value = "8";
			classWeekCnt.setAttribute("max", "8");
		}
	}

	function calculateStartDate(month, dayOfWeek, year) {
		if(dayOfWeek=="월") {
			dayOfWeek = 0;
		} else if(dayOfWeek=="화") {
			dayOfWeek = 1;
		} else if(dayOfWeek=="수") {
			dayOfWeek = 3;
		} else if(dayOfWeek=="목") {
			dayOfWeek = 4;
		} else if(dayOfWeek=="금") {
			dayOfWeek = 5;
		} else if(dayOfWeek=="토") {
			dayOfWeek = 6;
		} 

		// 첫째주의 dayOfWeek 요일을 계산
		var firstDay = new Date(year, month - 1, 1); // 월은 0부터 시작하므로 month - 1
		var dayOfWeekInMonth = firstDay.getDay();
		var diff = dayOfWeek - dayOfWeekInMonth;
		if (diff < 0) {
			diff += 7;
		}
		var startDate = new Date(year, month - 1, 1 + diff);
		return startDate.toISOString().slice(0, 10); // yyyy-mm-dd 형식으로 반환
	}

	function calculateEndDate(month, dayOfWeek, year) {
		if(dayOfWeek=="월") {
			dayOfWeek = 0;
		} else if(dayOfWeek=="화") {
			dayOfWeek = 1;
		} else if(dayOfWeek=="수") {
			dayOfWeek = 3;
		} else if(dayOfWeek=="목") {
			dayOfWeek = 4;
		} else if(dayOfWeek=="금") {
			dayOfWeek = 5;
		} else if(dayOfWeek=="토") {
			dayOfWeek = 6;
		} 

		// 마지막 주의 dayOfWeek 요일을 계산
		var lastDay = new Date(year, month, 0); // 현재 월의 마지막 날
		var dayOfWeekInMonth = lastDay.getDay();
		var diff = dayOfWeekInMonth - dayOfWeek;
		if (diff < 0) diff += 7;

		var endDate = new Date(year, month - 1, lastDay.getDate() - diff);
		return endDate.toISOString().slice(0, 10); // yyyy-mm-dd 형식으로 반환
	}

	// 전체 평가 비율 합이 100
	$("#atPropotion").on("blur", function() {

		examProprion = parseInt($("#examProprion").val()) || 0;
	    atPropotion = parseInt($("#atPropotion").val()) || 0;
	    hwPropotion = parseInt($("#hwPropotion").val()) || 0;

		var totalPercentage = examProprion + atPropotion + hwPropotion;

		if (totalPercentage != 100) {
			alert("세 비율의 합이 100이여야합니다.");
			return;
		}
	});

	function f_back() {
		window.history.back();
	}

	function f_plusSchedule() {
		lecDowCodeVal = $("#lecDowCode option:selected").text();
		lecStartTimeVal = $("#lecStartTime option:selected").text();
		lecEndTimeVal = $("#lecEndTime option:selected").text();

		classTotalTimeVal = parseInt(classTotalTime.value);
		classWeekCntVal = parseInt(classWeekCnt.value);
		
		if($("#semester").val() == null || $("#semester").val()== ""){
			alert("학기를 선택해주세요");
			return;
		}
		
		// 추가된 부분
		// 첫째주의 요일과 마지막 주의 요일을 찾아서 시작일과 종료일을 계산

		if (!dayList.includes(lecDowCodeVal)) {
			dayList.push(lecDowCodeVal);

			startDate = calculateStartDate(staMonth, dayList[0], semesterArr[0]) + " 12:30:00";
			endDate = calculateEndDate(endMonth, dayList[dayList.length - 1], semesterArr[0]) + " 12:30:00";
			console.log("startDate", startDate);
			console.log("endDate", endDate);

			var lecScheduleVO = {
				lecDowStr : lecDowCodeVal,
				lecStartTime : lecStartTimeVal,
				lecEndTime : lecEndTimeVal,
				lecStartDate : startDate,
				lecEndDate : endDate,
			};

			console.log("lecScheduleVO", lecScheduleVO);

			lecScheduleList.push(lecScheduleVO); // 배열에 추가
			console.log("값이 추가되었습니다.");
		} else {
			alert("이미 선택한 요일의 스케줄이 있습니다.");
			return;
		}

		// 총 주간 강의 시간 = 총 강의시간 / 총 주차횟수
		//calculatedTotalWeekClassTime = Math.round(classTotalTimeVal / classWeekCntVal);

		var tot = (lecEndTimeVal - lecStartTimeVal) *  classWeekCntVal;
		classTotalTime.value = tot;
		
		var str = "<li><span>"
				+ lecDowCodeVal
				+ "요일</span>&emsp;|&emsp;<span id='startCart'>"
				+ lecStartTimeVal
				+ "</span>교시 ~ <span id='lastCart'>"
				+ lecEndTimeVal
				+ "</span>교시&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;"
				+ "<button type='button' onclick='f_deleteSchedule()' class='btn btn-circle btn-xs btn-secondary'> - </button></li>";

		scheduleBox.innerHTML += str;

		// 주의문 프로세스 //
		addTime = lecEndTimeVal - lecStartTimeVal; // 담을 때마다 총 내가 담는 시간에 더해질 시간
		myTotalWeekClassTime += addTime;

		console.log("lecStartTimeVal", lecStartTimeVal);
		console.log("lecEndTimeVal", lecEndTimeVal);
		console.log("addTime", addTime);
		console.log("myTotalWeekClassTime", myTotalWeekClassTime);

		calculatedTime.innerHTML = calculatedTotalWeekClassTime;
		myTime.innerHTML = myTotalWeekClassTime;

		console.log("calculatedTotalWeekClassTime",
				calculatedTotalWeekClassTime, " : myTotalWeekClassTime",
				myTotalWeekClassTime);
		/* var answerStr;
		if (calculatedTotalWeekClassTime > myTotalWeekClassTime) {
			answerStr = "부족";
		} else if (calculatedTotalWeekClassTime < myTotalWeekClassTime) {
			answerStr = "초과";
		} else {
			answerStr = "충분";
		}

		answerTime.innerHTML = answerStr; */

		console.log("addlecScheduleList : ", lecScheduleList);
	}

	// 담은 강의 시간을 삭제하는 함수
	function f_deleteSchedule() {
		var button = event.target;
		var li = button.parentElement;
		var startCart = parseInt(li.querySelector("#startCart").innerText);
		var lastCart = parseInt(li.querySelector("#lastCart").innerText);

		console.log("lastCart", lastCart, " : startCart", startCart);
		addTime = lastCart - startCart; // 뺄 때마다 총 내가 담는 시간에 빠질 시간
		myTotalWeekClassTime -= addTime;

		myTime.innerHTML = myTotalWeekClassTime;

		/* var answerStr;
		if (calculatedTotalWeekClassTime > myTotalWeekClassTime) {
			answerStr = "부족";
		} else if (calculatedTotalWeekClassTime < myTotalWeekClassTime) {
			answerStr = "초과";
		} else {
			answerStr = "충분";
		}
		answerTime.innerHTML = answerStr; */

		let index = dayList.indexOf(lecDowCodeVal);
		if (index !== -1) {
			console.log(dayList[index]);
			dayList.splice(index, 1);
			lecScheduleList.splice(index, 1); // 배열에 추가
			console.log("값이 제거", dayList);
		}

		scheduleBox.removeChild(li);
	}

	function validateForm() {
		var inputs = document
				.querySelectorAll("#classOpenForm input, #classOpenForm select, #classOpenForm textarea");
		var isFileUploaded = document.getElementById("file").files.length > 0;
		var timeValidMsg = true; //document.querySelector("#answerTime").innerHTML === "충분";

		for (var i = 0; i < inputs.length; i++) {
			if (inputs[i].value.trim() === "") {
				// 입력란 중에 비어 있는 것이 있다면 false 반환
				return false;
			}
		}

		// 파일이 업로드되지 않았다면 false 반환
		if (!isFileUploaded) {
			return false;
		}

		// 강의시간이 '충분'이 아닌 경우 false 반환
		return timeValidMsg;
	}

	// submitBtn 클릭 시 validateForm() 호출
	var ywForm = document.querySelector("#classOpenForm");
	$("#submitBtn").click(function() {
		if (validateForm()) {
			// 조건이 충족되면 양식을 제출
			var lectureList = [];
			var lectureVO = {
				lecNo : ywForm.lecNo.value,
			};
			lectureList.push(lectureVO);

			var departmentList = [];
			var departmentVO = {
				dprtName : ywForm.dprtName.value,
				dprtCategoryStr : ywForm.dprtCategoryStr.value,
			};
			departmentList.push(departmentVO);

			/* var lecScheduleVO = {
					lecDowCode:ywForm.lecDowCode.value,
					lecStartTime:ywForm.lecStartTime.value,
					lecEndTime:ywForm.lecEndTime.value
				}
				lecScheduleList.push(lecScheduleVO); */

			var formData = new FormData(); // new FormData(ywForm);

			var classVO = {
				valueType : ywForm.valueType.value,
				className : ywForm.className.value,
				lecPoint : ywForm.lecPoint.value,
				semester : ywForm.semester.value,
				classReqCode : ywForm.classReqCode.value,
				classMaxMem : ywForm.classMaxMem.value,
				classTotalTime : ywForm.classTotalTime.value,
				examProprion : ywForm.examProprion.value,
				hwPropotion : ywForm.hwPropotion.value,
				atPropotion : ywForm.atPropotion.value,
				classStatusCode : "CLS001", // 신청 폼이니깐 무조건 상태는 '신청'
				classWeekCnt : ywForm.classWeekCnt.value,
				classNote : ywForm.classNote.value,
				lectureList : lectureList,
				departmentList : departmentList,
				lecScheduleList : lecScheduleList,
			};

			formData.append("fileName", ywForm.fileName.files[0]);
			formData.append("classVO", new Blob([ JSON.stringify(classVO) ], {
				type : "application/json;charset=utf-8",
			}));

			$.ajax({
				type : "post",
				url : "/DYUniv/professor/newClassOpen.do",
				contentType : false,
				processData : false,
				cache : false,
				data : formData,
				dataType : "text",
				success : function(rslt) {
					console.log("아작스 성공 체킁:", rslt);
					location.href = "/DYUniv/professor/classOpenList.do";
				},
			});
			console.log("체킁:", classVO);
			/* for(var elem of ywForm){
					console.log(elem);
				} */
		} else {
			alert("입력값이 충분하지 않습니다. 확인 후 다시 시도하세요.");
		}
	});
</script>
