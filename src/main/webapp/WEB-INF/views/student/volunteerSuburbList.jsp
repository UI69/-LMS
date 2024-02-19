<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
 <div class="container-full">
    
<!-- Content Header (Page header) -->
<div class="content-header">
	<div class="d-flex align-items-center">
		<div class="me-auto">
			<!-- 현재 메뉴명 --><h3 class="page-title">교외 봉사활동  </h3>
			<div class="d-inline-block align-items-center">
				<nav>
					<ol class="breadcrumb">
						<!-- 홈아이콘 --><li class="breadcrumb-item"><a href="#"><i class="mdi mdi-home-outline"></i></a></li>
						<!-- 상위메뉴명 --><li class="breadcrumb-item" aria-current="page">봉사활동</li>
						<!-- 하위메뉴명(현재메뉴명) --><li class="breadcrumb-item active" aria-current="page">봉사활동(교외 봉사활동 목록)</li>
					</ol>
				</nav>
			</div>
		</div>

	</div>
</div>
   <section class="content"> 
   
   <div class="row" style="justify-content: flex-end;">
           	<div class="col-md-4"> <!-- col-md-5: 부모 너비 값의 절반 사용 -->
				<div class="form-group">
					<select class="form-control" style="width: 30%; display: inline-block;">
						<option selected="selected" disabled="disabled">봉사활동</option> <!-- disabled : 선택안됨(select의 제목?) -->
						<option>식물생리학</option>
						<option>동물생리학</option>
						<option>생화학</option>
					</select> 
					<input type="text" placeholder="입력하세요" class="form-control" style="width: 55%; display: inline-block;">
					<button type="button" class="btn btn-primary btn-sm">검색</button>
				</div>
		</div>
	</div>
		<div class="table-responsive">
			<table class="table">
                  <thead class="bg-primary">
                      <tr>
                          <th>번호</th>
                          <th>봉사활동 명칭</th>
                          <th>봉사활동 설명</th>
                          <th>봉사 시간</th>
                          <th>진행 상태</th>
                      </tr>
                  </thead>
                  <tbody>
                      <tr>
                          <td>1</td>
                          <td>교육 보조 및 청소</td>
                          <td>교육 보조 및 청소..</td>
                          <td>3</td>
                          <td>
                          	<button type="button" class="btn btn-rounded btn-sm btn-success m-5" data-bs-toggle="modal" data-bs-target="#modal-center3">
								상태
							</button>
                          </td>
                          
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
   </section>
	</div>



<!-- 모달 창 부분  -->
<div class="modal center-modal fade" id="modal-center3" tabindex="-1" style="display: none;" aria-hidden="true">
  <div class="modal-dialog">
	<div class="modal-content">
	  <div class="modal-header">
		<h5 class="modal-title"></h5>
		<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	  </div>
	  <div class="modal-body">
		<form class="form">
			<div class="box-body">
				<h4 class="box-title text-info mb-0"><i class="ti-user me-15"></i>봉사 반려  </h4>
				<hr class="my-15">

				<h4 class="box-title text-info mb-0 mt-20"><i class="ti-envelope me-15"></i>반려 사유</h4>
			<hr class="my-15">
			<div class="form-group">
				  <label class="form-label">반려 사유 :</label>
				  <textarea rows="4" class="form-control" placeholder=""></textarea>
				</div>
			</div>
			</form>
		 </div>
	  <div class="modal-footer modal-footer-uniform">
		<button type="button" class="btn btn-danger" data-bs-dismiss="modal">취소 </button>
		<button type="button" class="btn btn-primary float-end">확인</button>
	  </div>
	</div>
  </div>
</div>


      