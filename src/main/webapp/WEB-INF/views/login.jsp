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
<link rel="icon"
	href="${pageContext.request.contextPath }/resources/images/favicon.ico">

<title>EduAdmin - Log in</title>

<!-- Vendors Style-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/vendors_css.css">

<!-- Style-->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/style.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/css/skin_color.css">

<!-- JQuery -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

</head>
<style>
#bg-video {
    position: fixed;
    height: 130%;
    width: 110%;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    z-index: 11;
}

#bg-cover {
	position: fixed;
	height: 100%;
	width: 100%;
	top: 0;
	left: 0;
	z-index: 22;
	background: rgba(255, 255, 255, 0.4);
}

.container {
	position: fixed;
	top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
	z-index: 33;
}
p.mb-20 {
	margin: 0 !important;
}
</style>
<body class="hold-transition theme-primary">

	<iframe width="560" height="315"
		src="https://www.youtube.com/embed/PzUZ1zP940U?si=Z7u7MaDhkaGxVT3U&amp;controls=0&autoplay=1&mute=1&amp;clip=UgkxOZPGoJbay0Xkv5lZKH1EVajy1h5Ksyox&amp;clipt=EAAYqIsD"
		title="YouTube video player" frameborder="0"
		allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
		allowfullscreen id="bg-video"></iframe>

	<div id="bg-cover"></div>

	<div class="container h-p100">
		<div class="row align-items-center justify-content-md-center h-p100">

			<div class="col-12">
				<div class="row justify-content-center g-0">
					<div class="col-lg-5 col-md-5 col-12">
						<div class="rounded10 shadow-lg bg-white">
							<div class="content-top-agile p-20 pb-0">
								<h3 class="text-primary">대육 대학교</h3>
								<h2 class="mb-0">로그인</h2>
							</div>
							<div class="p-40">
								<form action="login.do" method="post" id="loginForm">
									<div class="form-group">
										<h4>학사/학번</h4>
										<%
											String id = (String) session.getAttribute("rememberId");
										String idRememberChecked = "";
										if (id != null) {
											idRememberChecked = "checked";
										} else {
											id = "";
										}
										%>

										<div class="input-group mb-3">
											<span class="input-group-text bg-transparent"><i
												class="ti-id-badge"></i></span> <input type="text"
												class="form-control ps-15 bg-transparent" name="memId"
												id="memId" placeholder="" value="<%=id%>">
										</div>
									</div>
									<div class="form-group">
										<h4>비밀번호</h4>
										<div class="input-group mb-3">
											<span class="input-group-text  bg-transparent"><i
												class="ti-lock"></i></span> <input type="password"
												class="form-control ps-15 bg-transparent" name="memPw"
												id="memPw" placeholder="">
										</div>
									</div>
									<div class="row">
										<div class="col-12">
											<div class="checkbox">
												<input type="checkbox" name="idRememberCheckbox"
													id="basic_checkbox_1" <%=idRememberChecked%>> <label
													for="basic_checkbox_1">학사/학번 기억하기</label>
											</div>
										</div>

										<c:if test="${failCount eq null }">
											<c:set value="${0 }" var="failCount" />
										</c:if>
										<c:if test="${failCount >= 3 }">
											<div id="g-recaptcha"></div>
										</c:if>
										<input type="hidden" name="failCount" value="${failCount }">


									</div>
								</form>
								<div class="col-12 text-center">
									<button type="button" class="btn btn-danger mt-10"
										onclick="f_login()" id="loginBtn">LOG IN</button>
								</div>
								<div class="text-center">
									<p class="mt-20 text-mute" style="margin-bottom: 0.7rem; font-size: 13px;">아이디/비밀번호를 잊어버리셨나요?</p>
									<p class="gap-items-2 mb-20">
										<a href="/findId.do" class="hover-warning"><i class="ion ion-locked"></i>아이디/비밀번호 찾기</a><br>
									</p>
								</div>
							</div>
						</div>
						<div class="text-center" style="margin-top: 30px;">
							<button class="btn btn-info btn-xl" onclick="f_std()">학생용</button>
							<button class="btn btn-info btn-xl" onclick="f_pro()">교수용</button>
							<button class="btn btn-info btn-xl" onclick="f_emp()">직원용</button>
							<button class="btn btn-info btn-xl" onclick="f_t1()">신입용</button>

							<script type="text/javascript">
								function f_std() {
									$("#memId").val("21018763");
									$("#memPw").val("java");
								}
								function f_pro() {
									$("#memId").val("24000253");
									$("#memPw").val("java");
								}
								function f_emp() {
									$("#memId").val("admin");
									$("#memPw").val("1234aa!@");
								}
								function f_t1() {
									$("#memId").val("21012346");
									$("#memPw").val("pw1");
								}
							</script>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>



	<c:if test="${failCount >= 3 }">
		<!--  -->
		<script
			src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit"
			async defer></script>
		<script type="text/javascript">
			$("#loginBtn").addClass("disabled-btn");
			$("#loginBtn").attr("disabled", "disabled");

			//화면 시작 시 g-recaptcha 생성
			var onloadCallback = function() {
				grecaptcha.render('g-recaptcha', {
					'sitekey' : '6LdprUopAAAAAPmw1c6JkWc7FY_OmNf7BhRuMbEh', //인증용 사이트키
					'callback' : verifyCallback,
					'expired-callback' : expiredCallback,
				});
			};
			// 인증 성공 시
			var verifyCallback = function(response) {
				console.log("g-recaptcha success...");
				$("#loginBtn").removeClass("disabled-btn");
				$("#loginBtn").removeAttr("disabled");
			};
			// 인증 만료 시
			var expiredCallback = function(response) {
				console.log("g-recaptcha failed...");
				$("#loginBtn").addClass("disabled-btn");
				$("#loginBtn").attr("disabled", "disabled");
			}
			// g-recaptcha 리셋
			var resetCallback = function() {
				grecaptcha.reset();
			}
		</script>
	</c:if>

</body>
<!-- Vendor JS -->
<script
	src="${pageContext.request.contextPath }/resources/js/vendors.min.js"></script>
<script
	src="${pageContext.request.contextPath }/resources/js/pages/chat-popup.js"></script>
<script
	src="${pageContext.request.contextPath }/resources/assets/icons/feather-icons/feather.min.js"></script>

<script type="text/javascript">
	$(function() {
		$("#memPw").keydown(function(e) {
			console.log(e.keyCode);
			if (e.keyCode == 13) {
				f_login();
			}
		})
	})

	var loginForm = $("#loginForm");

	function f_login() {

		var memId = $("#memId").val();
		var memPw = $("#memPw").val();
		//console.log("test", $("#memId").val());
		//console.log("test", $("#memPw").val());

		if (memId == null || memId == "") {
			alert("아이디를 입력");
			return false;
		}

		if (memPw == null || memPw == "") {
			alert("비밀번호를 입력");
			return false;
		}

		loginForm.submit();

	}
</script>
</html>
