<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container-full" id="srvView">

	<!-- Content Header (Page header) -->
	<div class="content-header">
		<div class="d-flex align-items-center">
			<div class="me-auto">
				<h3 class="page-title">설문조사 </h3>
				<div class="d-inline-block align-items-center">
					<nav>
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="#"><i class="mdi mdi-home-outline"></i></a>
							</li>
							<li class="breadcrumb-item" aria-current="page">설문조사 조회 </li>
							<li class="breadcrumb-item active" aria-current="page">설문조사 목록</li>
						</ol>
					</nav>
				</div>
			</div>
		</div>
	</div>



	<section class="content">
		<div class="col-12">
			<div class="box">
			</div>
		</div>


		<div class="col-10">
			<div class="col-12 row text-center">
				<h1>${surveyVO.srvName } </h1>
				<div class="col-4">
					<h4></h4>
				</div>
				<div class="col-4"></div>
				<div class="col-4">
					<h4></h4>
				</div>
			</div>


			<div class="col-12">
				<form action="#" method="post" id="insertForm">

					<c:forEach items="${surveyVO.srvQstList }" var="qst">
						<div class="box container examQst" idx="${qst.qstNo }">
							<div class="row box-header with-border" style="display: flex;">

								<div class="col-1">
									<h4>${qst.qstNo }.</h4>
								</div>
								<div class="col-10">
									<h4 class="box-title">${qst.srvQst }</h4>
								</div>
								<div class="col-1">
									<h4></h4>
								</div>

							</div>
							<div class="box-body p-0">
								<div class="media-list media-list-hover media-list-divided text-center">

								</div>
							</div>
							<div class="row box-footer bt-1 border-light p-10">

								<c:forEach items="${qst.srvQstChList }" var="choice">
									<div class="col-10 answerStr">
										<a class="media media-single qstCh p-0" href="#"
											idx="qst${qst.qstNo }-${choice.chNo}">
											<div class="col">
												<h5>(${choice.chNo}).</h5>
											</div>
											<div class="col-10">
												<h5>${choice.chStr }</h5>
											</div>
											<div class="col"></div>
										</a>
									</div>
									<div class="col-2 answer">
										<font style="text-align: center;">
											<input type="radio" name="qst${qst.qstNo }" idq="${qst.srvQstNo }"
												idc="${choice.chNo}" id="qst${qst.qstNo }-${choice.chNo}">
											<label for="qst${qst.qstNo }-${choice.chNo}"
												class="h-20 p-10 mb-0"></label>
										</font>
									</div>
								</c:forEach>
							</div>
						</div>
					</c:forEach>

				</form>
				<div class="text-end">
					<button id="testBtn" name="delBtn" class="btn btn-danger-light">테스트 </button>
					<button type="button" id="surSubmit" name="surSubmit"
						class="btn btn-primary-light">제출</button>

				</div>

			</div>
		</div>
	</section>
</div>

<script>

	$(function () {
		var surSubmit = $("#surSubmit");
		var srvNo = parseInt("${surveyVO.srvNo}");

		var suryAnswer = [];

		$("#testBtn").on("click", function () {
			var surveyList = $("#insertForm").find(".examQst");
			for (var i = 0; i < surveyList.length; i++) {
				var rd = $(surveyList[i]).find("label");
				var t = Math.floor(Math.random() * rd.length);
				//console.log(t, rd[t]);
				$(rd[t]).trigger("click");
			}
			
			chatUl = document.querySelector('#srvView');
			chatUl.scrollTop = chatUl.scrollHeight;
			
		})

		surSubmit.on("click", function () {
			var suryAnswer = [];
			var surveyList = $("#insertForm").find(".examQst");

			for (var i = 0; i < surveyList.length; i++) {
				var qstNo = $(surveyList[i]).attr("idx");
				var select = $(surveyList[i]).find("input:checked");
				console.log($(select).attr("idq"), $(select).attr("idc"));
				var data = {
					"srvQstNo": $(select).attr("idq"),
					"svrResAns": $(select).attr("idc"),
					"srvNo": srvNo
				}
				suryAnswer.push(data);
			}

			console.log("suryAnswer", suryAnswer);

			$.ajax({
				type: "post",
				url: "/DYUniv/suryAnswerForm.do",
				contentType: "application/json; charset=utf-8",
				data: JSON.stringify(suryAnswer),
				success: function (res) {
					console.log(res);

					if (res == "OK") {
						location.href = "/DYUniv/surveyList.do";
					} else {
						// alert("일치하는 정보가 없습니다...")
						Swal.fire({
							icon: 'error',
							title: '업로드 실패...',
							text: '',
						});
					}
				}

			});

		});

		$(".qstCh").on("click", function () {
			console.log($(this).attr("idx"));
			var idx = $(this).attr("idx");
			$("#" + idx).trigger("click");
		});
	});
</script>