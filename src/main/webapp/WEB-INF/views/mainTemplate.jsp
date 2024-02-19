<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
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
	href="${pageContext.request.contextPath}/resources/images/favicon.ico">
<title>Main template</title>

<!-- 제이쿼리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/vendor_components/jquery-ui/jquery-ui.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui-touch-punch/0.2.3/jquery.ui.touch-punch.min.js"></script>


<!-- Vendors Style-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/vendors_css.css">

<!-- Style-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/skin_color.css">

<!-- fullcalendar css -->
<link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.5/main.min.css" rel="stylesheet">

<!-- sweetalert -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.2/dist/sweetalert2.all.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.10.2/dist/sweetalert2.min.css" rel="stylesheet">

<!-- toastr -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

</head>

<!-- 풀캘린더, toastr 설정 -->
<script type="text/javascript">
	var defaultview = "timeGridWeek";
	var calendarSelectType = true;
	function f_dateSelectEvent(info) {};
	function f_dateClickEvent(info) {};
	function f_eventClickEvent(info) {};
	
	toastr.options = {
		"closeButton": false,
		"debug": false,
		"newestOnTop": false,
		"progressBar": true,
		"positionClass": "toast-bottom-center mb-70",
		"preventDuplicates": false,
		"onclick": null,
		"showDuration": "100",
		"hideDuration": "1000",
		"timeOut": "2500",
		"extendedTimeOut": "1000",
		"showEasing": "swing",
		"hideEasing": "linear",
		"showMethod": "fadeIn",
		"hideMethod": "fadeOut"
	}
</script>

<!-- 공통 알람 성정 -->
<c:if test="${!empty message }">
<script type="text/javascript">
	$(function () {
		Swal.fire("${message}");
		<c:remove var="message" scope="request"/>
		<c:remove var="message" scope="session"/>	
	})
</script>
</c:if>

<!-- 파일 다운로드 설정 -->
<script type="text/javascript">
function fileDownload(fileNo, fileName) {
	
	if(fileNo == null || fileNo == 0){
		return;
	}
	
	var downloadTag = document.createElement("a");
	downloadTag.href = "/DYUniv/fileDownload/" + fileNo;

	downloadTag.download = fileName;
	downloadTag.click();
}

</script>

<body class="hold-transition light-skin sidebar-mini theme-primary fixed">

	<div class="wrapper">

		<div id="loader"></div>
		<!-- header(nav) 영역 -->
		<tiles:insertAttribute name="header" />

		<!-- sideBar 영역 -->
		<tiles:insertAttribute name="side" />

		<div class="content-wrapper">
			<!-- content 영역 -->
			<tiles:insertAttribute name="content" />
		</div>

		<!-- footer 영역 -->
		<tiles:insertAttribute name="footer" />

		<!-- chat 영역 -->
		<tiles:insertAttribute name="chat" />

	</div>

</body>
<!-- 스크립트 -->
<!-- Vendor JS -->
<script src="${pageContext.request.contextPath}/resources/js/vendors.min.js"></script>

<script src="${pageContext.request.contextPath}/resources/assets/icons/feather-icons/feather.min.js"></script>

<script src="${pageContext.request.contextPath}/resources/assets/vendor_components/moment/min/moment.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js"></script>


<!-- EduAdmin App -->
<script src="${pageContext.request.contextPath}/resources/js/template.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/pages/calendar.js"></script>
</html>
