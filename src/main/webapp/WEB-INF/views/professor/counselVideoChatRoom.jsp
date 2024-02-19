<!-- 교수 화상 채팅방 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
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

/*  */
#notification {
	position: absolute;
	z-index: 1;
	text-align: center;
	color: #fff;
	margin: 0;
	top: 47.33px;
	font-size: 18pt;
	width: 100%;
	background-color: orange;
}

#remote-video {
	height : 100%;
	width: 100%;
	object-fit: cover;
	background-color: #ccc;
	border: 1px solid #ccc;
	border-radius: 10px; 
}

#local-video {
	position: absolute;
	top: 45px;
    left: 45px;
	width: 300px;
	height: 150px;
	object-fit: cover;
	z-index: 1;
	background-color: #444444;
	border-radius: 10px; 
	border: 1px solid #444;
}

#stopBtn {
	position: absolute;
	bottom: 40px;
	right: 40px;
}

#startBtn {
	position: absolute;
	bottom: 40px;
	right: 100px;
}
</style>

<div class="container-full">
	<!-- 페이지 헤더 -->
	<div class="content-header">
		<div class="d-flex align-items-center">
			<div class="me-auto">
				<h3 class="page-title">상담(화상)</h3>
				<div class="d-inline-block align-items-center">
					<nav>
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="#"><i class="mdi mdi-home-outline"></i></a></li>
							<li class="breadcrumb-item" aria-current="page">상담 관리</li>
							<li class="breadcrumb-item" aria-current="page">상담 신청 내역</li>
							<li class="breadcrumb-item active" aria-current="page">상담(화상)</li>
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
		    <div class="alert alert-danger" role="alert">
		        ${error}
		    </div>
		</c:if>
	
		<!-- 뒤로가기(목록) 버튼 -->
		<button type="button" class="btn btn-primary" id="listBtn">목록</button>

		<div class="row boxParent">
			<div class="box b-1 border-secondary" style="width: 63%">
				<div class="box-body" style="height: 618px; overflow-y: hidden;">
					<!-- 채팅 방 id -->
					<input id="room-input" class="room-input" type="hidden" value="${chatRoomNo }">
					
					<!-- 화상채팅 영역 -->
					<!-- Remote Video Element-->
					<video id="remote-video"></video>
					<!-- Local Video Element-->
					<video id="local-video"></video>
					
					<button type="button" class="btn btn-success btn-circle"
						id="startBtn" onclick="createRoom()">
						<i class="mdi mdi-phone"></i>
					</button>
					<button type="button" class="btn btn-danger btn-circle"
						id="stopBtn" onclick="leaveRoom()">
						<i class="mdi mdi-phone-hangup"></i>
					</button>
					
				</div>
			</div>
			<div class="box" style="width: 33%">
				<form action="/DYUniv/counsel/updateCnslDetail" method="post" id="updateCounselCont">
					<input type="hidden" name="cnslNo" value="${counselVO.cnslNo }">
					<div class="box-header with-border">
						<h4 class="box-title">상담 학생 인적 사항</h4>
					</div>
					<div class="box-body">
						<div class="table-responsive">
							<table class="table mb-0">
								<tbody>
									<tr>
										<th scope="col">이름</th>
										<td>${CounselMember.memName }</td>
									</tr>
									<tr>
										<th scope="row">신청일</th>
										<td>${fn:substring(counselVO.cnslRegDate, 0, 10) }</td>
									</tr>
									<tr>
										<th scope="row">상담일</th>
										<td>${fn:substring(counselVO.cnslStartDate, 0, 10) }</td>
									</tr>
									<tr>
										<th scope="row">상담시간</th>
										<td>${fn:substring(counselVO.cnslStartDate, 11, 16) } ~ ${fn:substring(counselVO.cnslEndDate, 11, 16) }</td>
									</tr>
									<tr>
										<th scope="row">신청사항</th>
										<td colspan="2">${counselVO.cnslReason }</td>
									</tr>
									<tr style="border-bottom: 1px solid rgba(255, 255, 255, 0);">
										<th scope="row">상담 내용</th>
										<td><textarea placeholder="저장 전 반드시 작성해주세요."
												style="width: 100%; height: 195px; overflow: hidden; padding: 0.5rem;" name="cnslDetail" id="cnslDetail"></textarea>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="box-footer">
						<button type="button" class="btn btn-primary-light float-end" id="cnslUpdateBtn" onclick="f_cnslUpdate()">상담 내용 저장</button>
					</div>
				</form>
			</div>
		</div>
	</section>
</div>

<script src="https://unpkg.com/peerjs@1.5.2/dist/peerjs.min.js"></script>
<script type="text/javascript">
	const PRE = "DELTA"
	const SUF = "MEET"
	var room_id;
	var getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia;
	var local_stream;
	var screenStream;
	var peer = null;
	var currentPeer = null;
	var screenSharing = false;

	console.log("id 확인 : ", document.getElementById("room-input").value);
	
	function createRoom() {
	    console.log("Creating Room")
	   	let room = document.getElementById("room-input").value;
	    if (room == " " || room == "") {
	    	alert("상담 입장에 실패했습니다. 다시 입장해주십시오.");
	    	location.href = "/DYUniv/counsel/counselList.do";
	    }
	    room_id = PRE + room + SUF;
	    peer = new Peer(room_id);
	    peer.on('open', (id) => {
	        console.log("Peer Connected with ID: ", id)
	        getUserMedia({ video: true, audio: true }, (stream) => {
	            local_stream = stream;
	            setLocalStream(local_stream)
	        }, (err) => {
	            console.log(err)
	        })
	    })
	    peer.on('call', (call) => {
	        call.answer(local_stream);
	        call.on('stream', (stream) => {
	            setRemoteStream(stream)
	        })
	        currentPeer = call;
	    })
	}

	function setLocalStream(stream) {
	    let video = document.getElementById("local-video");
	    video.srcObject = stream;
	    video.muted = true;
	    video.play();
	}
	
	function setRemoteStream(stream) {
	    let video = document.getElementById("remote-video");
	    video.srcObject = stream;
	    video.play();
	}

	function leaveRoom(){
		console.log("Leaving Room");
		if (peer) {
			local_stream.getVideoTracks()[0].stop();
		}
	}
	
	document.querySelector("#listBtn").addEventListener("click", function() {
        let confirmation = confirm("채팅을 종료하고 목록으로 돌아가시겠습니까?");
        if (confirmation) {
            leaveRoom();
            location.href = "/DYUniv/counsel/counselList.do";
        } else {
        	return;
        }
	});

	function f_cnslUpdate(){
		var cnslDetailVal = document.querySelector("#cnslDetail").value;
		let confirmation = confirm("상담을 마치고 목록으로 돌아가시겠습니까?");
		
		if(confirmation){
			if(cnslDetailVal == "" || cnslDetailVal == null){
				Swal.fire({
					  icon: "error",
					  text: "저장 전에 상담내용을 작성해 주십시오.",
					});
			} else {
				document.querySelector("#updateCounselCont").submit();
			}
		} else {
			return;
		}
	}
</script>