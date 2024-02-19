<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="path/to/touchspin.js"></script>


<style>
td {
	/* padding: 8px !important; */
}
td > a {
	cursor: pointer;
}
</style>
<div class="container-full">
	<!-- Content Header (Page header) -->
	<div class="content-header">
		<div class="d-flex align-items-center">
			<div class="me-auto">
				<h3 class="page-title">모임 홈</h3>
				<div class="d-inline-block align-items-center">
					<nav>
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="#"><i
									class="mdi mdi-home-outline"></i></a></li>
							<li class="breadcrumb-item" aria-current="page">모임</li>
							<li class="breadcrumb-item active" aria-current="page">모임 홈</li>
						</ol>
					</nav>
				</div>
			</div>
		</div>
	</div>
	<!-- Main content -->
	<section class="content" >
		<div class="row">
			<div class="col-12">
				<div class="box">
					<div class="box-body">
						<!-- Nav tabs -->
						<ul class="nav nav-tabs customtab2" role="tablist">
							<li class="nav-item"><a class="nav-link <c:if test="${tab ne 'mylist' }">active</c:if>"
								data-bs-toggle="tab" href="#home7" role="tab"><span
									class="hidden-sm-up"><i class="ion-home"></i></span> <span
									class="hidden-xs-down">전체 모임 목록</span></a></li>
							<li class="nav-item"><a class="nav-link <c:if test="${tab eq 'mylist' }">active</c:if>"
								data-bs-toggle="tab" href="#messages7" role="tab"><span
									class="hidden-sm-up"><i class="ion-email"></i></span> <span
									class="hidden-xs-down">모임 생성 관리</span></a></li>
						</ul>
						<!-- Tab panes -->
						<div class="tab-content">
							<!-- 전체 모임 목록 -->
									
							<div class="tab-pane <c:if test="${tab ne 'mylist' }">active</c:if>" id="home7" role="tabpanel">
								<div class="p-15">
									<div class="row" style="justify-content: space-between;">
										<div class="col-md-6">
											<div class="form-group" style="margin-top: 10px">
												<h4 style="display: inline-block;">전체 모임</h4>
												<p style="display: inline-block; line-height: 1.2; color: #0d6efd;">
													
												</p>
											</div>
										</div>
										<div class="col-md-4 col-12" style="margin-top: 5px;">
											<div class="form-group">
											<form method="post" id="searchForm">
												<input type="hidden" name="page" id="page"/>
													<select class="form-control" name="searchType"
														style="width: 30%; display: inline-block;">
														<option selected="selected">-선택-</option>
														<option value="type" <c:if test="${searchType eq 'type' }">selected</c:if>>모임명</option>
														<option value="master" <c:if test="${searchType eq 'master' }">selected</c:if>> 마스터</option>
													</select> 
												
													<input type="text" name="searchWord" value="${searchWord }"
                     									class="form-control" style="width: 50%; display: inline-block;" placeholder="검색">
												<button type="submit"  value="" class="btn btn-primary" style="padding: 5px 12px;">검색</button>
												</form>
											</div>
										</div>
									</div>
									<div class="table-responsive">
										<table class="table mb-0" style="text-align: center">
											<thead class="bg-primary">
												<tr>
													<th scope="col">순번</th>
													<th scope="col">모임분류</th>
													<th scope="col">모임명</th>
													<th scope="col">모임목표</th>
													<th scope="col">마스터</th>
													<th scope="col">인원</th>
													<th scope="col">가입 신청</th>
												</tr>
											</thead>
											<tbody>
												<!-- 보여지는 목록 갯수는 무조건 5개 !! - ㅊㅇㅇ -->
										<c:set value="${pagingVO.dataList }" var="communityList" />
											<c:choose>
												<c:when test="${empty communityList }">
													<tr>
														<td colspan="7">생성된 커뮤니티 그룹이 없습니다</td>
													</tr>
												</c:when>
												<c:otherwise>
													<c:set var="cmIndex" value="${pagingVO.totalRecord - (pagingVO.currentPage -1 ) * pagingVO.screenSize }"/>
													<c:forEach items="${communityList }" var="list">
														
														<c:set var="regFlag" value="false"/>
														<c:if test="${!empty regCmList }">
															<c:forEach items="${regCmList }" var="myCmm">
																<c:if test="${myCmm.cmNo eq list.cmNo }">
																	<c:set var="regFlag" value="true"/>
																</c:if>
															</c:forEach>
														</c:if>
													
														<tr>
															<td><strong>${cmIndex }</strong></td>
															<c:set var="cmIndex" value="${cmIndex - 1}" />
															<td>
																<c:if test="${list.cmType eq 'CMT001' }">학업</c:if>
																<c:if test="${list.cmType eq 'CMT002' }">외국어</c:if>
																<c:if test="${list.cmType eq 'CMT003' }">봉사</c:if>
																<c:if test="${list.cmType eq 'CMT004' }">예체능</c:if>
																<c:if test="${list.cmType eq 'CMT005' }">여가</c:if>
																<c:if test="${list.cmType eq 'CMT006' }">종교</c:if>
																<c:if test="${list.cmType eq 'CMT007' }">기타</c:if>
															</td>
															<td> 
																<%-- <a class="viewCommu" data-detail="${list.cmNo }">${list.cmName }</a>  --%>
																${list.cmName }
															</td>
														
															<td>${list.cmGoal }</td>
															<td>${list.cmMaster }</td>
															<td><span>${list.cmCount }</span>/<span>${list.cmMaxMem }</span></td>
															<td class="p-0">
																<c:if test="${list.memNo ne memberVO.memNo && list.cmMaxMem > list.cmCount+1 && regFlag eq 'false'}">
																	<button type="button" class="waves-effect waves-light btn btn-rounded btn-primary-light mb-5 applyForCoummnity"
																	style="font-size: 12px;" idx="${list.cmNo }" idn="${list.cmName }">가입신청</button>
																</c:if>
																
															</td>
														</tr>
														<c:set var="index" value="${index + 1}" />
													</c:forEach>
												</c:otherwise>
											</c:choose>
												
											</tbody>
										</table>
									</div>
								</div>
						<!--  -->		
						<div class="col-sm-12 col-md-6" style="float: right; margin-right: 80px">
							<div class="dataTables_paginate paging_simple_numbers" id="pagingArea">
								${pagingVO.pagingHTML }
							</div>
						</div>
						<!--  -->		
								
							</div>
							<!-- 모임 생성 관리 시작-->
							
							<div class="tab-pane <c:if test="${tab eq 'mylist' }">active</c:if>" id="messages7" role="tabpanel">
								<div class="p-15">
									<div class="row" style="justify-content: space-between;">
										<div class="col-md-6">
											<div class="form-group" style="margin-top: 10px">
												<h4 style="display: inline-block;">모임 생성 신청 현황</h4>
											</div>
										</div>
										<div class="col-md-3 col-12"
											style="margin-top: 5px; display: flex; justify-content: flex-end;">
											<div class="form-group">
												<button type="button" class="btn btn-primary"
													style="padding: 5px 12px;" data-bs-toggle="modal"
													data-bs-target="#createCommu">새 모임 생성</button>
											</div>
										</div>
									</div>
									
									<div class="table-responsive">
										<table class="table mb-0" style="text-align: center">
											<thead class="bg-primary">
												<tr>
													<th scope="col">모임분류</th>
													<th scope="col">모임명</th>
													<th scope="col">모임목표</th>
													<th scope="col">정원</th>
													<th scope="col">운영 상태</th>
												</tr>
											</thead>
											<tbody>
												<!-- 보여지는 목록 갯수는 무조건 5개 !! - ㅊㅇㅇ -->
											 <c:set value="${pagingVO2.dataList }" var="myCommunityList" />
											 	<c:choose>
													<c:when test="${empty myCommunityList}">
														<tr>
															<td>신청그룹 목록이 존재하지 않습니다</td>
														</tr>
													</c:when>
												<c:otherwise>
													<c:forEach items="${myCommunityList}" var="myCommu">
															<tr>
																<td>
																	<c:if test="${myCommu.cmType eq 'CMT001' }">학업</c:if>
																	<c:if test="${myCommu.cmType eq 'CMT002' }">외국어</c:if>
																	<c:if test="${myCommu.cmType eq 'CMT003' }">봉사</c:if>
																	<c:if test="${myCommu.cmType eq 'CMT004' }">예체능</c:if>
																	<c:if test="${myCommu.cmType eq 'CMT005' }">여가</c:if>
																	<c:if test="${myCommu.cmType eq 'CMT006' }">종교</c:if>
																	<c:if test="${myCommu.cmType eq 'CMT007' }">기타</c:if>
																</td>
																<td> 
																	<a class="viewCommu" data-detail="${myCommu.cmNo }">${myCommu.cmName }</a> 
																</td>
																<td>${myCommu.cmGoal  }</td>
																<td>${myCommu.cmMaxMem   }</td>
																<td>
																	<c:if test="${myCommu.cmOpenStatusCode eq 'CMO002'}">
																		<div class="badge badge-primary">운영</div>
																	</c:if>
																	<c:if test="${myCommu.cmOpenStatusCode eq 'CMO003'}">
																		<div class="badge badge-primary">폐쇄</div>
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
								<!--  -->		
						<div class="col-sm-12 col-md-6"
							style="float: right; margin-right: 80px">
							<div class="dataTables_paginate paging_simple_numbers" id="pagingArea2">
								${pagingVO2.pagingHTML }
							</div>
					
						</div>
						<!--  -->		
								<form method="post" id="searchForm2">
									<input type="hidden" name="page2" id="page2"/>
									<input type="hidden" name="tab" value="mylist"/>
								</form>


								<!-- 새 모임 생성 폼 모달 창 시작 -->
							
								<div class="modal center-modal fade" id="createCommu"
									tabindex="-1">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title"> <strong>새 모임 생성 폼</strong> </h5>
												<button type="button" class="btn-close"
													data-bs-dismiss="modal" aria-label="Close"></button>
											</div>
											<div class="modal-body">
												<form action="/DYUniv/commuRegistr" method="post" id="commuGroup">
													<div class="form-group">
														<label class="form-label">모임 분류</label> 
														<select name="cmType" id="cmType" class="form-control">
															<option value="CMT001">학업</option>
															<option value="CMT002">외국어</option>
															<option value="CMT003">봉사</option>
															<option value="CMT004">예체능</option>
															<option value="CMT005">여가</option>
															<option value="CMT006">종교</option>
															<option value="CMT007">기타</option>
														</select>
													</div>
													<div class="form-group">
														<label class="form-label">모임명</label> 
														<input name="cmName" id="cmName" 
															type="text" class="form-control" placeholder="모임 명을 입력하세요.">
													</div>
													<div class="form-group">
														<label class="form-label">모임목표</label>
														<textarea rows="5" class="form-control" name="cmGoal" id="cmGoal" 
																placeholder="모임 목표를 입력하세요."></textarea>
													</div>
													<!-- <div class="form-group">
														<input id="demo3" type="text" value="" name="demo3" data-bts-button-down-class="btn btn-secondary" data-bts-button-up-class="btn btn-secondary">
													</div> -->
													<div class="form-group">
														<label class="control-label">정원</label> <span>*최대 정원 15명</span> <br>
														<input class="form-control"  name="cmMaxMem" id="cmMaxMem" 
															type="number" min="0" max="15" placeholder="0" style="display: block">
													</div>
												</form>
											</div>
											<div class="modal-footer modal-footer-uniform">
												<button type="button" class="btn btn-danger"
													data-bs-dismiss="modal">취소</button>
												<button type="button" class="btn btn-danger-light"
													onclick="
													$('#cmType').val('CMT005')
													$('#cmName').val('캠핑모임');
													$('#cmGoal').val('캠핑을 즐기는 모임');
													$('#cmMaxMem').val('6');
													">test</button>
												<button type="button" id="registerBtn" value="registerBtn"  class="btn btn-primary float-end">생성</button>
											</div>
										</div>
									</div>
								</div>
								<!-- 새 모임 생성 폼 모달 창 끝 -->
								
								<!-- 모임 상세보기 모달 창 시작 -->
								<div class="modal center-modal fade" id="detailCommu"
									tabindex="-1">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title"> <strong>모임 상세 정보</strong> </h5>
											</div>
											<div class="modal-body">
												<form>
													<input type="hidden" id="cmNo" value="" />
													<div class="form-group">
														<label class="form-label">모임 분류</label> 
													<%-- 	 <input type="text" class="form-control" 
															name="cmType" id="cmType" value="${myCommu.cmType }" readonly>  --%>
														 <select name="cmType" id="cmType" class="form-control" disabled="disabled">
															<option value="CMT001">학업</option>
															<option value="CMT002">외국어</option>
															<option value="CMT003">봉사</option>
															<option value="CMT004">예체능</option>
															<option value="CMT005">여가</option>
															<option value="CMT006">종교</option>
															<option value="CMT007">기타</option>
														</select>  
														
													</div>
													<div class="form-group">
														<label class="form-label">모임명</label> 
														<input type="text" class="form-control" 
															name="cmName" id="cmName" value="" readonly>
													</div>
													<div class="form-group">
														<label class="form-label">모임목표</label>
														<textarea rows="5" class="form-control"
															name="cmGoal" id="cmGoal" readonly></textarea>
													</div>
													<div class="form-group">
														<label class="control-label">인원</label> 
														<input type="text" class="form-control"
															name="cmMaxMem" id="cmMaxMem"  value="" readonly>
													</div>
												</form>
											</div>
											<div class="modal-footer modal-footer-uniform">
												<button id="closureBtn" name="closureBtn" type="button" class="btn btn-danger"
													data-bs-dismiss="modal">폐쇄</button>
												<button type="button" class="btn btn-success" id="commuUpdate">수정</button>
											
												<button type="button" class="btn btn-light float-end" id="exitlButton" >취소</button>
											</div>
										</div>
									</div>
								</div>
								<!-- 모임 상세보기 모달 창 끝 -->
							</div>
							<!-- /.box-body -->
						</div>
						<!-- /.box -->
					</div>
					<!-- /.col -->
				</div>

			</div>
		</div>
	</section>
</div>
<script>
$(function () {
	// 등록
	var registerBtn = $("#registerBtn");
  	// 수정 
  	var commuUpdate = $("#commuUpdate");
  	// 운영 상태 변경 
  	var closureBtn = $("#closureBtn");
  	
  	//가입 신청 버튼
  	var applyForCoummnity = $(".applyForCoummnity");
	
  	
  	applyForCoummnity.on("click", function () {
  		var idx = $(this).attr("idx");
  		var idn = $(this).attr("idn");
  		
  		var cmap = {
  				cmNo : idx
  		}
  		
  		//가입 신청
  		if(confirm("" + idn +"\n가입 신청을 하시겠습니까?")){
  			$.ajax({
  				url: "/DYUniv/student/applyForCoummnityForm.do",
  	            type: "post",
  	            data: JSON.stringify(cmap),
  	            contentType: "application/json; charset=utf-8",
  	            success: function (res) {
  	            	console.log("res ",res);
  	            	if(res == 'OK'){
  	            		Swal.fire({
  	            		  text: "가입 성공",
  	            		  icon: "success"
  	            		});
  	            		$(this).remove();
  	            	} else if(res == "EXIST"){
  	            		Swal.fire({
    	            		  text: "중복 가입 불가",
    	            		  icon: "warning"
    	            	});
  	            		$(this).remove();
  	            	} else {
  	            		Swal.fire({
    	            		  text: "가입 실패...",
    	            		  icon: "error"
    	            	});
  	            	}
  	            }
  			})
  		}
	})
  	
  	registerBtn.on("click", function (){
  		
  		console.log("test");
  		
  		var cmType =$("#cmType").val();
  		var cmName =$("#cmName").val();
  		var cmGoal =$("#cmGoal").val();
  		var cmMaxMem =$("#cmMaxMem").val();
  	
	if(cmName == null || cmName == ""){
		alert("모임명을 입력해주세요");
		return false;
	}    		
	if(cmGoal == null || cmGoal == ""){
		alert("모임 목표를 입력해주세요");
		return false;
	}    		
	if(cmMaxMem == null || cmMaxMem == ""){
		alert("0명이상 선택해주세요");
		return false;
	}    		
		commuGroup.submit();
  	});
    	
  
  	
  	 // 상세보기 버튼 클릭 이벤트
	var cmNo;   //  전역변수
    $(document).on("click", ".viewCommu", function() {
    	cmNo = $(this).data("detail");

    	console.log("cmNo",cmNo);
    	
        var detailCommuObject = {
            cmNo: cmNo,
/*             cmType : cmType,
            cmGoal : cmGoal,
            cmMaxMem : cmMaxMem */ 
        };

        $.ajax({
            url: "/DYUniv/detailCommu",
            type: "post",
            data: JSON.stringify(detailCommuObject),
            contentType: "application/json; charset=utf-8",
            success: function (data) {
            	console.log("detailCommu",data);
            	$("#detailCommu").find("#cmType").val(data.cmType).attr("disabled", true);
            	$("#detailCommu").find("#cmName").val(data.cmName).attr("readonly", true);
            	$("#detailCommu").find("#cmGoal").val(data.cmGoal).attr("readonly", true);
            	$("#detailCommu").find("#cmMaxMem").val(data.cmMaxMem).attr("readonly", true);
            	$("#detailCommu").find("#cmNo").val(data.cmNo);
                console.log("data" + data);
               	$("#detailCommu").modal("show");
            },
			error: function (xhr) {
        		console.log("code: " + xhr.status)
        		console.log("message: " + xhr.statusText)
        		console.log("error: " + xhr.responseText);
    		}
        }); 
    });
  	 
	// 수정 
  	commuUpdate.on("click",function(){
		if($(this).html()=="저장"){

			var communityVO = {
				cmNo:cmNo,
				cmType:$("#detailCommu").find("#cmType").val(),
				cmName:$("#detailCommu").find("#cmName").val(),
				cmGoal:$("#detailCommu").find("#cmGoal").val(),
				cmMaxMem:$("#detailCommu").find("#cmMaxMem").val()
			};

			console.log(":체킁:",communityVO); // 누느로 보아용!

			$.ajax({
            	url: "/DYUniv/commuUpdate",
            	type: "post",
            	data: JSON.stringify(communityVO),
            	contentType: "application/json; charset=utf-8",
				dataType:"text",
            	success: function (data) {
            		console.log("처리결과",data);
					if(data == 1 ){
						alert("잘 수정되었어용");
						location.href = location.href; // 새로고침과 같음!
					}
            	},
				error: function (xhr) {
        			console.log("code: " + xhr.status)
        			console.log("message: " + xhr.statusText)
        			console.log("error: " + xhr.responseText);
    			}
        	}); 
		}else {
		   $("#detailCommu").find("#cmType").prop("disabled", false).focus();
 	       $("#detailCommu").find("#cmName").prop("readonly", false);
 	       $("#detailCommu").find("#cmGoal").prop("readonly", false);
 	       $("#detailCommu").find("#cmMaxMem").prop("readonly", false);
		   $(this).html("저장");
		}
		
		
		
	});
  	 // 취소를 눌렀을때 저장 버튼이 수정으로 변경되어야 한다 
    document.getElementById('exitlButton').addEventListener('click', function() {
    	console.log("취소");
    	if(commuUpdate.html()=="저장"){
    		commuUpdate.html("수정");
    	}
    	
    	$('#detailCommu').modal('hide');  // 모달 창 닫기
    }); 	 
   
  	 // 폐쇄 버튼 클릭시 폐쇄
    closureBtn.on("click", function () {
        var cmNo = $("#cmNo").val();
        console.log("글번호 :", cmNo); // 누느로 보아용!
        
        var communityVO = {
        		cmNo: cmNo,
        };
        
        console.log("폐쇄 처리 코드 :" + JSON.stringify(communityVO)); // 누느로 보아용!
        $.ajax({
            url: "/DYUniv/commuStatus",
            type: "post",
            data: JSON.stringify(communityVO),
            contentType: "application/json; charset=utf-8",
            dataType: "text",
            success: function (data) {
                console.log("폐쇄 처리결과", data);
                if (data == 1) {
                    alert("잘 수정되었어용");
                    location.href = location.href; // 새로고침과 같음!
                }
            },
            error: function (xhr) {
                console.log("code: " + xhr.status);
                console.log("message: " + xhr.statusText);
                console.log("error: " + xhr.responseText);
            },
        });
    });
  	 
  	 
  	 
   // 페이징
    	var pagingArea = $("#pagingArea");
   		var pagingArea2 = $("#pagingArea2");
		var searchForm = $("#searchForm");
		var searchForm2 = $("#searchForm2");
		
			
		// 1번째 탭
		pagingArea.on("click", "a", function(event) {
		    event.preventDefault();
		    var pageNo = $(this).data("page");
		    console.log("페이지 111 : : " + pageNo);

			searchForm.find("#page").val(pageNo);
	    	searchForm.submit();

		    
		});
		
		
	// 2 번째 탭
		pagingArea2.on("click", "a", function(event) {
		    event.preventDefault();
		    var pageNo2 = $(this).data("page");
		    console.log("페이지 2222 : : " + pageNo2);
		   
		    searchForm2.find("#page2").val(pageNo2);
		 
		 	searchForm2.submit();  
		  
		});
	
		
	    
});
</script>