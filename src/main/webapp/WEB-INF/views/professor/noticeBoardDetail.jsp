<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="sec" %>

<style>
.childInline > * {
	display: inline-block;
}
th {
	text-align: center;
	width: 20%;
}
tr {
    border-top: 1px solid rgba(72, 94, 144, 0.382);
    border-bottom: 1px solid rgba(72, 94, 144, 0.382);
}
</style>
<div class="container-full">
	<!-- Content Header (Page header) -->
	<div class="content-header">
		<div class="d-flex align-items-center">
			<div class="me-auto">
				<h3 class="page-title">공지사항 상세 게시글</h3>
				<div class="d-inline-block align-items-center">
					<nav>
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="#"><i
									class="mdi mdi-home-outline"></i></a></li>
							<li class="breadcrumb-item" aria-current="page">기타</li>
							<li class="breadcrumb-item active" aria-current="page">공지사항</li>
							<li class="breadcrumb-item active" aria-current="page">공지사항 상세</li>
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
				<div class="box"  style="min-height: 660px;">
					<div class="box-header with-border" style="padding: 1.7rem;">
						<h4 class="box-title text-primary">${boardVO.brdTitle }</h4>
						<div style="display:flex; float: right;">
							<p style="margin: 0">등록일&emsp;|&emsp;</p><span>${boardVO.writeDate }</span> 
							<p style="margin-left: 30px; margin-bottom: 0;">조회수&emsp;|&emsp;</p><span>${boardVO.brdHitCount }</span>
						</div>
					</div>
					<div class="box-body" style="max-height: 500px; overflow: auto;">
						<c:if test="${boardVO.fileNo ne '' }">
							<div>
								<span class="text-primary">첨부파일&emsp;|&emsp;</span>
								<span></span><!-- 파일이름 넣을 예정... -->
								<span><button type="button" class="btn btn-sm btn-light">다운로드</button> </span>
								<hr style="color: rgba(72, 94, 144, 0.382);">
							</div>
						</c:if>
						<div class="text-dark " style="padding: 1.5rem;">
							${boardVO.brdCont }
						</div>
						<form action="/DYUniv/noticeBoardDelete.do" method="post" id="delForm">
							<input type="hidden" name="brdNo" value="${boardVO.brdNo }">
						</form>
					</div>
					<div class="box-footer">
						<div class="childInline" style="float: right;">
							<button type="button" class="btn btn-primary" id="listBtn">목록</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>
<script type="text/javascript">
// 목록
$("#listBtn").on("click", function(){
	location.href = "/DYUniv/noticeBoard.do";
});
</script>