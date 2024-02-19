<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="sec"%>

<style>
.childInline>* {
	display: inline-block;
}

.cke_chrome {
	border: 1px solid #2b579a;
	box-shadow: 0 0 3px 1px rgba(172, 181, 194, 0.56);
}

#brdTitle {
	border-color: #2b579a;
	box-shadow: 0 0 3px 1px rgba(172, 181, 194, 0.56);
}

.cke_top {
	border-bottom: 1px solid #eee;
	background: #fff;
}

.cke_bottom {
	border-top: 1px solid #2b579a;
	background: #2b579a;
}

#cke_1_contents {
	min-height: 295px;
	overflow: auto;
}

section p {
	width: 65px;
	text-align: center;
	margin-top: 1rem;
	font-weight: bold;
	font-size: 15px;
}

.btn-xs {
	height: 23px;
	width: 22px;
	border-radius: 50px;
	margin-left: 20px;
}

.fileList li {
	margin-bottom: 7px;
}
</style>

<c:set value="등록" var="name" />
<c:if test="${status eq 'u' }">
	<c:set value="수정" var="name" />
</c:if>

<div class="container-full">
	<div class="content-header">
		<div class="d-flex align-items-center">
			<div class="me-auto">
				<h3 class="page-title">공지사항 ${name}</h3>
				<div class="d-inline-block align-items-center">
					<nav>
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="#"><i
									class="mdi mdi-home-outline"></i></a></li>
							<li class="breadcrumb-item" aria-current="page">기타</li>
							<li class="breadcrumb-item active" aria-current="page">공지사항</li>
							<li class="breadcrumb-item active" aria-current="page">공지사항
								상세</li>
						</ol>
					</nav>
				</div>
			</div>
		</div>
	</div>
	<!-- Main content -->
	<section class="content">
		<div class="row">
			<div class="col-12">
				<div class="box">
					<div class="box-body">
						<form action="/DYUniv/noticeBoardCreate.do" method="post" id="noticeForm">
							<c:if test="${status eq 'u' }">
								<input type="hidden" name="brdNo" value="${notice.brdNo }" />
							</c:if>
							<p class="text-primary">제목</p>
							<input type="text" name="brdTitle" id="brdTitle"
								class="form-control" placeholder="제목을 입력하세요."
								value="${notice.brdTitle }">
							<p class="text-primary">내용</p>
							<textarea id="brdCont" name="brdCont" rows="10" cols="80"
								placeholder="내용을 입력하세요.">${notice.brdCont }
							</textarea>
						</form>
					</div>
					<div class="box-footer" style="padding: 1rem;">
						<c:if test="${status eq 'u' }">
							<c:if test="${not empty notice.fileList }">
								<p class="text-primary">첨부파일</p>
								<ul class="fileList">
									<c:forEach items="${notice.fileList }" var="noticeFile">
										<li>
											<span>${noticeFile.fileName }</span>&emsp;
											<span class="text-mute">${noticeFile.fileSize }</span>
											<button class="btn btn-danger btn-xs attachmentFileDel" id="delete_${noticeFile.fileNo }">-</button>
										</li>
									</c:forEach>
								</ul>
							</c:if>
						</c:if>

						<div class="childInline" style="float: right;">
							<button type="button" class="btn btn-warning" id="listBtn">취소</button>
							<button type="button" class="btn btn-primary" id="createNotice">${name }</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/assets/vendor_components/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
	CKEDITOR.replace( 'brdCont', {
		filebrowserUploadUrl : '/DYUniv/imageUpload.do?${_csrf.parameterName}=${_csrf.token}'
	});

	var createNotice = $("#createNotice");
	var noticeForm = $("#noticeForm");
	var name = "${name}"

	// 목록
	$("#listBtn").on("click", function() {
		location.href = "/DYUniv/noticeBoard.do";
	});

	createNotice.on("click", function() {
		var brdTitle = $("#brdTitle").val();
		var brdCont = CKEDITOR.instances.brdCont.getData();

		if (brdTitle == null || brdTitle == "") {
			alert("제목을 입력해주세요 !");
			$("#brdTitle").focus();
			return false;
		}
		if (brdCont == null || brdCont == "") {
			alert("내용을 입력해주세요 !");
			$("#brdCont").focus();
			return false;
		}

		if (name == '수정') {
			noticeForm.attr("action", "/DYUniv/noticeBoardModify.do");
		}

		noticeForm.submit();
	});
	
	$(".attachmentFileDel").on("click", function(){
		var id = $(this).prop("id");
		var idx = id.indexOf("_");
		var noticeFileNo = id.substring(idx + 1);
		var ptrn = "<input type='hidden' name='delNoticeNo' value='%V' />";
		$("#noticeForm").append(ptrn.replace("%V", noticeFileNo));
		$(this).parents("li:first").hide();
	});
</script>