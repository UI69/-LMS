<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon"
	href="${pageContext.request.contextPath}/resources/images/favicon.ico">
<title>Main template</title>

<!-- 제이쿼리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/vendor_components/jquery-ui/jquery-ui.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui-touch-punch/0.2.3/jquery.ui.touch-punch.min.js"></script>


<!-- Vendors Style-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/vendors_css.css">

<!-- Style-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/skin_color.css">

<!-- toastr -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

</head>

<body class="col-12 row hold-transition light-skin sidebar-mini theme-primary fixed">
	<div class="col-8" style="border: 1px solid; max-height: 100%; overflow: scroll;">
		<div class="col-12 row text-center">
			<h1>${exampleVO.examName }</h1>
			<div class="col-4"><h4>최종 점수 : ${exampleVO.examTotalScore }</h4></div>
			<div class="col-4"></div>
			<div class="col-4"><h4>시험 시간 : ${exampleVO.examTime }</h4></div>
		</div>
		
		
		<div class="col-12">	
			<c:forEach items="${exampleVO.examQstList }" var="examQst">
				<div class="box container examQst">
					<div class="row box-header with-border" style="display: flex;">
					
						<div class="col-1"><h4>${examQst.qstNo }.</h4></div>
						<div class="col-10"><h4 class="box-title">${examQst.examQst }</h4></div>
						<div class="col-1"><h4>(${examQst.qstScore }점)</h4></div>
						
					</div>
					<div class="box-body p-0">
					  <div class="media-list media-list-hover media-list-divided text-center">
						<!-- 문제 이미지 -->
						<c:if test="${examQst.fileNo ne '0' }">
							<img class="w-80 rounded" src="${pageContext.request.contextPath}/resources/file${examQst.filepath}" alt="...">
						</c:if>
	
					  </div>
					</div>
				  <div class="box-footer bt-1 border-light p-10">
				  	
				  	<c:forEach items="${examQst.qstChList }" var="qstCh">
							<a class="media media-single qstCh" href="#" idx="qst${examQst.qstNo }-${qstCh.chNo}">
								<div class="col"><h5>(${qstCh.chNo }).</h5></div>
								<div class="col-11"><h5>${qstCh.chStr }</h5></div>
								<div class="col"></div>
								<div class="col"></div>
							</a>
				  	</c:forEach>
				  </div>
				</div>
			</c:forEach>
		</div>
	</div>
	
	
	<!-- 응답 제출용 -->
	<div class="col-4" style="border: 1px solid; max-height: 100%; overflow: scroll;">
		<div class="col-12 text-end my-15">
			<h4> 시험 시간 </h4> <h3 > <span id="timer"></span> / ${exampleVO.examTime }:00 </h3>
			<button class="btn btn-sm btn-primary-light" id="examTest">테스트</button>
			<button class="btn btn-sm btn-danger-light" id="examReset">초기화</button>
			<button class="btn btn-sm btn-primary-light" id="examSubmit">제출</button>
		</div>
		<div class="col-12">
			<table class="table">
				<thead class="bg-primary">
					<tr>
						<!-- ${maxQstChLen } -->
						<th><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">번호</font></font></th>
						<c:forEach var="item" begin="1" end="${maxQstChLen }" step="1" varStatus="status">
							<th><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">${status.index }</font></font></th>
						</c:forEach>
					</tr>
				</thead>
				<tbody id="answer">
					<c:forEach items="${exampleVO.examQstList }" var="examQst">
					
						<tr idx="${examQst.examQstNo }">
							<td><font style="vertical-align: inherit;">${examQst.qstNo }</font></td>
							<c:forEach items="${examQst.qstChList }" var="qstCh">
								<td>
									<font style="vertical-align: inherit;">
										<input type="radio" name="qst${examQst.qstNo }" id="qst${examQst.qstNo }-${qstCh.chNo}">
										<label for="qst${examQst.qstNo }-${qstCh.chNo}" id="sp-qst${examQst.qstNo }-${qstCh.chNo}" class="h-20 p-10 mb-0"></label>
									</font>
								</td>
							</c:forEach>
						</tr>
					
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</body>

<script>
	var examSubmit = $("#examSubmit");
	var examReset = $("#examReset");
	var examTest = $("#examTest");
	
	var examNo = parseInt("${exampleVO.examNo }");
	var classNo = parseInt("${exampleVO.classNo }");
	
	var examTime = parseInt("${exampleVO.examTime}");
	var timerSec = examTime * 60;
	var timer = $("#timer");
	
	toastr.options = {
		"closeButton": false,
		"debug": false,
		"newestOnTop": false,
		"progressBar": false,
		"positionClass": "toast-bottom-center mb-70",
		"preventDuplicates": false,
		"onclick": null,
		"showDuration": "100",
		"hideDuration": "1000",
		"extendedTimeOut": "1000",
		"showEasing": "swing",
		"hideEasing": "linear",
		"showMethod": "fadeIn",
		"hideMethod": "fadeOut"
	}
	
	exampleTimerSet();
	
	function exampleTimerSet(){
		console.log("temeSet...")
		var min = Math.floor(timerSec / 60);
		var sec = timerSec - (min * 60);
		sec = sec < 10 ? "0"+sec : sec;
		
		//console.log("time test", min + ":" + sec);
		$("#timer").text(min + ":" + sec);
		timerSec--;
		if(timerSec < 0){
			selectBtnDisabled();
			toastr.warning('시험 시간이 종료되었습니다.');
			return;
		}
		setTimeout(exampleTimerSet, 1000);
	}
	
	function selectBtnDisabled() {
		var r = $("#answer label");
		for (var i = 0; i < r.length; i++) {
			$(r[i]).attr("for", "");
		}
	}
	
	examSubmit.on("click", function () {
		
		var answerDate = dateFormat(new Date());
		var examAnswer = [];
		var answerList = $("#answer").find("tr");
		for (var i = 0; i < answerList.length; i++) {
			//$(radioList[i]).trigger("click");
			//console.log("answerList : " + i);
			
			var chList = $(answerList[i]).find("input[type=radio]");
			var examQstNo = $(answerList[i]).attr("idx");
			for (var j = 0; j < chList.length; j++) {
				if(chList[j].checked){
					//console.log("checked ch :", i+1, j+1);
					
					var anData = {
							"examNo" : examNo,
							"examQstNo" : examQstNo,
							"answer" : (j+1),
							"answerDate" : answerDate
					}
					examAnswer.push(anData);
				}
			}
		}
		
		console.log("examAnswer : ", examAnswer);
		var conFirmStr = examAnswer.length + "개의 답을 체크하셨습니다.\n제출 하시겠습니까?";
		if(!confirm(conFirmStr)){
			return;
		}
		
		$.ajax({
			type : 'post',
			url : '/DYUniv/example/examAnswerForm.do',
			contentType : "application/json; charset=utf-8",
			data : JSON.stringify(examAnswer),
			success : function(res) { // 결과 성공 콜백함수
				console.log(res);
			 	
			 	if(res == "OK"){
			 		location.href = "/DYUniv/student/class/classRoom/" + classNo;
			 	} else {
			 	// alert("일치하는 정보가 없습니다...")
					Swal.fire({
						icon: 'error',
						title: '업로드 실패...',
						text: '',
				    });
			 	}
			}
		})
	})
	
	examTest.on("click", function () {
		var radioList = $("#answer").find("input[type=radio]");
		for (var i = 0; i < radioList.length; i++) {
			$(radioList[i]).trigger("click");
		}
	})
	
	// 초기화 버튼
	examReset.on("click", function () {
		if(timerSec < 0){
			return;
		}
		
		var radioList = $("#answer").find("input[type=radio]");
		console.log("radioList : ", radioList);
		for (var i = 0; i < radioList.length; i++) {
			radioList[i].checked = false;
		}
	})
	
	$(function () {
		$(".qstCh").on("click", function () {
			console.log($(this).attr("idx"));
			var idx = $(this).attr("idx");
			$("#sp-" + idx).trigger("click");
		})
	})
	
</script>

<!-- Vendor JS -->
<script src="${pageContext.request.contextPath}/resources/js/vendors.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/icons/feather-icons/feather.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js"></script>

<!-- EduAdmin App -->
<script src="${pageContext.request.contextPath}/resources/js/template.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/chat.js"></script>