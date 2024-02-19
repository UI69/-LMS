<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>     
    
 <div class="container-full">
<!-- Content Header (Page header) -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<div class="content-header">
	<div class="d-flex align-items-center">
		<div class="me-auto">
				<h3 class="page-title"><a href="/DYUniv/anonymouseBoard.do">대나무 숲</a></h3>
				<div class="d-inline-block align-items-center">
					<nav>
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="/DYUniv/anonymouseBoard.do"><i
									class="mdi mdi-home-outline"></i>게시판 사용</a></li>
							<li class="breadcrumb-item" aria-current="page">대나무 숲 (상세보기)</li>
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
					<!-- Default box -->
					<div class="box">
						<div class="row box-header with-border">
							<div class="col-7">
								<h4 class="box-title">
									<a
										href="<c:url value="/DYUniv/anoyBoardDetail.do?anonBrdNo=${anonyVO.anonBrdNo}" />">${anonyVO.anonBrdTitle}</a>
								</h4>
							</div>
							<div class="col-md-3 col-lg-12 text-end">
								<b>날짜:</b> &nbsp&nbsp ${anonyVO.anonWriteDate }&nbsp&nbsp&nbsp <b>조회수:</b>
								&nbsp&nbsp ${anonyVO.anonHitCount }
							</div>
						</div>
					</div>

					<div class="box-body">

						<div>
							내용 : ${anonyVO.anonBrdCont }
						</div>
						
						

					</div>
					
					<div class="box-body" align="right">
						<hr>
						
						<div class="d-inline-block pull-right mt-10">
							<form id="delForm" action="/DYUniv/anonymousDelete.do"
								method="post" class="">
								<input type="hidden" name="anonBrdNo"
									value="${anonyVO.anonBrdNo }" />
								<c:if test="${ anonyVO.memNo eq member.memNo }">
									<button type="button"
									class="waves-effect waves-light btn btn-primary mb-5"
									id="deleteBtn">삭제</button>
								</c:if>
								<button type="button"
									class="waves-effect waves-light btn btn-primary mb-5"
									id="listBtn">목록</button>
							</form>
						</div>

					</div>
					<!-- /.box-body -->
					<div class="box-footer" >
						<!-- 댓글 목록 -->
						<c:set value="${anonyVO.lastWriter + 1 }" var="rpWriter"/>
						
						<div id="commentList">
							<!-- 댓글들이 여기에 추가됩니다. -->
							<c:if test="${!empty replyList }">
								<c:forEach items="${replyList }" var="reply">
									<div class="row" >
										<div class="col-2">익명 ${reply.anonRpWriter }<hr></div>
										<div class="col-6">${reply.anonRpCont }<hr></div>
										<div class="col-2">${fn:substring(reply.anonRpWriteDate,0, 10) } <hr></div>
										
										<c:if test="${reply.memNo eq member.memNo }">
											<div class="col-2"><button class="btn btn-xs btn-secondary replyDelBtn" idx="${reply.anonRpNo }">삭제</button></div>
										</c:if>
										
									</div>
									
									<c:if test="${reply.memNo eq member.memNo }">
										<c:set value="${reply.anonRpWriter }" var="rpWriter"/>
									</c:if>
								</c:forEach>
							</c:if>
						</div>

						<!-- 댓글 입력 폼 -->
						<div id="commentForm">
							<form action="/DYUniv/addComment" method="post">
								<input type="hidden" name="anonBrdNo" value="${anonyVO.anonBrdNo }" />
								<input type="hidden" name="memNo" value="${member.memNo }" />
								<input type="hidden" name="anonRpWriter" value="${rpWriter }" />
								<textarea name="anonRpCont" placeholder="댓글을 입력하세요." class="form-control"></textarea>
								<div class="text-end"><button type="submit" class="btn btn-primary-light">댓글 작성</button></div>
							</form>
						</div>
					</div>
					<!-- /.box-footer-->
				</div>
				<!-- /.box -->
			</div>
		</div>
		
		<form action="/DYUniv/anonymousDelete.do" method="post" id="anonDelForm">
			<input type="hidden" value="${anonyVO.anonBrdNo }" name="anonBrdNo">
		</form>
		<form action="/DYUniv/deleteComment.do" method="post" id="anonReplyDelForm">
			<input type="hidden" value="" name="anonRpNo" id="anonRpNo">
			<input type="hidden" value="${anonyVO.anonBrdNo }" name="anonBrdNo">
		</form>
	
		</div>
	</section>
</div>

<!-- <script>
var brdNo = ${anonyVO.anonBrdNo};  // 서버에서 렌더링하는 시점에 brdNo 값을 설정

$(document).ready(function() {
    // 페이지 로드 시 댓글 불러오기
    loadComments();

    // 댓글 작성 폼 제출 이벤트 처리
    $('#commentForm form').on('submit', function(e) {
        e.preventDefault();
        $.post('/addComment', $(this).serialize(), function() {
            loadComments();
        });
    });
});

function loadComments() {
    $.get('/getComments', { brdNo: brdNo }, function(comments) {  // brdNo 변수 사용
        var commentList = $('#commentList');
        commentList.empty();
        comments.forEach(function(comment) {
            commentList.append('<div>' + comment.content + '</div>');
        });
    });
}
</script>
 -->

<script>
var brdNo = ${anonyVO.anonBrdNo};
var anonReplyDelForm = $("#anonReplyDelForm");

$("#listBtn").on("click", function () {
	location.href="/DYUniv/anonymouseBoard.do";
})

$("#deleteBtn").on("click", function () {
	console.log("del");
	if(confirm("정말 삭제하시겠습니까?")){
		$("#anonDelForm").submit();
	}
})

$(".replyDelBtn").on("click", function () {
	console.log($(this).attr("idx"));
	$("#anonRpNo").val($(this).attr("idx"));
	anonReplyDelForm.submit();
})

$(document).on('click', '.edit-button', function() {
    var commentDiv = $(this).parent();
    var rpNo = commentDiv.data('rpNo');
    var newContent = prompt('새로운 댓글 내용을 입력하세요.');
    if (newContent) {
        $.post('/updateComment', { rpNo: rpNo, content: newContent }, function() {
            loadComments();
        });
    }
});

$(document).on('click', '.delete-button', function() {
    var commentDiv = $(this).parent();
    var rpNo = commentDiv.data('rpNo');
    $.post('/deleteComment', { rpNo: rpNo }, function() {
        loadComments();
    });
});
</script>
