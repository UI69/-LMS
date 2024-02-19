<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!-- Content Header (Page header) -->
<div class="content-header">
	<div class="d-flex align-items-center">
		<div class="me-auto">
			<h3 class="page-title">${myClassVO.className }</h3>
			<div class="d-inline-block align-items-center">
				<nav>
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="#">
								<i class="mdi mdi-home-outline"></i></a></li>
						<li class="breadcrumb-item" aria-current="page">강의</li>
						<li class="breadcrumb-item active" aria-current="page">수강</li>
					</ol>
				</nav>
			</div>
		</div>
	</div>
</div>
<div class="row m-10 bg-white">
	<div class="row col-md-3">
		<div class="form-group">
			<strong>대학</strong>
			<div class="b-1 border-dark rounded p-1 ps-2">
				<c:if test="${myClassVO.dprtCategory eq 'DPC001'}">인문</c:if>
				<c:if test="${myClassVO.dprtCategory eq 'DPC002'}">사회</c:if>
				<c:if test="${myClassVO.dprtCategory eq 'DPC003'}">교육</c:if>
				<c:if test="${myClassVO.dprtCategory eq 'DPC004'}">공학</c:if>
				<c:if test="${myClassVO.dprtCategory eq 'DPC005'}">자연</c:if>
				<c:if test="${myClassVO.dprtCategory eq 'DPC006'}">의약</c:if>
				<c:if test="${myClassVO.dprtCategory eq 'DPC007'}">예체능</c:if>
			</div>
		</div>
	</div>
	<div class="row col-md-3">
		<div class="form-group">
			<strong>학과</strong>
			<div class="b-1 border-dark rounded p-1 ps-2">${myClassVO.dprtName }</div>
		</div>
	</div>
	<div class="row col-md-4">
		<div class="form-group">
			<strong>강의명</strong>
			<div class="b-1 border-dark rounded p-1 ps-2">${myClassVO.className }</div>
		</div>
	</div>
	<div class="row col-md-2">
		<div class="form-group">
			<strong>수강인원</strong>
			<div class="b-1 border-dark rounded p-1 ps-2">
				${myClassVO.classRegCnt }/${myClassVO.classMaxMem }
			</div>
		</div>
	</div>
</div>
<ul class="nav nav-tabs" role="tablist">
	<li class="nav-item">
		<a class="nav-link active" data-bs-toggle="tab" href="#debit-card" role="tab" aria-selected="true">
			<span class="hidden-sm-up"><i class="fa fa-cc"></i></span>
			<span class="hidden-xs-down">강의 자료실</span>
		</a>
	</li>
	<li class="nav-item">
		<a class="nav-link" data-bs-toggle="tab" href="#paypal1" role="tab" aria-selected="false">
			<span class="hidden-sm-up"><i class="fa fa-paypal"></i></span>
			<span class="hidden-xs-down">강의 과제</span>
		</a>
	</li>
	<li class="nav-item">
		<a class="nav-link" data-bs-toggle="tab" href="#paypal2" role="tab" aria-selected="false">
			<span class="hidden-sm-up"><i class="fa fa-paypal"></i></span>
			<span class="hidden-xs-down">온라인 시험</span>
		</a>
	</li>
</ul>

<div class="tab-content tabcontent-border m-15 bg-white">
	<div class="tab-pane active" id="debit-card" role="tabpanel">
		<div class="box-body">
			<h3 style="margin: 30px;"><strong>강의 자료실</strong></h3>

			<div class="table-responsive" style="margin: 30px;">
				<table class="table">
					<thead class="bg-primary">
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성일</th>
							<th>조회</th>
							<th>파일</th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty classBoardList }">
								<tr>
									<td colspan="4">조회하실 게시물이 존재하지 않습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
							<c:set var="reverseIndex" value="${fn:length(classBoardList) }"/>
								<c:forEach items="${classBoardList }" var="classBoard">
									<tr>
										<td>
											${reverseIndex }
											<c:set var="reverseIndex" value="${reverseIndex -1 }"/>
										</td>
										<td>
											<button type="button"
												class="btn btn-primary-light btn-sm classBoardBtn"
												style="max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;"
												data-bs-toggle="modal" data-bs-target="#modal-classBrdTitle"
												idx="${classBoard.classBrdNo}">
												${classBoard.classBrdTitle }
											</button>
										</td>
										<td>${fn:substring(classBoard.classWriteDate, 0, 10) }</td>
										<td>${classBoard.classBrdHitCount }</td>
										<td style="text-align: center;">
											<c:if test="${classBoard.fileNo ne 0 }">
												<button type="button"
													class="btn btn-circle btn-xs btn-primary"
													onclick="FileDownload1(this)" idx="${classBoard.fileNo}"
													idn="${classBoard.fileName }">
													<i class="fa fa-folder-open" style="color: white"></i>
												</button>
											</c:if>
										</td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
			<!-- 모달창 -->
			<div class="modal center-modal fade row" id="modal-classBrdTitle" tabindex="-1"
				style="display: none;" aria-hidden="true">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title">
								<strong></strong>
							</h4>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body b-4 min-h-300">
							<p>
								<span class=""> 내용 </span>
								<a type="button" class="float-end" id="downloadBtn" href="#"
								onclick="FileDownload1(this)" idx="" idn="">
								다운로드</a></p>
							<p id="brdModalCont"></p>
						</div>
						<div class="modal-footer modal-footer-uniform">
							<button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>

			<!-- 모달창 끝 -->
		</div>
	</div>

	<div class="tab-pane" id="paypal1" role="tabpanel">
		<div class="box-body">
			<h3 style="margin: 30px;"><strong>강의 과제</strong></h3>
			<div class="table-responsive">
				<div id="example_wrapper"
					class="dataTables_wrapper container-fluid dt-bootstrap4 no-footer">

					<div class="row">
						<div class="box-body">
							<div class="table-responsive">
								<table class="table">
									<thead class="bg-primary">
										<tr>
											<th>과제번호</th>
											<th>제목</th>
											<th>내용</th>
											<th>제출기한</th>
											<th>과제 현황</th>
										</tr>
									</thead>
									<tbody>
									
										<c:choose>
											<c:when test="${empty homeworkList }">
												<tr>
													<td colspan="4">조회하실 게시물이 존재하지 않습니다.</td>
												</tr>
											</c:when>
											<c:otherwise>
												<c:set var="reverseIndex" value="${fn:length(homeworkList) }"/>
												<c:forEach items="${homeworkList }" var="homework">
													<tr>
														<td>
															${reverseIndex }
															<c:set var="reverseIndex" value="${reverseIndex -1 }"/>
														</td>
														<td>${homework.hwTitle }</td>
														<td>${homework.hwCont }</td>
														<td>${fn:substring(homework.hwUpload, 0, 10) }</td>
														<td>
															<c:set var="check" value="false"/>
															<c:set var="hwSbNo" value=""/>
															<c:forEach items="${homeworkSubmitList }" var="hwSubItem">
																<c:if test="${hwSubItem.hwNo eq homework.hwNo }">
																	<c:set var="check" value="true"/>
																	<c:set var="hwSbNo" value="${hwSubItem.hwSbNo }"/>
																</c:if>
															</c:forEach>
															<c:choose>
																<c:when test="${ check eq false }"><!-- 내 제출 리스트를 확인  -->
																	<button type="button" idx="${homework.hwNo }"
																		class="waves-effect waves-light btn btn-secondary mb-5 homeworkSubmit"
																		data-bs-toggle="modal"
																		data-bs-target="#modal-center">
																		미제출
																	</button>
																</c:when>
																<c:otherwise>
																	<button type="button" idx="${homework.hwNo }"
																			class="waves-effect waves-light btn btn-primary mb-5 homeworkSubmit"
																			data-bs-toggle="modal"
																			data-bs-target="#modal-center" disabled>						
																			제출완료
																		</button>
																		<strong class="separator">/</strong>
																			<button type="button" idx="${hwSbNo }"
																			class="waves-effect waves-light btn btn-warning mb-5 homeworkSbUPdate"
																			data-bs-toggle="modal"
																			data-bs-target="#modal-center">
																			과제수정
																		</button>
																</c:otherwise>
															</c:choose>
														</td>	
													</tr>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 모달 -->
	<div class="modal center-modal fade row" id="modal-center" tabindex="-1" style="display: none;"
		aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content" style="padding: 2px;">
				<div class="box box-solid bg-primary">
					<div class="box-header">
						<h4 class="box-title">
							<strong>과제 등록</strong>
						</h4>
					</div>
				</div>
				<div class="table-responsive">
					<table class="table mb-0">
						<tr>
							<td class="table-dark">제목</td>
							<td colspan="3">
								<div class="b-2 border-dark rounded p-2 ps-1 homeworkTitle"
									id="homeworkTitle"></div>
							</td>
						</tr>
						<tr>
							<th class="table-dark">작성자</th>
							<td>
								<div class="b-2 border-dark rounded p-2 ps-1">${member.memName }</div>
							</td>
							<td class="table-dark">작성일</td>
							<td>
								<div class="b-2 border-dark rounded p-2 ps-1" sdMerong></div>
							</td>
						</tr>
					</table>
				</div>
				<form action="/DYUniv/homeWorkSubmit.do" method="post" enctype="multipart/form-data" id="homeWorkSubmitForm">
					<div class="form-group">
						<h3>
							<span class="text-danger">*</span>내용
						</h3>
						<div class="controls">
							<textarea name="hwContent" id="hwContent" class="form-control" required=""
								placeholder="내용을 입력하세요" rows="10"></textarea>
							<div class="help-block"></div>
						</div>
					</div>
					<div>
						<h3>첨부파일<span class="text-danger">*</span></h3><input type="file" id="files"
							name="files" class="form-control" required="" aria-invalid="false">
					</div>
					<input type="hidden" name="classNo" value="${myClassVO.classNo }">
					<input type="hidden" id="hwNo" name="hwNo" value="0">
					<input type="hidden" name="hwSbNo" id="hwSbNo" value="0">
				</form>
				<div class="modal-footer modal-footer-uniform">
					<button type="button" class="btn btn-danger" data-bs-dismiss="modal">취소</button>
					<button type="button" class="btn btn-danger-light" id="testBtn1">test</button>
					<button type="button" class="btn btn-primary float-end insertBtn" id="insertBtn"
						name="insertBtn">완료</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 모달 창끝 -->

	<div class="tab-pane" id="paypal2" role="tabpanel">
		<div class="box-body">
			<div class="table-responsive">
				<div class="box-body">
					<h3><strong>시험 리스트</strong></h3>
				</div>
				<div id="example_wrapper"
					class="dataTables_wrapper container-fluid dt-bootstrap4 no-footer">

					<div class="row">
						<div class="box-body">
							<div class="table-responsive">
								<table class="table">
									<thead class="bg-primary">
										<tr>
											<th>시험번호</th>
											<th>시험 명</th>
											<th>제출 기간</th>
											<th>제출인원</th>
											<th>문제 타입</th>
											<th>현 황</th>
										</tr>
									</thead>
									<tbody>
										<c:choose>
											<c:when test="${empty exampleList }">
												<tr>
													<td colspan="4">조회하실 게시물이 존재하지 않습니다.</td>
												</tr>
											</c:when>
											<c:otherwise>
												<c:set var="reverseIndex" value="${fn:length(exampleList) }"/>
												<c:forEach items="${exampleList }" var="example">
													<tr>
														<td>
															${reverseIndex }
															<c:set var="reverseIndex" value="${reverseIndex -1 }"/>
														</td>
														<td>${example.examName }</td>
														<td>${fn:substring(example.examDate, 0, 10) }</td>
														<td>5/18</td>
														<td>
															<c:if test="${example.examType eq 'EXT001'}">
																	객관식
															</c:if>
															<c:if test="${example.examType eq 'EXT002'}">
																	단답식
															</c:if>
															<c:if test="${example.examType eq 'EXT003'}">															
																	주관식
															</c:if>
														</td>
														<td>
														<c:if test="${example.examYn eq 'N' }" >
															<button type="button" idx="${example.examNo }" idn="${fn:substring(example.examDate, 0, 10) }"
																class="waves-effect waves-light btn btn-secondary mb-5 exampleQuestion">
																미제출
															</button>
														</c:if>
														
														<c:if test="${example.examYn eq 'Y' }" >
															<button type="button" idx="${example.examNo }"
																class="waves-effect waves-light btn btn-success mb-5 ">
																시험완료
															</button>
														</c:if>
													</tr>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script src="${pageContext.request.contextPath}/resources/js/chat.js"></script>

<script>
	$(function () {
		/* 강의 자료실 */
		var classBoardBtn = $(".classBoardBtn");
		var hwNo;

		classBoardBtn.on("click", function () {
			var classBrdNo = $(this).attr("idx");
			var classBrdCount = $(this).closest("tr").children()[3];
			//console.log("체킁", classBrdCount, classBrdNo);

			$.ajax({
				type: 'get',
				url: '/DYUniv/getClassBoardDetail.do?classBrdNo=' + classBrdNo,
				success: function (res) { /* 결과 성공 콜백함수 */
					/* 모달 내용 초기화 */
					$("#modal-classBrdTitle .modal-title").empty();
					$("#brdModalCont").empty();
					
					/* 모달 내용 채워넣기 */
					$("#modal-classBrdTitle .modal-title").text(res.classBrdTitle);
					$("#brdModalCont").text(res.classBrdCont);

					$("#downloadBtn").text("");
					
					if (res.fileNo === 0) {
						$("#downloadBtn").css("display", "none");
					} else {
						$("#downloadBtn").css("display", "block");
						$("#downloadBtn").text("파일 : " + res.fileName);
						$("#downloadBtn").attr("idx" , res.fileNo);
						$("#downloadBtn").attr("idn" , res.fileName);
					}

					$(classBrdCount).html(res.classBrdHitCount);  // 조회수 재 설정
					//	classBrdCount.innerHTML = res.classBrdHitCount;

					/* 모달 띄우기*/
					/* 	$("#modal-classBrdTitle").modal("show"); */
				},
				error: function (request, status, error) {
					console.log("code: " + request.status)
					console.log("message: " + request.responseText)
					console.log("error: " + error);
				}
			});
		});
	});

	/* 강의 자료실 파일 다운로드*/
	function FileDownload1(el) {

		var fileNo = $(el).attr("idx")
		var fileName = $(el).attr("idn")

		fileDownload(fileNo, fileName);
	}
	
	var homeworkindex;
	var miORup;
	
	/* homework 제출 */
	$(function () {

		var homeworkTitle = $("#homeworkTitle");
		var homeworkSubmit = $(document.querySelectorAll(".homeworkSubmit")); // 자바스크립트 DOM객체를 $()로 둘러싸면 jQuery객체로 바뀜!
		var insertBtn = $("#insertBtn"); //과제 제출
		var insertBtn2 = $("#insertBtn2"); //실습 신청
		var homeworkSbUPdate = $(".homeworkSbUPdate");//과제 수정

		var homeWorkSubmitForm = $("#homeWorkSubmitForm");
		var exampleQuestion = $(".exampleQuestion");
		
		homeworkSubmit.on("click", function () {
			miORup="미제출";
		    $("#files").val(""); // 파일 input 초기화
		    $('#modal-center h3:contains("첨부파일")').nextAll('span.badge').remove(); // 기존 파일 링크 삭제
			
		    //var hwSbNo = $("#hwSbNo").val("0")
			var now = new Date();  // 만약 꼭 서버시간이 필요하다면 new Date('서버에서받아온값')
			var sdDate = now.toLocaleDateString();

			var hwNo = $(this).attr("idx");
			
			console.log("새롭게 과제 제출");
			console.log("hwNo", hwNo);
			console.log("ppp", sdDate);
			
			$("[sdMerong]").html(sdDate);
			$("#hwNo").val(hwNo);

			// 보통 화면에서 값 찾을 때 많이 쓰는 방법 해당 부모를 먼저 찾는당

			var sdTR = $(this).closest("tr")[0];
			console.log("sdTR ", sdTR.children[1].innerHTML);
			homeworkTitle.html(sdTR.children[1].innerHTML);
			hwNo = sdTR.children[0].innerHTML;
			console.log("현재 hwNo=", hwNo);
		});
		
		
		/*과제 제출 모달창 완료 버튼*/
		insertBtn.on("click", function () {

			var hwContent = $("#hwContent").val();
			var files = $("#files").val();
			var msg = "";

			if(miORup == "미제출"){
				if (hwContent == null || hwContent == "") {
					msg += "작성한 내용이 없습니다.\n"
				}
				if (files == null || files == "") {
					msg += "업로드된 파일이 없습니다.\n"
				}

				if (confirm(msg + "과제를 등록 하시겠습니까?")) {
					homeWorkSubmitForm.submit();
				}
			} else {
				if(hwContent == null || hwContent == ""){
					msg += "작성한 내용이 없습니다.\n"
				}
				if(confirm(msg + "과제를 수정 하겠습니까?")){
					homeWorkSubmitForm.submit();
				}
			}

		});
		
		/*과제 수정버튼 */
		homeworkSbUPdate.on("click", function(){
			miORup="과제수정";
			$("#hwSbNo").val("")	//hwSbNo 초기화
			
			var homeworkindex = $(this).closest("tr").find("td:eq(0)").text();
	        var hwTitle = $(this).closest("tr").find("td:eq(1)").text();
	        var now = new Date();
	        var sdDate = now.toLocaleDateString();
	        
	        var hwSbNo = $(this).attr("idx");
	  
	        $('#modal-center h3:contains("첨부파일")').nextAll('span.badge').remove(); // 기존 파일 링크 삭제
	        
	        console.log("수정제출")
	        console.log("hwSbNo : ", hwSbNo);
	  
	        $("#modal-center #homeworkTitle").text(hwTitle);
	        $("#modal-center [sdMerong]").text(sdDate);
	        
	         data = {
	        		 
	        		"hwSbNo" : hwSbNo,
	        		"hwNo" : homeworkindex
	        }
	         
	        $.ajax({
            	url: "/DYUniv/homeworkSubmitDetail.do",
            	type: "post",
            	data: JSON.stringify(data),
            	contentType: "application/json; charset=utf-8",
				dataType:"json",
            	success: function (homeworkSubmitVO) {
            		
					$("#hwSbNo").val("")	//hwSbNo 초기화
                    $("#hwContent").val(""); // 내용 초기화
        		    $("#files").val(""); // 파일 input 초기화
                    
        		 	// 새로운 정보로 모달 채우기
        		    var hwContent = homeworkSubmitVO.hwContent;
        		    var fileName = homeworkSubmitVO.fileName;
        		    var hwSbNo = homeworkSubmitVO.hwSbNo;
        		    console.log("처리결과",homeworkSubmitVO);
        		    
        		    // 내용 채우기
        		    
        		    $("#hwContent").val(hwContent);
        		    $("#hwSbNo").val(hwSbNo);
        		    
        		    // 파일 링크 추가
        		    var fileLink = $('<span>').addClass('badge badge-warning').text(fileName);
        		    $('#modal-center h3:contains("첨부파일")').after(fileLink);
					
            	},
                error: function (error) {
                	
                    console.error("에러 발생: ", error);
                }
		    });  
	
		});

		exampleQuestion.on("click", function(){
			var examNo = $(this).attr("idx");
			var exDate = $(this).attr("idn");
			var curDate = dateFormat(new Date()).substr(0,10);
			//console.log("test : ", examNo, exDate, curDate, (exDate > curDate));
			
			if(exDate > curDate){
				location.href="/DYUniv/example.do/" + examNo;
			} else {
				 toastr.error("시험 참여 기한이 지났습니다.");
			}
			
		});
		

	});
	/*강의 과제 기간 지날시 수정 버튼 none */
	 document.addEventListener("DOMContentLoaded", function () {
	        var rows = document.querySelectorAll(".table tbody tr");

	        rows.forEach(function (row) {
	            var deadlineCell = row.querySelector("td:nth-child(4)");
	            var updateButton = row.querySelector(".homeworkSbUPdate");
	            var separator = row.querySelector(".separator");

	            if (deadlineCell && updateButton) {
	                var deadlineDate = new Date(deadlineCell.innerText);
	                var currentDate = new Date();

	                if (deadlineDate < currentDate) {
	                    // 날짜가 지났을 때, 버튼과 separator을 숨김
	                    updateButton.style.display = "none";
	                    separator.style.display = "none";
	                }
	            }
	        });
	    });
	 
	
	$("#testBtn1").on("click", function () {
		$("#hwContent").val("과제 제출 합니다.")
	})
</script>