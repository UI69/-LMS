<!-- 학생 화상 채팅방 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
							<li class="breadcrumb-item" aria-current="page">기타</li>
							<li class="breadcrumb-item" aria-current="page">상담</li>
							<li class="breadcrumb-item active" aria-current="page">상담 예약 내역</li>
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
				<div class="box-body" style="height: 615px; overflow-y: hidden;">
					<!-- 채팅 방 id -->
					<input id="room-input" class="room-input" type="hidden" value="${chatRoomNo }">
					
					<!-- 화상채팅 영역 -->
					<!-- Remote Video Element-->
					<video id="remote-video"></video>
					<!-- Local Video Element-->
					<video id="local-video"></video>
					
					<button type="button" class="btn btn-success btn-circle"
						id="startBtn" onclick="joinRoom()">
						<i class="mdi mdi-phone"></i>
					</button>
					<button type="button" class="btn btn-danger btn-circle"
						id="stopBtn" onclick="leaveRoom()">
						<i class="mdi mdi-phone-hangup"></i>
					</button>
					
				</div>
			</div>
			<div class="box" style="width: 33%">
					<div class="box-header with-border">
						<h4 class="box-title">상담 정보</h4>
					</div>
					<div class="box-body">
						<div class="table-responsive">
							<table class="table mb-0">
								<tbody>
									<tr>
										<th scope="col">상담 교수명</th>
										<td>${CounselMember.memName }</td>
									</tr>
									<tr>
										<th scope="row">신청일</th>
										<td id="cnslRegDate"></td>
									</tr>
									<tr>
										<th scope="row">상담일</th>
										<td id="csnlDate"></td>
									</tr>
									<tr>
										<th scope="col">상담시간</th>
										<td id="csnlTime"></td>
									</tr>
									<tr>
										<th scope="row">신청사항</th>
										<td colspan="2">${counselVO.cnslReason }</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
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
	
	$(function(){
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
	});

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

	function joinRoom() {
	    console.log("Joining Room");
	    let room = document.querySelector("#room-input").value;
	    if (room == " " || room == "") {
	        alert("교수님께서 아직 접속을 하지 않았습니다. 조금 기다렸다가 다시 눌러주세요.")
	        return;
	    }
	    room_id = PRE + room + SUF;
	    peer = new Peer();
	    peer.on('open', (id) => {
	        console.log("Connected with Id: " + id)
	        getUserMedia({ video: true, audio: true }, (stream) => {
	            local_stream = stream;
	            setLocalStream(local_stream)
	            let call = peer.call(room_id, stream)
	            call.on('stream', (stream) => {
	                setRemoteStream(stream);
	            })
	            currentPeer = call;
	        }, (err) => {
	            console.log(err)
	        })
	    })
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
	
</script>