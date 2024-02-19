<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="${pageContext.request.contextPath}/resources/images/favicon.ico">

    <title>비밀번호 찾기</title>

    <!-- Vendors Style-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/vendors_css.css">

    <!-- Style-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/skin_color.css">

    <!-- JQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <style>
        /* 사용자 정의 CSS */
        .center-text {
            text-align: center;
            margin-top: 20px; /* 필요에 따라 조정하세요 */
        }

        .form-container {
            margin-top: 30px; /* 필요에 따라 조정하세요 */
        }
    </style>
</head>

<body class="hold-transition theme-primary bg-img"
      style="background-image: url(${pageContext.request.contextPath}/resources/images/auth-bg/bg-2.jpg)">

<div class="container h-p100">
    <div class="row align-items-center justify-content-md-center h-p100">
        <div class="col-12">
            <div class="row justify-content-center g-0">
                <div class="btn-group col-lg-5 col-md-5 col-6">
                    <button type="button" class="waves-effect waves-light btn btn-flat btn-light bg-white" disabled="disabled">아이디 찾기</button>
                    <button type="button" class="waves-effect waves-light btn btn-info" onclick="location.href='/findPw.do'">비밀번호 찾기</button>
                </div>
            </div>
            <div class="row justify-content-center g-0">
                <div class="col-lg-5 col-md-5 col-12">
                    <div class="bg-white rounded10 shadow-lg">
                        <div class="content-top-agile p-20 pb-0">
                            <h3 class="mb-0 text-primary">아이디 찾기</h3>
                            <h3 class="center-text">회원가입 시 사용한 아이디는<br> 입니다.</h3>
                        </div>
                        <div class="p-40 form-container">
                            <form action="index.html" method="post">
                                <div class="form-group">
                                    <!-- 추가 필드가 있으면 여기에 추가 -->
                                </div>
                                <div class="row">
                                    <div class="col-12 text-center">
                                        <button type="button" class="btn btn-info margin-top-10 btn-sm m-10" onclick="location.href='/login.do'">로그인 화면으로 돌아가기</button>
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
		var findId = $("#findId");
		
		findId.on("click", function() {
			var memName = $("#memName");
			var memEmail = $("#memEmail");
			
			data = {
					"memName" : memName,
					"memEmail" : memEmail
			}
			
			//아이디 찾기 컨트롤러 이동
			$.ajax({
				type : "post",
				data : JSON.stringify(data),
				url : "/findIdAjax.do",
				contentType : "application/json; charset=utf-8",
				success : function(res) {
					
				}
			})
		})
	})
	</script>
</body>
