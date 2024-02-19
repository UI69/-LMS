<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
	  <div class="container-full">
		<!-- Content Header (Page header) -->
		<div class="content-header">
			<div class="d-flex align-items-center">
				<div class="me-auto">
					<h3 class="page-title">학생 계정 생성</h3>
					<div class="d-inline-block align-items-center">
						<nav>
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="#"><i class="mdi mdi-home-outline"></i></a></li>
								<li class="breadcrumb-item" aria-current="page">학생 관리</li>
								<li class="breadcrumb-item active" aria-current="page">한생 계정 생성</li>
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
			<div class="box-header with-border">
			  <h4 class="box-title">Client Registration</h4>
			  <h6 class="box-subtitle">You can find the <a href="http://www.jquery-steps.com" target="_blank">offical website </a></h6>		
			</div>
			<!-- /.box-header -->
			<div class="box-body wizard-content">
				<form action="#" class="tab-wizard wizard-circle">
				
				
				<!-- Step 1 -->
				<h6>User Information</h6>
					<section>
					<div class="row">
						<div class="col-md-4">
							<div class="box box-widget widget-user">
									<!-- Add the bg color to the header using any of the bg-* classes -->
									<div class="widget-user-header bg-img bbsr-0 bber-0" style="background: url('../images/gallery/full/10.jpg') center center;" data-overlay="5">
									  <h3 class="widget-user-username text-white">USER NAME</h3>
									  <h6 class="widget-user-desc text-white">Student</h6>
									</div>
									<div class="widget-user-image">
									  <img class="rounded-circle" src="../images/user3-128x128.jpg" alt="User Avatar">
									</div>
									<div class="box-footer">
									  <div class="row">
										<div class="col-sm-6">
										  <div class="description-block">
											<h5 class="description-header">아이콘</h5>
											<span class="description-text">사진 등록</span>
										  </div>
										  <!-- /.description-block -->
										</div>
										<!-- /.col -->
										<div class="col-sm-6">
										  <div class="description-block">
											<h5 class="description-header">아이콘</h5>
											<span class="description-text">사진 삭제</span>
										  </div>
										  <!-- /.description-block -->
										</div>
										<!-- /.col -->
									  </div>
									  <!-- /.row -->
									</div>
							  </div>
							</div>		
							<div class="col-md-8">
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label for="firstName5" class="form-label">ID 생성</label>
											<input type="text" class="form-control" id="firstName5">
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group">
											<div class="form-group">
												<label for="location3" class="form-label">단과대학 :</label>
												<select class="form-select" id="location3" name="location">
													<option value="">Select College</option>
													<option value="Amsterdam">사회과학대학</option>
													<option value="Berlin">문과대학</option>
													<option value="Frankfurt">법학대학</option>
												</select>
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label for="emailAddress1" class="form-label">성명</label>
											<input type="email" class="form-control" id="emailAddress1"> 
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group">
											<div class="form-group">
												<label for="location3" class="form-label">전공 :</label>
												<select class="form-select" id="location3" name="location">
													<option value="">Select College</option>
													<option value="Amsterdam">사회과학대학</option>
													<option value="Berlin">문과대학</option>
													<option value="Frankfurt">법학대학</option>
												</select>
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label for="date1" class="form-label">생년월일 :</label> <input
												type="date" class="form-control" id="date1">
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group">
											<label class="form-label">성별 :</label>
											<div class="c-inputs-stacked">
												<input type="checkbox" id="checkbox_123"> 
												<label for="checkbox_123" class="d-block">F</label>
												<input type="checkbox" id="checkbox_234"> 
												<label for="checkbox_234" class="d-block">M</label>
											</div>
										</div>
									</div>
								</div>
							</div>
					</div>
					</section>

					
					
					
					
					<!-- Step 2 -->
					<h6>User Detail</h6>
					<section>
						<div class="row">
							
							<div class="col-6">
								<div class="form-group">
									<label for="username123" class="form-label">주민등록번호 :</label>
									<input type="text" class="form-control" id="username123">
								</div>
							</div>
							<div class="col-6">
								<div class="form-group">
									<label for="password123" class="form-label">비밀번호 :</label>
									<input type="password" class="form-control" id="password123">
								</div>
							</div>
							<div class="col-6">
								<div class="form-group">
									<label for="username123" class="form-label">휴대폰번호 :</label>
									<input type="text" class="form-control" id="username123">
								</div>
							</div>
							<div class="col-6">
								<div class="form-group">
									<label for="password123" class="form-label">E-MAIL :</label>
									<input type="password" class="form-control" id="password123">
								</div>
							</div>
							<div class="col-12">
								<div class="form-group">
									<label for="addressline1" class="form-label">Address Line 1 :</label>
									<input type="text" class="form-control" id="addressline1"> 
								</div>
							</div>
							<div class="col-12">
								<div class="form-group">
									<label for="addressline1" class="form-label">Address Line 2 :</label>
									<input type="text" class="form-control" id="addressline1"> 
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
											<label for="date1" class="form-label">입학일 :</label>
											<input type="date" class="form-control" id="date1">
										</div>
										<div class="col-6">
											<label for="date1" class="form-label">졸업일 :</label>
											<input type="date" class="form-control" id="date1">
										</div>
									</div>
								</div>
							</div>
						</div>
					</section>
					
				</form>
			</div>
			<!-- /.box-body -->
		  </div>
		  <!-- /.box -->

		  <!-- vertical wizard -->
		  <div class="box">

			<!-- /.box-body -->
		  </div>
		  <!-- /.box -->
		<button type="button" class="btn btn-success save-category" id="addBtn">Save</button>
		<button type="button" class="btn btn-danger" id="jhBtnClose">Close</button>
		</section>
		<!-- /.content -->
		</div>
		

