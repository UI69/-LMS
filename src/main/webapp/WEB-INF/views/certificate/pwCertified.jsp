<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
	
	<!-- sweetalert -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.2/dist/sweetalert2.all.min.js"></script>
	<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.2/dist/sweetalert2.min.css" rel="stylesheet">
	
	<style type="text/css">
		.btnBox {
			margin: 0 auto;
		    display: flex;
		    justify-content: space-evenly;
		    text-align: center;
		}
	</style>
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
								<span class="text-danger" id="tempPw">${resetPw }</span>
							</div>
							<div class="p-40" style="padding-top: 20px !important;">
								<form action="/DYUniv/passCheck.do" method="post" id="pwCheckForm" >
									<div class="form-group">
										<div class="input-group mb-3">
											<span class="input-group-text bg-transparent"><i class="ti-lock"></i></span>
											<input type="password" class="form-control ps-15 bg-transparent" 
												name="memPw" id="memPw" placeholder="Password">
										</div>
										<div class="input-group mb-3">
											<span class="input-group-text bg-transparent"><i class="ti-lock"></i></span>
											<input type="password" class="form-control ps-15 bg-transparent"
												name="memPw2" id="memPw2" placeholder="Write Password Again">
										</div>
									</div>
									  <div class="row">
										<div class="col-5 btnBox">
										  <button type="button" class="btn btn-warning mt-10" id="homeBtn">취소</button>
										  <button type="submit" class="btn btn-info mt-10" id="pwCertified" name="pwCertified">인증</button>
										</div>
										<!-- /.col -->
									  </div>
								</form>		

								<div class="text-center">
								  <p class="mt-20"></p>
								  <p class="mb-5"></p>	
								</div>

								<div class="text-center">
									<!-- <p class="mt-15 mb-0"> <a href="#" class="btn btn-info" id="homeBtn">홈으로</a></p> -->
									<p class="mt-15 mb-0"> <a href="#" class="btn btn-danger-light btn-sm" id="testBtn">test</a></p>
									<script type="text/javascript">
										$("#testBtn").on("click", function() {
											$("#memPw").val("1234aa!@");
											$("#memPw2").val("1234aa!@");
										})
									</script>
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

<script type="text/javascript">
$(function () {
    var pwCheckForm = $("#pwCheckForm");
    
    // pwCertified 버튼의 클릭 이벤트 핸들러 설정
    $("#pwCertified").on("click", function () {
        var pw1 = $("#memPw").val();
        var pw2 = $("#memPw2").val();
        
        if(pw1 === "" || pw2 === ""){
            alert("비밀번호를 입력해주세요");
            return false;
        }
        if (pw1 !== pw2) {
            alert("비밀번호가 일치하지 않습니다.");
            return false;
        }

        // 폼 제출
        pwCheckForm.submit();
    });
});

$("#homeBtn").on("click", function () {
	var pwspan = $("#tempPw").text();
	if(pwspan == null || pwspan == "" ){
		location.href = "/DYUniv/mainpage.do";
	}
	
	Swal.fire({
		text: "비밀번호를 재설정하지 않고 나가시겠습니까?",
		icon: "warning",
		showCancelButton: true,
		confirmButtonColor: "#3085d6",
		cancelButtonColor: "#d33",
		confirmButtonText: "Yes"
	}).then(function(result) {
		if (result.isConfirmed) {
			location.href = "/DYUniv/mainpage.do";
		}
	});
})

</script>


</html>


