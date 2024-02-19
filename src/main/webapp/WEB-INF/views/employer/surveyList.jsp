<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="container-full">
	<!-- Content Header (Page header) -->
	<div class="content-header">
		<div class="d-flex align-items-center">
			<div class="me-auto">
				<h3 class="page-title">설문조사 </h3>
				<div class="d-inline-block align-items-center">
					<nav>
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="#"><i class="mdi mdi-home-outline"></i></a></li>
							<li class="breadcrumb-item" aria-current="page">설문조사 조회 </li>
							<li class="breadcrumb-item active" aria-current="page">설문조사 목록</li>
						</ol>
					</nav>
				</div>
			</div>		
		</div>
	</div>	  

<section class="content">  
<div class="col-12">
    <div class="box">
      </div>
 </div>

<div class="box">
<div class="box-body">
	<button type="button" class="btn btn-success pull-right" id="addSrvBtn">설문 조사 추가</button>
	<div class="my-20 bg-white" align="center">
		<form id="searchForm" method="post">
			<input type="hidden" name="page" id="page">		
			<select id="sclDateType" class="form-control" name="searchType" style="width: 20%; display: inline-block;">
				<option value="">-카테고리 -</option>
				<option value="name" <c:if test="${searchType eq 'name' }">selected</c:if>>설문명</option>
				<option value="type" <c:if test="${searchType eq 'type' }">selected</c:if>>설문타입</option>
			</select>
			<input type="text" name="searchWord" value="${searchWord }" placeholder="입력하세요"
				 class="form-control" style="width: 30%; display: inline-block;">
			<button type="submit" class="btn btn-primary" style="padding: 5px 12px;">검색</button>			
		</form>
	</div>
			
			<div class="table-responsive">
			<table class="table">
				<thead class="bg-primary">
					<tr>
						<th>번호</th>
						<th width="40%">설문조사 이름</th>
						<th>카테고리</th>
						<th>설문 마감일 </th>
						<th>응답 인원  </th>
						<th>결과 확인  </th>
					</tr>
				</thead>
				<tbody>
					<c:set value="${pagingVO.dataList }" var="surveyList"/>
					<c:choose>
						<c:when test="${empty surveyList }">
							<tr><td colspan="5">조회하신 게시글이 존재하지 않습니다.</td></tr>
						</c:when>
						<c:otherwise>
							<c:set var="rvsno" value="${pagingVO.totalRecord - (currentPage -1) * screenSize }"/>
							<c:forEach items="${surveyList }" var="survey">
								<tr>
									<td>${rvsno }</td>
									<c:set var="rvsno" value="${rvsno -1 }"/>
									<td><a href="/DYUniv/surveyView.do?srvNo=${survey.srvNo}">${survey.srvName}</a></td>
									<td> ${survey.srvCategoryStr } </td>
									<td>${fn:substring(survey.srvEndDate, 0, 10) }</td>
									<td>
										${survey.srvRegCount }명 참여
									</td>
									<td>
										<button id="readBtn" name="readBtn" idx="${survey.srvNo }" 
											class="btn btn-primary btn-outline resBtn">결과</button>
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
<%-- 	<div class="col-sm-12 col-md-6"
		style="float: right; margin-right: 80px">
		<div class="dataTables_paginate paging_simple_numbers" id="example1_paginate">
		${pagingVO2.pagingHTML }
		</div>
	</div> --%>
	<!--  -->
</div>
		<div class="col-sm-12 col-md-6"
			style="float: right; margin-right: 80px">
		<div class="dataTables_paginate paging_simple_numbers" id="example1_paginate">
			${pagingVO.pagingHTML }
		</div>
</div>
</section>
</div>
<script type="text/javascript">
$(function(){
	
	var pagingArea = $("#example1_paginate");
	var searchForm = $("#searchForm");
	
	var sclDateType = $("#sclDateType");
	var sclDateType2 = $("#sclDateType2");
	
	$("#addSrvBtn").on("click", function () {
		location.href= "/DYUniv/surveyManagementForm.do";
	})
	
	sclDateType.on("change", function(){
		var selectedValue = $(this).val();
		if(selectedValue == "name"){	// 설문명으로 검색
			sclDateType2.css("display", "none");
		}else if(selectedValue == "type"){	// 설문타입으로 검색
			sclDateType2.css("display", "inline-block");
		}else{
			sclDateType2.css("display", "none");
		}
	});
	
	pagingArea.on("click", "a", function(event) {
		event.preventDefault(); // a태그의 이벤트를  block
		var pageNo = $(this).data("page");
		
		console.log("pageNo",pageNo);
		
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
	
	$(".resBtn").on("click", function() {
		var srvNo = $(this).attr("idx");
		
		//console.log("srvNo ",srvNo)
		location.href = "/DYUniv/surveyResultDetail.do/" + srvNo;
	})
});
</script>