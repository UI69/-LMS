<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.ico">

    <title>비밀번호 찾기</title>
  
	<!-- Vendors Style-->
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/vendors_css.css">
	  
	<!-- Style-->  
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/skin_color.css">	
	
	<!-- JQuery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="
	https://cdn.jsdelivr.net/npm/sweetalert2@11.10.2/dist/sweetalert2.all.min.js
	"></script>
	<link href="
	https://cdn.jsdelivr.net/npm/sweetalert2@11.10.2/dist/sweetalert2.min.css
	" rel="stylesheet">

<style type="text/css">
.borderStyle {
	border-radius: 0 0 10px 10px;
}
.buttonBorder {
	border-radius: 10px 10px 0 0;
}
</style>

</head>

<body class="hold-transition theme-primary bg-img" style="background-image: url(${pageContext.request.contextPath }/resources/images/auth-bg/bg-2.jpg)">
	
	<div class="container h-p100">
		<div class="row align-items-center justify-content-md-center h-p100">
			
			<div class="col-12">
				<div class="row justify-content-center g-0 ">
					<div class="btn-group col-lg-5 col-md-5 col-6">
					  <button type="button" class="waves-effect waves-light btn btn-primary-light buttonBorder" onclick="location.href='/findId.do'">아이디 찾기</button>
					  <button type="button" class="waves-effect waves-light btn btn-primary buttonBorder">비밀번호 찾기</button>
					</div>
				</div>
				<div class="row justify-content-center g-0">
					<div class="col-lg-5 col-md-5 col-12">						
						<div class="bg-white borderStyle shadow-lg">
							<div class="content-top-agile p-20 pb-0">
								<h3 class="mb-0 text-primary">비밀번호 찾기</h3>								
							</div>
							<div class="p-40">
								<form action="#" method="post">
									<div class="form-group">
										<div class="input-group mb-3">
											<span class="input-group-text bg-transparent"><i class="ti-id-badge "></i></span>
											<input type="text" class="form-control ps-15 bg-transparent" id="memId" name="memId" placeholder="ID">
										</div>
										<div class="input-group mb-3">
											<span class="input-group-text bg-transparent"><i class="ti-user"></i></span>
											<input type="text" class="form-control ps-15 bg-transparent" id="memName"  name="memName" placeholder="Name">
										</div>
										<div class="input-group mb-3">
											<span class="input-group-text bg-transparent"><i class="ti-email"></i></span>
											<input type="email" class="form-control ps-15 bg-transparent" id="memEmail" name="memEmail" placeholder="Email">
										</div>
									</div>
									  <div class="row">
										<div class="col-12 text-center">
										  <button type="button" class="btn btn-warning btn-sm m-10" onclick="location.href='/login.do'">돌아가기</button>
										  <button type="button"  id="findPw" class="btn btn-primary btn-sm m-10">비밀번호 찾기</button>
										</div>
										<!-- <div class="col-12 text-center">
										  <button type="button" class="btn btn-info margin-top-10 btn-sm m-10" onclick="location.href='/login.do'">돌아가기</button>
										</div> -->
										<div class="col-12 text-center">
										   <button type="button" class="btn btn-danger-light margin-top-10 btn-sm m-10" id="testBtn">test</button>
										</div>
									  </div>
								</form>	
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>	

	<!-- Vendor JS -->
	<script src="${pageContext.request.contextPath }/resources/js/vendors.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/js/pages/chat-popup.js"></script>
    <script src="${pageContext.request.contextPath }/resources//assets/icons/feather-icons/feather.min.js"></script>
    <script type="text/javascript">	
    
	$(function() {
		var findPw = $("#findPw");
		
		$("#testBtn").on("click", function () {
			$("#memId").val("21012346");
			$("#memName").val("김현우");
			$("#memEmail").val("codinator1001@gmail.com");
		})
		
		
		findPw.on("click", function() {
			var memId = $("#memId").val();
			var memName = $("#memName").val();
			var memEmail = $("#memEmail").val();
			
			data = {
					memId : memId,
					memName : memName,
					memEmail : memEmail
			}
			
			//비밀번호 찾기 컨트롤러 이동
			$.ajax({
				type : "post",
				data : JSON.stringify(data),
				url : "/findPwAjax.do",
				contentType : "application/json; charset=utf-8",
				success : function(res) {
					console.log("체크 : ", res);
					if(res == 'failed'){
						// alert("일치하는 정보가 없습니다...")
						Swal.fire({
						      icon: 'error',
						      title: '일치하는 정보가 없습니다.',
						      text: '',
						    });
					} else {
						// alert("이메일로 임시 비밀번호가 전송되었습니다. \n 전송된 비밀번호로 로그인 후 비밀번호 재설정이 필요합니다");
						// location.href = "/login.do";
						Swal.fire({
			                icon: 'success',
			                title: '이메일로 임시 비밀번호가 \n전송되었습니다.',
			                text: '전송된 비밀번호로 로그인 후 \n비밀번호 재설정이 필요합니다.'
			            }).then(function() {
			                window.location.href = "/login.do";
			            });
					}
				}
			})
		})
	})
	</script>
</body>
</html>