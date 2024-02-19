<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!-- 
년도 학기  선택 검색 기능  
납부금액 이 완납시 으로 나옴 
 -->
<div class="container-full">
	<!-- Content Header (Page header) -->
	<div class="content-header">
		<div class="d-flex align-items-center">
			<div class="me-auto">
				<h3 class="page-title">등록금 및 장학금 </h3>
				<div class="d-inline-block align-items-center">
					<nav>
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="#"><i
									class="mdi mdi-home-outline"></i></a></li>
							<li class="breadcrumb-item" aria-current="page">등록금 및 장학금</li>
							<li class="breadcrumb-item active" aria-current="page">등록금 및 장학금 조회 </li>
						</ol>
					</nav>
				</div>
			</div>
		</div>
	</div>
	<!-- Main content -->
	<div class="my-20 bg-white" align="center">
		<form id="searchForm" method="post">
			<select id="sclDateType" class="form-control" name="sclDate" style="width: 30%; display: inline-block;">
				<option value="">학기년도선택</option>
				<option value="2020">2020</option>
				<option value="2021">2021</option>
				<option value="2022">2022</option>
				<option value="2023">2023</option>
				<option value="2024">2024</option>
			</select>
			<select class="form-control" name="schType" style="width: 30%; display: inline-block;">
				<option selected="selected">--학기--</option>
				<option value="semester">1</option>
				<option value="semester">2</option>
			</select>
			<button type="submit" class="btn btn-primary" style="padding: 5px 12px;">검색</button>
		</form>
	</div>
	<section class="content">
		<div class="row">
			<div class="col-12">
				<div class="box">
				<div class="b-1 border-light rounded p-15">등록금 </div>
					<div class="box-body">
							<div class="row-8">
								<div class="col-md-4 col-12 flex-end" style="margin-top: 5px;">
								<div class="form-group">
									</div>
								</div>
							</div>
							<div class="table-responsive">
								<table class="table mb-0" style="text-align: center">
									<thead class="bg-primary">
										<tr>
											<th scope="col">번호</th>
											<th scope="col">학기</th>
											<th scope="col">금액</th>
											<th scope="col">납부한 금액</th>
											<th scope="col">남은 금액</th>
											<th scope="col">납부 상태 </th>
											<th scope="col">납부 일</th>
										</tr>
									</thead>
									<tbody>
										<c:choose>
											<c:when test="${empty myTuitList }">
												<tr>
													<td colspan="5">조회하신 게시글이 존재하지 않습니다.</td>
												</tr> 
											</c:when>
											<c:otherwise>
												<c:forEach items="${myTuitList }" var="tuition">
													<tr>
														<td><strong>${tuition.tuitionNo }</strong></td>
														<td>${tuition.semester }</td>
														<td>${tuition.dprtTuition }</td>
														<td>${tuition.amount }</td>
														<td>
														    <c:set var="amount" value="${tuition.dprtTuition - tuition.amount}" />
														    <c:out value="${amount}"></c:out>
														</td>
														<td>
														    <c:set var="tuit" />
														    <c:choose>
														        <c:when test="${amount eq 0}">
														            <c:set var="tuit" value="완납" />
														        </c:when>
														        <c:when test="${amount gt 0 and amount lt tuition.dprtTuition}">
														            <c:set var="tuit" value="부분납부" />
														        </c:when>
														        <c:when test="${amount eq tuition.dprtTuition}">
														            <c:set var="tuit" value="미납" />
														        </c:when>
														        <c:otherwise>
														            <c:set var="tuit" />
														        </c:otherwise>
														    </c:choose>
														    ${tuit} <%-- ${amount }, ${tuition.dprtTuition } --%>
														</td>
														<td>${fn:substring(tuition.depositDate,0,10) }</td>
														
													</tr>
												</c:forEach>
											</c:otherwise>
										</c:choose>

										<!-- 보여지는 목록 갯수는 무조건 5개 !! - ㅊㅇㅇ -->
									</tbody>
								</table>
							</div>
						</div>
	
					</div>
				</div>
				
			</div>
	</section>
<section class="content">
	<div class="row">
		<div class="col-12">
			<div class="box">
				<div class="b-1 border-light rounded p-15">장학금 </div>
					<div class="box-body">
						<div class="p-15">
							<div class="row-8">
								<div class="form-group">
								<table class="table mb-0" style="text-align: center">
									<thead class="bg-primary">
										<tr>
											<th scope="col">순번</th>
										<!-- 	<th scope="col">년도</th> -->
											<th scope="col">지급일</th>
											<th scope="col">분류명</th>
											<th scope="col">장학명</th>
											<th scope="col">장학금 금액</th>
										</tr>
									</thead>
									<tbody>
									<c:choose>
										<c:when test="${empty mySchHistoryList}">
											<tr>
												<td colspan="5">조회하신 게시글이 존재하지 않습니다.</td>
											</tr> 
										</c:when>
										<c:otherwise>
											<c:forEach items="${mySchHistoryList }" var="myShList">
												<tr>
													<td><strong>${myShList.sclNo }</strong></td>
											<%-- 		<td>${myShList.sclNo }</td> --%>
													<td>${fn:substring(myShList.sclDate,0,10) }</td>
													
													<td>
													<c:set var="sch"/>
											           <c:if test="${myShList.schType eq 'SCT001' }">
												          	<c:set var="sch" value="국가"/>
											          </c:if>
											           <c:if test="${myShList.schType eq 'SCT002' }">
											          	<c:set var="sch" value="소득"/>
											          </c:if>
											           <c:if test="${myShList.schType eq 'SCT003' }">
											          	<c:set var="sch" value="취업연계"/>
											          </c:if>
											          <c:if test="${myShList.schType eq 'SCT004' }">
											          	<c:set var="sch" value="성적우수"/>
											          </c:if>
											           <c:if test="${myShList.schType eq 'SCT005' }">
											          	<c:set var="sch" value="다문화"/>
											          </c:if>
											           <c:if test="${myShList.schType eq 'SCT006' }">
											          	<c:set var="sch" value="근로"/>
											          </c:if>
											           <c:if test="${myShList.schType eq 'SCT007' }">
											          	<c:set var="sch" value="체육비전"/>
											          </c:if>
											          ${sch }
													 </td>
													<td>${myShList.schName }</td>
													<td>${myShList.schMoney }</td>
												</tr>
											</c:forEach>
										</c:otherwise>				
									</c:choose>
										<!-- 보여지는 목록 갯수는 무조건 5개 !! - ㅊㅇㅇ -->
										</tbody>
									</table>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>

<script type="text/javascript">
	$(function() {
		
		var sclDateType =("#sclDateType");
		
		var searchForm = $("#searchForm");

		pagingArea.on("click", "a", function(event) {
			event.preventDefault(); // a태그의 이벤트를  block
			var pageNo = $(this).data("page");
			
			searchForm.find("#page").val(pageNo);
			searchForm.submit();
		});

		
		
		
		
		
		
	});
</script>