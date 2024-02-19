<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="sec"%>

<div class="content-header mb-10">
	<div class="d-flex align-items-center">
		<div class="me-auto">
			<h3 class="page-title">성적 관리</h3>
			<div class="d-inline-block align-items-center">
				<nav>
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="#"><i
								class="mdi mdi-home-outline"></i></a></li>
						<li class="breadcrumb-item" aria-current="page">성적</li>
						<li class="breadcrumb-item" aria-current="page">성적 등록</li>
					</ol>
				</nav>
			</div>
		</div>
	</div>
</div>

<section class="content">
	<div class="row">
		<div class="col-12">
			<div class="box">
				<div class="box-body" style="border: 1px solid black;">
					&nbsp;&nbsp;&nbsp; 내 강의 목록
					<div class="p-15">
						<form id="searchForm">
							<div class="row" style="justify-content: space-between;">
								<div class="col-md-3">
									<div class="form-group" style="margin-top: 10px">
										<label class="form-label" style="margin-right: 10px;">이수
											구분</label> <select class="form-control" 
											style="width: 30%; display: inline-block;">
											<option selected="selected">전체</option>
											<c:forEach items="${myClassList }" var="cList">
												<option value="${cList.classReqStr }">${cList.classReqStr }</option>
											</c:forEach>
										</select>
									</div>
								</div>
								<div class="col-md-5">
									<div class="form-group" style="margin-top: 10px">
										<input type="hidden" name="page" id="page" /> <select
											class="form-control" name="searchType"
											style="width: 30%; display: inline-block;">
											<option selected="selected">전체</option>
											<option value="facRsvStartDate">강의명</option>
											<option value="buildingName">학점</option>
										</select> 
										<input type="text" name="searchWord" value="${searchWord }"
											class="form-control"
											style="width: 50%; display: inline-block;" placeholder="검색">
										<button type="submit" value="" class="btn btn-primary"
											style="padding: 5px 12px;">검색</button>
									</div>
								</div>
							</div>
						</form>
						<div class="table-responsive">
							<table class="table mb-0" style="text-align: center">
								<thead class="bg-primary">
									<tr>
										<th scope="col">순번</th>
										<th scope="col">학기</th>
										<th scope="col">강의명</th>
										<th scope="col">이수구분</th>
										<th scope="col">평가기준</th>
										<th scope="col">학점</th>
										<th scope="col">시험비율</th>
										<th scope="col">과제비율</th>
										<th scope="col">출석비율</th>
										<th scope="col">진행상태</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${empty myClassList }">
											<tr>
												<td colspan="7">조회하신 게시글이 존재하지 않습니다.</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:set var="index" value="${pagingVO.startRow + 1}" />
											<c:set var="index" value="${index - 1}" />
											<c:forEach items="${myClassList }" var="cList">
												<tr>
													<td class="index"><strong>${index }</strong></td>
													<td>${cList.semester }</td>
													<td onclick="classClick(this)" idx="${cList.classNo}" style="cursor : pointer; font-weight: bold;">${cList.className }</td>
													<td>${cList.classReqStr }</td>
													<td data-vt="${cList.classNo}">${cList.valueType }</td>
													<td>${cList.lecPoint }</td>
													<td id="examProprion" data-ep="${cList.classNo}">${cList.examProprion }%</td>
													<td id="hwPropotion" data-hp="${cList.classNo}">${cList.hwPropotion } %</td>
													<td id="atPropotion" data-ap="${cList.classNo}">${cList.atPropotion } %</td>
													<td <c:if test="${cList.classStatusStr eq '종료' }"> style="color:red;"</c:if>>${cList.classStatusStr }</td>
												</tr>
												<c:set var="index" value="${index + 1}" />
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
						</div>
						<div class="col-sm-12 col-md-6"
							style="float: right; margin-right: 80px; margin-top: 20px;">
							<div class="dataTables_paginate paging_simple_numbers"
								id="pagination">${pagingVO.pagingHTML }</div>
						</div>	
					</div>	
				</div>
			</div>
		</div>
	</div>	
	<hr/>
	<div class="row">
		<div class="col-12">
			<div class="box">
				<div class="box-body">
					<div class="p-10">
					&nbsp;&nbsp;&nbsp; 수강생 목록
					<button id="updateScore" value="" class="btn btn-primary"
								style="padding: 5px 12px; float:right;">일괄 저장</button>
					</div>
					<div class="p-15">
						<form id="searchForm">
							<div class="row" style="justify-content: space-between;">
							</div>
						</form>
						<div class="table-responsive">
							<table class="table mb-0" style="text-align: center">
								<thead class="bg-primary">
									<tr>
										<th scope="col" rowspan="2">순번</th>
										<th scope="col" rowspan="2">학번</th>
										<th scope="col" rowspan="2">이름</th>
										<th scope="col" rowspan="2">예비학점</th>
										<th scope="col" rowspan="2">시험</th>
										<th scope="col" rowspan="2">과제</th>
										<th scope="col" colspan="5">출석</th>
										<th scope="col" rowspan="2">총점</th>
										<th scope="col" rowspan="2">저장</th>
									</tr>
									<tr>
										<th scope="col">출석</th>
										<th scope="col">결석</th>
										<th scope="col">지각</th>
										<th scope="col">조퇴</th>
										<th scope="col">출석점수</th>
									</tr>
								</thead>
								<tbody id="scoreTable">
									<c:set var="index" value="${pagingVO.startRow + 1}" />
									<c:set var="index" value="${index - 1}" />
									<c:forEach items="${myClassList }" var="cList"/>
									<c:set var="index" value="${index + 1}" />
								</tbody>
							</table>
						</div>
						<div class="col-sm-12 col-md-6"
							style="float: right; margin-right: 80px; margin-top: 20px;">
							<div class="dataTables_paginate paging_simple_numbers"
								id="pagination">${pagingVO.pagingHTML }</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>	

<script type="text/javascript">
var scoreTable = $("#scoreTable");
var scoreList = [];

function classClick(pThis){	
	var classNo = $(pThis).attr("idx");
	
	var valueType = pThis.parentElement.querySelector('[data-vt="' + pThis.getAttribute('idx') + '"]').innerText;
	var vType = valueType.substring(0,2);
	
	var examProprion = pThis.parentElement.querySelector('[data-ep="' + pThis.getAttribute('idx') + '"]').innerText;
	var hwPropotion = pThis.parentElement.querySelector('[data-hp="' + pThis.getAttribute('idx') + '"]').innerText;
	var atPropotion = pThis.parentElement.querySelector('[data-ap="' + pThis.getAttribute('idx') + '"]').innerText;
	
	var exP = examProprion.replace('%', '');
	var hwP = hwPropotion.replace('%', '');
	var atP = atPropotion.replace('%', '');
	
	console.log("valueType", vType);
	console.log("examProprion", examProprion.replace('%', ''));		
	
//	setTimeout(() => {
	$.ajax({
		type:"get",
		url:"/DYUniv/professor/totalScore.ajax/"+classNo,
		dataType:"json",
		success: function(res){
			console.log("res", res);
			
			// 수강생 점수 출력
			scoreTable.empty();
			
			console.log(res.atScoreMap[0].ATS001);
			console.log(res.atScoreMap[0].ATS002);
			console.log(res.atScoreMap[0].ATS003);
			console.log(res.atScoreMap[0].ATS004);
			
			for(var i=0; i<res.listenerList.length; i++){
				var listenNo = res.listenerList[i].listenNo;
				var memId = res.listenerList[i].member.memId;	
				var memName = res.listenerList[i].member.memName;
				var examScore = 0;	// 개인별 시험 점수 합계
				if(res.examScoreList[i] != null){
					examScore = res.examScoreList[i].totalExamScore;
				}
				
				var hwScore = 0;			// 개인별 과제 점수 합계
				if(res.hwScoreList[i] != null){
					hwScore = res.hwScoreList[i].totalHwScore;	
				}
				
				var classWeekCnt = 1;	// 출석 기준점수
				if(res.examScoreList[0] != null && res.examScoreList[0].classVO != null){
					classWeekCnt = res.examScoreList[0].classVO.classWeekCnt;
				}
				var examStandardScore = 1;					// 시험 기준점수
				if(res.examStandardScore != null){
					examStandardScore = res.examStandardScore;
				}
				var hwStandardScore = 1;					// 과제 기준점수
				if(res.hwStandardScore != null && res.hwStandardScore != 0){
					hwStandardScore = res.hwStandardScore;
				}
				
				//console.log("t : ", exP, hwP, atP, classWeekCnt);
				//console.log("t1 ", examScore, hwScore, examStandardScore, hwStandardScore);
				
				var code =
					'<tr>'
					+	'<td class="index"><strong>' + (i+1) + '</strong></td><td class="mId">' + memId + '</td>'
					+	'<td>' + memName + '</td>'
					+	'<td><h5 class="box-subtitle"><code class="fScore">학점 넣기</code></h5></td>'
					+	'<td style="font-weight:bold;">' + examScore + '</td>'
					+	'<td style="font-weight:bold;">' + hwScore + '</td>'
					+	'<td>' + settingATS(res.atScoreMap[i].ATS002) + '</td>'
					+	'<td>' + settingATS(res.atScoreMap[i].ATS001) + '</td>'
					+	'<td>' + settingATS(res.atScoreMap[i].ATS003) + '</td>'
					+	'<td>' + settingATS(res.atScoreMap[i].ATS004) + '</td>'
					+	'<td style="font-weight:bold;">' 
					+		(settingATS(res.atScoreMap[i].ATS001)*0
					+		settingATS(res.atScoreMap[i].ATS002)*1
					+		settingATS(res.atScoreMap[i].ATS003)*0.5
					+		settingATS(res.atScoreMap[i].ATS004)*0.5)
					+	'</td>'
					+	'<td style="color: #BA0003;" class="tScore">' 
					+ 		(
								(examScore / examStandardScore) * exP + 
 								(hwScore / hwStandardScore ) * hwP +
								(	(settingATS(res.atScoreMap[i].ATS002) * 1
									+ settingATS(res.atScoreMap[i].ATS003) * 0.5
									+ settingATS(res.atScoreMap[i].ATS004) * 0.5
								) / classWeekCnt ) * atP
							).toFixed(2)
					+	'</td>'
					+	'<td>'
					+		'<button name="saveBtn" class="btn btn-primary btn-rounded btn-sm replyBtn" data-bs-target="#replyWaiting">저장</button>'
					+	'</td>'
					+'</tr><br/>';	
					//console.log("test :", examStandardScore, hwStandardScore, classWeekCnt, atP)
				scoreTable.append(code);			
			}
			
			// 학점 계산
			var tScore = $(".tScore");
			var fScore = $(".fScore");
			var tLength = tScore.length;
			var tMemId = $(".mId");
			var tScoreArray = [];
			var Arate = res.scoreValueVO.gradeA;
			var Brate = res.scoreValueVO.gradeB;
			var Crate = res.scoreValueVO.gradeC;
			
			
			for(var i = 0; i < tLength; i++){
				var toScore = tScore[i].innerText;	// 성적
				var toMemId = tMemId[i].innerText;	// 수강생 Id
				
				// 절대평가
				if(vType == '절대'){
					if(toScore >= 90){
						fScore[i].innerText = "A";
					}else if(toScore >= 80){
						fScore[i].innerText = "B";
					}else if(toScore >= 70){
						fScore[i].innerText = "C";
					}else if(toScore >= 60){
						fScore[i].innerText = "D";
					}else{
						fScore[i].innerText = "F";
					}
				}
				
				// 상대평가	
				var tScoreObj = {
					score : toScore,
					memId : toMemId,
					rank : 1
				}
				tScoreArray.push(tScoreObj);
			}
			
			
			if(vType == '상대'){
				// 순위 매기기(rank)
				tScoreArray.sort((a, b) => {
					var sc = a.score - b.score;
					if(sc > 0){
						b.rank++;
					}
					return sc
				});
				
				var len = tScoreArray.length;
				// 학점 계산
				for(var i = 0; i < len; i++){
					console.log("rank", tScoreArray[i].rank);
					if(tScoreArray[i].rank >= len*0.2){
						fScore[i].innerText = "A";
					}else if(tScoreArray[i].rank >= len*0.5 && tScoreArray[i].rank < len*0.2){
						fScore[i].innerText = "B";
					}else {
						fScore[i].innerText = "C";
					}
					
				}
			}
			
			/* return rank;
			console.log("rank", rank); */
			console.log("tscoreArray", tScoreArray);
			
			// 성적 일괄 등록
			scoreList = [];				
			var fScore = $(".fScore");
			for(var i = 0; i < fScore.length; i++){
				var classScore = fScore[i].innerText;
				var memNo = res.listenerList[i].member.memNo;	
				
				var scoreUpdate = 
				{
		 			classScore: classScore,
		 			classNo: classNo,
		 			memNo: memNo
				};		
				scoreList.push(scoreUpdate);
			}
			
			// 저장버튼 비활성화
			var saveBtns = document.querySelectorAll('[name="saveBtn"]');
			for(var i = 0; i < res.listenerList.length; i++){
				var scoreFlag = res.listenerList[i].classScore;
				if(scoreFlag == null || scoreFlag == ""){
					saveBtns[i].removeAttribute('disabled');
				}else{
					saveBtns[i].setAttribute('disabled', true);
				}
			}
		}
	});
//	}, 300);
}

function settingATS(value){
	if(value == null || value == ""){
		value = "";
	}
	return value;
}

//성적 일괄 등록				
$("#updateScore").on("click", function(){
	var data = {"arrStr": scoreList};
	
	 $.ajax({
		type : "put",
		url : "/DYUniv/professor/updateScore.ajax",
		contentType : "application/json",
		data : JSON.stringify(data),
		success : function(res){
			console.log("dddd", res);
			if(res == "OK"){	
				alert("학점이 일괄 저장되었습니다.");
				location.reload();
			}
		}
	});
});

					// tScoreEl.forEach(function(element){
					// 	tScoreArray.push({element.textContent, element.tScoreMemNo});
					// });
					/*
						tScoreMemNo.forEach(function(element){
						tScoreArray.push(element.textContent);
					}); */
					//console.log("listenerArray", res.listenerList[i].memNo);
					/*
					var ranker = Array(tScoreArray.length).fill(1);

					tScoreArray.forEach((e, i) => {
						ranker.forEach((f, j) => {
							if (e < tScoreArray[j]) {
								ranker[i]++;
							}
						});
					});

					tScoreArray.forEach((e,i){
						console.log("순위", ranker[i]);
					})
					*/
					/*
					var scores = tScoreArray.map(function(element){
						return parseFloat(element.textContent);
					});
					var ranks = {};
					scores.forEach(function(score, index){
						ranks[score] = index + 1;
					})
					tScoreArray.forEach(function(element){
						var score = parseFloat(element.textContent);
						console.log("rank", ranks[score]);
					});
					*/
					
					/*
					function solution(tScoreArray){							
						var answer = Array.from({length: tLength}, () =>1);
						
						for(var j = 0; j < tLength; j++){
							for(k = 0; k < tLength; k++){
								if(tScoreArray[k] > tScoreArray[j]) answer[j]++;
							}
						}
						return answer;
						console.log("answer", answer);
					}
					console.log("solution", solution(tScoreArray));
					
					
					tLength / 100 * Arate;
					*/
</script>