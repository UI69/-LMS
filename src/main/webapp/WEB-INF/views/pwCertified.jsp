<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.ico">

	<title>비번 2차 인증 </title>

<!-- Vendors Style-->
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/vendors_css.css">
	  
	<!-- Style-->  
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/skin_color.css">
	
	<!-- JQuery -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	
</head>
<body class="hold-transition theme-primary bg-img" 
style="background-image: url(${pageContext.request.contextPath }/resources/images/auth-bg/bg-2.jpg)">
	
	<div class="container h-p100">
		<div class="row align-items-center justify-content-md-center h-p100">
			
			<div class="col-12">
				<div class="row justify-content-center g-0">
					<div class="col-lg-5 col-md-5 col-12">
						<div class="bg-white rounded10 shadow-lg">
							<div class="content-top-agile p-20">
								<h3 class="mb-0">비밀번호 인증 </h3>								
							</div>
							<div class="p-40">
								<form action="index.html" method="post">
									<div class="form-group">
										<div class="input-group mb-3">
											<span class="input-group-text bg-transparent"><i class="ti-lock"></i></span>
											<input type="password" class="form-control ps-15 bg-transparent" placeholder="Password">
										</div>
										<div class="input-group mb-3">
											<span class="input-group-text bg-transparent"><i class="ti-lock"></i></span>
											<input type="password" class="form-control ps-15 bg-transparent" placeholder="Password">
										</div>
									</div>
									  <div class="row">
										<div class="col-12 text-center">
										  <button type="submit" class="btn btn-info mt-10">비밀번호 확인</button>
										</div>
										<!-- /.col -->
									  </div>
								</form>		

								<div class="text-center">
								  <p class="mt-20"></p>
								  <p class="mb-5"></p>	
								</div>

								<div class="text-center">
									<p class="mt-15 mb-0">Or <a href="auth_login.html" class="text-warning"><b>비밀번호 확인</b></a> as a Different User</p>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
						
		</div>
	</div>	


</body>
<!-- Vendor JS -->
<script src="${pageContext.request.contextPath }/resources/js/vendors.min.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/pages/chat-popup.js"></script>
<script src="${pageContext.request.contextPath }/resources/assets/icons/feather-icons/feather.min.js"></script>	
</html>


