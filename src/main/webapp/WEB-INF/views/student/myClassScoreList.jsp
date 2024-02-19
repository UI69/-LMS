<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="d-flex align-items-center">
	<div class="me-auto p-10">
		<h3 class="page-title">내 강의 목록</h3>
	</div>
</div>

<div class="box-body">
	<div class="table-responsive">
		<div id="example_wrapper"
			class="dataTables_wrapper container-fluid dt-bootstrap4 no-footer">
			<table id="example"
				class="table table-lg invoice-archive dataTable no-footer" role="grid" aria-describedby="example_info">

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
								<option value="" >3학기</option>
								<option value="">4학기</option>
		
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
											<th>과목명</th>
											<th>이수구분</th>
											<th>학점</th>
											<th>점수</th>
											<th>등급</th>
											<th>이의 신청</th>
										</tr>
									</thead>
									<tbody>
									<c:forEach items="${listenList}" var="mylist">
										<tr>
											<td>${mylist.semester}</td>
											<td>${mylist.dprtName }</td>
											<td><a href="/DYUniv/student/class/classRoom/${mylist.classNo}">${mylist.className}</a></td>
											<td>
												<c:if test="${mylist.classReqCode eq 'CLR001'}">전공필수</c:if>
												<c:if test="${mylist.classReqCode eq 'CLR002'}">전공선택</c:if>
												<c:if test="${mylist.classReqCode eq 'CLR003'}">교양필수</c:if>
												<c:if test="${mylist.classReqCode eq 'CLR004'}">교양선택</c:if>
											</td>
											<td>${mylist.lecPoint }</td>
											<c:choose>
												<c:when test="${mylist.classStatusCode eq 'CLS006' }">
													<td colspan="2">강의 취소</td>
												</c:when>
												<c:when test="${mylist.classStatusCode eq 'CLS007' and mylist.lsStatusCode eq 'LSS002' }">
													<td>강의 완료</td>
													<td class="p-0">
														<a class="btn btn-primary-light m-0" href="/DYUniv/class/rating/${mylist.classNo }">강의 평가</a>
													</td>
												</c:when>
												<c:when test="${mylist.classStatusCode eq 'CLS007' and mylist.lsStatusCode eq 'LSS004' }">
													<td>
														<c:if test="${mylist.classScore eq 'A' }">4.0</c:if>
														<c:if test="${mylist.classScore eq 'B' }">3.0</c:if>
														<c:if test="${mylist.classScore eq 'C' }">2.0</c:if>
														<c:if test="${mylist.classScore eq 'D' }">1.0</c:if>
														<c:if test="${mylist.classScore eq 'F' }">0.0</c:if>
													</td>
													<td>${mylist.classScore }</td>
												</c:when>
												
												<c:otherwise>
													<td>-</td>
													<td>
														<c:if test="${mylist.lsStatusCode eq 'LSS002' }">강의중</c:if>
														<c:if test="${mylist.lsStatusCode eq 'LSS003' }">취소</c:if>
														<c:if test="${mylist.lsStatusCode eq 'LSS005' }">제적</c:if>
													</td>
												</c:otherwise>
											</c:choose>
											<td class="p-0">
												<c:if test="${mylist.classStatusCode eq 'CLS007' and mylist.lsStatusCode eq 'LSS004' }">
													<a class="btn btn-danger-light" href="#">정정 신청</a>
												</c:if>
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

	</div>
</div>
