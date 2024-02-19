<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



 <div class="container-full">
 <!-- Content Header (Page header) -->
<div class="content-header">
	<div class="d-flex align-items-center">
		<div class="me-auto">
			<!-- 현재 메뉴명 --><h3 class="page-title">성적 조회</h3>
			<div class="d-inline-block align-items-center">
				<nav>
					<ol class="breadcrumb">
						<!-- 홈아이콘 --><li class="breadcrumb-item"><a href="#"><i class="mdi mdi-home-outline"></i></a></li>
						<!-- 상위메뉴명 --><li class="breadcrumb-item" aria-current="page">성적조회</li>
						<!-- 하위메뉴명(현재메뉴명) --><li class="breadcrumb-item active" aria-current="page">하위메뉴명(현재메뉴명)</li>
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
			<span class="hidden-xs-down">교과목별 성적</span>
		</a>
	</li>
	<li class="nav-item">
		<a class="nav-link" data-bs-toggle="tab" href="#paypal1" role="tab" aria-selected="false">
			<span class="hidden-sm-up"><i class="fa fa-paypal"></i></span> 
			<span class="hidden-xs-down">학기별 성적 </span>
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

	<div class="tab-pane active" id="debit-card" role="tabpanel">
	<h3 class="box-title">교과목별 성적</h3>

	<div class="box">
                <div class="box-body ">
                <div class="d-flex col-12">
                <div class="col-2">
                   	년도
                    <select name="complex_header_length" aria-controls="complex_header" class="form-select form-control-sm">
                        <option value="">------</option>
                        <option value="10">2020</option>
                        <option value="25">2021</option>
                        <option value="50">2022</option>
                        <option value="100">2023</option>
                    </select>
                </div>
                <div class="col-1"></div>
                
                <div class="col-2">
                 	   학기
                    <select name="complex_header_length" aria-controls="complex_header" class="form-select form-control-sm ">
                        <option value="">------</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                    </select>
                 </div>
 
				<div class="col-1"></div>
                
                <div class="col-2">
                 	   교과목
                    <select name="complex_header_length" aria-controls="complex_header" class="form-select form-control-sm ">
                        <option value="">------</option>
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                    </select>
                 </div>                
             </div>
                    <h6 class="box-subtitle mb-20"></h6>
                    <div class="table-responsive">
                        <table class="table">
                            <thead class="bg-primary">
                                <tr>
                                    <th>번호</th>
                                    <th>년도</th>
                                    <th>학기</th>
                                    <th>교과목명</th>
                                    <th>학점</th>
                                    <th>이수 구분</th>
                                    <th>등급</th>
                                    <th>학점 구분</th>
                                    <th>이의 신청</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>1</td>
                                    <td>2023</td>
                                    <td>1</td>
                                    <td>사회복지</td>
                                    <td>3</td>
                                    <td>전공필수</td>
                                    <td>A+</td>
                                    <td>일반 성적</td>
                                    <td>
	                                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modal-center">
											정정신청
										</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>2</td>
                                    <td>2023</td>
                                    <td>1</td>
                                    <td>사회복지</td>
                                    <td>3</td>
                                    <td>전공필수</td>
                                    <td>A+</td>
                                    <td>일반 성적</td>
                                    <td>
                                    	<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modal-center">
											정정신청
										</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td>3</td>
                                    <td>2023</td>
                                    <td>1</td>
                                    <td>사회복지</td>
                                    <td>3</td>
                                    <td>전공필수</td>
                                    <td>A+</td>
                                    <td>일반 성적</td>
                                    <td>
                                    	<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modal-center">
											정정신청
										</button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

	</div>
	
	<div class="tab-pane" id="paypal1" role="tabpanel">
           	<h3 class="box-title">학기별 성적</h3>
       <div class="box">    	
<div class="box-body">
	<div class="d-flex col-12">
        <div class="col-1"></div>
     </div>
	<div class="d-flex col-12">
             <div class="col-2">
             	년도<select name="complex_header_length" aria-controls="complex_header" class="form-select form-control-sm">
                  <option value="">------</option>
                  <option value="">2020</option>
                  <option value="">2021</option>
                  <option value="">2022</option>
                  <option value="">2023</option>

              </select>
           </div>
     	<div class="col-1"></div>
     	<div class="col-2">
             	학기<select name="complex_header_length" aria-controls="complex_header" class="form-select form-control-sm">
                  <option value="">------</option>
                  <option value="">1</option>
                  <option value="">2</option>

              </select>
           </div>
     	<div class="col-1"></div>
     </div>
		<h6 class="box-subtitle mb-20"></h6>
		<div class="table-responsive">
			<table class="table">
				<thead class="bg-primary">
					<tr>
						<th>번호</th>
						<th>년도</th>
						<th>학기</th>
						<th>성적</th>
						<th>이수학점</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>1</td>
						<td>2023</td>
						<td>1</td>
						<td>A+</td>
						<td>3</td>
					</tr>
					<tr>
						<td>1</td>
						<td>2022</td>
						<td>1</td>
						<td>A+</td>
						<td>3</td>
					</tr>
					<tr>
						<td>1</td>
						<td>2021</td>
						<td>1</td>
						<td>A+</td>
						<td>3</td>
					</tr>
					
				</tbody>
			</table>
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
	<div class="tab-pane" id="paypal4" role="tabpanel">
		<h4>5</h4>
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

<!--  -->            
            
            
            
            
            
            
            
            
            
                
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


               