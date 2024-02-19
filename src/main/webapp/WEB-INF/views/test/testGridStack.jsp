<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/9.1.1/gridstack.min.css" />
<!-- column 갯수 제한 할 땐 아래 꺼도 피로-->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/9.1.1/gridstack-extra.min.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/gridstack.js/9.1.1/gridstack-all.min.js"></script>

<style>
#wrapper {
	width: 70vw;
	height: 60vh;
}

.grid-stack {
	background: #FAFAD2;
}

.grid-stack-item-content {
	background-color: #18BC9C;
}

.trash {
	height: 100%;
	border: 1px solid black;
	background: rgba(255, 0, 0, 0.1) center center
		url(data:image/svg+xml;utf8;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iaXNvLTg4NTktMSI/Pgo8IS0tIEdlbmVyYXRvcjogQWRvYmUgSWxsdXN0cmF0b3IgMTYuMC4wLCBTVkcgRXhwb3J0IFBsdWctSW4gLiBTVkcgVmVyc2lvbjogNi4wMCBCdWlsZCAwKSAgLS0+CjwhRE9DVFlQRSBzdmcgUFVCTElDICItLy9XM0MvL0RURCBTVkcgMS4xLy9FTiIgImh0dHA6Ly93d3cudzMub3JnL0dyYXBoaWNzL1NWRy8xLjEvRFREL3N2ZzExLmR0ZCI+CjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB4bWxuczp4bGluaz0iaHR0cDovL3d3dy53My5vcmcvMTk5OS94bGluayIgdmVyc2lvbj0iMS4xIiBpZD0iQ2FwYV8xIiB4PSIwcHgiIHk9IjBweCIgd2lkdGg9IjY0cHgiIGhlaWdodD0iNjRweCIgdmlld0JveD0iMCAwIDQzOC41MjkgNDM4LjUyOSIgc3R5bGU9ImVuYWJsZS1iYWNrZ3JvdW5kOm5ldyAwIDAgNDM4LjUyOSA0MzguNTI5OyIgeG1sOnNwYWNlPSJwcmVzZXJ2ZSI+CjxnPgoJPGc+CgkJPHBhdGggZD0iTTQxNy42ODksNzUuNjU0Yy0xLjcxMS0xLjcwOS0zLjkwMS0yLjU2OC02LjU2My0yLjU2OGgtODguMjI0TDMwMi45MTcsMjUuNDFjLTIuODU0LTcuMDQ0LTcuOTk0LTEzLjA0LTE1LjQxMy0xNy45ODkgICAgQzI4MC4wNzgsMi40NzMsMjcyLjU1NiwwLDI2NC45NDUsMGgtOTEuMzYzYy03LjYxMSwwLTE1LjEzMSwyLjQ3My0yMi41NTQsNy40MjFjLTcuNDI0LDQuOTQ5LTEyLjU2MywxMC45NDQtMTUuNDE5LDE3Ljk4OSAgICBsLTE5Ljk4NSw0Ny42NzZoLTg4LjIyYy0yLjY2NywwLTQuODUzLDAuODU5LTYuNTY3LDIuNTY4Yy0xLjcwOSwxLjcxMy0yLjU2OCwzLjkwMy0yLjU2OCw2LjU2N3YxOC4yNzQgICAgYzAsMi42NjQsMC44NTUsNC44NTQsMi41NjgsNi41NjRjMS43MTQsMS43MTIsMy45MDQsMi41NjgsNi41NjcsMi41NjhoMjcuNDA2djI3MS44YzAsMTUuODAzLDQuNDczLDI5LjI2NiwxMy40MTgsNDAuMzk4ICAgIGM4Ljk0NywxMS4xMzksMTkuNzAxLDE2LjcwMywzMi4yNjQsMTYuNzAzaDIzNy41NDJjMTIuNTY2LDAsMjMuMzE5LTUuNzU2LDMyLjI2NS0xNy4yNjhjOC45NDUtMTEuNTIsMTMuNDE1LTI1LjE3NCwxMy40MTUtNDAuOTcxICAgIFYxMDkuNjI3aDI3LjQxMWMyLjY2MiwwLDQuODUzLTAuODU2LDYuNTYzLTIuNTY4YzEuNzA4LTEuNzA5LDIuNTctMy45LDIuNTctNi41NjRWODIuMjIxICAgIEM0MjAuMjYsNzkuNTU3LDQxOS4zOTcsNzcuMzY3LDQxNy42ODksNzUuNjU0eiBNMTY5LjMwMSwzOS42NzhjMS4zMzEtMS43MTIsMi45NS0yLjc2Miw0Ljg1My0zLjE0aDkwLjUwNCAgICBjMS45MDMsMC4zODEsMy41MjUsMS40Myw0Ljg1NCwzLjE0bDEzLjcwOSwzMy40MDRIMTU1LjMxMUwxNjkuMzAxLDM5LjY3OHogTTM0Ny4xNzMsMzgwLjI5MWMwLDQuMTg2LTAuNjY0LDguMDQyLTEuOTk5LDExLjU2MSAgICBjLTEuMzM0LDMuNTE4LTIuNzE3LDYuMDg4LTQuMTQxLDcuNzA2Yy0xLjQzMSwxLjYyMi0yLjQyMywyLjQyNy0yLjk5OCwyLjQyN0gxMDAuNDkzYy0wLjU3MSwwLTEuNTY1LTAuODA1LTIuOTk2LTIuNDI3ICAgIGMtMS40MjktMS42MTgtMi44MS00LjE4OC00LjE0My03LjcwNmMtMS4zMzEtMy41MTktMS45OTctNy4zNzktMS45OTctMTEuNTYxVjEwOS42MjdoMjU1LjgxNVYzODAuMjkxeiIgZmlsbD0iI2ZmOWNhZSIvPgoJCTxwYXRoIGQ9Ik0xMzcuMDQsMzQ3LjE3MmgxOC4yNzFjMi42NjcsMCw0Ljg1OC0wLjg1NSw2LjU2Ny0yLjU2N2MxLjcwOS0xLjcxOCwyLjU2OC0zLjkwMSwyLjU2OC02LjU3VjE3My41ODEgICAgYzAtMi42NjMtMC44NTktNC44NTMtMi41NjgtNi41NjdjLTEuNzE0LTEuNzA5LTMuODk5LTIuNTY1LTYuNTY3LTIuNTY1SDEzNy4wNGMtMi42NjcsMC00Ljg1NCwwLjg1NS02LjU2NywyLjU2NSAgICBjLTEuNzExLDEuNzE0LTIuNTY4LDMuOTA0LTIuNTY4LDYuNTY3djE2NC40NTRjMCwyLjY2OSwwLjg1NCw0Ljg1MywyLjU2OCw2LjU3QzEzMi4xODYsMzQ2LjMxNiwxMzQuMzczLDM0Ny4xNzIsMTM3LjA0LDM0Ny4xNzJ6IiBmaWxsPSIjZmY5Y2FlIi8+CgkJPHBhdGggZD0iTTIxMC4xMjksMzQ3LjE3MmgxOC4yNzFjMi42NjYsMCw0Ljg1Ni0wLjg1NSw2LjU2NC0yLjU2N2MxLjcxOC0xLjcxOCwyLjU2OS0zLjkwMSwyLjU2OS02LjU3VjE3My41ODEgICAgYzAtMi42NjMtMC44NTItNC44NTMtMi41NjktNi41NjdjLTEuNzA4LTEuNzA5LTMuODk4LTIuNTY1LTYuNTY0LTIuNTY1aC0xOC4yNzFjLTIuNjY0LDAtNC44NTQsMC44NTUtNi41NjcsMi41NjUgICAgYy0xLjcxNCwxLjcxNC0yLjU2OCwzLjkwNC0yLjU2OCw2LjU2N3YxNjQuNDU0YzAsMi42NjksMC44NTQsNC44NTMsMi41NjgsNi41N0MyMDUuMjc0LDM0Ni4zMTYsMjA3LjQ2NSwzNDcuMTcyLDIxMC4xMjksMzQ3LjE3MnogICAgIiBmaWxsPSIjZmY5Y2FlIi8+CgkJPHBhdGggZD0iTTI4My4yMiwzNDcuMTcyaDE4LjI2OGMyLjY2OSwwLDQuODU5LTAuODU1LDYuNTctMi41NjdjMS43MTEtMS43MTgsMi41NjItMy45MDEsMi41NjItNi41N1YxNzMuNTgxICAgIGMwLTIuNjYzLTAuODUyLTQuODUzLTIuNTYyLTYuNTY3Yy0xLjcxMS0xLjcwOS0zLjkwMS0yLjU2NS02LjU3LTIuNTY1SDI4My4yMmMtMi42NywwLTQuODUzLDAuODU1LTYuNTcxLDIuNTY1ICAgIGMtMS43MTEsMS43MTQtMi41NjYsMy45MDQtMi41NjYsNi41Njd2MTY0LjQ1NGMwLDIuNjY5LDAuODU1LDQuODUzLDIuNTY2LDYuNTdDMjc4LjM2NywzNDYuMzE2LDI4MC41NSwzNDcuMTcyLDI4My4yMiwzNDcuMTcyeiIgZmlsbD0iI2ZmOWNhZSIvPgoJPC9nPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+CjxnPgo8L2c+Cjwvc3ZnPgo=)
		no-repeat;
}

#dleft, #dright {
	display: inline-block;
	vertical-align: top;
}

#dleft {
	width: 70%;
}

#dright {
	width: 25%;
}
</style>

<div class="container-full">
	<!-- Content Header (Page header) -->
	<div class="content-header">
		<div class="d-flex align-items-center">
			<div class="me-auto">
				<h3 class="page-title">Draggable Portlets</h3>
				<div class="d-inline-block align-items-center">
					<nav>
						<ol class="breadcrumb">
							<li class="breadcrumb-item"><a href="#"><i
									class="mdi mdi-home-outline"></i></a></li>
							<li class="breadcrumb-item" aria-current="page">Component</li>
							<li class="breadcrumb-item active" aria-current="page">Draggable
								Portlets</li>
						</ol>
					</nav>
				</div>
			</div>

		</div>
	</div>

	<!-- Main content -->
	<section class="content">

		<!-- tabs -->

		<div class="row">
			<div class="col-12">
				<div class="box">
					<!-- /.box-header -->
					<div class="box-body">
						<h4 class="box-title my-0">Draggable Panel Portlets</h4>
						Thus is a widget layout jquery plugin. <a
							href="http://troolee.github.io/gridstack.js/" target="_blank"
							class="text-purple">gridstack.js</a> is used to design this
						layout. This is drag-and-drop multi-column grid. It allows you to
						build draggable responsive layouts.
					</div>
					<!-- /.box-body -->
				</div>
				<!-- /.box -->
			</div>
			<!-- /.col -->

			<div class="col-12">
				<div class="box">
					<div class="box-body">
						<div class="grid-stack" id="dleft"></div>
						<div class="trash" id="dright">휴지통</div>
						<div>
							<button onclick="fcompact()">컴팩트</button>
						</div>
						<div>
							x : <input type="number" min="1" max="6" id="grid_x" value="1">
							y : <input type="number" min="1" max="6" id="grid_y" value="1">
							<button onclick="f_addObj()">add obj</button>
						</div>
						<div>
							<button onclick="f_postion()">포지션</button>
						</div>
						<div>
							<button onclick="f_postionSave()">포지션 저장</button>
						</div>
						<div>
							<button onclick="f_postionLoad()">포지션 불러오기</button>
						</div>
						<div>
							<button onclick="f_removeAll()">모든 요소 삭제</button>
						</div>

					</div>
				</div>
			</div>
			<!-- /.col -->

		</div>
		<!-- /.row -->
		<!-- END tabs -->

	</section>
	<!-- /.content -->
</div>

<script>

// using serialize data instead of .addWidget()
let items = [
    { x: 0, y: 0, w: 2, h: 2, content: 'item 1' },
    { x: 3, y: 0, w: 4, h: 2, content: 'item 2' },
    { x: 2, y: 3, w: 3, content: 'item 3' },
    { x: 1, y: 3, content: 'item 4' }
];

//확장 (jQuery Plugin 느낌!)
GridStack.prototype.e7eMerong = function () {
    console.log("GridStack", this);
}



// const grid = GridStack.init(); // 옵션 없이 생성

let gridOption = {
    column: 6,                   // default 12
    oneColumnSize: 100,          // default 768
    minRow: 1,
    disableOneColumnMode: true,
    margin: 1,
    placeholderText: '그리드 오브젝트가 움직일때 보이는 화면 text',
    disableResize: true,
    float: true,
    removable: '.trash',    //body로 설정하면 구성화면 밖으로 던지면 삭제됨

    //cellHeight: 50,
    //cellWidth: 50,
    // 한줄 혼자 꽉 채우는 거 금지!,default value of oneColumnSize is 768px
    disableOneColumnMode: true,
    resizable: { handles: 'e,se,s,sw,w' }
}

// const grid = GridStack.init(); // 옵션 없이 생성(Default)
let grid = GridStack.init(gridOption);

function f_loadGrid(){
    grid.load(items);
    grid.e7eMerong();
}

f_loadGrid();
// 컴팩트
function fcompact() {
    grid.compact();
}

function f_addObj(){
    var grid_x = document.querySelector("#grid_x").value;
    var grid_y = document.querySelector("#grid_y").value;

    grid.addWidget({ w: grid_x, h: grid_y, content: "add obj" });
}

function f_postion(){
    console.log(grid.engine.nodes);
}

//현재설정 저장하기
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

//모두 삭제
function f_removeAll(){
    grid.removeAll();
}

//요소 삭제
function f_removeWidget(el){
    //console.log(el);
    grid.removeWidget(el, false);
    el.remove();
}

//불러오기
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
}
</script>