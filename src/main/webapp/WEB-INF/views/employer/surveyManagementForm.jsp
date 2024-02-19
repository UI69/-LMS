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
						<li class="breadcrumb-item" aria-current="page">설문조사</li>
						<li class="breadcrumb-item active" aria-current="page">설문 조사 관리</li>
					</ol>
				</nav>
			</div>
		</div>
	</div>
</div>
<div class="ms-15">
	<ul class="nav nav-tabs" role="tablist">
		<li class="">
			<a class="nav-link bg-danger-light" href="/DYUniv/surveyResult.do" role="tab" aria-selected="false" id="Btn">
				<span class="hidden-xs-down" class="" > &lt;&lt; 설문목록으로 이동</span>
			</a>
		</li>
		<li class="nav-item">
			<a class="nav-link active" data-bs-toggle="tab" href="#examplCreate" role="tab" aria-selected="false">
				<span class="hidden-sm-up"><i class="fa fa-paypal"></i></span>
				<span class="hidden-xs-down">설문 등록</span>
			</a>
		</li>
	</ul>


</div>

<div class="tab-content tabcontent-border m-15 bg-white">
	<!-- 
	<div class="tab-pane active" id="examAnswer" role="tabpanel">
		<div class="box-body">
			<div class="col-12">
				<h3 class="mt-30 ms-30"><strong>설문 참여자 목록</strong></h3>
			</div>
			<div class="row col-12 justify-content-end">
				<div class="row col-3 text-end me-15">
					<select class="form-control" id="">
						<option value="">===선택===</option>
						<option value="SRV001">대학 관련</option>
						<option value="SRV002">일반 설문</option>
					</select>
				</div>
				<div class="row col-3 text-end me-15">
					
				</div>
			</div>
			<div class="table-responsive m-30">
				<table class="table">
					<thead class="bg-primary">
						<tr>
							<th>학번</th>
							<th>이름</th>
							<th width="30%">설문명</th>
							<th>응답일</th>
							<th class="text-center">제출 정보 보기</th>
							<th class="text-center"></th>
						</tr>
					</thead>
					<tbody id="exSubList">
						<tr>
							<td colspan="6">조회하실 목록이 존재하지 않습니다.</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div> 
	-->

	<div class="tab-pane active" id="examplCreate" role="tabpanel">
		<div class="box-header">
			<div class="row col-12 justify-content-end">
				<div class="col-7">
					<h3 class="mt-15 ms-30"><strong>설문 등록</strong></h3>
				</div>
			</div>
		</div>
		<div class="box-body row" style="min-height: 350px">
			<div class="row col-12 " style="height: 140px">
				<div class="row col-6"></div>
				<div class="col-6 text-end">
					<button class="waves-effect waves-light btn bg-danger me-5 mt-5 btn-sm" 
						id="" onclick="examSetting()">설문 등록 폼 설정</button>
					<button class="waves-effect waves-light btn bg-success me-5 mt-5 btn-sm" 
						id="examExcelDownloadBtn" onclick="fileDownload()">설문 출제 폼 다운로드</button>
					<button class="waves-effect waves-light btn bg-success me-5 mt-5 btn-sm" 
						id="examExcelUploadBtn" data-bs-toggle="modal" data-bs-target="#examExcelUploadModal">설문 업로드(Excel)</button>
					<button class="waves-effect waves-light btn bg-success me-5 mt-5 btn-sm" 
						id="examCreateBtn">설문 등록</button>
				</div>
			
				<div class="row col-2 text-end"><span>설문 명 : </span></div>
				<div class="row col-2 "><input type="text" class="form-control h-30" id="examName"></div>
				
				<div class="row col-2 text-end"><span>마감 일자 : </span></div>
				<div class="row col-2"><input type="date" class="form-control h-30" id="examDate"></div>
				<div class="row col-2 text-end"><span>분류 : </span></div>
				<div class="row col-2">
					<select class="form-control h-30" id="srvCat">
						<option value="">===선택===</option>
						<option value="SRV001">대학 관련</option>
						<option value="SRV002">일반 설문</option>
					</select>
				</div>
				
			</div>
			<div class="col-2" style="border: 1px solid">
				<!-- 총점	: <input type="number" min="0" value="0" readonly="readonly" id="examTotalScore">
				<hr> -->
				<ul class="p-0" id="Qst">
					<!-- 설문 목록 -->					
				</ul>
			</div>
			<div class="col-5" style="border: 1px solid">
				<h4 class="m-2">질문 :    </h4><input type="text" class="form-control" id="examQst">
				<input type="hidden" id="examQstNo" value="0">
				<div class="text-end">
					<button class="btn btn-danger-light mt-5 btn-sm" id="resetQstBtn">초기화</button>
					<button class="btn btn-success-light mt-5 btn-sm" id="addQstBtn">질문 저장</button>
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
		$("#examName").val("학교 행사 기간 설문");
		$("#examDate").val("2024-02-25");
		$("#srvCat").val("SRV001").prop("selected", true);;
		
	}
	
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
            url : "/DYUniv/surveyExcelUpload.do",
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
	
	
	function addExcelQstList(qstNo, examQstObj) {
	    var qstChList = examQstObj.srvQstChList;
	    
	    var code = ''
	        +'<li class="row Qst">                                             '
	        +'<div class="col-1">                                              '
	        +'	<span class="box-title" style="">'+ qstNo +'</span>           '
	        +'</div>                                                           '
	        +'<div class="col-9">	                                           '
	        +'	<button class="btn btn-secondary btn-sm text-truncate max-w-150 qstDetail">' + examQstObj.srvQst + ' </button> '
	        +'</div>                                                           '
	        +'<div class="col-2 position-relative">	                           '
	        +'	<button type="button" class="btn-close position-absolute top-50 start-50 translate-middle qstDelBtn" title="삭제"></button> '
	        +'</div>                                                           '
	        +'<input type="hidden" class="qstName" value="' + examQstObj.srvQst +'"> '

		    for (var i = 0; i < qstChList.length; i++) {
		        if(qstChList[i].chStr != null && qstChList[i].chStr != ""){
		            code += '<input type="hidden" class="qstChoice" value="' + qstChList[i].chStr +'"> '
		        }
		    }
	        
	        code += '</li>        ';

	    Qst.append(code);
	}
	
	
	
	examCreateBtn.on("click", function () {
		
		var examName = $("#examName").val();
		var examDate = $("#examDate").val();
		var examTime = $("#examTime").val();
		
		if(examName == null || examName == ""){
			alert("설문 이름을 입력해주세요");
			return false;
		}
		if(examDate == null || examDate == "" || new Date(examDate) <= new Date()){
			alert("마감날짜를 정확히 입력해 주세요");
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
					"srvQst" : $(item).find(".qstName").val(),
					"srvQstChList" : chData
			}
			exam.push(examData);
		}
		
		//console.log("examData : " + JSON.stringify(exam));
		
		var data = {
				"srvName" : examName, 
				"srvEndDate" : examDate, 
				"srvQstList" : exam,
				"srvCategory" : $("#srvCat").val()
		}
		
		$.ajax({
			url: "/DYUniv/surveyUpload",
		    method: "post",
		    data : JSON.stringify(data),
		    contentType:'application/json; charset:utf-8',
		    success: function(res) {
		     	console.log(res);
		     	if(res == 'OK'){
		     		alert("저장에 성공했습니다");
		     		location.href = "/DYUniv/surveyManagementForm.do";
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
	
	function isExcelFile(file) {
		var ext = file.name.split(".").pop().toLowerCase();		//파일명의 확장자를 가져온다
		//확장자중 이미지에 해당하는 확장자가 아닌경우 -1 리턴 (false)
		return ($.inArray(ext, ["xlsx"]) === -1) ? false : true
	}
	

	function updateQstList() {
	    console.log("update")
	    var qstlist = Qst.find("li");
	    
	    var qstListNo = examQstNo.val();
	    console.log("now qstNo : " + qstListNo)
	    
	    for (var i = 0; i < qstlist.length; i++) {
	        if($(qstlist[i]).find(".box-title").text() == qstListNo){
	            var qdetail = $(qstlist[i]);
	            qdetail.find(".qstDetail").text(examQst.val());
	            qdetail.find(".qstName").val(examQst.val());
	            qdetail.find(".qstFileName").val(examImg.val())
	            qdetail.find(".qstFileNo").val(examImgFileNo.val())
	            qdetail.find(".qstScore").val(qstScore.val())
	            qdetail.find(".qstCorrect").val(qstCorrect.val())
	            
	            $(qdetail).find(".qstChoice").remove();
	            
	            var qstChoice = qchoice.find(".choiceStr");
	            
	            for (var i = 0; i < qstChoice.length; i++) {
	                code = '<input type="hidden" class="qstChoice" value="' + $(qstChoice[i]).val() +'"> '
	                $(qdetail).append(code);
	            }
	        }
	    }
	}

	function addQstList() {
	    var qstNo = Qst.find("li").length + 1;
	    
	    var qstChoice = qchoice.find(".choiceStr");
	    var chStr = [];
	    
	    for (var i = 0; i < qstChoice.length; i++) {
	        chStr.push($(qstChoice[i]).val());
	    }
	    
	    console.log("chStr : ",chStr);
	    
	    var code = ''
	        +'<li class="row Qst">                                             '
	        +'<div class="col-1">                                              '
	        +'	<span class="box-title" style="">'+ qstNo +'</span>           '
	        +'</div>                                                           '
	        +'<div class="col-9">	                                           '
	        +'	<button class="btn btn-secondary btn-sm text-truncate max-w-150 qstDetail">' + examQst.val() + ' </button> '
	        +'</div>                                                           '
	        +'<div class="col-2 position-relative">	                           '
	        +'	<button type="button" class="btn-close position-absolute top-50 start-50 translate-middle qstDelBtn" title="삭제"></button> '
	        +'</div>                                                           '
	        +'<input type="hidden" class="qstName" value="' + examQst.val() +'"> '
	        +'<input type="hidden" class="qstFileName" value="' + examImg.val() +'"> '
	        +'<input type="hidden" class="qstFileNo" value="' + examImgFileNo.val() +'"> '
	        +'<input type="hidden" class="qstScore" value="' + qstScore.val() +'"> '
	        +'<input type="hidden" class="qstCorrect" value="' + qstCorrect.val() +'"> '

	        for (var i = 0; i < chStr.length; i++) {
	            code += '<input type="hidden" class="qstChoice" value="' + chStr[i] +'"> '
	        }
	        
	        code += '</li>        ';

	    Qst.append(code);
	}

	function addCh(val, chNo) {
	    var code = ''
	        +'<li class="row choice">                     '
	        +'<div class="col-1">                         '
	        +'	<span class="box-title" >' +chNo+'.</span>'
	        +'</div>                                      '
	        +'<div class="col-10">	                      '
	        +'	<input class="form-control choiceStr" value="' + val + '">    '
	        +'</div>                                      '
	        +'<div class="col-1 position-relative">	      '
	        +'<button type="button" class="btn-close position-absolute top-50 start-50 translate-middle chDelBtn" title="삭제"></button>'
	        +'</div>                                      '
	        +'</li>                                       '
	    qchoice.append(code);
	}

	qstScore.on("change", function () {
	    try{
	        parseInt(this.value);
	    } catch (e) {
	        this.value = 1;
	    }
	    
	    if(this.value < 1){
	        this.value = 1;
	    }
	    
	    if(this.value > 100){
	        this.value = 100;
	    }
	})

	qstCorrect.on("change", function () {
	    console.log("changes...", this.value);
	    
	    try{
	        parseInt(this.value);
	    } catch (e) {
	        this.value = 1;
	    }
	    
	    if(this.value < 1){
	        this.value = 1;
	    }
	    
	    var chl = qchoice.find("li").length;
	    if(this.value > chl){
	        this.value = chl;
	    }
	})

	//문제 임시 목록 추가
	addQstBtn.on("click", function () {
	    console.log("addQst");
	    
	    
	    if($("#examQst").val() == null || $("#examQst").val() == ""){
	    	alert("질문을 설정해주세요.");
	    	return;
	    }
	    
	    if(examQstNo.val() == 0){
	        //문제 목록 추가
	        addQstList();
	    } else {
	        updateQstList();
	    }
	    
	    //제출 폼 초기화
	    resetQstBtn.trigger("click");
	    resetChoiceBtn.trigger("click");
	})


	//보기 삭제 버튼
	$(document).on("click", ".chDelBtn", function () {
	    console.log("del");
	    $(this).parents("li").remove();
	    
	    var chl = qchoice.find("li");
	    
	    //보기 번호 재설정
	    for (var i = 2; i < chl.length; i++) {
	        $(chl[i]).find(".box-title").text( (i + 1) + ".");
	    }
	})

	//보기 추가
	addChoiceBtn.on("click", function (){
	    var chNo = qchoice.find("li").length + 1;
	    
	    if(chNo > 7){
	        alert("보기는 최대 7개입니다.");
	        return false;
	    }
	    
	    addCh("", chNo);
	    
	})

	//설정중인 보기 초기화
	resetChoiceBtn.on("click", function (){
	    var code = ''
	        +'<li class="row choice">                     '
	        +'<div class="col-1">                         '
	        +'	<span class="box-title" >1.</span>        '
	        +'</div>                                      '
	        +'<div class="col-10">	                      '
	        +'	<input class="form-control choiceStr">    '
	        +'</div>                                      '
	        +'<div class="col-1 position-relative">	      '
	        +'</div>                                      '
	        +'</li>                                       '
	        +'<li class="row choice">                     '
	        +'<div class="col-1">                         '
	        +'	<span class="box-title" >2.</span>        '
	        +'</div>                                      '
	        +'<div class="col-10">	                      '
	        +'	<input class="form-control choiceStr">    '
	        +'</div>                                      '
	        +'<div class="col-1 position-relative">	      '
	        +'</div>                                      '
	        +'</li>                                       '
	    
	    $("#qchoice").html(code);
	})

	//설정중인 문제 초기화
	resetQstBtn.on("click", function () {
	    examQst.val("");
	    examImg.val("");
	    examImgFileNo.val("");
	    qstCorrect.val("1");
	    qstScore.val("5");
	    examQstNo.val("0")
	    addQstBtn.text("문제 저장");
	})


	//과제 선택
	exSelect.on("change", function () {
	    var examNo = $(this).val();
	    
	    if(examNo == null || examNo == ""){
	        return false;
	    }
	    
	    var data = {
	            "examNo" : examNo
	    }
	    
	    exSubList.html(
	        '<tr>'
	            + '<td colspan="6">조회하실 게시물이 존재하지 않습니다.</td>'
	        + '</tr>'
	    );

	    $.ajax({
	        type: 'post',
	        url: '/DYUniv/class/exSubmitList',
	        data : data,
	        success: function (res) { /* 결과 성공 콜백함수 */
	            console.log(res);
	        
	            code = '';

	            if(res != null && res.length > 0){
	                $.each(res, function(i,v)  {
	                    
	                    var fileNo = "0";
	                    var fileName = "(제출 파일 없음)";
	                    
	                    if(v.fileNo != 0){
	                        fileNo = v.fileNo;
	                        fileName = v.fileName;
	                    }
	                    
	                    code += '<tr class="exMemList">';
	                    code += '	<td class="">' + v.memId + '</td>';
	                    code += '	<td class="memName" idx="'+ v.memNo +'">' + v.memName + '</td>';
	                    code += '	<td>' + v.examName + '</td>';
	                    code += '	<td>' + v.answerDate.substr(0,10) + '</td>';
	                    code += '	<td class="text-center"><button class="btn btn-primary-light btn-xs examDetailBtn" idt="' + v.examNo + '">시험지 체점하기</button></td>';
	                    code += '	<td class="exScore text-end" idx="'+ v.examNo +'"><input type="number" value="'+ v.totalScore +'" readonly> </td>';
	                    code += '</tr>';
	                });
	            } 
	            //console.log(code);
	            exSubList.html(code);
	        }
	    })
	})
	
		/* 파일 다운로드*/
	function fileDownload() {
		var downloadTag = document.createElement("a");
		downloadTag.href = "/DYUniv/surveyTemplateFileDownload/";

		downloadTag.download = "시험 문제 폼.xlsx";
		downloadTag.click();
	}

</script>