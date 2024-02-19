let clickFlag = true;

/* $(function(){
	// 날짜 데이터 넣기
	var currentDate = new Date();

	var formattedDate = currentDate.toLocaleDateString('ko-KR', {
		year: 'numeric',
		month: 'long',
		day: 'numeric',
		weekday: 'short'
	});

	$("#todaySpan").innerHTML = formattedDate;
}); */

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

function f_todoModify() {
	const todoModify = document.querySelector("#todoModify");
	const todoText = document.querySelector("#todoText");
	
	if (clickFlag) {
		todoModify.innerHTML = "수정";
		todoText.readOnly = true;
	} else {
		todoModify.innerHTML = "완료";
		todoText.readOnly = false;
	}
	clickFlag = !clickFlag;
}

/* 위젯 시작 */

// 학사일정
academicCal = `
	<div class="box">
		<div class="box-header with-border">
			<h4 class="box-title">학사일정</h4>
			<div class="box-controls pull-right d-md-flex d-none">
				<a href="/DYUniv/univSchedule.do">더보기</a>
			</div>
		</div>
		<div class="box-body">
			<div class="table-responsive">
				<table class="table mb-0 b-1 border-primary"
					style="text-align: center">
					<thead class="bg-primary">
						<tr>
							<th scope="col" style="width:40%;">일정제목</th>
							<th scope="col">학기</th>
							<th scope="col" style="width:35%;">기간</th>
						</tr>
					</thead>
					<tbody id='uniScheduleBox'></tbody>
				</table>
			</div>
		</div>
	</div>
`;

// TODO
todo = `
	<div class="box">
		<div class="box-header with-border">
			<h4 class="box-title">Todo</h4>
			<div class="box-controls pull-right d-md-flex d-none">
				<button class="btn btn-primary px-10" href="#"
					style="font-size: 11px" data-bs-toggle="modal"
						data-bs-target="#createTodo">추가하기</button>
			</div>
		</div>
		<div class="box-body slimScrollDiv" id="todoListBox"></div>
	</div>
`;

// 공지사항
noticeBoard = `
		<div class="box">
			<div class="box-header with-border">
				<h4 class="box-title">공지사항</h4>
				<div class="box-controls pull-right d-md-flex d-none">
					<a href="/DYUniv/noticeBoard.do">더보기</a>
				</div>
			</div>
			<div class="box-body">
				<div class="table-responsive">
					<table class="table mb-0 b-1 border-primary"
						style="text-align: center">
						<thead class="bg-primary">
							<tr>
								<th scope="col" style = "width='50%'">공지제목</th>
								<th scope="col">게시일</th>
								<th scope="col" style = "width='10%'">조회수</th>
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
classBoard = `
	<div class="box">
		<div class="box-header with-border">
			<h4 class="box-title">오늘의 시간표</h4>
			<span id="todaySpan" class="text-info" style="margin-left: 16px;"></span>
			<div class="box-controls pull-right d-md-flex d-none">
				<a href="/DYUniv/student/class/myClassList.do">더보기</a>
			</div>
		</div>

		<div class="box-body">
			<div id="classBox">
				<!-- 시간표 아작스 -->
			</div>
		</div>
	</div>
`;

// 메모
memo = `
	<div class="box box-outline-warning" style="width:100%; height:100%">
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

let gridOption = {
    column: 12,                   // default 12 -> 6
    oneColumnSize: 100,          // default 768 -> 100
    minRow: 1,
    // disableOneColumnMode: true,
    margin: 10,
    disableResize: true,
    disableDrag: false,
    removable: 'body',
    removable: true,
    resizable: { handles: 'e,se,s,sw,w' },
}

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
		/*
		items.forEach(function(item) {
			 str += ' (x,y)=' + item.x + ',' + item.y;
		});
		
		console.log(e.type + ' ' + items.length + ' items:' + str );
    	*/
    });
    
	univScheduleWidget();
	noticeWidget();
	f_listTodo();
	f_classBoardList();
}

// 알아서 정리 메뉴
function fcompact() {
    grid.compact();
}
// 요소 더하기 메뉴 (메모 위젯만 추가)
function f_addObj(){
    var grid_x = document.querySelector("#grid_x").value;
    var grid_y = document.querySelector("#grid_y").value;

    grid.addWidget({ w: grid_x*2, h: grid_y*2, id:'memo', content: memo });
}
// 포지션 저장 메뉴
function f_postionSave(){
    console.log("position save...");
    var items = [];

    var itemList = grid.engine.nodes;
    
    console.log("포지션 저장메뉴 itemList", itemList);

    for(var i=0; i<itemList.length; i++){
        var item = {};
        
        item.memNo = memNo;
        item.x = itemList[i].x;
        item.y = itemList[i].y;
        item.w = itemList[i].w;
        item.h = itemList[i].h;

        if(itemList[i].id === 'classBoard'){
	    	item.widType = 'WID001';
			item.content = null;
	    } else if(itemList[i].id === 'todo'){
	    	item.widType = 'WID002';
			item.content = JSON.stringify(toDoList);
	    } else if(itemList[i].id === 'academicCal'){
	    	item.widType = 'WID003';
			item.content = null;
	    } else if(itemList[i].id === 'noticeBoard'){
	    	item.widType = 'WID004';
			item.content = null;
	    } else if(itemList[i].id === 'memo'){
	    	item.widType = 'WID005';
	    } 

        items.push(item);
    }
    console.log("저장할 new 데이터", items);

	$.ajax({
		type: "post",
		url: "/DYUniv/mainpage.do/updateWidget",
		contentType: "application/json",
	    data: JSON.stringify(items),
	    dataType: 'json',
		success: function (result) {
		  console.log("update position check : ", result);
		  if (result == 1) {
			alert("포지션 수정 완료 !");
		  }
		},
	  });

    //스트링 형태로 저장
    // localStorage.setItem("items", JSON.stringify(items));
}
// 모든 요소 삭제 메뉴
function f_removeAll(){
    grid.removeAll();
}
// 포지션 불러오기 메뉴
function f_postionLoad(){
	var items = [];

	$.ajax({
		type : "get",
		url : "/DYUniv/mainpage.do/widgetList",
		data : {memNo:memNo},       // get 방식인 경우 jQuery가 알아서 "/mainpage.do/widgetList?memNo=4" 맹글어 줌
		dataType : "json",
		success : function(result){
			console.log("result", result);
		
			for (var i = 0; i < result.length; i++) {

			    var item = {
			        x: result[i].x,
			        y: result[i].y,
			        w: result[i].w,
			        h: result[i].h,
			        id: '',
			        content: null,
					label: null
			    };
		
			    if (result[i].widType === 'WID001') {
			        item.id = 'classBoard';
			        item.content = classBoard;
			    } else if (result[i].widType === 'WID002') {
			        item.id = 'todo';
			        item.content = todo;
			        item.label = result[i].label;
			    } else if (result[i].widType === 'WID003') {
			        item.id = 'academicCal';
			        item.content = academicCal;
			    } else if (result[i].widType === 'WID004') {
			        item.id = 'noticeBoard';
			        item.content = noticeBoard;
			    } else if (result[i].widType === 'WID005') {
			        item.id = 'memo';
			        item.content = memo;
			    }
			
			    items.push(item);
			}
		    //스트링 변환
		    // var items = JSON.parse(localStorage.getItem("items"));
		    
		    console.log("items", items);
		
		    if(items == null || items == ""){
		        console.log("position empty...")
		        return;
		    }
			
		    f_removeAll();
		    console.log("reloadItems : ", items);
		    grid.load(items);
		    loadGrid(items);
		}	
	});
}
// 선택 메뉴 생성
function f_selectwidget(){
	var selectMenu = $("#selectMenu").val();
	var selectData = {
		memNo : memNo,
		widType : selectMenu
	};

    $.ajax({
    	type: "post",
		url: "/DYUniv/mainpage.do/selectWidget",
		contentType: "application/json",
	    data: JSON.stringify(selectData),
	    dataType: 'json',
		success: function (result) {
		  
		if(result.widType === 'WID001'){
	    	result.id = 'classBoard';
	    	result.content = classBoard;
	    } else if(result.widType === 'WID002'){
	    	item.id = 'todo';
			alert("체킁:"+itemList[i].label);
			//toDoList = itemList[i].label;
	    } else if(result.widType === 'WID003'){
	    	result.id = 'academicCal';
	    	result.content = academicCal;
	    } else if(result.widType === 'WID004'){
	    	result.id = 'noticeBoard';
	    	result.content = noticeBoard;
	    } else if(result.widType === 'WID005'){
	    	result.id = 'memo';
	    	result.content = memo;
	    } 
		  
		  grid.addWidget(result);
		  univScheduleWidget();
		  noticeWidget();
		  f_listTodo();
		  f_classBoardList();
		}
    	
    });
}

/* 포틀릿 끝 */


/* 학사일정 아작스 시작 */

function univScheduleWidget(){
	$.ajax({
		type : "get",
		url : "/DYUniv/mainpage.do/univSchedule",
		dataType : "json",
		success : function(result){
			let html = "";
			
			console.log("success check : ", result);
			
	        for (let i = 0; i < result.length; i++) {
	          	let rs = result[i];
	          	
	          	html += '<tr><td>' + rs.univSchName +'</td>';
	          	html += '<td>' + rs.univSchSem + '</td>';
	          	html += '<td><span>' + rs.univSchStartDate.slice(0, 10) + '</span> ~ <span>' + rs.univSchEndDate.slice(0, 10) + '</span></td></tr>';
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


/* 학사일정 아작스 끝 */
	
	
/* 공지사항 아작스 시작 */

function noticeWidget(){
	$.ajax({
		type : "get",
		url : "/DYUniv/mainpage.do/notice",
		dataType : "json",
		success : function(result){
			let html = "";
			
			console.log("success check : ", result);
			
	        for (let i = 0; i < result.length; i++) {
	          	let rs = result[i];
	          	
	          	html += '<tr><td>' + rs.brdTitle +'</td>'
	          	html += '<td>' + rs.writeDate.slice(0, 10) + '</td>';
	          	html += '<td>' + rs.brdHitCount + '</td></tr>'
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

/* 공지사항 아작스 끝 */


/* todo 시작 */
function f_listTodo(){
	
	console.log("toDoList", toDoList);
	
	html = "";
	index = 20;
	
	if(toDoList.length === 0){
		html += '<p class="text-mute">저장된 TODO가 없습니다.</p>';
		
		$("#todoListBox").html(html);
	}

	for(var i = 0; i < toDoList.length; i++){
		index += i;
		todoItem = toDoList[i];
		// console.log("todoItem", todoItem);
		html 
			+= '<div class="d-flex align-items-center mb-25 todoBox"><span class="bullet bullet-bar bg-primary align-self-stretch"></span>'
			+'<div class="h-20 mx-20 flex-shrink-0"><input type="checkbox" id="md_checkbox_'
			+ index
			+'" class="filled-in chk-col-primary todoCheckBox"  />'
			+'<label for="md_checkbox_'
			+ index
			+'" class="h-20 p-10 mb-0 todoBoxLabel"></label></div><div class="d-flex flex-column flex-grow-1">'
			+'<a class="text-dark hover-primary fw-500 fs-16" data-bs-toggle="modal" data-bs-target="#detailTodo" onclick="fYWchk(this)" style="cursor: pointer;" id="yw'
			+ i
			+'">' 
			+ todoItem.text
			+ '</a><span class="text-fade fw-500" id="todoDate">'
			+ todoItem.date
			+ '</span></div></div>';

		$("#todoListBox").html(html);
		
	}
	
	$(".todoCheckBox").on("change", f_deleteTodo);
}
// 모달의 "저장" 버튼 클릭 시
$("#saveTodoChanges").click(function () {
	// 수정된 값을 가져옴
	var modifiedText = $("#modTodoText").val();
	alert(modifiedText);

	//ywAtag.innerHTML = modifiedText;  //
	//console.log("체킁1:",ywAtag); 
	
	var ywIndex = ywAtag.id.replace("yw","");
	toDoList[ywIndex].text= modifiedText;
	console.log("체킁2:",toDoList);

	// 모달 닫기
	$("#detailTodo").modal('hide');

	// 수정 후 목록 갱신
	f_listTodo();
});

// 수정화면
var ywAtag;  // 클릭한 a 태그 값을 담을 변수
function fYWchk(pThis){
	//alert(pThis.innerHTML);  예원이 모달 맹글어 써야 함!, 요렇게 하면 실력이 안 늘어용!, 가성비가 안 나와용!
	$("#modTodoText").val(pThis.innerHTML);
	ywAtag  = pThis;	
	console.log("i", pThis.id);
}
// 요기를 쪼금 설계 개념이 보이도록
function f_createTodo(){

	newTodoText = $("#newTodoText").val();
	newTodoTime = new Date().toISOString().slice(0, 10); // yyyy-mm-dd
	
	var toDo = {}
	toDo.text = newTodoText;
	toDo.date = newTodoTime;
	
	console.log("toDo", toDo);

	console.log("체킁:",toDoList);
	toDoList.push(toDo);
	
	// textarea 비우기
	$("#newTodoText").val("");

	//모달창끄기
	$("#createTodo").modal('hide');
	
	f_listTodo();
}
// todo 삭제
function f_deleteTodo() {
    const checkbox = event.target;

    const todoBox = checkbox.closest('.todoBox');
    
    console.log();
    console.log(todoBox.children[2].children[1].innerText);

	for(var i = 0; i < toDoList.length; i++){
		if(toDoList[i].text == todoBox.children[2].children[0].innerText){
			toDoList.splice(i,1);
		}
	}

    if (checkbox.checked) {
        setTimeout(function () {
            todoBox.remove();
        }, 700);
    }
}

/* todo 끝 */

/* 강의시간표 시작 */

function f_classBoardList(){
	
	// 날짜 데이터 넣기
	var currentDate = new Date();

	var formattedDate = currentDate.toLocaleDateString('ko-KR', {
		year: 'numeric',
		month: 'long',
		day: 'numeric',
		weekday: 'short'
	});

	$("#todaySpan").html(formattedDate);
	
	$.ajax({
		type : "get",
		url : "/DYUniv/mainpage.do/classBoard",
		dataType : "json",
		success : function(result){
			let html = "";
			
			console.log("f_classBoardList check : ", result);

			if (result.length === 0) {
            
				html +=
                    '<div class="box mb-15 pull-up boar bg-primary-light">' +
                    '<div> <div class="table-responsive"> <table class="table no-border mb-0">' +
                    '<tbody> <tr> <td class="fw-600 min-w-130"> <p class="text-mute">오늘은 강의가 없습니다.</p> </td> </tr> </tbody> </table> </div> </div> </div>';
				
				$("#classBox").html(html);

			} else {

				for (let i = 0; i < result.length; i++) {
					let rs = result[i];
					
					html +=
					'<div class="box mb-15 pull-up boar bg-primary-light">' +
					'<div> <div class="table-responsive"> <table class="table no-border mb-0">' +
					'<tbody> <tr> <td class="fw-600 min-w-130"> <div class="d-flex flex-column fw-600">' +
					'<a class="text-dark hover-primary mb-1 fs-16">' +
					rs.lecScheduleList[0].lecStartTime + '교시 - '+ rs.lecScheduleList[0].lecEndTime +'교시' +
					'</a> <span class="text-fade">' +
					rs.roomVO.buildingNo + '동 ' + rs.roomVO.roomName +
					'</span></div> </td> <td class="fw-600 fs-16 min-w-200 text-center">' +
					'<i class="fa fa-fw fa-circle text-primary fs-12" style="display:inline-block;"></i><span>'+
					rs.className +
					'</span> </td> <td class="fw-400 fs-16 min-w-150 text-center">'+
					
					(memRole == "ROL001" ? rs.memberVO.memName : rs.memName) +
					
					' 교수</td><td class="text-primary fw-600 fs-16 min-w-150 text-end"> <a href="/DYUniv/managementClassRoom/'+
					rs.classNo+'"> <span>Class room > </span> </a>' +
					'</td> </tr> </tbody> </table> </div> </div> </div> ';
				} 
	        
	       		$("#classBox").html(html);
			
			}
		},
		error: function (request, status, error) {
		       console.log("code: " + request.status);
		       console.log("error: " + error);
		}
	});
}

/* 강의시간표 끝 */
