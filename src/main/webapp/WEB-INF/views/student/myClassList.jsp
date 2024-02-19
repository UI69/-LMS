<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="d-flex align-items-center">
		<div class="me-auto p-10">
			<h3 class="page-title">내 강의 목록</h3>
		</div>
</div>

<div class="box-body">
	<div class="table-responsive">
		<div id="example_wrapper" class="dataTables_wrapper container-fluid dt-bootstrap4 no-footer">
			<table id="example" class="table table-lg invoice-archive dataTable no-footer" role="grid" aria-describedby="example_info">

					<tr class="odd">
						<td class="sorting_1"><strong>년도</strong></td>
							<td>
						<select name="status" class="form-select " data-placeholder="Select status">
								<option value="2024" selected="">2024</option>
								<option value="">2023</option>
								<option value="" >2022</option>
								<option value="">2021</option>
		
						</select>
						</td>
					<td class="sorting_2"><strong>학기</strong></td>
					<td>
						<select name="status" class="form-select" data-placeholder="Select status">
								<option value="1학기" selected="">1학기</option>
								<option value="">2학기</option>
						</select>
						</td>
					<td class="text-center">
				<button type="button" class="waves-effect waves-light btn btn-dark mb-5">조회</button>
						</td>			
					</tr>
			</table>
		
			<div class="col-xl-12">
				<div class="box box-solid box-inverse box-info">
			<div class="row">
				<div class="box-body">
							<div class="table-responsive">
								<table class="table">
									<thead class="bg-primary">
										<tr>
											<th>년도/학기</th>
											<th>전공</th>
											<th width="40%">과목명</th>
											<th class="text-center">강의 횟수</th>
											<th class="text-center">총강의시간</th>
											<th>이수구분</th>
										</tr>
									</thead>
									<tbody>
									<c:forEach items="${mylectureList}" var="mylist">
										<tr>
											<td>${mylist.semester}</td>
											<td>${mylist.dprtName }</td>
											<td><a href="/DYUniv/student/class/classRoom/${mylist.classNo}">${mylist.className}</a></td>
											<td class="text-center">${mylist.classWeekCnt}</td>
											<td class="text-center">${mylist.classTotalTime}</td>
											<td >
												<c:if test="${mylist.classReqCode eq 'CLR001'}">전공필수</c:if>
												<c:if test="${mylist.classReqCode eq 'CLR002'}">전공선택</c:if>
												<c:if test="${mylist.classReqCode eq 'CLR003'}">교양필수</c:if>
												<c:if test="${mylist.classReqCode eq 'CLR004'}">교양선택</c:if>
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
			</div>
			<!-- <div class="col-sm-12 col-md-7" style="float: right; margin-right: 100px">
				<div class="dataTables_paginate paging_simple_numbers"
					id="example1_paginate">
					<ul class="pagination">
						<li class="paginate_button page-item previous disabled"
							id="example1_previous"><a href="#" aria-controls="example1"
							data-dt-idx="0" tabindex="0" class="page-link">Previous</a></li>
						<li class="paginate_button page-item active"><a href="#"
							aria-controls="example1" data-dt-idx="1" tabindex="0"
							class="page-link">1</a></li>
						<li class="paginate_button page-item"><a href="#"
							aria-controls="example1" data-dt-idx="2" tabindex="0"
							class="page-link">2</a></li>
						<li class="paginate_button page-item"><a href="#"
							aria-controls="example1" data-dt-idx="3" tabindex="0"
							class="page-link">3</a></li>
						<li class="paginate_button page-item"><a href="#"
							aria-controls="example1" data-dt-idx="4" tabindex="0"
							class="page-link">4</a></li>
						<li class="paginate_button page-item"><a href="#"
							aria-controls="example1" data-dt-idx="5" tabindex="0"
							class="page-link">5</a></li>
						<li class="paginate_button page-item next" id="example1_next"><a
							href="#" aria-controls="example1" data-dt-idx="6" tabindex="0"
							class="page-link">Next</a></li>
					</ul>
				</div>
			</div> -->

	</div>
</div>
