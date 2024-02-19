<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<style>
.demo-checkbox label {
	min-width: 60px !important;
}

th {
	text-align: center;
	border: 1px solid #fff;
}

.period {
	color: gray;
	font-size: 0.8rem;
}

.cmName {
	font-size: 25px;
	font-weight: 600; position : absolute; top : 18px;
	right: 45px;
	position: absolute;
	top: 18px;
}
</style>

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
<div class="container-full">
	<!-- Content Header (Page header) -->
	<div class="content-header">
		<div class="d-flex align-items-center">
			<div class="me-auto">
				<h3 class="page-title">내 모임</h3>
				<div class="d-inline-block align-items-center">
					<nav>
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="#"><i
									class="mdi mdi-home-outline"></i></a></li>
							<li class="breadcrumb-item" aria-current="page">모임</li>
							<li class="breadcrumb-item active" aria-current="page">내 모임
							</li>
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
				<div class="box" style="min-height: 47rem;">
					<div class="box-body">
						<!-- Nav tabs -->
						<ul class="nav nav-tabs customtab2" role="tablist">
							<li class="nav-item"><a class="nav-link active"
								data-bs-toggle="tab" href="#communityHome" role="tab"> <span
									class="hidden-sm-up"><i class="ion-home"></i></span> <span
									class="hidden-xs-down">모임 홈</span></a></li>
							<li class="nav-item"><a class="nav-link"
								data-bs-toggle="tab" href="#communityChat" role="tab"
								onclick="contentScroll();"> <span class="hidden-sm-up"><i
										class="ion-email"></i></span> <span class="hidden-xs-down">모임
										채팅</span></a></li>
							<li class="nav-item"><a class="nav-link"
								data-bs-toggle="tab" href="#communitySchedule" role="tab"> <span
									class="hidden-sm-up"><i class="ion-email"></i></span> <span
									class="hidden-xs-down">모임 정보</span></a></li>
						</ul>
						<!-- Tab panes -->
						<div class="tab-content">
							<c:set var="memNo" value="${member.memNo }" />
							<!-- 모임 스케쥴 목록 -->
							<div class="tab-pane active" id="communityHome" role="tabpanel">
								<div class="row col-12" id="reserveDateForm"
									style="justify-content: space-between; overflow: auto;">
									<c:set var="schedule" value="${classScheduleList }" />
									<!-- 공유시간표 -->
									<div class="col-xl-7" style="height: 580px; overflow: auto;">

										<h4 class="text-primary cmName">
											<span>${communityVO.cmName }</span><span> 커뮤니티</span>
										</h4>

										<table class="table table-bordered mb-0" id="schTable">
											<thead>
												<tr>
													<th scope="col"></th>
													<th scope="col" class="addDate">Monday</th>
													<th scope="col" class="addDate">Tuesday</th>
													<th scope="col" class="addDate">Wednesday</th>
													<th scope="col" class="addDate">Thursday</th>
													<th scope="col" class="addDate">Friday</th>
													<th scope="col" class="addDate">Saturday</th>
												</tr>
											</thead>
											<tbody>
												<tr class="1">
													<th scope="row">9 <span class="period"> - 1교시</span></th>
													<td class="Monday"></td>
													<td class="Tusday"></td>
													<td class="Wendsday"></td>
													<td class="Thursday"></td>
													<td class="Friday"></td>
													<td class="Saturday"></td>
												</tr>
												<tr class="2">
													<th scope="row">10 <span class="period"> - 2교시</span></th>
													<td class="Monday"></td>
													<td class="Tusday"></td>
													<td class="Wendsday"></td>
													<td class="Thursday"></td>
													<td class="Friday"></td>
													<td class="Saturday"></td>
												</tr>
												<tr class="3">
													<th scope="row">11 <span class="period"> - 3교시</span></th>
													<td class="Monday"></td>
													<td class="Tusday"></td>
													<td class="Wendsday"></td>
													<td class="Thursday"></td>
													<td class="Friday"></td>
													<td class="Saturday"></td>
												</tr>
												<tr class="4">
													<th scope="row">12 <span class="period"> - 4교시</span></th>
													<td class="Monday"></td>
													<td class="Tusday"></td>
													<td class="Wendsday"></td>
													<td class="Thursday"></td>
													<td class="Friday"></td>
													<td class="Saturday"></td>
												</tr>
												<tr class="5">
													<th scope="row">13 <span class="period"> - 5교시</span></th>
													<td class="Monday"></td>
													<td class="Tusday"></td>
													<td class="Wendsday"></td>
													<td class="Thursday"></td>
													<td class="Friday"></td>
													<td class="Saturday"></td>
												</tr>
												<tr class="6">
													<th scope="row">14 <span class="period"> - 6교시</span></th>
													<td class="Monday"></td>
													<td class="Tusday"></td>
													<td class="Wendsday"></td>
													<td class="Thursday"></td>
													<td class="Friday"></td>
													<td class="Saturday"></td>
												</tr>
												<tr class="7">
													<th scope="row">15 <span class="period"> - 7교시</span></th>
													<td class="Monday"></td>
													<td class="Tusday"></td>
													<td class="Wendsday"></td>
													<td class="Thursday"></td>
													<td class="Friday"></td>
													<td class="Saturday"></td>
												</tr>
												<tr class="8">
													<th scope="row">16 <span class="period"> - 8교시</span></th>
													<td class="Monday"></td>
													<td class="Tusday"></td>
													<td class="Wendsday"></td>
													<td class="Thursday"></td>
													<td class="Friday"></td>
													<td class="Saturday"></td>
												</tr>
												<tr class="9">
													<th scope="row">17 <span class="period"> - 9교시</span></th>
													<td class="Monday"></td>
													<td class="Tusday"></td>
													<td class="Wendsday"></td>
													<td class="Thursday"></td>
													<td class="Friday"></td>
													<td class="Saturday"></td>
												</tr>
												<tr class="10">
													<th scope="row">18 <span class="period"> - 10교시</span></th>
													<td class="Monday"></td>
													<td class="Tusday"></td>
													<td class="Wendsday"></td>
													<td class="Thursday"></td>
													<td class="Friday"></td>
													<td class="Saturday"></td>
												</tr>
												<tr class="11">
													<th scope="row">19 <span class="period"> - 11교시</span></th>
													<td class="MONDAY"></td>
													<td class="Tusday"></td>
													<td class="Wendsday"></td>
													<td class="Thursday"></td>
													<td class="Friday"></td>
													<td class="Saturday"></td>
												</tr>
												<tr class="12">
													<th scope="row">20 <span class="period"> - 12교시</span></th>
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
									<!-- /공유시간표 -->

									<div class="col-xl-4" style="margin-right: 2.5%;">
										<div class="box">
											<div class="box-header">
												<div class="row">
													<div class="col-8">
														<h4 class="box-title">
															<strong>가입자 일정 보기</strong>
														</h4>
														<div>
															<span class=""
																style="background-color: #B5E61D; border: 1px solid black; padding-right: 20px;"></span>&nbsp;
															: 커뮤니티 일정
														</div>
													</div>
													<div class="col-4">
														<button type="button"
															class="btn btn-primary mb-5 flex-end"
															style="font-size: 12px; width: 135px; margin-bottom: 15px !important; float: right"
															data-bs-toggle="modal" data-bs-target="#createPlan">커뮤니티
															일정추가</button>
													</div>
												</div>
											</div>
											<div class="box" style="height: 60%; overflow: auto;">
												<div class="box-body">
													<div class="media-list media-list-divided media-list-hover">
														<c:set var="cnt" value="1" />
														<c:forEach items="${communityVO.cmMemberList }"
															var="member">
															<div class="form-group">
																<div class="demo-checkbox" style="padding-left: 25px;">
																	<input type="checkbox" name="chkMember"
																		value="${member.memNo }" id="md_checkbox_${cnt }"
																		class="filled-in chk-col-primary sc_ch_btn"
																		onchange="fCkChg(this)"
																		<c:if test="${member.memNo eq memNo}">checked</c:if> />
																	<!-- 위의 input의 id와 아래 label의 for 명 일치, ** 리스트 커질때 하나씩 커져야함 -->
																	<label for="md_checkbox_${cnt }"> <a>
																			<div>
																				<h6 style="margin: 0;">${member.memName }</h6>
																				<small> <span>${member.dprtName }</span> <span
																					class="divider-dash">${member.memId }</span>
																				</small>
																			</div>
																	</a>
																	</label>
																</div>
															</div>
															<c:set var="cnt" value="${cnt + 1 }" />
														</c:forEach>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>

							<!-- 커뮤니티 채팅 -->
							<div class="tab-pane" id="communityChat" role="tabpanel">
								<!-- chat  -->
								<section class="content">
									<div class="row">
										<!-- 채팅 -->
										<div class="col-lg-9 col-12">
											<div class="row">
												<div class="col-xl-8 col-12">
													<div class="box bg-lightest" style="height: 550px;">
														<div class="box-header" style="padding: 1rem;">
															<div class="media align-items-top p-0">
																<p class="text-primary" style="font-size: 20px;">
																	${communityVO.cmName } 모임 채팅</p>
															</div>
														</div>
														<div class="box-body"
															style="max-height: 450px; overflow-y: scroll;"
															id="chatBox">
															<div class=".direct-chat-messages" id="chatContent">

																<c:if test="${!empty cmChatList }">
																	<c:forEach items="${cmChatList }" var="chat">
																		<c:if test="${chat.memNo eq memNo }">

																			<div
																				class="card d-inline-block mb-3 float-end me-2 bg-primary max-w-p80 min-w-300">
																				<div class="position-absolute pt-1 pe-2 r-0">
																					<span class="text-extra-small">${fn:substring(chat.chatDate,
																						0, 10) }</span>
																				</div>
																				<div class="card-body">
																					<div class="d-flex flex-row pb-2">
																						<div class="d-flex flex-grow-1 min-width-zero">
																							<div
																								class="m-2 ps-0 align-self-center d-flex flex-column flex-lg-row justify-content-between">
																								<div class="min-width-zero">
																									<p class="mb-0 fs-16">${chat.chatSender
																										}
																									</p>
																								</div>
																							</div>
																						</div>
																					</div>
																					<div class="chat-text-start ps-55">
																						<p class="mb-0 text-semi-muted">
																							${chat.chatMsg }</p>
																					</div>
																				</div>
																			</div>
																			<div class="clearfix"></div>
																		</c:if>
																		<c:if test="${chat.memNo ne memNo }">
																			<div
																				class="card d-inline-block mb-3 float-start me-2 no-shadow bg-lighter max-w-p80 min-w-300">
																				<div class="position-absolute pt-1 pe-2 r-0">
																					<span class="text-extra-small text-muted">${fn:substring(chat.chatDate,
																						0, 10) }</span>
																				</div>
																				<div class="card-body">
																					<div class="d-flex flex-row pb-2">
																						<div class="d-flex flex-grow-1 min-width-zero">
																							<div
																								class="m-2 ps-0 align-self-center d-flex flex-column flex-lg-row justify-content-between">
																								<div class="min-width-zero">
																									<p class="mb-0 fs-16 text-dark">
																										${chat.chatSender
																										}
																									</p>
																								</div>
																							</div>
																						</div>
																					</div>
																					<div class="chat-text-start ps-55">
																						<p class="mb-0 text-semi-muted">
																							${chat.chatMsg }</p>
																					</div>
																				</div>
																			</div>
																			<div class="clearfix"></div>
																		</c:if>
																	</c:forEach>
																</c:if>
															</div>
														</div>
														<div class="box-footer no-border">
															<div
																class="d-md-flex d-block justify-content-between align-items-center bg-white p-5 rounded10 b-1 overflow-hidden">
																<input class="form-control b-0 py-10" type="text"
																	placeholder="Say 메시지 입력" id="msg">
																<div
																	class="d-flex justify-content-between align-items-center mt-md-0 mt-30">
																	<button type="button"
																		class="waves-effect waves-circle btn btn-circle me-10 btn-outline-secondary"
																		id="fileUploadBtn">
																		<i class="mdi mdi-link"></i>
																	</button>
																	<button type="button"
																		class="waves-effect waves-circle btn btn-circle btn-primary"
																		id="sendBtn">
																		<i class="mdi mdi-send"></i>
																	</button>
																</div>
															</div>
														</div>
													</div>
												</div>
												<!-- <div class="col-xl-4 col-12">
													<div class="box">
														<div class="box-header">
															<h3 class="box-title"> <strong>채팅 인원</strong>
															</h3>
														</div>
														<div class="box-body">
											  <div class="alert alert-success alert-dismissible fade show" role="alert">
												<strong>(타이틀)</strong><br> (내용)
											  </div>				
										  </div>
														<div class="box"
															style="height: 60%; overflow: auto;">
															<div class="box-body">
																<div class="media-list media-list-divided media-list-hover"
																	id="">

																	<div class="form-group">
																		<div class="demo-checkbox"
																			style="padding-left: 25px;">
																			<input type="checkbox"
																				id="md_checkbox_12"
																				class="filled-in chk-col-primary" />
																			<label for="md_checkbox_12">
																				<a>
																					<div>
																						<h6
																							style="margin: 0;">
																							홍길동</h6>
																						<small> <span>사회교육학과
																								3학년</span>
																							<span
																								class="divider-dash">201210111</span>
																						</small>
																					</div>
																				</a>
																			</label>
																		</div>
																	</div>

																	<div class="form-group">
																		<div class="demo-checkbox"
																			style="padding-left: 25px;">
																			<input type="checkbox"
																				id="md_checkbox_13"
																				class="filled-in chk-col-primary" />
																			<label for="md_checkbox_13">
																				<a>
																					<div>
																						<h6
																							style="margin: 0;">
																							홍길동</h6>
																						<small> <span>사회교육학과
																								3학년</span>
																							<span
																								class="divider-dash">201210111</span>
																						</small>
																					</div>
																				</a>
																			</label>
																		</div>
																	</div>
																</div>
															</div>
														</div>
													</div>
												</div> -->
												<div class="col-xl-4">
													<button class="btn btn-danger-light" id="chatTest">test</button>
												</div>
											</div>
										</div>
									</div>
								</section>
								<!-- /chat -->
							</div>

							<!-- 모임 정보 -->
							<div class="tab-pane" id="communitySchedule" role="tabpanel">
								<div class="row col-12">
									<div class="box-body">
										<h4 class="box-title">모임 정보</h4>
										<div class="table-responsive" style="display: flex; justify-content: center;">
											<table class="table b-1 border-primary" style="width: 80%;">
												<tbody>
													<tr>
														<th class="bg-primary text-center" width="30%">그룹명</th>
														<td>${communityVO.cmName }</td>
													</tr>
													<tr>
														<th class="bg-primary text-center">그룹 마스터</th>
														<td>${communityVO.cmMaster }</td>
													</tr>
													<tr>
														<th class="bg-primary text-center">그룹 분류</th>
														<td><c:if test="${communityVO.cmType eq 'CMT001' }">
																	학업</c:if> <c:if test="${communityVO.cmType eq 'CMT002' }">
																	외국어</c:if> <c:if test="${communityVO.cmType eq 'CMT003' }">
																	봉사</c:if> <c:if test="${communityVO.cmType eq 'CMT004' }">
																	예체능</c:if> <c:if test="${communityVO.cmType eq 'CMT005' }">
																	여가</c:if> <c:if test="${communityVO.cmType eq 'CMT006' }">
																	종교</c:if> <c:if test="${communityVO.cmType eq 'CMT007' }">
																	기타</c:if></td>
													</tr>
													<tr>
														<th class="bg-primary text-center">목표</th>
														<td>${communityVO.cmGoal }</td>
													</tr>
													<tr>
														<th class="bg-primary text-center">최대 인원</th>
														<td>${communityVO.cmMaxMem }</td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- /.box-body -->
				</div>
				<!-- /.box -->
			</div>
			<!-- /.col -->
		</div>
	</section>
	<!-- 일정추가 모달 시작 -->
	<div class="modal center-modal fade" id="createPlan" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">
						<strong>모임 일정 추가</strong>
					</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="cmInsertForm" method="post"
						action="/DYUniv/student/addCommunitySch.do">
						<div class="form-group row">
							<label class="col-form-label"><strong>일자 일시</strong></label> <br>
							<label class="col-form-label col-md-2">날짜</label>
							<div class="col-md-10" style="margin-bottom: 15px;">
								<input class="form-control" type="date" name="schStart"
									id="schStart" /> <input class="form-control" type="hidden"
									name="schEnd" id="schEnd" />
							</div>
							<label class="col-form-label col-md-2">시작 시간</label>
							<div class="col-md-10">
								<input type="number" min="9" max="20"
									class="form-control timepicker" placeholder="1-20"
									name="schStartTime" id="schStartTime" />
							</div>
							<label class="col-form-label col-md-2">완료 시간</label>
							<div class="col-md-10">
								<input type="number" min="9" max="20"
									class="form-control timepicker" placeholder="1-20"
									name="schEndTime" id="schEndTime" />
							</div>
						</div>
						<div class="form-group">
							<label class="form-label"><strong>일정 내용</strong></label>
							<textarea rows="3" class="form-control" id="schName"
								name="schName" placeholder="일정 내용을 입력하세요."></textarea>
						</div>
						<%-- <c:forEach items="${communityVO.cmMemberList }" var="member" varStatus="status">
							<input type="hidden" name="memNoList[${status.index }]" value="${member.memNo }">
						</c:forEach> --%>
						<input type="hidden" name="cmNo" value="${cmNo }">
					</form>
				</div>
				<div class="modal-footer modal-footer-uniform">
					<button type="button" class="btn btn-danger"
						data-bs-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary float-end"
						id="comunitySchSave">추가</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 일정추가 모달 끝 -->
</div>
<script src="${pageContext.request.contextPath}/resources/js/chat.js"></script>
<script>
	var backColor = [ "RGB(210,200,240)", "RGB(250,210,220)",
			"RGB(200,240,200)", "RGB(240,220,190)", "#C3C3C3" ];
	var fontColor = [ "white", "white", "white", "white", "", "black" ];
	var colorIndex = 0;

	var addDates = document.getElementsByClassName('addDate');
	var curDate = "";
	$(function() {
		// 테이블에 날짜 추가
		function addDate() {
			var date = new Date();

			for (var i = 0; i < addDates.length; i++) {
				curDate = dateFormat(
						new Date(date.getFullYear(), date.getMonth(), (date
								.getDate())+1
								- date.getDay() + i)).substr(5, 6)

				var weekends = addDates[i].textContent;
				addDates[i].innerHTML = weekends
						+ "<br/><span style='font-weight: normal;'>(" + curDate
						+ ")";
			}
		}
		addDate();

		// 커뮤니티 일정 생성 이벤트
		$("#comunitySchSave")
				.on(
						"click",
						function() {
							var schName = $("#schName").val();
							var schStart = $("#schStart").val();
							$("#schEnd").val(schStart);

							var schStartTime = $("#schStartTime").val();
							var schEndTime = $("#schEndTime").val();
							var cmInsertForm = $("#cmInsertForm");

							// 선택 멤버 배열
							var chkMemArr = [];
							$("input[name=chkMember]:checked").each(function() {
								var chkMember = $(this).val();
								chkMemArr.push(chkMember);
							})
							var newInput = document.createElement('input');
							console.log("chkMemArr1", chkMemArr);
							var code = "";
							for (var i = 0; i < chkMemArr.length; i++) {
								code += '<input type="hidden" name="memNoList[' + i +']" value="' + chkMemArr[i] + '"/>'
							}

							cmInsertForm.append(code);
							cmInsertForm.submit();

						});

	})

	// 로그인 정보
	var memNo = parseInt("${memNo}");
	console.log("loginMemNo", memNo);

	/* // 내 일정(강의+일반) => 기본 출력
	$.ajax({
		type : "get",
		url : "/DYUniv/student/community.ajax",
		dataType : "json",
		success : function(res) {
			console.log("loginRes", res);
			addSchedule(res, "m" + memNo);
		}
	}); */
	
	
	//내 일정
	$.ajax({
		type : "get",
		url : "/DYUniv/student/allSchShare.ajax",
		data : {
			memNo : memNo
		},
		dataType : "json",
		success : function(res) {
			//console.log("res",res)
			addSchedule(res.classSchShare, "m" + memNo);
			addShareSchedule(res.scheduleShare, "m"+ memNo);
		}
	})

	// 공유 일정(강의+일반) => 체크 출력
	function fCkChg(pThis) {
		// 일반 스케줄
		$.ajax({
			type : "get",
			url : "/DYUniv/student/allSchShare.ajax",
			data : {
				memNo : pThis.value
			},
			dataType : "json",
			success : function(res) {
				console.log("memNo", memNo);
				console.log("shareRes", res);
				if (pThis.checked) {
					addSchedule(res.classSchShare, "m"
							+ res.classSchShare[0].memNo); // 강의
					addShareSchedule(res.scheduleShare, "m"
							+ res.scheduleShare[0].memNo); // 일반
				} else {
					removeSchedule(res.classSchShare, "m"
							+ res.classSchShare[0].memNo);
					removeSchedule(res.scheduleShare, "m"
							+ res.scheduleShare[0].memNo);
				}
			}
		})
	}

	// 체크 일정(일반)
	function addShareSchedule(res, memNo) {
		for (var i = 0; i < addDates.length; i++) {
			var dateStr = addDates[i].innerText.replace(/[()]/g, '').substr(-6); // 기준 날짜
			//console.log("dateStr", dateStr);

			for (var j = 0; j < res.length; j++) {
				var schDateStr = res[j].schStart.substr(5, 6); // 커뮤니티 일정 날짜
				var shareStime = res[j].schStartTime; // 시작 교시
				var shareEtime = res[j].schEndTime;

				var findDow = [ "Monday", "Tusday", "Wendsday", "Thursday",
						"Friday", "Saturday" ];

				// 완료 교시
				//console.log("schDateStr", schDateStr);

				if (dateStr == schDateStr) {
					console.log("correct", shareStime, shareEtime);

					for (var k = parseInt(shareStime); k <= parseInt(shareEtime); k++) {
						var findPath = "." + parseInt(k - 8) + " ."
								+ findDow[i];
						//console.log("findPath :", findPath);

						var code = '<div class="m777" style="background-color: #B5E61D; color: black;">'
								+ res[j].schName + '</div>';

						$(findPath).html(code);
					}
				}
			}
		}
	}

	// 일정  출력
	function addSchedule(res, memNo) {
		var bColor = getRandomColor();
		var fColor = "white";
		colorIndex++;

		console.log("totalRes", res);

		for (var i = 0; i < res.length; i++) {
			if (res[i].lecDowCode == 'LDW001') {
				dow = "Monday";
			}
			if (res[i].lecDowCode == 'LDW002') {
				dow = "Tusday";
			}
			if (res[i].lecDowCode == 'LDW003') {
				dow = "Wendsday";
			}
			if (res[i].lecDowCode == 'LDW004') {
				dow = "Thursday";
			}
			if (res[i].lecDowCode == 'LDW005') {
				dow = "Friday";
			}
			if (res[i].lecDowCode == 'LDW006') {
				dow = "Saturday";
			}

			// 내 일정(강의 + 일반)
			for (var j = parseInt(res[i].lecStartTime); j <= parseInt(res[i].lecEndTime); j++) {
				var findPath = "." + j + " ." + dow;
				var ch = $(findPath);

				for (let k = 0; k < ch.length; k++) {
					var addDiv = document.createElement("div");
					addDiv.setAttribute("class", memNo);
					addDiv.innerHTML = res[i].className;
					addDiv.style.backgroundColor = bColor;
					addDiv.style.color = fColor;
					ch[k].appendChild(addDiv);

					// 내용 중복체크 ====> 함수로 뺄 것
					var dChilds = ch[k].children;
					var isRepeat = false; // 반복 없음 초기화
					for (let z = 0; z < dChilds.length; z++) {
						if (dChilds[z].innerHTML == res[i].schName) {
							isRepeat = true; // 반복 있음.
							break;
						}
					}
					if (!isRepeat) {
						ch[k].appendChild(addDiv);
					}
				}
				//ch.html(res[i].className);
			}

			// 체크 일정(강의)
			for (var j = parseInt(res[i].schStartTime); j <= parseInt(res[i].schEndTime); j++) {
				var findPath = "." + j + " ." + dow;
				var ch = $(findPath);

				for (let k = 0; k < ch.length; k++) {
					var addDiv = document.createElement("div");
					addDiv.setAttribute("class", memNo);
					addDiv.innerHTML = res[i].className;
					addDiv.style.backgroundColor = bColor;
					addDiv.style.color = fColor;

					// 내용 중복체크 ====> 함수로 뺄 것
					var dChilds = ch[k].children;
					var isRepeat = false; // 반복 없음으로 초기값
					for (let z = 0; z < dChilds.length; z++) {
						if (dChilds[z].innerHTML == res[i].className) {
							isRepeat = true; // 반복 있음.
							break;
						}
					}
					if (!isRepeat) {
						ch[k].appendChild(addDiv);
					}
				}
			}
		}
	}

	// 일정 제거
	function removeSchedule(res, memNo) {
		$("." + memNo).remove(); // 해당 클래스의 div 삭제
		colorIndex--;
	}

	$(function() {
		contentScroll();

		var sendBtn = $("#sendBtn");
		var fileUploadBtn = $("#fileUploadBtn");

		var sock = new SockJS("/community");

		sock.onopen = function() {
			console.log("연결완료");
		}

		sock.onmessage = function(res) {
			var data = JSON.parse(res.data);
			console.log("socket data :", data);

			if (data.resString == 'FAILED') {
				Swal.fire({
					icon : "error",
					text : "전송에 실패하였습니다.",
				});
			}

			if (memNo == data.memNo) {
				msgOnMe(data);
			} else {
				msgOnOther(data);
			}
			contentScroll();
		}

		sock.onclose = function() {
			console.log("연결 종료");
		}

		//메시지 전송버튼
		sendBtn.on("click", function() {
			console.log("send");

			var msg = $("#msg").val();

			if (msg == null || msg == "") {
				return false;
			}

			console.log("msg : " + msg)

			$("#msg").val("");

			data = {
				"chatMsg" : msg,
			}

			sock.send(JSON.stringify(data));
		})

		//파일 전송
		fileUploadBtn.on("click", function() {
			console.log("file");
		})

	})

	function msgOnOther(msgData) {
		console.log("msgOnOther");

		code = "";

		code += '<div class="card d-inline-block mb-3 float-start me-2 no-shadow bg-lighter max-w-p80 min-w-300" animated headShake>        '
				+ '	<div class="position-absolute pt-1 pe-2 r-0">                                                               '
				+ '		<span class="text-extra-small text-muted">'
				+ dateFormat(new Date).substr(0, 10)
				+ '</span>                                                  '
				+ '	</div>                                                                                                      '
				+ '	<div class="card-body">                                                                                     '
				+ '		<div class="d-flex flex-row pb-2">                                                                      '
				+ '			<div class="d-flex flex-grow-1 min-width-zero">                                                     '
				+ '				<div class="m-2 ps-0 align-self-center d-flex flex-column flex-lg-row justify-content-between"> '
				+ '					<div class="min-width-zero">                                                                '
				+ '						<p class="mb-0 fs-16 text-dark">'
				+ msgData.chatSender
				+ '</p>                                       '
				+ '					</div>                                                                                      '
				+ '				</div>                                                                                          '
				+ '			</div>                                                                                              '
				+ '		</div>                                                                                                  '
				+ '		<div class="chat-text-start ps-55">                                                                     '
				+ '			<p class="mb-0 text-semi-muted">'
				+ msgData.chatMsg
				+ ' </p>                                                           '
				+ '		</div>                                                                                                  '
				+ '	</div>                                                                                                      '
				+ '  </div>                                                                                                      '
				+ '  <div class="clearfix"></div>                                                                                '

		$("#chatContent").append(code);
	}

	function msgOnMe(msgData) {
		console.log("msgOnMe");

		code = "";

		code += '<div class="card d-inline-block mb-3 float-end me-2 bg-primary max-w-p80 min-w-300" animated headShake>                    '
				+ '<div class="position-absolute pt-1 pe-2 r-0">                                                                    '
				+ '	<span class="text-extra-small">'
				+ dateFormat(new Date).substr(0, 10)
				+ '</span>                                                                  '
				+ '</div>                                                                                                           '
				+ '<div class="card-body">                                                                                          '
				+ '	<div class="d-flex flex-row pb-2">                                                                           '
				+ '		<div class="d-flex flex-grow-1 min-width-zero">                                                          '
				+ '			<div class="m-2 ps-0 align-self-center d-flex flex-column flex-lg-row justify-content-between">      '
				+ '				<div class="min-width-zero">                                                                     '
				+ '					<p class="mb-0 fs-16">'
				+ msgData.chatSender
				+ '</p>                                                      '
				+ '				</div>                                                                                           '
				+ '			</div>                                                                                               '
				+ '		</div>                                                                                                   '
				+ '	</div>                                                                                                       '
				+ '	<div class="chat-text-start ps-55">                                                                          '
				+ '		<p class="mb-0 text-semi-muted">'
				+ msgData.chatMsg
				+ '</p>  '
				+ '	</div>                                                                                                       '
				+ '</div>                                                                                                           '
				+ '</div>                                                                                                             '
				+ '<div class="clearfix"></div>                                                                                       '

		$("#chatContent").append(code);
	}

	//스케줄 색상 - 랜덤
	function getRandomColor() {
		var color = Math.floor(Math.random() * 127 + 128).toString(16);
		color += Math.floor(Math.random() * 127 + 128).toString(16);
		color += Math.floor(Math.random() * 127 + 128).toString(16);
		return "#" + color;
	}
	
	$("#chatTest").on("click", function () {
		$("#msg").val("17일날 9시 부터 풋살어때?");
	})
</script>