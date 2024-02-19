<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<section class="content">
	<div class="content-header">
		<div class="d-flex align-items-center">
			<div class="me-auto">
				<h3 class="page-title">출석 성적 조회</h3>
				<div class="d-inline-block align-items-center">
					<nav>
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="#"><i
									class="mdi mdi-home-outline"></i></a></li>
							<li class="breadcrumb-item" aria-current="page">출석확인</li>
						</ol>
					</nav>
				</div>
			</div>

		</div>
	</div>
	<div class="row">
		<div class="col-lg-12">
			<div class="box">
				<div class="box-body">
					<h4 class="box-title">출결 확인</h4>
					<div class="table-responsive">
						<table class="table">
							<tbody class="bg-inverse">
								<tr>
									<th>년도</th>
									<th><select class="form-select">
											<option>----------------</option>
											<option>2020</option>
											<option>2021</option>
											<option>2022</option>
											<option>2023</option>
											<option>1996</option>
									</select></th>
									<th>학기</th>
									<th><select class="form-select">
											<option>----------------</option>
											<option>1학기</option>
											<option>2학기</option>
									</select></th>
									<th>강의</th>
									<th><select class="form-select">
											<option>----------------</option>
											<option>경찰행정</option>
											<option>실용음악</option>
											<option>연극연기</option>
											<option>호텔관광</option>
											<option>컴퓨터공학</option>
									</select></th>
								</tr>
							</tbody>
						</table>
						<table class="table div6">
							<thead class="bg-primary">
								<tr>
									<th>강의</th>
									<th>출석</th>
									<th>결석</th>
									<th>지각</th>
									<th>조퇴</th>
									<th>총 강의 일수</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>경찰행정</td>
									<td>12</td>
									<td>1</td>
									<td>0</td>
									<td>1</td>
									<td>14</td>

								</tr>

							</tbody>
							<tbody>
										<tr>
									<td>실용음악</td>
									<td>12</td>
									<td>1</td>
									<td>0</td>
									<td>1</td>
									<td>14</td>

								</tr>

							</tbody>
							<tbody>
										<tr>
									<td>연극연기</td>
									<td>12</td>
									<td>1</td>
									<td>0</td>
									<td>1</td>
									<td>14</td>

								</tr>

							</tbody>
							<tbody>
								<tr>
									<td>컴퓨터공학</td>
									<td>12</td>
									<td>0</td>
									<td>1</td>
									<td>0</td>
									<td>13</td>

								</tr>

							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>