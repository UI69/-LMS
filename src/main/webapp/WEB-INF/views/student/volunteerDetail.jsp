<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
 <div class="container-full">
    
<!-- Content Header (Page header) -->
<div class="content-header">
	<div class="d-flex align-items-center">
		<div class="me-auto">
			<!-- 현재 메뉴명 --><h3 class="page-title">봉사활동 상세 </h3>
			<div class="d-inline-block align-items-center">
				<nav>
					<ol class="breadcrumb">
						<!-- 홈아이콘 --><li class="breadcrumb-item"><a href="#"><i class="mdi mdi-home-outline"></i></a></li>
						<!-- 상위메뉴명 --><li class="breadcrumb-item" aria-current="page">봉사활동</li>
						<!-- 하위메뉴명(현재메뉴명) --><li class="breadcrumb-item active" aria-current="page">봉사활동(상세보기)</li>
					</ol>
				</nav>
			</div>
		</div>

	</div>
</div>
   <section class="content"> 
   
   <div class="box">
		<div class="box-body">
			<div class="col-lg-12 col-12">
					<!-- Default box -->
					  <div class="box">
					  	<div class="row box-header with-border">
					    	<div class="col-7">
						      <h4 class="box-title">제목</h4>
						    </div>
					    	<div class="col-md-3 col-lg-12 text-end">
					     	 	<b>날짜:</b> 2024-01-08
					     	 	<b>조회수:</b> 7
					   		 </div>
				  		</div>
					</div>

						<div class="box-body">
						
						<table>
						<thead>
							<tr>
								<th>
									제목
								</th>
							</tr>
						</thead>
							<tr>
								<td>
									내용
								</td>
								<td>
								2
								</td>
							</tr>
							<tr>
								<td>
									내용
								</td>
								<td>
								2
								</td>
							</tr>
						</table>
						
						
						</div>
						<!-- /.box-body -->
						<div class="box-footer" align="right">
							<div class="d-inline-block pull-right mt-10">
						  		<button type="button" class="btn btn-rounded btn-sm btn-success m-5" data-bs-toggle="modal" data-bs-target="#modal-center" >신청</button>
						  		<button type="button" class="btn btn-rounded btn-sm btn-danger m-5">목록</button>
						  		

							</div>
						</div>
						<!-- /.box-footer-->
					  </div>
					<!-- /.box -->
				</div>
			</div>
   </section>
</div>




<!-- 모달 창 부분  -->
	<div class="modal center-modal fade" id="modal-center" tabindex="-1" style="display: none;" aria-hidden="true">
	  <div class="modal-dialog">
		<div class="modal-content">
		  <div class="modal-header">
			<h5 class="modal-title"></h5>
			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
		  </div>
		  <div class="modal-body">
			<form class="form">
				<div class="box-body">
					<h4 class="box-title text-info mb-0"><i class="ti-user me-15"></i> 이의신청 </h4>
					<hr class="my-15">
					<div class="row">
					  <div class="col-md-6">
	
						<div class="form-group">
						  <label class="form-label">신청자명 </label>
						  <input type="text" class="form-control" placeholder="">
						</div>
					  </div>
					  
					  <div class="col-md-6">
						<div class="form-group">
						  <label class="form-label">전 공</label>
						  <input type="text" class="form-control" placeholder="">
						</div>
					  </div>
					  <div class="col-md-6">
						<div class="form-group">
						  <label class="form-label">학 번</label>
						  <input type="text" class="form-control" placeholder="">
						</div>
					  </div>
					  <div class="col-md-6">
						<div class="form-group">
						  <label class="form-label">정정 신청 강의</label>
						  <input type="text" class="form-control" placeholder="">
						</div>
					  </div>
					  <div class="col-md-6">
						<div class="form-group">
						  <label class="form-label">학 년</label>
						  <input type="text" class="form-control" placeholder="">
						</div>
					  </div>
					  <div class="col-md-6">
						<div class="form-group">
						  <label class="form-label">신청일</label>
						  <input type="text" class="form-control" placeholder="">
						</div>
					  </div>
					  <div class="col-md-6">
						<div class="form-group">
						  <label class="form-label">연 락 처 </label>
						  <input type="text" class="form-control" placeholder="">
						</div>
					  </div>
					</div>
					<h4 class="box-title text-info mb-0 mt-20"><i class="ti-envelope me-15"></i> 신청 사유</h4>
				<hr class="my-15">
				<div class="form-group">
					  <label class="form-label">신청 사유 작성 :</label>
					  <textarea rows="4" class="form-control" placeholder=""></textarea>
					</div>
				</div>
				</form>
			 </div>
		  <div class="modal-footer modal-footer-uniform">
			<button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
			<button type="button" class="btn btn-primary float-end">Save changes</button>
		  </div>
		</div>
	  </div>
	</div>


      