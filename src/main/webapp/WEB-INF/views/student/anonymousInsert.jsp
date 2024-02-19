<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<div class="container-full">
	<div class="content-header">
		<div class="d-flex align-items-center">
			<div class="me-auto">
				<h3 class="page-title">대나무 숲 등록 페이지</h3>
				<div class="d-inline-block align-items-center">
					<nav>
						<ol class="breadcrumb">
							<li class="breadcrumb-item" aria-current="page">대나무 숲 (등록하기)</li>
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
					<div class="box">
						<form class="form" id="registerForm" method="post" action="/DYUniv/anonymousInsert.do">
							<div class="box-body">
								<h4 class="box-title text-info mb-0">
									<i class="ti-user me-15"></i> 글 제목
								</h4>
								<hr class="my-15">
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<input type="text" id="title" name= "anonBrdTitle" class="form-control" placeholder="">
										</div>
									</div>
								</div>
								<h4 class="box-title text-info mb-0 mt-20">
									<i class="ti-envelope me-15"></i> 글내용
								</h4>
								<hr class="my-15">
								<div class="form-group">
									<textarea rows="4" class="form-control" id="content" name= "anonBrdCont" placeholder="">${anonyVO.anonBrdCont }</textarea>
								</div>

							</div>
							<c:set value="등록" var="btnText" />
							<button type="button"
								class="waves-effect waves-light btn btn-primary mb-5"
								id="registerBtn">${btnText }</button>
							<button type="button"
								class="waves-effect waves-light btn btn-primary mb-5"
								id="listBtn">목록</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>
<script type="text/javascript">
$(function(){
	var registerForm = $("#registerForm");	// form element
	var registerBtn = $("#registerBtn");	// 등록 버튼 element
	var listBtn = $("#listBtn");			// 목록 버튼 element
	
	registerBtn.on("click", function(){
		var title = $("#title").val();
		var content = $("#content").val();
		
		if(title == null || title == ""){
			alert("제목을 입력해주세요!");
			return false;
		}
		
		if(content == null || content == ""){
			alert("내용을 입력해주세요!");
			return false;
		}
		
		
		
		registerForm.submit();
	});
	
	listBtn.on("click", function(){
		location.href = "/DYUniv/anonymouseBoard.do";
	});
	
});
</script>
