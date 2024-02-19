<!-- 학생 텍스트 채팅방 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>

<style>
.box {
	overflow: hidden;
}
.boxParent {
	padding: 1.5rem;
	justify-content: space-around;
}

.content {
	position: relative;
}

#listBtn {
	position: absolute;
	top: -25px;
	right: 53px;
}
</style>

<div class="container-full">
	<div class="content-header">
		<div class="d-flex align-items-center">
			<div class="me-auto">
				<h3 class="page-title">상담(채팅)</h3>
				<div class="d-inline-block align-items-center">
					<nav>
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="#"><i
									class="mdi mdi-home-outline"></i></a></li>
							<li class="breadcrumb-item" aria-current="page">기타</li>
							<li class="breadcrumb-item" aria-current="page">상담</li>
							<li class="breadcrumb-item" aria-current="page">상담 예약 목록</li>
							<li class="breadcrumb-item active" aria-current="page">상담(채팅)</li>
						</ol>
					</nav>
				</div>
			</div>

		</div>
	</div>
	<!-- 페이지 컨텐츠 -->
	<section class="content">
		<!-- 에러메시지 -->
		<c:if test="${not empty error}">
			<div class="alert alert-danger" role="alert">${error}</div>
		</c:if>

		<!-- 뒤로가기(목록) 버튼 -->
		<button type="button" class="btn btn-primary" id="listBtn"  >목록</button>

		<div class="row boxParent">
			<div class="box b-1 border-secondary" style="width: 63%">
				<div class="box-body" style="height: 520px; overflow-y: auto;"
					id="chatBox">
					<div class=".direct-chat-messages" id="chatContent">
						<c:if test="${not empty recordList }">
							<c:forEach items="${recordList }" var="record">
								<c:if test="${member.memNo ne record.memNo }">
									<div class="card d-inline-block mb-3 float-start me-2 no-shadow bg-lighter max-w-p80 min-w-300">
										<div class="position-absolute pt-1 pe-2 r-0">
											<span class="text-extra-small text-muted">${record.chatDate }</span>
										</div>
										<div class="card-body">
											<div class="d-flex flex-row pb-2">
												<div class="d-flex flex-grow-1 min-width-zero">
													<div
														class="m-2 ps-0 align-self-center d-flex flex-column flex-lg-row justify-content-between">
														<div class="min-width-zero">
															<p class="mb-0 fs-16 text-dark">${record.chatSender }</p>
														</div>
													</div>
												</div>
											</div>
											<div class="chat-text-start ps-55">
												<p class="mb-0 text-semi-muted">${record.chatMsg }</p>
											</div>
										</div>
									</div>
								</c:if>
								<c:if test="${member.memNo eq record.memNo }">
									<div
										class="card d-inline-block mb-3 float-end me-2 bg-primary max-w-p80 min-w-300">
										<div class="position-absolute pt-1 pe-2 r-0">
											<span class="text-extra-small text-muted">${record.chatDate }</span>
										</div>
										<div class="card-body">
											<div class="d-flex flex-row pb-2">
												<div class="d-flex flex-grow-1 min-width-zero">
													<div
														class="m-2 ps-0 align-self-center d-flex flex-column flex-lg-row justify-content-between">
														<div class="min-width-zero">
															<p class="mb-0 fs-16">${record.chatSender }</p>
														</div>
													</div>
												</div>
											</div>
											<div class="chat-text-start ps-55">
												<p class="mb-0 text-semi-muted">${record.chatMsg }</p>
											</div>
										</div>
									</div>
								</c:if>
								<div class="clearfix"></div>
							</c:forEach>
						</c:if>
					</div>
				</div>
				<div class="box-footer">
					<div
						class="d-md-flex d-block justify-content-between align-items-center bg-white p-5 rounded10 b-1 overflow-hidden">
						<input class="form-control b-0 py-10" type="text"
							placeholder="메시지 입력" id="msg">
						<div
							class="d-flex justify-content-between align-items-center mt-md-0 mt-30">
							<button type="button"
								class="waves-effect waves-circle btn btn-circle btn-primary"
								id="sendBtn">
								<i class="mdi mdi-send"></i>
							</button>
						</div>
					</div>
				</div>
			</div>
			<div class="box" style="width: 33%">
				<div class="box-header with-border">
					<h4 class="box-title">상담 정보</h4>
				</div>
				<div class="box-body">
					<div class="table-responsive">
						<table class="table mb-0">
							<tbody id="cnslInfo" idx="${counselVO.cnslNo }">
								<tr>
									<th scope="col">상담 교수명</th>
									<td>${CounselMember.memName }</td>
								</tr>
								<tr>
									<th scope="col">신청일</th>
									<%-- <td>${counselVO.cnslRegDate }</td> --%>
									<td id="cnslRegDate"></td>
								</tr>
								<tr>
									<th scope="col">상담일</th>
									<%-- <td>${counselVO.cnslStartDate }</td> --%>
									<td id="csnlDate"></td>
								</tr>
								<tr>
									<th scope="col">상담시간</th>
									<td id="csnlTime"></td>
								</tr>
								<tr>
									<th scope="row">신청 사항</th>
									<td>${counselVO.cnslReason }</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- <button onclick="test()">test</button> -->
</div>
<script src="${pageContext.request.contextPath}/resources/js/chat.js"></script>
<script>
	

$(function () {
	contentScroll();

	var sendBtn = $("#sendBtn");
	var chatContent = $("#chatContent");
	
	var memNo = parseInt("${member.memNo }");
	var memName = "${member.memName }";
	
	var counselDateArrStr = "${counselVO.cnslStartDate }";
	var counselDateArr = counselDateArrStr.split(" ");
	var counselEndDateArrStr = "${counselVO.cnslEndDate }";
	var counselEndDateArr = counselEndDateArrStr.split(" ");
	
	var csnlDate = document.querySelector("#csnlDate");
	var csnlTime = document.querySelector("#csnlTime");
	
	csnlDate.innerHTML = counselDateArr[0];
	csnlTime.innerHTML = counselDateArr[1].substring(0,5) + " ~ " + counselEndDateArr[1].substring(0,5);
	
	var cnslRegDateStr = "${counselVO.cnslRegDate}";
	var cnslRegDate = document.querySelector("#cnslRegDate");
	
	cnslRegDate.innerHTML = cnslRegDateStr.substring(0,10);
	
	var sock = new SockJS("/counsel");

	sock.onopen = function(){
		console.log("연결완료");
		
		var chatMsg = memName + "님이 입장하셨습니다.";
		
		data = {
				"chatMsg" : chatMsg,
				"resString" : "open"
		}
		
		sock.send(JSON.stringify(data));
	}

	sock.onmessage = function(res){
		var data = JSON.parse(res.data);
		//console.log(data);
		
		if(data.resString == 'FAILED'){
			Swal.fire({
				icon: "error",
				text: "전송에 실패하였습니다.",
			});
			return;
		}
		
		var code = "";
		
		if(data.resString == "open" || data.resString == "close"){
			code =                                                                                                       
				'<div class="col-12 text-center card d-inline-block mb-3 float-start me-2 no-shadow" style="padding: 0.5rem;">   '
				+ data.chatMsg
			  	+'</div>                                                                                                   '
			  	+'<div class="clearfix"></div>'
			chatContent.append(code);
		  	contentScroll();
		  	
		  	return;
		}
		
		if(memNo != data.memNo){
			code +=                                                                                                          
				'<div class="card d-inline-block mb-3 float-start me-2 no-shadow bg-lighter max-w-p80 min-w-300  animated fadeIn">   '
				+'<div class="position-absolute pt-1 pe-2 r-0">                                                            '
				+'	<span class="text-extra-small text-muted">'+ dateFormat(new Date).substr(0,10) + '</span>                          '
				+'</div>                                                                                                   '
				+'<div class="card-body">                                                                                  '
				+'	<div class="d-flex flex-row pb-2">                                                                     '
				+'		<div class="d-flex flex-grow-1 min-width-zero">                                                    '
				+'			<div class="m-2 ps-0 align-self-center d-flex flex-column flex-lg-row justify-content-between">'
				+'				<div class="min-width-zero">                                                               '
				+'					<p class="mb-0 fs-16 text-dark">'+ data.chatSender +'</p>                            '
				+'				</div>                                                                                     '
				+'			</div>                                                                                         '
				+'		</div>                                                                                             '
				+'	</div>                                                                                                 '
				+'	<div class="chat-text-start ps-55">                                                                    '
				+'		<p class="mb-0 text-semi-muted">'+ data.chatMsg +'</p>     '
				+'	</div>                                                                                                 '
				+'</div>                                                                                                   '
			  	+'</div>                                                                                                   '
			  	+'<div class="clearfix"></div>                                                                              '
		
		} else {
			code +=
				'<div class="card d-inline-block mb-3 float-end me-2 bg-primary max-w-p80 min-w-300  animated fadeIn">           '
				+'	<div class="position-absolute pt-1 pe-2 r-0">                                                               '
				+'		<span class="text-extra-small">'+ dateFormat(new Date).substr(0,10) + '</span>                                     '
				+'	</div>                                                                                                      '
				+'	<div class="card-body">                                                                                     '
				+'		<div class="d-flex flex-row pb-2">                                                                      '
				+'			<div class="d-flex flex-grow-1 min-width-zero">                                                     '
				+'				<div class="m-2 ps-0 align-self-center d-flex flex-column flex-lg-row justify-content-between"> '
				+'					<div class="min-width-zero">                                                                '
				+'						<p class="mb-0 fs-16">'+ data.chatSender +'</p>                                        '
				+'					</div>                                                                                      '
				+'				</div>                                                                                          '
				+'			</div>                                                                                              '
				+'		</div>                                                                                                  '
				+'		<div class="chat-text-start ps-55">                                                                     '
				+'			<p class="mb-0 text-semi-muted">'+ data.chatMsg +'</p>                               '
				+'		</div>                                                                                                  '
				+'	</div>                                                                                                      '
				+'  </div>                                                                                                      '
				+'  <div class="clearfix"></div>                                                                                '
		}
		
	  	chatContent.append(code);
	  	contentScroll();
	}

	sock.onclose = function(){
		console.log("연결 종료");
		var chatMsg = memName + "님이 퇴장하셨습니다.";
		
		data = {
				"chatMsg" : chatMsg,
				"resString" : "close"
		}
		
		sock.send(JSON.stringify(data));
	}
	
	//메시지 전송
	sendBtn.on("click", function () {
		console.log("send");
		
		var msg = $("#msg").val();
		
		if(msg == null || msg == ""){
			return false;
		}
		
		console.log("msg : " + msg)
		
		$("#msg").val("");
		
		data = {
				"chatMsg" : msg
		}
		
		sock.send(JSON.stringify(data));
	})
	
	$("#msg").keypress(function (e) {
        if (e.keyCode === 13) {
        	sendBtn.trigger("click");
        }
    });
	

});

document.querySelector("#listBtn").addEventListener("click", function() {
    //console.log("f_list check!!");
    let confirmation = confirm("채팅을 종료하고 목록으로 돌아가시겠습니까?");
    if (confirmation) {
        location.href = "/DYUniv/counsel/counselList.do";
    } else {
        return;
    }
});
</script>




