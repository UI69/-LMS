<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
#imgBox img{

    height: 237px;
    width: 468px;
	object-fit: fill;
}
</style>

	  <div class="container-full">
		<!-- Content Header (Page header) -->	  
		<div class="content-header">
			<div class="d-flex align-items-center">
				<div class="me-auto">
					<h3 class="page-title">분실물</h3>
					<div class="d-inline-block align-items-center">
						<nav>
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="#"><i class="mdi mdi-home-outline"></i></a></li>
								<li class="breadcrumb-item" aria-current="page">게시판 사용</li>
								<li class="breadcrumb-item active" aria-current="page">분실물 게시판</li>
							</ol>
						</nav>
					</div >	
				</div>	
					<c:if test="${member.memRole eq 'ROL003' }">
						<button type="button" class="btn btn-primary itemBtn" data-bs-toggle="modal" data-bs-target="#modal-center">
								등록
						  </button>
						  	</c:if>
						  <!-- 모달 -->  
						  <div class="modal center-modal fade" id="modal-center" tabindex="-1" style="display: none;" aria-hidden="true">
								  <div class="modal-dialog">
									<div class="modal-content">
									  <div class="modal-header">
										<h3 class="modal-title">분실물 등록</h3>
										<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
									  </div>
							<div class="modal-body">
								<form action="/DYUniv/lostItemBoardinset.do" method="post" enctype="multipart/form-data" id="lostItemForm">		
									<div class="media">
										<div class="col-lg-4">
											<div class="box text-center bg-img box-inverse" style="background-image: url(../images/gallery/thumb-sm/1.jpg)" data-overlay="7">
											  <div class="box-body">
												<h5 class="text-uppercase text-muted">이미지</h5>								
												<hr>
												
												<input type="button" class="btn d-grid btn-outline btn-white" id="FileUp" name="FileUp" value="파일 업로드"/>
												<input type="file" id="file" name="files"  style="display: none;">
												<span class="fileName"></span>
											  </div>
											</div>
										  </div>
										<div class="media-body">
											<h5>
												<strong>분실물 : </strong> &nbsp; <input type="text" name="brdTitle" id="lostItem" class="lostItem"/></h5> <br>
											<h5><strong>분실 위치 : </strong> &nbsp; <input type="text" name="brdCont" id="lostLocation" class="lostLocation"/></h5>											
										  </div>
										</div>		
									</form>
									  </div>
									  <div class="modal-footer modal-footer-uniform">
										<button type="button" class="btn btn-danger exitBtn" data-bs-dismiss="modal" id="exitBtn">취소</button>
										<button type="button" class="btn btn-danger-light"  id="lostTest">test</button>
										<button type="button" class="btn btn-primary float-end insertBtn" id="insertBtn">완료</button>
									  </div>
									</div>
								  </div>
								</div>
						<!-- 모달창 끝 -->
			</div>
		</div>
		<section class="row content">
			  <div class="box bg-transparent no-shadow b-0">
				<div class="row box-body">
				<c:set var="index" value="${grypagingVO.startRow + 1}" />
					 <c:forEach items="${lostItemList }" var="lostItem">
					<div class="col-xl-4 col-lg-6 col-12">
					  <div class="box box-widget widget-user-1">
						<div class="widget-user-header bg-img" style="background: url('/resources/images/photo1.png');" data-overlay="5">
						   <div class="box-body text-white">
							   <div class="widget-user-image" id="imgBox">
							   <img class="rounded bg-success-light" src="/resources/files${lostItem.filePath }" alt="User Avatar" fname="${lostItem.fileName }">
								</div>
								  <h6 class="widget-user-desc"></h6>
						   </div>
						</div>
						<div class="box-footer">
						  <div class="row">
			
							<div class="col-sm-12">
							  <div class="description-block">
								<span class="description-text">
								<h5><strong>분실물 : </strong> &nbsp; ${lostItem.brdTitle }</h5> <br>
								<h5><strong>분실위치 : </strong> &nbsp;${lostItem.brdCont }</h5>
								</span>
							  </div>
							</div>
						  </div>
						</div>
					  </div>
					</div>
				</c:forEach>		
			</div>
		</div>	
		<div class="col-sm-12 col-md-6"
			style="float: right; margin-right: 80px">
			<div class="dataTables_paginate paging_simple_numbers" id="example1_paginate">
				${grypagingVO.pagingHTML }
			</div>
		</div>
	</section>
</div>
	  
<script type="text/javascript">

	var lostItem = document.querySelector(".lostItem");
	var lostLocation = document.querySelector(".lostLocation"); 
	var insertBtn = $(".insertBtn");
	var lostItemForm = $("#lostItemForm");
	var FileUp = $("#FileUp")
	var exitBtn = $("#exitBtn")
	
	var pagingArea = $("#example1_paginate");
	var searchForm = $("#searchForm");

	pagingArea.on("click", "a", function(event) {
		event.preventDefault(); // a태그의 이벤트를  block
		var pageNo = $(this).data("page");
			
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
	

	$("#FileUp").on("click", function () {
		
		  $("#file").trigger("click");
		  
	});
	$("#file").on("change", function() {
        // 선택된 파일 이름을 가져와서 span 태그에 표시
        var fileName = $(this).val().split('\\').pop();
        $(".fileName").text(fileName);
    });
	
	
	/* 분실물 등록 완료 버튼 */
	insertBtn.on("click", function(){
		
		lostItem = $(".lostItem").val();
		lostLocation = $(".lostLocation").val();
		
		console.log(lostItem);
		console.log(lostLocation);
		console.log(FileUp);
		
		 var fileName = $("#file").val().split('\\').pop();
	      $(".fileName").text(fileName);


		
		lostItemForm.submit();
		
	});
	
	/* 초기화 */
	exitBtn.on("click", function(){
		
		  // 초기화 코드 추가
	    $(".fileName").text(""); // 이미지 파일 이름 초기화
	    $(".lostItem").val(""); // 분실물 입력 초기화
	    $(".lostLocation").val(""); // 분실 위치 입력 초기화
		
		
	});

	$("#lostTest").on("click", function () {
		$("#lostItem").val("금색 반지");
		$("#lostLocation").val("공과대 1층 남자화장실 세면대");
	})


	 


	

</script>
	  
	  

	  
	  
	 
	  
