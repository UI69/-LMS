<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



 <div class="container-full">
 <!-- Content Header (Page header) -->
<div class="content-header">
	<div class="d-flex align-items-center">
		<div class="me-auto">
			<!-- 현재 메뉴명 --><h3 class="page-title">봉사활동</h3>
			<div class="d-inline-block align-items-center">
				<nav>
					<ol class="breadcrumb">
						<!-- 홈아이콘 --><li class="breadcrumb-item"><a href="#"><i class="mdi mdi-home-outline"></i></a></li>
						<!-- 상위메뉴명 --><li class="breadcrumb-item" aria-current="page">봉사활동</li>
						<!-- 하위메뉴명(현재메뉴명) --><li class="breadcrumb-item active" aria-current="page">봉사활동(교내/교외)</li>
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

  

<ul class="nav nav-tabs" role="tablist">
	<li class="nav-item">
		<a class="nav-link active" data-bs-toggle="tab" href="#debit-card" role="tab" aria-selected="true">
			<span class="hidden-sm-up"><i class="fa fa-cc"></i></span> 
			<span class="hidden-xs-down">교외 봉사활동</span>
		</a>
	</li>
	<li class="nav-item">
		<a class="nav-link" data-bs-toggle="tab" href="#paypal1" role="tab" aria-selected="false">
			<span class="hidden-sm-up"><i class="fa fa-paypal"></i></span> 
			<span class="hidden-xs-down">교내 봉사활동 </span>
		</a>
	</li>
	<li class="nav-item">
		<a class="nav-link" data-bs-toggle="tab" href="#paypal2" role="tab" aria-selected="false">
			<span class="hidden-sm-up"><i class="fa fa-paypal"></i></span> 
			<span class="hidden-xs-down">추가 필요시</span>
		</a>
	</li>

</ul>

<div class="tab-content tabcontent-border m-15">

	<!-- 검색  -->
	<div class="tab-pane active" id="debit-card" role="tabpanel">
	<div class="row" style="justify-content: flex-end;">
	<div class="col-md-4"> <!-- col-md-5: 부모 너비 값의 절반 사용 -->
		<div class="form-group">
			<select class="form-control" style="width: 30%; display: inline-block;">
				<option selected="selected" disabled="disabled">과목명</option> <!-- disabled : 선택안됨(select의 제목?) -->
				<option>식물생리학</option>
				<option>동물생리학</option>
				<option>생화학</option>
			</select> 
			<input type="text" placeholder="입력하세요" class="form-control" style="width: 55%; display: inline-block;">
			<button type="button" class="btn btn-primary btn-sm">검색</button>
		</div>
	</div>
	<!-- 검색  -->
	
</div>
	<div class="box">
                <div class="box-body ">
                    <h6 class="box-subtitle mb-20"></h6>
                    <div class="table-responsive">
                        <table class="table">
                            <thead class="bg-primary">
                                <tr>
                                    <th>번호</th>
                                    <th>봉사활동 명</th>
                                    <th>봉사활동 설명</th>
                                    <th>봉사 시간</th>
                                    <th>신청인원</th>
                                    <th>신청</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>1</td>
                                    <td>교육 보조 및 청소</td>
                                    <td>교육 보조 및 청소..</td>
                                    <td>3</td>
                                    <td>3/5</td>
                                    <td>
			                        	<div class="d-inline-block pull-right mt-10">
									  		<button type="button" class="btn btn-rounded btn-sm btn-success m-5" data-bs-toggle="modal" data-bs-target="#modal-center" >신청</button>
			                         	</div>
                          			</td>
                                    
                                </tr>
                                <tr>
                                    <td>2</td>
 									<td>교육 보조 및 청소</td>
                                    <td>교육 보조 및 청소..</td>
                                    <td>3</td>
                                    <td>3/5</td>
                                    <td>
			                        	<div class="d-inline-block pull-right mt-10">
									  		<button type="button" class="btn btn-rounded btn-sm btn-success m-5" data-bs-toggle="modal" data-bs-target="#modal-center" >신청</button>
			                         	</div>
                          			</td>
                                    
                                </tr>
                                <tr>
                                    <td>3</td>
 									<td>교육 보조 및 청소</td>
                                    <td>교육 보조 및 청소..</td>
                                    <td>3</td>
                                    <td>3/5</td>
                                    <td>
			                        	<div class="d-inline-block pull-right mt-10">
									  		<button type="button" class="btn btn-rounded btn-sm btn-success m-5" data-bs-toggle="modal" data-bs-target="#modal-center" >신청</button>
			                         	</div>
                          			</td>
                                    
                                </tr>
                            </tbody>
                        </table>
                    </div>
    
			<div class="col-sm-12 col-md-7"
				style="float: right; margin-right: 100px">
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
			</div>
                </div>
            </div>
	
	
	</div>
	
	<div class="tab-pane" id="paypal1" role="tabpanel">
	<div class="row" style="justify-content: flex-end;">
           	<div class="col-md-4"> <!-- col-md-5: 부모 너비 값의 절반 사용 -->
		<div class="form-group">
			<select class="form-control" style="width: 30%; display: inline-block;">
				<option selected="selected" disabled="disabled">과목명</option> <!-- disabled : 선택안됨(select의 제목?) -->
				<option>식물생리학</option>
				<option>동물생리학</option>
				<option>생화학</option>
			</select> 
			<input type="text" placeholder="입력하세요" class="form-control" style="width: 55%; display: inline-block;">
			<button type="button" class="btn btn-primary btn-sm">검색</button>
		</div>
		</div>
	</div>
       <div class="box">    	
<div class="box-body">
	<div class="d-flex col-12">
        <div class="col-1"></div>
     </div>

		<h6 class="box-subtitle mb-20"></h6>
		<div class="table-responsive">
			<table class="table">
                  <thead class="bg-primary">
                      <tr>
                          <th>1</th>
                          <th>1</th>
                          <th>1</th>
                          <th>1</th>
                          <th>1</th>
                          <th>신청</th>
                      </tr>
                  </thead>
                  <tbody>
                      <tr>
                          <td>1</td>
                          <td>교육 보조 및 청소</td>
                          <td>교육 보조 및 청소..</td>
                          <td>3</td>
                          <td>3/5</td>
                          <td>
                          <div class="d-inline-block pull-right mt-10">
						  		<button type="button" class="btn btn-rounded btn-sm btn-success m-5" >신청</button>
                          </div>
                          </td>
                          
                      </tr>
                      <tr>
                          <td>2</td>
							<td>교육 보조 및 청소</td>
                          <td>교육 보조 및 청소..</td>
                          <td>3</td>
                          <td>3/5</td>
                          <td>
                        	  <div class="d-inline-block pull-right mt-10">
						  		<button type="button" class="btn btn-rounded btn-sm btn-success m-5">신청</button>
                         	 </div>
                          </td>
                          
                      </tr>
                      <tr>
                          <td>3</td>
						  <td>교육 보조 및 청소</td>
                          <td>교육 보조 및 청소..</td>
                          <td>3</td>
                          <td>3/5</td>
                          <td>
                        	  <div class="d-inline-block pull-right mt-10">
						  		<button type="button" class="btn btn-rounded btn-sm btn-success m-5">신청</button>
                         	 </div>
                          </td>
                          
                      </tr>
                  </tbody>
              </table>
		</div>
		
<div class="col-sm-12 col-md-7"
		style="float: right; margin-right: 100px">
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
	</div>
		
	</div>
</div>   	
               
	</div>
	<div class="tab-pane" id="paypal2" role="tabpanel">
		<h4>3</h4>
		<div class="table-responsive">
			<table class="table">
                  <thead class="bg-primary">
                      <tr>
                          <th>3</th>
                          <th>3</th>
                          <th>3</th>
                          <th>3</th>
                          <th>3</th>
                      </tr>
                  </thead>
                  <tbody>
                      <tr>
                          <td>1</td>
                          <td>교육 보조 및 청소</td>
                          <td>교육 보조 및 청소..</td>
                          <td>3</td>
                          <td>3/5</td>
                          
                      </tr>
                      <tr>
                          <td>2</td>
							<td>교육 보조 및 청소</td>
                          <td>교육 보조 및 청소..</td>
                          <td>3</td>
                          <td>3/5</td>
                          
                      </tr>
                      <tr>
                          <td>3</td>
						  <td>교육 보조 및 청소</td>
                          <td>교육 보조 및 청소..</td>
                          <td>3</td>
                          <td>3/5</td>
                          
                      </tr>
                  </tbody>
              </table>
		</div>
	</div>


	<div class="tab-pane" id="paypal3" role="tabpanel">
		<h4>4</h4>
		<div class="table-responsive">
			<table class="table">
				<thead class="bg-primary">
					<tr>
						<th>#</th>
						<th>First Name</th>
						<th>Last Name</th>
						<th>Username</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>1</td>
						<td>Nigam</td>
						<td>Eichmann</td>
						<td>@Sonu</td>
					</tr>
					<tr>
						<td>2</td>
						<td>Deshmukh</td>
						<td>Prohaska</td>
						<td>@Genelia</td>
					</tr>
					<tr>
						<td>3</td>
						<td>Roshan</td>
						<td>Rogahn</td>
						<td>@Hritik</td>
					</tr>
				</tbody>
			</table>
		</div>
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
					<h4 class="box-title text-info mb-0"><i class="ti-user me-15"></i>  </h4>
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
						  <label class="form-label">학 번</label>
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
						  <label class="form-label">학과</label>
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
				
				<input type="file" id="file">
				
				</form>
			 </div>
		  <div class="modal-footer modal-footer-uniform">
			<button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
			<button type="button" class="btn btn-primary float-end">Save changes</button>
		  </div>
		</div>
	  </div>
	</div>


               