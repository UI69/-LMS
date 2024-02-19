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
						<li class="breadcrumb-item active" aria-current="page">과제 점수</li>
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
<ul class="nav nav-tabs" role="tablist">
	<li class="nav-item">
		<a class="nav-link bg-danger-light" data-bs-toggle="tab" href="" role="tab" aria-selected="false" id="classRoomBtn">
			<span class="hidden-xs-down"> &lt;&lt; 클래스룸으로 </span>
		</a>
	</li>
	<li class="nav-item">
		<a class="nav-link active" data-bs-toggle="tab" href="#paypal1" role="tab" aria-selected="false">
			<span class="hidden-sm-up"><i class="fa fa-paypal"></i></span>
			<span class="hidden-xs-down">제출 목록</span>
		</a>
	</li>
</ul>

<div class="tab-content tabcontent-border m-15 bg-white">
	<div class="tab-pane active" id="debit-card" role="tabpanel">
		<div class="box-body">
			<div class="col-12">
				<h3 class="mt-30 ms-30"><strong>과제 제출 목록</strong></h3>
			</div>
			<div class="row col-12 justify-content-end">
				<div class="row col-2 text-end">
					<!-- homeworkList -->
					<select class="form-control" id="hwSelect">
						<option value="">===선택===</option>
						
						<c:if test="${!empty homeworkList }">
							<c:forEach items="${homeworkList }" var="hw">
								<option value="${hw.hwNo }">${hw.hwTitle }</option>
							</c:forEach>
						</c:if>
					</select>
				</div>
				<div class="col-3 text-end">
					<button class="waves-effect waves-light btn bg-info me-30" 
						id="hwScoreSubmitBtn">과제 점수 등록</button>
					<button class="waves-effect waves-light btn bg-danger-light me-30" 
						id="hwScoreSubmitTest">test</button>
				</div>
			</div>
			<div class="table-responsive m-30">
				<table class="table">
					<thead class="bg-primary">
						<tr>
							<th>학번</th>
							<th>이름</th>
							<th width="35%">제목</th>
							<th>작성일</th>
							<th class="text-center">파일</th>
							<th class="text-center">점수</th>
						</tr>
					</thead>
					<tbody id="hwSubList">
						<tr>
							<td colspan="6">조회하실 게시물이 존재하지 않습니다.</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<script>
	$(function () {

		var hwSelect = $("#hwSelect");
		var hwSubList = $("#hwSubList");

		var hwScoreSubmitBtn = $("#hwScoreSubmitBtn");
		var classNo = parseInt("${myClassVO.classNo }");
		
		$("#classRoomBtn").on("click", function () {
			location.href = "/DYUniv/managementClassRoom/" + classNo;
		})
		
		hwScoreSubmitBtn.on("click", function () {
			var hwScoreList = $(".hwMemList");
			
			var hwData = [];
			
			if(hwScoreList != null && hwScoreList){
				
				$.each(hwScoreList, function(i,v){
					/* console.log("hw " + i,$(v).find(".memName").attr("idx"));
					console.log($(v).find(".hwScore").attr("idx"));
					console.log($(v).find(".hwScore input").val()); */
					
					var hwSubData = {
							"hwSbNo" : $(v).find(".hwScore").attr("idx"),
							"hwScore" : $(v).find(".hwScore input").val()
					}
					hwData.push(hwSubData);
				})
				
				console.log(hwData);
				
				if(confirm("점수를 저장 하시겠습니까?")){
					hwScoreSubmitBtn.attr("disabled", true);
					
					$.ajax({
						type: 'post',
						url: '/DYUniv/class/hwSubmitScoreForm',
						contentType: 'application/json; charset=utf-8',
						data : JSON.stringify(hwData),
						success: function (res){
							console.log("res : " + res);
							if(res == "OK"){
								alert("저장되었습니다.")
								location.href = "/DYUniv/class/homeworkScoreForm/" + ${myClassVO.classNo} ;
							} else {
								alert("저장에 실패하였습니다.");
								hwScoreSubmitBtn.removeAttr("disabled");
							}
						}
					})
				}
			}
		})
		
		//과제 선택
		hwSelect.on("change", function () {
			var hwNo = $(this).val();
			
			if(hwNo == null || hwNo == ""){
				return false;
			}
			
			var data = {
					"hwNo" : hwNo
			}

			hwSubList.html(
				'<tr>'
					+ '<td colspan="6">조회하실 게시물이 존재하지 않습니다.</td>'
				+ '</tr>'
			);

			$.ajax({
				type: 'post',
				url: '/DYUniv/class/hwSubmitList',
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
							
							code += '<tr class="hwMemList">';
							code += '	<td class="">' + v.memId + '</td>';
							code += '	<td class="memName" idx="'+ v.memNo +'">' + v.memName + '</td>';
							code += '	<td>' + v.hwContent + '</td>';
							code += '	<td>' + v.hwSbDate.substr(0,10) + '</td>';
							code += '	<td class="hwFile">';
							
							if(fileNo != 0){
								code += '	<a href="javascript:void(0);" onclick="hwFileDownload(this)" idx="'+ fileNo +'" idn="'+ fileName +'">' + fileName + '</a></td>';
							} else {
								code += fileName + '</td>';
							}
							
							code += '	<td class="hwScore text-end" idx="'+ v.hwSbNo +'" min="0" max="100"><input type="number" value="'+ v.hwScore +'"> </td>';
							code += '</tr>';
						});
					} 
					//console.log(code);
					hwSubList.html(code);
				}
			})
		})
		
	})
	

	/* 파일 다운로드*/
	function hwFileDownload(el) {
		//console.log($(el).attr("idx"));
		//console.log($(el).attr("idn"));

		var fileNo = $(el).attr("idx");
		var fileName = $(el).attr("idn");

		fileDownload(fileNo, fileName);
	}
	
	$("#hwScoreSubmitTest").on("click", function () {
		$(".hwScore input").val("90");
		
	})
</script>