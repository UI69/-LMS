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
		<a class="nav-link active" data-bs-toggle="tab" href="#debit-card" role="tab"
			aria-selected="true">
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
	<li class="nav-item">
		<a class="nav-link" data-bs-toggle="tab" href="#attendTap" role="tab" aria-selected="false">
			<span class="hidden-sm-up"><i class="fa fa-paypal"></i></span>
			<span class="hidden-xs-down">출석체크</span>
		</a>
	</li>
</ul>

<div class="tab-content tabcontent-border m-0 bg-white">
	<div class="tab-pane active" id="debit-card" role="tabpanel">
		<div class="box-body">
			<div class="col-12">
				<h3 class="mt-30 ms-30"><strong>강의 자료실</strong></h3>
			</div>
			<div class="col-12 text-end">
				<button class="btn bg-info me-30" data-bs-toggle="modal"
					data-bs-target="#modal-classBrd">자료 등록</button>
			</div>


			<div class="table-responsive m-30">
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
												data-bs-toggle="modal" data-bs-target="#brdDetail"
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
													onclick="boardFileDownload(this)"
													idx="${classBoard.fileNo }"
													idn="${classBoard.fileName }"
													title="${classBoard.fileName }">
													<i class="fa fa-folder-open"
														style="color: white"></i>
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

			<!-- 자료실 상세 모달창 -->
			<div class="modal center-modal fade row" id="brdDetail" tabindex="-1" style="display: none;"
				aria-hidden="true">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<div class="modal-header">
							<h4 class="modal-title"><strong id="brdTitle"></strong></h4>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<div class="modal-body b-4 min-h-300">
							<p>
								<span class=""> 내용 </span>
								<a type="button" class="float-end" id="fileLink" href="#"
								onclick="boardFileDownload(this)" idx="" idn="">
								다운로드</a>
							</p>
							<hr>
							<p id="brdContent"></p>
						</div>
						<div class="modal-footer modal-footer-uniform">
							<button type="button" class="btn btn-danger"
								data-bs-dismiss="modal">닫기</button>
							<!-- <button type="button" class="btn btn-primary float-end" id="downloadBtn" onclick="FileDownload2()">다운로드</button> -->
						</div>
					</div>
				</div>
			</div>
			<!-- 모달창 끝 -->

			<!-- 자료실 등록 모달창 -->
			<div class="modal center-modal fade row" id="modal-classBrd" tabindex="-1"
				style="display: none;" aria-hidden="true">
				<form action="/DYUniv/class/classBrdForm.do" method="post" enctype="multipart/form-data"
					id="classBrdForm">
					<div class="modal-dialog modal-lg">
						<div class="modal-content">
							<div class="modal-header">
								<h4 class="modal-title">강의 자료 등록</h4>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body b-4">
								<label>제목 : </label><input type="text" class="form-control"
									id="classBrdTitle" name="classBrdTitle">
								<span>내용 : </span>
								<textarea class="form-control" rows="12" id="classBrdCont"
									name="classBrdCont"></textarea>
								<input class="form-control" type="file" id="files" name="files">
								<input type="hidden" value="${myClassVO.classNo }" id="classNo"
									name="classNo">
							</div>
							<div class="modal-footer modal-footer-uniform">
								<button type="button" class="btn btn-danger"
									data-bs-dismiss="modal">닫기</button>
								<button type="button" class="btn btn-danger-light"
									id="BrdUploadTest">test</button>
								<button type="button" class="btn btn-primary float-end"
									id="BrdUploadBtn">등록</button>
							</div>
						</div>
					</div>
				</form>
			</div>
			<!-- 모달창 끝 -->

		</div>
	</div>

	<div class="tab-pane" id="paypal1" role="tabpanel">
		<div class="box-body">
			<div class="col-12">
				<h3 class="mt-30 ms-30"><strong>강의 과제</strong></h3>
			</div>
			<div class="col-12 text-end">	
				<button class="waves-effect waves-light btn bg-info me-5" data-bs-toggle="modal"
					data-bs-target="#modal-homework">과제 등록</button>
				<a type="button" class="waves-effect waves-light btn bg-info me-30"
					href="/DYUniv/class/homeworkScoreForm/${myClassVO.classNo }">
					제출자 목록 >> </a>
			</div>
			<div class="table-responsive m-30">
				<table class="table">
					<thead class="bg-primary">
						<tr>
							<th>과제번호</th>
							<th>제목</th>
							<th>내용</th>
							<th>제출기한</th>
							<th>과제 현황</th>
							<th>현황</th>
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
										<td>${fn:substring(homework.hwDate, 0, 10) }</td>
										<td>${homework.hwSubmitCnt } / ${myClassVO.classRegCnt }</td>
										<td>
											<button type="button"
												class="waves-effect waves-light btn btn-secondary mb-5">
												과제 취소
											</button>
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

	<!-- 과제 등록 모달 -->
	<div class="modal center-modal fade row" id="modal-homework" tabindex="-1" style="display: none;"
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
				<form action="/DYUniv/class/addHomework.do" method="post" enctype="multipart/form-data"
					id="hwForm">
					<div class="table-responsive">
						<table class="table mb-0">
							<tr>
								<td class="table-secondary">제목</td>
								<td>
									<input class="form-control b-2 border-dark rounded p-2 ps-1 "
										type="text" id="hwTitle" name="hwTitle">
								</td>
								<td class="table-secondary">제출 기한</td>
								<td>
									<input class="form-control b-2 border-dark rounded p-2 ps-1"
										type="date" id="hwUpload" name="hwUpload">
								</td>
							</tr>
						</table>
					</div>
					<div class="form-group">
						<h4 class="my-10">내용 <span class="text-danger">*</span></h4>
						<div class="controls">
							<textarea name="hwCont" id="hwCont" rows="10" class="form-control"
								placeholder="내용을 입력하세요"></textarea>
							<div class="help-block"></div>
						</div>
					</div>
					<div>
						<h4 class="my-10">첨부파일 <span class="text-danger">*</span></h4>
						<input type="file" id="files2" name="files" class="form-control"
							aria-invalid="false">
					</div>
					<input type="hidden" name="classNo" id="classNo2" value="${myClassVO.classNo }">
				</form>
				<div class="modal-footer modal-footer-uniform">
					<button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
					<button type="button" class="btn btn-danger" id="hwUploadTest">test</button>
					<button type="button" class="btn btn-primary float-end" id="hwUploadBtn">등록</button>
				</div>

			</div>
		</div>
	</div>
	<!-- 모달 창끝 -->

	<div class="tab-pane" id="paypal2" role="tabpanel">
		<div class="box-body">
			<div class="col-12">
				<h3 class="mt-30 ms-30"><strong>시험 리스트</strong></h3>
			</div>
			<div class="col-12 text-end">
				<button class="btn bg-info me-30" id="examSubList">시험 관리</button>
			</div>
			<div class="table-responsive m-30">
				<table class="table">
					<thead class="bg-primary">
						<tr>
							<th>시험번호</th>
							<th>과목 명</th>
							<th>제출 기간</th>
							<th>시험 시간</th>
							<th>제출인원</th>
							<th>시험 명</th>
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
										<td>${example.examTime } </td>
										<td>5/18</td>
										<td>
											<c:if test="${example.examType eq 'EXT001'}">
												<p
													class="">
													객관식 </p>
											</c:if>
											<c:if test="${example.examType eq 'EXT002'}">
												<p
													class="">
													단답식 </p>
											</c:if>
											<c:if test="${example.examType eq 'EXT003'}">
												<p
													class="">
													주관식 </p>
											</c:if>
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


	<div class="tab-pane" id="attendTap" role="tabpanel">
		<div class="box-body">
			<div class="col-12">
				<h3 class="mt-30 ms-30"><strong>출석 체크</strong></h3>
		</div>
			<div class="row col-12 justify-content-end">
				<div class="col-2 " >
			        <button type="button" class="waves-effect waves-light btn btn-rounded btn-primary-light mb-5 "
		                style="font-size: 12px;" id="attendInsert">출석 등록</button>
				</div>
			</div>
			<div class="row">
				<div class="box-body">
					<div class="table-responsive">
						<table class="table">
							<thead class="bg-primary">
								<tr>
									<th class="min-w-100" ></th>
								
									<!-- 강의 시작일부터, 강의 주차 만큼 -->
								
							        <c:forEach var="schedule" begin="1" end="${myClassVO.classWeekCnt }" varStatus="status">
							            <th>${schedule }</th>
							        </c:forEach>
							        <th colspan="4" class="text-center">정보 </th>
								</tr>
								<tr>
									<th class="min-w-100" ></th>
								
									<!-- 강의 시작일부터, 강의 주차 만큼 -->
								
							        <c:forEach var="schedule" begin="1" end="${myClassVO.classWeekCnt }" varStatus="status">
							            <th>
							            	<select name="atStatus" atd="${schedule }" class="form-select atBatSelect" style="width: 80px;" 
												aria-invalid="false">		<!-- <c:if test="${!empty atVal }">disabled</c:if> -->
											    <option value=""></option>
											    <option value="absent" <c:if test="${atVal eq 'ATS001' }">selected</c:if>>결석</option>
											    <option value="attend" <c:if test="${atVal eq 'ATS002' }">selected</c:if>>출석</option>
											    <option value="late"   <c:if test="${atVal eq 'ATS003' }">selected</c:if>>지각</option>
											    <option value="leave"  <c:if test="${atVal eq 'ATS004' }">selected</c:if>>조퇴</option>
											</select>
							            </th>
							        </c:forEach>
							        
							        <th>출석 </th>
									<th>결석 </th>
									<th>지각 </th>
									<th>조퇴 </th>
								</tr>
							</thead>
							<tbody id="attendBody">
								<!--여기  -->
					            
									<c:forEach items="${myClassCheck}" var="listener">
										<tr idx="${listener.member.memNo  }" idn="${listener.listenNo} "  >
								          <td class="h-48 py-0"> ${listener.member.memName}</td>
								            <c:forEach var="schedule" begin="1" end="${myClassVO.classWeekCnt }" varStatus="status">
									            <td class="h-48 py-0">
									            	<c:set var="atVal"/>
									            	<c:if test="${!empty listener.attendList[schedule - 1] }">
									            		<c:set var="atVal" value="${listener.attendList[schedule - 1].atStatus }"/>
									            		<c:set var="atNo" value="${listener.attendList[schedule - 1].atNo }"/>
									            	</c:if>
									            	<c:if test="${empty listener.attendList[schedule - 1] }">
									            		<c:set var="atNo" value="0"/>
									            	</c:if>
													<select  name="atStatus" atn="${atNo }" required="" class="form-select" style="width: 80px;" 
														aria-invalid="false">		<!-- <c:if test="${!empty atVal }">disabled</c:if> -->
													    <option value=""></option>
													    <option value="absent" <c:if test="${atVal eq 'ATS001' }">selected</c:if>>결석</option>
													    <option value="attend" <c:if test="${atVal eq 'ATS002' }">selected</c:if>>출석</option>
													    <option value="late"   <c:if test="${atVal eq 'ATS003' }">selected</c:if>>지각</option>
													    <option value="leave"  <c:if test="${atVal eq 'ATS004' }">selected</c:if>>조퇴</option>
													</select>
												</td>
									        </c:forEach>
									        <td class="h-48 py-0">
									        	<input class="attend" name="attend" value="0" type="number" style="width: 50px;" readonly="readonly">
									        </td>
									        <td class="h-48 py-0">
									        	<input class="absent" name="absent" value="0" type="number" style="width: 50px;" readonly="readonly">
									        </td>
									        <td class="h-48 py-0">
									        	<input class="late" name="late" value="0" type="number" style="width: 50px;" readonly="readonly">
									        </td>
									        <td class="h-48 py-0 ">
									        	<input class="leave" name="leave"  value="0" type="number" style="width: 50px;" readonly="readonly">
									        </td>
								      </tr>
							    </c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
<!--  -->

</div>
<script>
	$(function () {
		
		var classBoardBtn = $(".classBoardBtn");	//자료실 상세
		var BrdUploadBtn = $("#BrdUploadBtn");		//자료실 등록 버튼
		var classBrdForm = $("#classBrdForm");		//자료실 등록 폼
		var hwUploadBtn = $("#hwUploadBtn");
		var hwForm = $("#hwForm");
		var attendInsert = $("#attendInsert");
		
		// 출석 시작 
		var updateItem = $("#attendBody").find("tr");
		
		var classNo = ${myClassVO.classNo };
		
		//일괄 출석 체크 셀렉트
		$(".atBatSelect").on("change", function () {
			var atval = $(this).val();
			var atno = $(this).attr("atd");
			console.log("c", atval, atno);
			
			for (var i = 0; i < updateItem.length; i++) {
				var items = $(updateItem[i]).find(".form-select");
				items[atno-1].value = atval;
				
				changeAttend($(items).parents("tr"));
			}
			
			//console.log(items);
		})
		
		attendInsert.on("click", function () {
			var listenerData = [];
			
			console.log("updateItem::",updateItem);
			
			for (var i = 0; i < updateItem.length; i++) {
				
				//console.log("index : ",i ,updateItem[i])
				var memNo = $(updateItem[i]).attr("idx");
				var listenNo = $(updateItem[i]).attr("idn");
				var items = $(updateItem[i]).find(".form-select");
			   /*  var atDate = $(updateItem[i]).attr("ida"); */
				
				var attend = 0;
				var absent = 0;
				var late = 0;
				var leave = 0;
				
				for (var j = 0; j < items.length; j++) {
					var str = $(items[j]).val();
					var atNo = $(items[j]).attr("atn");
					if(str == ""){
						continue;
					}
					
					var atStatus = "";
					
					if(str == "attend"){
						atStatus = "ATS002"
					}
					if(str == "absent"){
						atStatus = "ATS001"
					}
					if(str == "late"){
						atStatus = "ATS003"
					}
					if(str == "leave"){
						atStatus = "ATS004"
					}
					
					
					var data = {
							"atNo" : atNo,
							"atStatus" : atStatus,
							"memNo" : memNo,
							"atDate": (j+1),
							"listenNo" : listenNo
					}
					//console.log("data :",data);
					if(data.atStatus != null && data.atStatus != ""){
						listenerData.push(data);
					}
				}
				console.log("listenerData :",listenerData);
			}
			
			 if(confirm("출석 등록 하시겠습니까?")){
				$.ajax({
					url : "/DYUniv/class/attendCheck.do",
					type: "post",
					data: JSON.stringify(listenerData),
	  	            contentType: "application/json; charset=utf-8",
	  	            success: function (res) {
	  	            	console.log("res ",res);
	  	            	if(res == listenerData.length){
	  	            		alert("등록성공");
	  	            		location.href = location.href; // 새로고침과 같음!
	  	            	}
	  	            }
				})
			} 
		});
		
		for (var i = 0; i < updateItem.length; i++) {
			changeAttend(updateItem[i]);
		}
		
		$(".form-select").on("change", function () {
			changeAttend($(this).parents("tr"));
		});
		
		function changeAttend(el) {
			var items = $(el).find(".form-select");
		    
			var attend = 0;
			var absent = 0;
			var late = 0;
			var leave = 0;
			
			for (var i = 0; i < items.length; i++) {
				var str = $(items[i]).val();
				if(str == "attend"){
					attend += 1;
				}
				if(str == "absent"){
					absent += 1;
				}
				if(str == "late"){
					late += 1;
				}
				if(str == "leave"){
					leave += 1;
				}
			}
			//console.log("val : ",attend,absent,late,leave )
			$(el).find(".attend").val(attend);
			$(el).find(".absent").val(absent);
			$(el).find(".late").val(late);
			$(el).find(".leave").val(leave);

		}		// 여기까지 출석
		
		$("#examSubList").on("click", function () {
			location.href= "/DYUniv/class/examManagement/" + ${myClassVO.classNo };
		})
		
		hwUploadBtn.on("click", function () {
			var hwTitle = $("#hwTitle").val();
			var hwUpload = $("#hwUpload").val();
			var hwCont = $("#hwCont").val();
			var files = $("#files2").val();

			console.log(hwTitle, hwUpload, hwCont, files);

			msg = "";

			if (hwTitle == null || hwTitle == "") {
				alert("제목을 입력해주세요");
				return;
			}
			if (hwUpload == null || hwUpload == "") {
				alert("기한을 입력해주세요");
				return;
			}
			if (hwCont == null || hwCont == "") {
				msg += "작성된 내용이 없습니다\n";
			}
			if (files == null || files == "") {
				msg += "업로드된 파일이 없습니다\n";
			}

			if (confirm(msg + "등록 하시겠습니까?")) {
				hwForm.submit();
			}
		})

		BrdUploadBtn.on("click", function () {
			var classBrdTitle = $("#classBrdTitle").val();
			var classBrdCont = $("#classBrdCont").val();
			var files = $("#files").val();

			var msg = "";

			if (classBrdTitle == null || classBrdTitle == "") {
				alert("제목을 입력해주세요");
				return;
			}

			if (classBrdCont == null || classBrdCont == "") {
				alert("내용을 입력해주세요");
				return;
			}

			if (files == null || files == "") {
				msg = "업로드된 파일이 없습니다\n";
			}

			if (confirm(msg + "등록 하시겠습니까?")) {
				classBrdForm.submit();
			}

		})

		/* 강의 자료실 상세정보 */
		classBoardBtn.on("click", function () {
			var classBrdNo = $(this).attr("idx");
			//console.log("체킁", classBrdNo);

			$.ajax({
				type: 'get',
				url: '/DYUniv/getClassBoardDetail.do?classBrdNo=' + classBrdNo,
				success: function (res) { /* 결과 성공 콜백함수 */
					//console.log("res :",res);

					/* 모달 내용 초기화 */
					$("#brdTitle").empty();
					$("#brdContent").empty();
					$("#fileLink").empty();
					
					$("#fileLink").attr("idx", "");
					$("#fileLink").attr("idn", "");
					$("#fileLink").css("display", "none");
					

					/* 모달 내용 채워넣기 */
					$("#brdTitle").text(res.classBrdTitle);
					$("#brdContent").text(res.classBrdCont);

					if (res.fileNo != null || res.fileNo != 0) {
						$("#fileLink").attr("idx", res.fileNo);
						$("#fileLink").attr("idn", res.fileName);
						$("#fileLink").text("파일 : " + res.fileName);
						$("#fileLink").css("display", "block");
					}

					/* 모달 띄우기*/
					$("#brdDetail").modal("show");
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
	function boardFileDownload(el) {
		var fileNo = $(el).attr("idx")
		var fileName = $(el).attr("idn")

		fileDownload(fileNo, fileName);
	}
	
	$("#BrdUploadTest").on("click", function () {
		$("#classBrdTitle").val("C++3강_연습문제");
		$("#classBrdCont").val("C++3강_연습문제");
	})
	
	$("#hwUploadTest").on("click", function () {
		$("#hwTitle").val("구구단 출력");
		$("#hwCont").val("반복문을 이용해서 구구단을 출력하는 코드를 작성해보세요.");
	})
</script>