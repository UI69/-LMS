<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/9.2.2/gridstack.min.css" integrity="sha512-c0A8wU7VMWZRt4qqDc+AxarWQ2XFsQcrJGABe1eyCNxNfj2AI4+YYTytjGlHdrSk7HxA4jHakbXLzw/O/W5WmA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/9.2.2/gridstack-extra.min.css" integrity="sha512-287EQpO1sItRDNvuCUARDlhpQs3qLRCMaidpOKp5BFu6EgcX3XxB92jmTvdXWW57Q9ImHcYqIHKx12EATT3sPA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/9.2.2/gridstack-all.min.js" integrity="sha512-5HTU6mahI/Gm/8o09h6r4B4mTypnVZnM0VgWqLVKJDgBxqbxt7JTqraIdGINJ3fp/5ek/k73kmAE6UitSWPZhw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<style type="text/css">
  .grid-stack { background: #FAFAD2; }
  .grid-stack-item-content { background-color: #18BC9C; }
</style>
</head>
<body>
<div class="row">
    <div class="col-md-2">
        <div class="grid-stack grid-stack-2" id="grid1"></div>
    </div>
    <div class="col-md-6">
        <div class="grid-stack grid-stack-6" id="grid2"></div>
    </div>
</div>
</body>
<script type="text/javascript">
$(function(){
	var comBoard = `
		<div gs-id="comBoard" class="grid-stack-item-content" style="background-color: white;">
			<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
				<h6 class="m-0 font-weight-bold text-primary">일반 공지</h6>
				<a class="ft_right" href="/student/board/studentCommonNoticeList"  style="font-size:30px;">+</a>
			</div>
			<div class="card-body" style="padding-top:10px;">
				<div class="chart-area" style="height: 200px;">
					<table class="table table_style01 table_center" id="dataTable" width="100%" cellspacing="0">
						<thead>
							<colgroup> 
								<col width="10%">
			                 	<col width="50%">
			                 	<col width="20%">
			                 	<col width="10%">
							</colgroup>
							<tr>
								<th>번호</th>
								<th>제목</th>
					            <th>작성일</th>
					            <th>조회수</th>
							</tr>
						</thead>
						<tbody id="comBoard-body"></tbody>                      
					</table>
				</div>
			</div>			
		</div>	
	`;
	
	var cal = `
		<div gs-id="calendar" id="Wrapper" class="" style="background:white;">
			<div class="card shadow mb-4">
				<div class="card-header02 py-3">
					<p>학사일정</p>
					<span>학사일정을 확인하세요.</span>
				</div>
				<div class="card-body">
					<div id="Wrapper">
						<div id='calendar'></div>
					</div>
				</div>
			</div>
		</div>
	`;


	var mypage = `
		<div gs-id="mypage" id="moveToMypage" class="grid-stack-item-content list_box" style="overflow:hidden">
			<div class="row no-gutters align-items-center">
				<a href="/student/mypage/student/myPageUI">
					<div class="text">
						<strong class="tit">마이페이지</strong>
						<p class="txt1">마이페이지 바로가기입니다.</p>
					</div>
					<div class="bot">
						<div class="arrow"></div>
						<div class="icon">
							<img src="/resources/img/mail.png" alt="">
						</div>
					</div>
				</a>
			</div>
		</div>
	`;

	var saramin = `
		<div gs-id="saramin" id="moveToSaramin" class="grid-stack-item-content list_box bg01">
			<div class="row no-gutters align-items-center">
				<a href="https://www.saramin.co.kr/zf_user/public-recruit/job-fair-schedule" style="color:white;">
					<div class="text">
						<strong class="tit">채용설명회</strong>
						<p class="txt1">다양한 채용정보를 확인하세요</p>
					</div>
					<div class="bot">
						<div class="arrow"></div>
						<div class="icon">
							<img src="/resources/img/main_ico05.png" alt="">
						</div>
					</div>
				</a>
			</div>
		</div>
	`;

	var certificate = `
		<div gs-id="certificate" id="moveToCertificate" class="grid-stack-item-content list_box bg02">
			<div class="row no-gutters align-items-center">
				<a href="/student/certificate/certificateDown" style="color:white;">
					<div class="text">
						<strong class="tit">증명서발급</strong>
						<p class="txt1">원하시는 증명서를 발급받으세요.</p>
					</div>
					<div class="bot">
						<div class="arrow"></div>
						<div class="icon" style="top:-10px;">
							<img src="/resources/img/main_ico06.png" alt="">
						</div>
					</div>
				</a>
			</div>
		</div>
	`;
	
	var items = [
	    { x: 0, y: 0, w: 6, h: 7, content: "a1", widgetId : "calendar" },
	    { x: 6, y: 2, w: 6, h: 3, content: "a2", widgetId : "comBoard" },
	    //{ x: 6, y: 3, w: 6, h: 3, content: noticeBoard, widgetId : "noticeBoard" },
	    { x: 6, y: 0, w: 2, h: 2, content: "a3", widgetId : "mypage" },
	    { x: 8, y: 0, w: 2, h: 2, content: "a4", widgetId : "saramin" },
	    { x: 10, y: 0, w: 2, h: 2, content: "a5", widgetId : "certificate" }
	];

	let gridOption = {
	    column: 12,                   // default 12 -> 6
	    oneColumnSize: 100,          // default 768 -> 100
	    minRow: 1,
	    disableOneColumnMode: true,
	    //margin: 10,
	    disableResize: true,
	    removable: '.trash',
	    removable: true,
	    disableOneColumnMode: true,
	    resizable: { handles: 'e,se,s,sw,w' }
	}
	let grid = GridStack.init(gridOption);

	
	grid = GridStack.init({
		minRow: 1, // don't let it collapse when empty
		cellHeight: 70, // initial / auto
//       sizeToContent: true, // default to make them all fit
		acceptWidgets: true,
		removable: '#trash', // drag-out delete class
		disableOneColumnMode: true,
    });
	
	loadGrid(items);
	
	function loadGrid(widget){
		
		grid.load(widget);
		let gridList = document.querySelectorAll('.grid-stack-item');
	    
	    for(let i=0; i<gridList.length; i++){
		    let menu = gridList[i].getAttribute('gs-id');
		    let menuName;
		    switch (menu) {
		        case 'mypage': menuName = '마이페이지'; break;
		        case 'calendar': menuName = '학사일정'; break;
		        case 'comBoard': menuName = '일반공지'; break;
		        case 'noticeBoard': menuName = '학사공지'; break;
		        case 'saramin': menuName = '취업박람회'; break;
		        case 'certificate': menuName = '증명서'; break;
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
});
</script>
</html>