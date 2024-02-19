<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<div class="container-full">
	<!-- Content Header (Page header) -->
	<div class="content-header">
		<div class="d-flex align-items-center">
			<div class="me-auto">
				<h3 class="page-title">교수 계정 생성</h3>
				<div class="d-inline-block align-items-center">
					<nav>
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="#"><i class="mdi mdi-home-outline"></i></a></li>
							<li class="breadcrumb-item" aria-current="page">교수 관리</li>
							<li class="breadcrumb-item active" aria-current="page">교수 계정 생성</li>
						</ol>
					</nav>
				</div>
			</div>		
		</div>
	</div>	  

	<!-- Main content -->
	<section class="content">

	 <!-- Step wizard -->
	  <div class="box">
		<div class="box-body wizard-content">
			<form action="/DYUniv/employer/createProID.do" class="tab-wizard wizard-circle" id="createIDForm" method="post">
			<input type="hidden" value="${departmentVO.dprtCategory }" name="dprtCategory"/>
			<!-- Step 1 -->
			<h6>User Information</h6>
				<section>
				<div class="row">
					<div class="col-md-4">
						<div class="box box-widget widget-user">
							<!-- Add the bg color to the header using any of the bg-* classes -->
							<div class="widget-user-header bg-img bbsr-0 bber-0" style="background: url('${pageContext.request.contextPath}/resources/images/gallery/full/10.jpg') center center;" data-overlay="5">
							  <h3 class="widget-user-username text-white">USER NAME</h3>
							  <h6 class="widget-user-desc text-white">Proressor</h6>
							</div>
							<div class="widget-user-image">
							  <img class="rounded-circle" src="${pageContext.request.contextPath}/resources/images/user3-128x128.jpg" alt="User Avatar">
							</div>
							<div class="box-footer">
								<div class="row">
									<div class="col-sm-6">
										<div class="description-block">
											<h5 class="glyphicon glyphicon-plus"></h5>
											<a class="btn btn-sm btn-primary-light btn-outline" id="profileUploadBtn">
												<span class="description-text">사진 등록</span>
											</a>
										</div>
										<!-- /.description-block -->
									</div>
									<div class="col-sm-6">
										<div class="description-block">
											<h5 class="glyphicon glyphicon-minus"></h5>
											<a class="btn btn-sm btn-primary-light btn-outline" id="profileDelBtn">
												<span class="description-text">사진 삭제</span>
											</a>
										</div>
									</div>
								</div>
								<input type="file" name="file" id="file" style="display: none;">
								<input type="hidden" name="memProfile" id="memProfile" value="">
							</div>
						</div>
					</div>
					<div class="col-md-8">
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<div class="form-group">
										<label for="location3" class="form-label">단과대학 :</label>									
										<select class="form-select" id="fSel" onchange="selDname(this)">
											<option value="none" disabled selected>Select College</option>
											<option value="DPC001">인문대학</option>
											<option value="DPC002">사회대학</option>
											<option value="DPC003">교육대학</option>
											<option value="DPC004">공학대학</option>
											<option value="DPC005">자연대학</option>
											<option value="DPC006">의약대학</option>
											<option value="DPC007">예체능대학</option>
										</select>																	
									</div>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<div class="form-group">
										<label for="dprtName" class="form-label">전공 :</label>
										<select class="form-select" id="sSel" name="dprtNo">
											<option value="none" disabled selected>Select College</option>
										</select>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label for="emailAddress1" class="form-label">성명 :</label>
									<input type="text" class="form-control" id="memName" name="memName"/>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label for="memBir" class="form-label">생년월일 :</label>
									<input type="date" class="form-control" id="memBir" name="memBir"/>
								</div>
							</div>
						</div>
						<div class="row">	
							<div class="col-md-2">
								<div class="form-group">
									<label class="form-label">성별 :</label>
									<div class="c-inputs-stacked">
										<input type="radio" id="memGenF" name="memGen" value="F"/>
										<label for="memGenF" class="d-block">F</label>
										<input type="radio" id="memGenM" name="memGen" value="M"/>
										<label for="memGenM" class="d-block">M</label>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				</section>				
				
				<!-- Step 2 -->
				<h6>User Detail <span style="color :red; font-size: 0.8rem;"> &nbsp;&nbsp; * ID와 비밀번호는 자동 생성됩니다. (초기 비밀번호:생년월일 6자리)</span></h6>
				<section>
					<div class="row">
						<div class="col-6">
							<div class="form-group">
								<label for="username123" class="form-label">휴대폰번호 :</label>
								<input type="text" class="form-control" id="memPh" name="memPh"/>
							</div>
						</div>	
						<div class="col-6">
							<div class="form-group">
								<label for="password123" class="form-label">E-MAIL :</label>
								<input type="email" class="form-control" id="memEmail" name="memEmail"/>
							</div>
						</div>
						<div class="col-6">
							<div class="form-group">
								<label for="username123" class="form-label">우편번호 :</label>
								<input type="text" class="form-control" id="postCode" name="memPostcode"/>
							</div>
						</div>
						<div class="col-3">
							<div class="form-group">
								<a class="btn btn-success-light form-control btn-sm mt-30" id="" href="#">주소 검색</a>
							</div>
						</div>
						<div class="col-12">
							<div class="form-group">
								<label for="addressline1" class="form-label">Address Line 1 :</label>
								<input type="text" class="form-control" id="addressline1" name="memAddr1"/> 
							</div>
						</div>
						<div class="col-12">
							<div class="form-group">
								<label for="addressline2" class="form-label">Address Line 2 :</label>
								<input type="text" class="form-control" id="addressline2" name="memAddr2"/> 
							</div>
						</div>
					</div>
				</section>				
				<!-- Step 3 -->
				<!-- <h6>입퇴사 관리</h6> -->
				<section>
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<div class="row">
									<div class="col-6">
										<label for="date1" class="form-label">입사일 :</label>
										<input type="date" class="form-control" id="joinDate" name="memJoinDate"/>
									</div>
								</div>
							</div>
						</div>
					</div>
				</section>
			</form>
		</div>
	  </div>
	  <div class="box">
	  </div>
	<button type="button" class="btn btn-success save-category" id="addBtn">Save</button>
	<button type="button" class="btn btn-danger" id="jhBtnClose">Close</button>
	<button type="button" class="btn btn-danger-light" id="test">test</button>
	</section>
	<!-- /.content -->
</div>

<c:if test="${not empty message }">
	<script type="text/javascript">
	Swal.fire({
		  text: '${message}',
		  icon: 'success',
		  confirmButtonText: 'Cool'
		});
		<c:remove var="message" scope="request"/>
		<c:remove var="message" scope="session"/>
	</script>
</c:if>
<script type="text/javascript">
	var memName = $("#memName");
	var memGen = $("#memGen");
	var memBir = $("#memBir");
	var memPh = $("#memPh");
	var memEmail = $("#memEmail");
	var memPostcode = $("#memPostcode");
	var memAddr1 = $("#memAddr1");
	var memAddr2 = $("#memAddr2");
	var joinDate = $("#joinDate");
	var resignDate = $("#resignDate");
	var createIDForm = $("#createIDForm");	// ID 생성 form
	
	//옵션 선택 이벤트
	var fSel = document.querySelector("#fSel");
	var sSel = document.querySelector("#sSel");
	var myForm = document.forms.createIDForm;

	
	$("#profileUploadBtn").on("click", function () {
		$("#file").trigger("click");
	})
	
	$("#profileDelBtn").on("click", function () {
		$("#file").val("");
		$("#fileNo").val("");
	})
	
	$("#file").on("change", function (event) {
		var file = event.target.files[0];
	    
	    //사진여부 확인
	    if(!isImageFile(file)){
	        console.log("not img file...");
	        alert("사진만 등록 가능합니다.");
	        examImg.val("");
	        return false;
	    }
	    
	    var formData = new FormData();
	    formData.append("files", file);
	    
	    $.ajax({
	        url : "/DYUniv/profileFileUpload.ajax",
	        type : "post",
	        data : formData,
	        processData : false,
	        contentType : false,
	        success : function(res){
	        	console.log("res : "+ res);
	        	
	        	if(res == "failed"){
	                alert("파일 업로드 실패...");
	            } else {
	            	$("#memProfile").val(res);
	            }
	        },
	        error : function(request,status,error){        
	            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);  
	        }
	    })
	})
	
	$("#test").on("click", function () {
		$("#memName").val("구미호");
		$("#memBir").val("2001-11-12");
		$("#memGenF").trigger("click");
		$("#memPh").val("010-1111-2222");
		$("#memEmail").val("ddit001@ddit.or.kr");
		$("#postCode").val("112233");
		$("#addressline1").val("대전 중구 오류동 OO빌딩");
		$("#addressline2").val("1301호");
		$("#joinDate").val("2024-02-10");
		$("#fSel").val('DPC003').trigger('change');
	})
	
	
	//옵션 선택 이벤트
	function selDname(dprtCategory){
		console.log("dprt  : ", dprtCategory.value );
		
		$.ajax({
			url : "/DYUniv/employer/selectDprt/" + dprtCategory.value,
			type : "get",
			dataType : "json",
			success : function(res){
				console.log("res", res);
				sSel.innerHTML = "";
				for(var i=0; i<res.length; i++){
					var departmentVO = res[i];
					addOption(sSel,departmentVO.dprtNo,departmentVO.dprtName);
				}
			}
		});
	}
	// 옵션 선택 이벤트
	function addOption(selectElement, optionValue, optionText){
		var optTag = document.createElement("option");
		optTag.value = optionValue;
		optTag.innerHTML = optionText;
		selectElement.appendChild(optTag);
		console.log("ddd",selectElement.appendChild(optTag))
	}
	
	
	$(function() {
		var addBtn = $("#addBtn");	// save 버튼
		// 교수 ID 생성 이벤트
		addBtn.on("click", function() {		
	// 		var dprtNo = document.createElement("option");
	 		var selected = sSel.options[sSel.selectedIndex].value;
			
			createIDForm.submit();
			
			/*
			memName = memName.val(); 		// 이름
	 		memGen = memGen.val(); 			// 성별
	 		memBir = memBir.val(); 			// 생년월일
	 		memPh = memPh.val(); 			// 핸드폰번호
	 		memEmail = memEmail.val(); 		// 이메일
	 		memPostcode = memPostcode.val();// 우편번호
	 		memAddr1 = memAddr1.val(); 		// 주소1
	 		memAddr2 = memAddr2.val(); 		// 주소2
	 		joinDate = joinDate.val();		// 입사일
	 		resignDate = resignDate.val();	// 퇴사일
	 		
	 		if (memName == null || memName == "") {
	 			alert("이름을 입력해주세요");
	 			memName.focus();
	 			return false;
	 		}
	 		if (memGen == null || memGen == "") {
	 			alert("성별을 입력해주세요");
	 			memGen.focus();
	 			return false;
	 		}
	 		if (memPh == null || memPh == "") {
	 			alert("핸드폰 번호를 입력해주세요");
	 			memPh.focus();
	 			return false;
	 		}
	 		if (memEmail == null || memEmail == "") {
	 			alert("이메일을 입력해주세요");
	 			memEmail.focus();
	 			return false;
	 		}
	 		if (memPostcode == null || memPostcode == "") {
	 			alert("우편번호를 입력해주세요");
	 			memPostcode.focus();
	 			return false;
	 		}
	 		if (memAddr1 == null || memAddr1 == "") {
	 			alert("주소를 입력해주세요");
	 			memAddr1.focus();
	 			return false;
	 		}
	 		if (joinDate == null || joinDate == "") {
	 			alert("입사일을 설정해주세요.");
	 			return false;
	 		}		
			*/
	 		
		});
		
		
		
	});

	function isImageFile(file) {
		var ext = file.name.split(".").pop().toLowerCase();		//파일명의 확장자를 가져온다
		//확장자중 이미지에 해당하는 확장자가 아닌경우 -1 리턴 (false)
		return ($.inArray(ext, ["jpg", "jpeg", "gif", "png"]) === -1) ? false : true
	}

</script>

	

