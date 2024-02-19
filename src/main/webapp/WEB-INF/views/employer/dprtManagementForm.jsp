<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>

<script
	src="
	https://cdn.jsdelivr.net/npm/sweetalert2@11.10.2/dist/sweetalert2.all.min.js
	"></script>
<link
	href="
	https://cdn.jsdelivr.net/npm/sweetalert2@11.10.2/dist/sweetalert2.min.css
	"
	rel="stylesheet">
<div class="box m-10">
    <div class="box-header with-border">
    <h4 class="box-title">학과 관리</h4>
    </div>
   	<ul class="nav nav-tabs" role="tablist">
		<li class="nav-item">
			<a class="nav-link active" data-bs-toggle="tab" href="#closeDprt" role="tab" aria-selected="true">
				<span class="hidden-sm-up"><i class="fa fa-cc"></i></span> 
				<span class="hidden-xs-down">학과 목록</span>
			</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" data-bs-toggle="tab" href="#addDprt" role="tab" aria-selected="false">
				<span class="hidden-sm-up"><i class="fa fa-paypal"></i></span> 
				<span class="hidden-xs-down">학과 추가</span>
			</a>
		</li>
	</ul>
	
	<div class="tab-content tabcontent-border m-15 bg-white">
		<div class="tab-pane active" id="closeDprt" role="tabpanel">
		<!-- 검색 시작 -->
		<div class="row" style="justify-content: flex-end;">
			<div class="col-md-5"> <!-- col-md-5: 부모 너비 값의 절반 사용 -->
				<form id="searchForm" method="post">
				<input type="hidden" name="page" id="page">
				<div class="form-group">
					<select class="form-control" name="searchType" style="width: 30%; display: inline-block;">
						<option selected="selected" disabled="disabled">======선택======</option> <!-- disabled : 선택안됨(select의 제목?) -->
						<option value="dprtName" <c:if test="${searchType eq 'dprtName' }">selected</c:if>>학과명</option>
						<option value="dprtCategory" <c:if test="${searchType eq 'dprtCategory' }">selected</c:if>>대학</option>
					</select> 
					<input type="text" placeholder="입력하세요" name="searchWord" value="${searchWord }" class="form-control" style="width: 55%; display: inline-block;">
					<button type="submit" class="btn btn-primary btn-sm">검색</button>
				</div>
				</form>
			</div>
		</div>
		<!-- 검색 끝 -->
		
		<div class="table-responsive"style="margin: 30px;">
			<table class="table">
				<thead class="bg-primary">
					<tr>
						<th>대학</th>
						<th>학과명</th>
						<th>졸업 기준 학점</th>
						<th>학기당 신청 가능 학점</th>
						<th>필요 봉사시간</th>
						<th>기준 등록금</th>
						<th>운영</th>
					</tr>
				</thead>
				<tbody>
				<c:set value="${pagingVO.dataList }" var="departmentList"/>
				<c:choose>
					<c:when test="${empty departmentList }">
						<tr>
							<td colspan="4">조회하실 게시물이 존재하지 않습니다.</td>
						</tr>
					</c:when>
						<c:otherwise>
							<c:set var="index" value="${pagingVO.startRow + 1}" />
							<c:set var="index" value="${index - 1}" />
						<c:forEach items="${departmentList }" var="dpList">
							<tr>
								<td>
									<c:if test="${dpList.dprtCategory eq 'DPC001'}">인문</c:if>
									<c:if test="${dpList.dprtCategory eq 'DPC002'}">사회</c:if>
									<c:if test="${dpList.dprtCategory eq 'DPC003'}">교육</c:if>
									<c:if test="${dpList.dprtCategory eq 'DPC004'}">공학</c:if>
									<c:if test="${dpList.dprtCategory eq 'DPC005'}">자연</c:if>
									<c:if test="${dpList.dprtCategory eq 'DPC006'}">의약</c:if>
									<c:if test="${dpList.dprtCategory eq 'DPC007'}">예체능</c:if>
								</td>
							 	<td width="25%">${dpList.dprtName }</td>
								<td>${dpList.dprtLecPoint }</td>
								<td>${dpList.semMaxLecPoint }</td>
								<td>${dpList.dprtSrvTime }</td> 
								<td>${dpList.dprtTuition }</td>
								<td style="text-align: center;">
									<%-- <c:if test="${dpList.fileNo ne 0 }">
										<button type="button" class="btn btn-circle btn-xs btn-primary">
											<i class="fa fa-folder-open" style="color: white"></i>폐쇄
										</button>
									</c:if> --%>
								</td>
							</tr> 	
							<c:set var="index" value="${index + 1}" />
						</c:forEach>
					</c:otherwise>
				</c:choose>
				</tbody>
			</table>
			<div class="col-sm-12 col-md-7" style="float: right; margin-right: 100px">
				<div class="dataTables_paginate paging_simple_numbers"
					id="example1_paginate">
					${pagingVO.pagingHTML }
				</div>
			</div>
		</div>
		
		</div>
		<div class="tab-pane" id="addDprt" role="tabpanel">
		 <!-- /.box-header -->
		    <form class="form" action="/DYUniv/addDprtForm" id="addDprtForm" method="post">
		        <div class="box-body col-8">
		            <h4 class="box-title text-info mb-0">학과 추가하기</h4>
		            <hr class="my-15">
		            <div class="row">
		              <div class="col-md-6">
		                <div class="form-group">
		                    <label class="form-label">학과 분류</label>
		                    <select class="form-select" id="dprtCategory" name="dprtCategory">
		                      <option value="">=== 선택 ===</option>
			                   <option value='DPC001'>인문</option>
			                   <option value='DPC002'>사회</option>
			                   <option value='DPC003'>교육</option>
			                   <option value='DPC004'>공학</option>
			                   <option value='DPC005'>자연</option>
			                   <option value='DPC006'>의약</option>
			                   <option value='DPC007'>예체능</option>
		                    </select>
		                  </div>
		              </div>
		              <div class="col-md-6">
		                <div class="form-group">
		                  <label class="form-label">학과명</label>
		                  <input type="text" class="form-control" id="dprtName" name="dprtName">
		                </div>
		              </div>
		              <div class="col-md-6">
		                <div class="form-group">
		                  <label class="form-label">기준 등록금</label>
		                  <input type="number" class="form-control" value="1280000" id="dprtTuition" name="dprtTuition">
		                </div>
		              </div>
		            <div class="col-md-6">
		                <div class="form-group">
		                  <label class="form-label">졸업 봉사활동 시간</label>
		                  <input type="number" class="form-control" value="0" min="0" max="120" id="dprtSrvTime" name="dprtSrvTime">
		                </div>
		            </div>
		        	<div class="row">
		              <div class="col-md-6">
		                <div class="form-group">
		                  <label class="form-label">졸업 기준 총 학점</label>
		                  <input type="number" class="form-control" value="148" min="72" max="" id="dprtLecPoint" name="dprtLecPoint">
		                </div>
		              </div>
		        	</div>
		              <div class="col-md-6">
		                <div class="form-group">
		                  <label class="form-label">학기당 신청 가능 학점</label>
		                  <input type="number" class="form-control" value="32" min="20" max="" id="semMaxLecPoint" name="semMaxLecPoint"> 
		                </div>
		              </div>
		            <div class="box-footer">
		                <button type="button" class="btn btn-primary" id="addDpartBtn">
		                  <i class="si-pencil si"></i> 등록
		                </button>
		                <button type="reset" class="btn btn-warning me-1" id="resetBtn">
		                  <i class="si-list si"></i> 초기화
		                </button>
		            </div>  
		        </div>
		            <hr class="my-15">
		        </div>
		        <!-- /.box-body -->
		    </form>
		</div>
	</div>
</div>

<script>

$(function () {

	/* 페이징 */
	var pagingArea = $("#example1_paginate");
	var searchForm = $("#searchForm");
	
	pagingArea.on("click", "a", function(event){
		event.preventDefault();	// a 태그의 기본 이벤트 동작 방지
		var pageNo = $(this).data("page");
		searchForm.find("#page").val(pageNo);
		
		searchForm.submit();
	});
	
	var addDpartBtn = $("#addDpartBtn");
	var addDprtForm = $("#addDprtForm");
	
	addDpartBtn.on("click", function () {
		var dprtCategory = $("#dprtCategory").val();
		var dprtName = $("#dprtName").val();
		console.log(dprtName);
		
		if(dprtCategory == null || dprtCategory == ""){
			Swal.fire({
				  title: 'Error!',
				  text: '학과를 선택해주세요',
				  icon: 'error',
				  confirmButtonText: 'Cool'
				})	
	
			return;
		}
		if(dprtName == null || dprtName == ""){
			Swal.fire({
				  title: 'Error!',
				  text: '학과명을 선택해주세요',
				  icon: 'error',
				  confirmButtonText: 'Cool'
				})
			return;
		}
		
		addDprtForm.submit();
	})
})

</script>
