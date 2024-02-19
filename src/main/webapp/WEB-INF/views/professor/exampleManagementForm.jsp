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
			<div class="b-1 border-dark rounded p-1 ps-2">??/25</div>
		</div>
	</div>
</div>
<div class="ms-15">
<ul class="nav nav-tabs" role="tablist">
	<li class="">
		<a class="nav-link bg-danger-light" data-bs-toggle="tab" href="" role="tab" aria-selected="false" id="classRoomBtn">
			<span class="hidden-xs-down" class="" > &lt;&lt; 클래스룸으로</span>
		</a>
	</li>
	<li class="nav-item">
		<a class="nav-link active" data-bs-toggle="tab" href="#examAnswer" role="tab" aria-selected="true">
			<span class="hidden-sm-up"><i class="fa fa-paypal"></i></span>
			<span class="hidden-xs-down">시험 응시 목록</span>
		</a>
	</li>
	<li class="nav-item">
		<a class="nav-link" data-bs-toggle="tab" href="#examplCreate" role="tab" aria-selected="false">
			<span class="hidden-sm-up"><i class="fa fa-paypal"></i></span>
			<span class="hidden-xs-down">시험 출제</span>
		</a>
	</li>
</ul>


</div>

<div class="tab-content tabcontent-border m-15 bg-white">
	<div class="tab-pane active" id="examAnswer" role="tabpanel">
		<div class="box-body">
			<div class="col-12">
				<h3 class="mt-30 ms-30"><strong>시험 응시자 목록</strong></h3>
			</div>
			<div class="row col-12 justify-content-end">
				<div class="row col-4 text-end">
					<!-- homeworkList -->
					<select class="form-control" id="exSelect">
						<option value="">===선택===</option>
						
						<c:if test="${!empty exampleList }">
							<c:forEach items="${exampleList }" var="ex">
								<option value="${ex.examNo }">${ex.examName }</option>
							</c:forEach>
						</c:if>
					</select>
				</div>
				<!-- <div class="col-3 text-end">
					<button class="waves-effect waves-light btn bg-info me-30" 
						id="hwScoreSubmitBtn">과제 점수 등록</button>
				</div> -->
			</div>
			<div class="table-responsive m-30">
				<table class="table">
					<thead class="bg-primary">
						<tr>
							<th>학번</th>
							<th>이름</th>
							<th width="30%">시험</th>
							<th>제출일</th>
							<th class="text-center">답안 보기</th>
							<th class="text-center">점수</th>
						</tr>
					</thead>
					<tbody id="exSubList">
						<tr>
							<td colspan="6">조회하실 게시물이 존재하지 않습니다.</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<div class="tab-pane" id="examplCreate" role="tabpanel">
		<div class="box-header">
			<div class="row col-12 justify-content-end">
				<div class="col-7">
					<h3 class="mt-15 ms-30"><strong>시험 출제</strong></h3>
				</div>
			</div>
		</div>
		<div class="box-body row" style="min-height: 470px">
			<div class="row col-12">
				<div class="row col-6"></div>
				<div class="col-6 text-end">
					<button class="waves-effect waves-light btn bg-danger me-5 mt-5 btn-sm" 
						id="" onclick="examSetting()">시험 출제 폼 설정</button>
					<button class="waves-effect waves-light btn bg-success me-5 mt-5 btn-sm" 
						id="examExcelDownloadBtn" onclick="fileDownload()">시험 출제 폼 다운로드</button>
					<button class="waves-effect waves-light btn bg-success me-5 mt-5 btn-sm" 
						id="examExcelUploadBtn" data-bs-toggle="modal" data-bs-target="#examExcelUploadModal">시험 업로드(Excel)</button>
					<button class="waves-effect waves-light btn bg-success me-5 mt-5 btn-sm" 
						id="examCreateBtn">시험 등록</button>
				</div>
			
				<div class="row col-2 text-end"><span>시험 명 : </span></div>
				<div class="row col-2 "><input type="text" class="form-control h-30" id="examName"></div>
				
				<div class="row col-2 text-end"><span>시험 일자 : </span></div>
				<div class="row col-2"><input type="date" class="form-control h-30" id="examDate"></div>
				
				<div class="row col-2 text-end" ><span >시험 시간(분) :</span></div>
				<div class="row col-2"><input type="number" min="10" max="180" class="form-control h-30" id="examTime" value="60"></div>
				
			</div>
			<div class="col-2" style="border: 1px solid">
				총점	: <input type="number" min="0" value="0" readonly="readonly" id="examTotalScore">
				<hr>
				<ul class="p-0" id="Qst">
					<!-- 문제 목록 -->					
				</ul>
			</div>
			<div class="col-5" style="border: 1px solid">
				<h4 class="m-2">문제 :    </h4><input type="text" class="form-control" id="examQst">
				<h4 class="m-2">보기 이미지  </h4><input type="file" class="form-control" id="examImg">
					<input type="hidden" id="examImgFileNo" value="">
					<input type="hidden" id="examQstNo" value="0">
				<h4 class="m-2">정답 :    </h4><input type="number" min="1" max="10" value="1" class="form-control" id="qstCorrect">
				<h4 class="m-2">배점 :    </h4><input type="number" min="1" max="100" value="5" class="form-control" id="qstScore">
				<div class="text-end">
					<button class="btn btn-danger-light mt-5 btn-sm" id="resetQstBtn">초기화</button>
					<button class="btn btn-success-light mt-5 btn-sm" id="addQstBtn">문제 저장</button>
					<hr>
				</div>
			</div>
			<div class="col-5" style="border: 1px solid">
				<div class="text-end m-10">
					<button class="btn btn-danger-light btn-sm" id="resetChoiceBtn">초기화</button>
					<button class="btn btn-success-light btn-sm" id="addChoiceBtn">보기 추가</button>
				</div>
				
				<ul class="p-0" id="qchoice">
				
					<li class="row choice">
						<div class="col-1">
							<span class="box-title" >1.</span>
						</div>
						<div class="col-10">	
							<input class="form-control choiceStr">
						</div>
						<div class="col-1 position-relative">	
							<!-- <button type="button" class="btn-close position-absolute top-50 start-50 translate-middle" title="삭제"></button> -->
						</div>
					</li>
					<li class="row choice">
						<div class="col-1">
							<span class="box-title" >2.</span>
						</div>
						<div class="col-10">	
							<input class="form-control choiceStr">
						</div>
						<div class="col-1 position-relative">	
							<!-- <button type="button" class="btn-close position-absolute top-50 start-50 translate-middle" title="삭제"></button> -->
						</div>
					</li>
				</ul>
			</div>
		</div>
	</div>
</div>

<!-- 모달 창 부분  -->
<div class="modal center-modal fade" id="examExcelUploadModal" tabindex="-1"
	style="display: none;" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title"></h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form id="excelUploadForm" name="excelUploadForm"
					enctype="multipart/form-data" method="post" action="/DYUniv/examExcelUpload.do">
					<div class="upload_file">
						<label for="excelFile">시험 Excel파일 업로드</label><br /> 
						<input type="file" class="" id="excelFile" name="excelFile" />
						<button type="button" class="btn btn-secondary btn-sm" id="excelUpload">업로드</button>
					</div>
				</form>
			</div>
			<div class="modal-footer modal-footer-uniform">
				<button type="button" class="btn btn-danger" data-bs-dismiss="modal">취소
				</button>
			<!-- 	<button type="button" class="btn btn-primary float-end">확인</button> -->
			</div>
		</div>
	</div>
</div>


<!-- <button onclick="test()">test</button>
 -->

<script>
	var exSelect = $("#exSelect");
	var exSubList = $("#exSubList");
	var classNo = parseInt("${myClassVO.classNo }");
	
	var Qst = $("#Qst");						// 문제 목록
	var addQstBtn = $("#addQstBtn");			// 문제 추가
	var resetQstBtn = $("#resetQstBtn");		// 문제 초기화
	
	var examQstNo = $("#examQstNo"); 			//문제 목록 번호
	
	var examQst = $("#examQst");				// 문제
	var examImg = $("#examImg");				// 파일
	var examImgFileNo = $("#examImgFileNo");	// 파일 번호
	var qstCorrect = $("#qstCorrect");			// 정답 번호
	var qstScore = $("#qstScore");				// 배점 
	
	var qchoice = $("#qchoice");				// 보기 목록
	var addChoiceBtn = $("#addChoiceBtn");		// 보기 추가
	var resetChoiceBtn = $("#resetChoiceBtn");	//	보기 초기화
	
	var examCreateBtn = $("#examCreateBtn");	// 시험 등록 버튼
	var examTotalScore = $("#examTotalScore");	// 총점
	
	function examSetting () {
		$("#examName").val("C++ 쪽지시험");
		$("#examDate").val("2024-02-29");
		$("#examTime").val("120");
		
	}
	
/* 	window.alert = function (txt) {
		console.log(txt);
	}
	function test() {
		alert("alert test");
	} */
	
	$("#classRoomBtn").on("click", function () {
		location.href = "/DYUniv/managementClassRoom/" + classNo;
	})
	
	//엑셀 파일로 문제 업로드
	$("#excelUpload").on("click", function () {
		var exf = $("#excelFile");
		
		if(exf.val() == null || exf.val() == ""){
			alert("선택된 파일이 없습니다...");
			return false;
		}
		
		var file = document.getElementById("excelFile").files[0];
		
		if(!isExcelFile(file)){
			alert(".xlsx 형식만 지원합니다");
			return false;
		}
		
		const form = $('#excelUploadForm')[0];
		const formData = new FormData(form);
        
        //console.log("file upload")
        
        $.ajax({
            url : "/DYUniv/examExcelUpload.do",
            data: formData,
            cache: false,
            contentType: false,
            processData: false,
            success : function(res) {
            	console.log("data :", res);
                
            	if(res == null || res.length == 0){
            		alert("데이터가 없습니다");
            	} else {
            		$(Qst).find("li").remove();
            		$.each(res, function (i,v) {
            			addExcelQstList(i+1, v);
					})
					
					//제출 폼 초기화
				    resetQstBtn.trigger("click");
				    resetChoiceBtn.trigger("click");
				    updateTotalScore();
				    $("#examExcelUploadModal .modal-footer button").trigger("click");
            	}
            },
            error : function(request, status, error) {
                console.log("error");
                alert("code : " + request.status + "\n" + "message : " + request.responseText + "\n" + "error : " + error);    
            },
            type : "POST"
        });
		
		
	})
	
	examCreateBtn.on("click", function () {
		
		var examName = $("#examName").val();
		var examDate = $("#examDate").val();
		var examTime = $("#examTime").val();
		
		if(examName == null || examName == ""){
			alert("시험명을 입력해주세요");
			return false;
		}
		if(examDate == null || examDate == "" || new Date(examDate) <= new Date()){
			alert("날짜를 정확히 입력해 주세요");
			return false;
		}
		
		var exam = [];
		var qstList = $(Qst).find("li");
		//console.log("exam len : ", qstList.length)
		
		if(qstList == null || qstList.length == 0){
			alert("문제를 등록해 주세요");
			return false;
		}
		
		examCreateBtn.attr("disabled", true);

		for (var i = 0; i < qstList.length; i++) {
			var item = qstList[i];
			
			var chData = [];
			var chList = $(qstList[i]).find(".qstChoice");
			
			for (var j = 0; j < chList.length; j++) {
				var dt = {
						"chStr" : chList[j].value,
						"chNo" : (j+1)
				}
				chData.push(dt); 
			}
			
			var examData = {
					"qstNo" : $(item).find(".box-title").text(),
					"examQst" : $(item).find(".qstName").val(),
					"qstScore" : $(item).find(".qstScore").val(),
					"qstCorrect" : $(item).find(".qstCorrect").val(),
					"fileNo" : $(item).find(".qstFileNo").val(),
					"qstChList" : chData
			}
			exam.push(examData);
		}
		
		//console.log("examData : " + JSON.stringify(exam));
		
		var data = {
				"classNo" : classNo,
				"examName" : examName, 
				"examDate" : examDate, 
				"examTime" : examTime,
				"examTotalScore" : examTotalScore.val(),
				"examQstList" : exam
		}
		
		$.ajax({
			url: "/DYUniv/exampleUpload",
		    method: "post",
		    data : JSON.stringify(data),
		    contentType:'application/json; charset:utf-8',
		    success: function(res) {
		     	console.log(res);
		     	if(res == 'OK'){
		     		location.href = "/DYUniv/managementClassRoom/" + classNo;
		     	}
		    },
		    error : function(request,status,error){        
	            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);  
	            examCreateBtn.removeAttr("disabled");
	        }
		})
		
	})
	
	//문제 목록에서 정보 가져오기
	$(document).on("click", ".qstDetail", function () {
		
		//제출 폼 초기화
		resetQstBtn.trigger("click");
		resetChoiceBtn.trigger("click");
		addQstBtn.text("문제 수정");
		
		var qdetail = $(this).parents("li");
		
		console.log(qdetail)
		console.log("qstNo : " + qdetail.find(".box-title").text())
		
		examQstNo.val( qdetail.find(".box-title").text() );
		
		examQst.val( qdetail.find(".qstName").val() );
		examImg.val( qdetail.find(".qstFileName").val() );
		examImgFileNo.val( qdetail.find(".qstFileNo").val() );
		qstScore.val( qdetail.find(".qstScore").val() );
		qstCorrect.val( qdetail.find(".qstCorrect").val() );
		
		var chl = qdetail.find(".qstChoice");
		
		for (var i = 0; i < chl.length; i++) {
			if(i<2){
				qchoice.find(".choiceStr")[i].value = $(chl[i]).val();	//$(chl[i]).val()
			} else {
				addCh($(chl[i]).val(), i+1);
			}
		}
	})
	
	$(document).on("click", ".qstDelBtn", function () {
		console.log("test");
		
		if(!confirm("삭제하시겠습니까?")){
			return false;
		}
		
		$(this).parents("li").remove();
		
		var chl = Qst.find("li");
		
		//보기 번호 재설정
		for (var i = 0; i < chl.length; i++) {
			$(chl[i]).find(".box-title").text( (i + 1) + ".");
		}
	})
	
	$(function () {
		var exPopup = "";
		
 		$(document).on("click", ".examDetailBtn", function () {
 			console.log("detailBtn click..");
 					
			var memInfoRow = $(this).parent().parent();
			
 			console.log("memNo : ", memInfoRow.find(".memName").attr("idx"));
 			console.log("memName : ", memInfoRow.find(".memName").text());
 			console.log("examNo : ", $(this).attr("idt"));
 			
 			//체점 페이지
		})
	})
	
	/* 파일 다운로드*/
	function fileDownload() {
		var downloadTag = document.createElement("a");
		downloadTag.href = "/DYUniv/examTemplateFileDownload/";

		downloadTag.download = "시험 문제 폼.xlsx";
		downloadTag.click();
	}
	
	function isImageFile(file) {
		var ext = file.name.split(".").pop().toLowerCase();		//파일명의 확장자를 가져온다
		//확장자중 이미지에 해당하는 확장자가 아닌경우 -1 리턴 (false)
		return ($.inArray(ext, ["jpg", "jpeg", "gif", "png"]) === -1) ? false : true
	}
	
	function isExcelFile(file) {
		var ext = file.name.split(".").pop().toLowerCase();		//파일명의 확장자를 가져온다
		//확장자중 이미지에 해당하는 확장자가 아닌경우 -1 리턴 (false)
		return ($.inArray(ext, ["xlsx"]) === -1) ? false : true
	}
</script>
<script src="${pageContext.request.contextPath}/resources/js/exam.js"></script>