<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/9.2.2/gridstack.min.css"
	integrity="sha512-c0A8wU7VMWZRt4qqDc+AxarWQ2XFsQcrJGABe1eyCNxNfj2AI4+YYTytjGlHdrSk7HxA4jHakbXLzw/O/W5WmA=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/9.2.2/gridstack-extra.min.css"
	integrity="sha512-287EQpO1sItRDNvuCUARDlhpQs3qLRCMaidpOKp5BFu6EgcX3XxB92jmTvdXWW57Q9ImHcYqIHKx12EATT3sPA=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/9.2.2/gridstack-all.min.js"
	integrity="sha512-5HTU6mahI/Gm/8o09h6r4B4mTypnVZnM0VgWqLVKJDgBxqbxt7JTqraIdGINJ3fp/5ek/k73kmAE6UitSWPZhw=="
	crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<style>
.grid-stack-item-content {
	border-radius: 10px;
	text-align: left;
	font-size: 1rem;
	box-shadow: 5px 5px 13px #ccc;
}
.grid-stack > .grid-stack-item > .grid-stack-item-content {
	border: none;
}
#addMenu > input {
	margin-right: 10px; 
}
</style>

<div class="container-full">
	<!-- Main content -->
	<section class="content">
		<%-- 환영메시지 박스 --%>
		<div class="row align-items-end">
			<div class="col-xl-12 col-12">
				<div class="box bg-primary-light pull-up">
					<div class="box-body p-xl-0">
						<div class="row align-items-center">
							<div class="col-12 col-lg-3">
								<img
									src="${pageContext.request.contextPath}/resources/images/svg-icon/color-svg/custom-14.svg"
									alt="" />
							</div>
							<div class="col-12 col-lg-9">
								<h2>안녕하세요! 홍길동님, 환영합니다.</h2>
								<p class="text-dark mb-0 fs-16">오늘도 힘찬 하루 되세요!</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<%-- 환영메시지 박스 --%>

		<!-- 포틀릿 시작 -->
		<div class="grid-stack"> </div>
		<!-- 포틀릿 끝 -->
		
		<!-- 포틀릿 메뉴 시작 -->
		<div class="row">
			<div class="d-none d-sm-inline-block">
				<button class="btn bg-gradient-primary btn-rounded btn-secondary btn-sm" id="gridBtn" onclick="f_gridMenu()" style="margin-bottom:7px; color:white !important">
					<i class="fa fa-gear"></i> <span id="gridBtnSpan">화면 구성 설정</span>
				</button>
				<div id="gridMenu" style="display: none">
					<div id="addMenu" style="margin-bottom:7px;">
						<span>너비 : </span><input type="number" min="1" max="6" id="grid_x" value="1">
	           			<span>높이 : </span><input type="number" min="1" max="6" id="grid_y" value="1">
           				<button class="btn btn-info btn-rounded btn-secondary btn-sm" onclick="f_addObj()">메모 위젯 추가</button>
					</div>
					<button class="btn btn-light btn-rounded btn-secondary btn-sm" onclick="fcompact()">알아서정리</button>
					<button class="btn btn-danger btn-rounded btn-secondary btn-sm" onclick="f_removeAll()">모든
						요소 삭제</button>
					<button class="btn btn-warning btn-rounded btn-secondary btn-sm" onclick="f_postionSave()">포지션
						저장</button>
					<button class="btn btn-success btn-rounded btn-secondary btn-sm"
						onclick="f_postionLoad()">포지션 불러오기</button>
				</div>
			</div>
		</div>
		<!-- 포틀릿 메뉴 끝 -->
		
	</section>
</div>

<!-- 스크립트 -->
<script>

	const gridBtn = document.querySelector("#gridBtn");
	const gridBtnSpan = document.querySelector("#gridBtnSpan");
	const gridMenu = document.querySelector("#gridMenu");
	
	let clickFlag = true;
	
	function f_gridMenu() {
		
		if (clickFlag) {
			gridBtnSpan.innerHTML = "화면 구성 완료";
			gridMenu.style.display = "block";
		} else {
			gridBtnSpan.innerHTML = "화면 구성 설정";
			gridMenu.style.display = "none";
		}
		clickFlag = !clickFlag;
	};
	
	function f_memoMenu() {
		const memoBtn = document.querySelector("#memoBtn");
		const inputText = document.querySelector("#inputText");
		const inputTA = document.querySelector("#inputTA");
		
		if (clickFlag) {
			memoBtn.innerHTML = "수정";
			inputText.readOnly = true;
			inputTA.readOnly = true; 
		} else {
			memoBtn.innerHTML = "완료";
			inputText.readOnly = false;
			inputTA.readOnly = false; 
		}
		clickFlag = !clickFlag;
	};
	
	/* 위젯 시작 */
	
	// 학사일정
	var academicCal = `
		<div class="box">
			<div class="box-header with-border">
				<h4 class="box-title">학사일정</h4>
				<div class="box-controls pull-right d-md-flex d-none">
					<a href="#">더보기</a>
				</div>
			</div>
			<div class="box-body">
				<div class="table-responsive">
					<table class="table mb-0 b-1 border-primary"
						style="text-align: center">
						<thead class="bg-primary">
							<tr>
								<th scope="col">순번</th>
								<th scope="col">제목</th>
								<th scope="col">학기</th>
								<th scope="col">기간</th>
								<th scope="col">내용</th>
							</tr>
						</thead>
						<tbody id='uniScheduleBox'></tbody>
					</table>
				</div>
			</div>
		</div>
	`;
	
	// TODO
	var todo = `
		<div class="box">
			<div class="box-header with-border">
				<h4 class="box-title">Todo</h4>
				<div class="box-controls pull-right d-md-flex d-none">
					<button class="btn btn-primary px-10" href="#"
						style="font-size: 11px">추가하기</button>
				</div>
			</div>
			<div class="box-body slimScrollDiv"
				style="max-height: 210px; overflow: auto">
				<div class="d-flex align-items-center mb-25">
					<span class="bullet bullet-bar bg-success align-self-stretch"></span>
					<div class="h-20 mx-20 flex-shrink-0">
						<input type="checkbox" id="md_checkbox_21"
							class="filled-in chk-col-success" /> <label
							for="md_checkbox_21" class="h-20 p-10 mb-0"></label>
					</div>

					<div class="d-flex flex-column flex-grow-1">
						<a href="#" class="text-dark hover-success fw-500 fs-16"> to
							do 예시 </a> <span class="text-fade fw-500"> 2023-10-11 </span>
					</div>
					<div class="dropdown">
						<a class="px-10 pt-5" href="#" data-bs-toggle="dropdown"><i
							class="ti-more-alt"></i></a>
						<div class="dropdown-menu dropdown-menu-end">
							<h6 class="dropdown-header">Choose option:</h6>
							<a class="dropdown-item flexbox" href="#"> <span>수정</span>
								<span class="badge badge-pill badge-default">+</span>
							</a> <a class="dropdown-item flexbox" href="#"> <span>삭제</span>
								<span class="badge badge-pill badge-default">×</span>
							</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	`;
	
	// 공지사항
	var noticeBoard = `
			<div class="box">
				<div class="box-header with-border">
					<h4 class="box-title">공지사항</h4>
					<div class="box-controls pull-right d-md-flex d-none">
						<a href="#">더보기</a>
					</div>
				</div>
				<div class="box-body">
					<div class="table-responsive">
						<table class="table mb-0 b-1 border-primary"
							style="text-align: center">
							<thead class="bg-primary">
								<tr>
									<th scope="col">순번</th>
									<th scope="col">제목</th>
									<th scope="col">내용</th>
									<th scope="col">게시일</th>
								</tr>
							</thead>
							<tbody id="noticeWidgetBox">
								<!-- 공지사항 게시물 아작스 -->
							</tbody>
						</table>
					</div>
				</div>
			</div>
	`;
	
	// 시간표
	var classBoard = `
		<div class="box">
			<div class="box-header with-border">
				<h4 class="box-title">수강 시간표</h4>
				<div class="box-controls pull-right d-md-flex d-none">
					<a href="#">더보기</a>
				</div>
			</div>

			<div class="box-body">
				<p class="mb-5">
					<span id="td_year">2023</span>년 <span id="td_month">01</span>월 <span
						id="td_date">05</span>일
				</p>
				<!-- 수업 박스 1개 시작 -->
				<div class="box mb-15 pull-up boar bg-primary-light">
					<div>
						<div class="table-responsive">
							<table class="table no-border mb-0">
								<tbody>
									<tr>
										<td class="fw-600 min-w-130">
											<div class="d-flex flex-column fw-600">
												<a href="#" class="text-dark hover-primary mb-1 fs-16">1교시
													- 3교시</a> <span class="text-fade">IT대학 A동 102호</span>
											</div>
										</td>
										<td class="fw-600 fs-16 min-w-200 text-center">
											<i class="fa fa-fw fa-circle text-primary fs-12" style="display:inline-block;"></i>
											<span>알고리즘의 이해</span>
										</td>
										<td class="fw-400 fs-16 min-w-150 text-center">홍길동 교수</td>
										<td class="text-primary fw-600 fs-16 min-w-150 text-end">
											<a href="#"> <span>Class room > </span> </a>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<!-- 수업 박스 1개 끝 -->
				<div class="box mb-15 pull-up bg-primary-light">
					<div>
						<div class="table-responsive">
							<table class="table no-border mb-0">
								<tbody>
									<tr>
										<td class="fw-600 min-w-130">
											<div class="d-flex flex-column fw-600">
												<a href="#" class="text-dark hover-primary mb-1 fs-16">1교시
													- 3교시</a> <span class="text-fade">IT대학 A동 102호</span>
											</div>
										</td>
										<td class="fw-600 fs-16 min-w-200 text-center">
											<i class="fa fa-fw fa-circle text-primary fs-12" style="display:inline-block;"></i>
											<span>알고리즘의 이해</span>
										</td>
										<td class="fw-400 fs-16 min-w-150 text-center">홍길동 교수</td>
										<td class="text-primary fw-600 fs-16 min-w-150 text-end">
											<a href="#"> <span>Class room > </span> </a>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	`;
	
	// 메모
	var memo = `
		<div class="box box-outline-warning">
		  <div class="box-header">
			<h4 class="box-title" style="width:100%"><strong><input type="text" class="no-border row" style="width:80%" id="inputText"></strong></h4>
			<div class="box-tools flex-end">					
				<div class="box-controls">
				  <button class="btn btn-rounded btn-secondary btn-sm btn-outline btn-primary" id="memoBtn" onclick="f_memoMenu()">수정</button>
				</div>
			</div>
		  </div>

		  <div class="box-body">
			<div class="form-group">
				<textarea class="form-control no-border" id="inputTA"></textarea>
			</div>
		  </div>
		</div>
	`;
	
	/* 위젯 끝 */
	
	
	/* 포틀릿 시작 */
	
	var items = [
	    { x: 0, y: 0, w: 7, h: 3, content: classBoard, widgetId : "classBoard" },
	    { x: 7, y: 0, w: 5, h: 3, content: todo, widgetId : "todo" },
	    { x: 0, y: 3, w: 6, h: 3, content: academicCal, widgetId : "academicCal" },
	    { x: 6, y: 3, w: 6, h: 3, content: noticeBoard, widgetId : "noticeBoard" }
	];
	
	let gridOption = {
	    column: 12,                   // default 12 -> 6
	    oneColumnSize: 100,          // default 768 -> 100
	    minRow: 1,
	    disableOneColumnMode: true,
	    margin: 10,
	    disableResize: true,
	    removable: 'body',
	    removable: true,
	    disableOneColumnMode: true,
	    resizable: { handles: 'e,se,s,sw,w' },
	    
	}
	
	let grid = GridStack.init(gridOption);
	
	loadGrid(items);
	
	function loadGrid(widget){
		
		grid.load(widget);
		let gridList = document.querySelectorAll('.grid-stack-item');
	    
	    for(let i=0; i<gridList.length; i++){
		    let menu = gridList[i].getAttribute('gs-id');
		    let menuName;
		    switch (menu) {
		        case 'academicCal': menuName = '학사일정'; break;
		        case 'todo': menuName = '할일목록'; break;
		        case 'noticeBoard': menuName = '공지사항'; break;
		        case 'classBoard': menuName = '수강시간표'; break;
		        case 'memo': menuName = '메모'; break;
	    	}
		}
		
		grid.on('added removed change', function(e, items) {
			let str = '';
			items.forEach(function(item) {
				 str += ' (x,y)=' + item.x + ',' + item.y;
			});
			
			console.log(e.type + ' ' + items.length + ' items:' + str );
	    });
	}
	
	// 알아서 정리 메뉴
	function fcompact() {
	    grid.compact();
	}
	// 요소 더하기 메뉴 (메모 위젯만 추가)
	function f_addObj(){
	    var grid_x = document.querySelector("#grid_x").value;
	    var grid_y = document.querySelector("#grid_y").value;

	    grid.addWidget({ w: grid_x, h: grid_y, content: memo });
	}
	// 코드 확인용
	function f_postion(){
	    console.log(grid.engine.nodes);
	}
	// 포지션 저장 메뉴
	function f_postionSave(){
	    console.log("position save...");
	    var items = [];

	    var itemList = grid.engine.nodes;

	    for(var i=0; i<itemList.length; i++){
	        var item = {};
	        item.x = itemList[i].x;
	        item.y = itemList[i].y;
	        item.w = itemList[i].w;
	        item.h = itemList[i].h;
	        item.content = itemList[i].content;

	        items.push(item);
	    }

	    console.log(items);

	    //스트링 형태로 저장
	    localStorage.setItem("items", JSON.stringify(items));
	}
	// 모든 요소 삭제 메뉴
	function f_removeAll(){
	    grid.removeAll();
	}
	// 포지션 불러오기 메뉴
	function f_postionLoad(){
	    //스트링 변환
	    var items = JSON.parse(localStorage.getItem("items"));

	    if(items == null || items == ""){
	        console.log("position empty...")
	        return;
	    }

	    f_removeAll();
	    grid.load(items);
	    console.log(items);
	    univScheduleWidget();
	    noticeWidget();
	}
	
	/* 포틀릿 끝 */
	
	
	/* 학사일정 아작스 시작 */
	
	function univScheduleWidget(){
		$.ajax({
			type : "get",
			url : "/mainpage.do/univSchedule",
			dataType : "json",
			success : function(result){
				let html = "";
				let index = 0;
				
				console.log("success check : ", result);
				
		        for (let i = 0; i < result.length; i++) {
		          	let rs = result[i];
		          	index = index + 1;
		          	
		          	html += '<tr><td>'+ index +'</td>';
		          	html += '<td>' + rs.univSchName +'</td>';
		          	html += '<td>' + rs.univSchSem  +'</td>';
		          	html += '<td><span>' + rs.univSchStartDate + '</span> ~ <span>' + rs.univSchEndDate + '</span></td>';
		          	html += '<td>' + rs.univSchCont + '</td></tr>';
		        }
		        
		       $("#uniScheduleBox").html(html);
			},
			error: function (request, status, error) {
		       console.log("code: " + request.status)
		       console.log("message: " + request.responseText)
		       console.log("error: " + error);
			}
		});
	}
	univScheduleWidget();
	
	/* 학사일정 아작스 끝 */
	
	
	/* 공지사항 아작스 시작 */
	
	function noticeWidget(){
		$.ajax({
			type : "get",
			url : "/mainpage.do/notice",
			dataType : "json",
			success : function(result){
				let html = "";
				let index = 0;
				
				console.log("success check : ", result);
				
		        for (let i = 0; i < result.length; i++) {
		          	let rs = result[i];
		          	index = index + 1;
		          	
		          	html += '<tr><td>'+ index +'</td><td><a href="/academicPlan/detail?brdNo='+ rs.brdNo +'">' + rs.brdTitle +'</a></td>'
		          	html += '<td>' + rs.brdCont + '</td>'
		          	html += '<td>' + rs.writeDate + '</td></tr>';
		        }
		        
		       $("#noticeWidgetBox").html(html);
			},
			error: function (request, status, error) {
			       console.log("code: " + request.status)
			       console.log("message: " + request.responseText)
			       console.log("error: " + error);
			}
		});
	}
	noticeWidget();
	
	/* 공지사항 아작스 끝 */

</script>
