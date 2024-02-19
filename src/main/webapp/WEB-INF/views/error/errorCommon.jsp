<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
  <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="../images/favicon.ico">

    <title>EduAdmin - 404 Page not found </title>
  
	<!-- Vendors Style-->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/vendors_css.css">
	  
	<!-- Style-->  
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/skin_color.css">	

</head>
<body class="hold-transition theme-primary bg-img" style="background-image: url(../images/auth-bg/bg-4.jpg)">
	
	<section class="error-page h-p100">
		<div class="container h-p100">
		  <div class="row h-p100 align-items-center justify-content-center text-center">
			  <div class="col-lg-7 col-md-10 col-12">
				  <div class="rounded10 p-50">
					  <img src="../images/auth-bg/404.jpg" class="max-w-200" alt="" />
					  <h1>잘못된 접근</h1>
					  <h3>페이지 로드 중 에러가 발생하였습니다.</h3>
					  <div class="my-30"><a href="/DYUniv/mainpage.do" class="btn btn-danger">홈으로</a></div>	
				  </div>
			  </div>				
		  </div>
		</div>
	</section>


	<!-- Vendor JS -->
	<script src="${pageContext.request.contextPath}/resources/js/vendors.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/pages/chat-popup.js"></script>
    <script src="${pageContext.request.contextPath}/resources/assets/icons/feather-icons/feather.min.js"></script>	


</body>