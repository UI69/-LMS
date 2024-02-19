<!-- 교수 메인 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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

.grid-stack>.grid-stack-item>.grid-stack-item-content {
	border: none;
}

#gridMenu input, #gridMenu select {
	margin-right: 13px;
}

#gridMenu>* {
	margin-bottom: 7px;
	display: inline-block;
}

#gridMenu button {
	margin-right: 13px;
}

.non-resizable-textarea {
	resize: none;
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
								<h2>안녕하세요! ${member.memName } 교수님, 환영합니다.</h2>
								<p class="text-dark mb-0 fs-16">오늘도 힘찬 하루 되세요!</p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<%-- 환영메시지 박스 --%>
		<!-- 포틀릿 메뉴 시작 -->
		<div class="row">
			<div class="box box-slided-up">
				<div class="box-header with-border">
					<h4 class="box-title">
						<strong>포틀릿 설정 메뉴</strong>
					</h4>
					<ul class="box-controls pull-right">
						<li><a class="box-btn-slide" href="#"></a></li>
					</ul>
				</div>
				<div class="box-body">
					<div id="gridMenu" style="display: flex; justify-content: space-around;">
						<div id="addMenu">
							<span>너비 : </span><input type="number" min="1" max="3"
								id="grid_x" value="1"> <span>높이 : </span><input
								type="number" min="1" max="3" id="grid_y" value="1">
							<button class="btn btn-info btn-rounded btn-secondary btn-sm"
								onclick="f_addObj()">메모 위젯 추가</button>
						</div>
						<div>
							<span>메뉴 선택 : </span> <select id="selectMenu"
								class="form-control"
								style="width: 150px; display: inline-block;">
								<option value="classBoard">오늘의 시간표</option>
								<option value="todo">할 일 목록</option>
								<option value="academicCal">학사일정</option>
								<option value="noticeBoard">공지사항</option>
							</select>
							<button class="btn btn-info btn-rounded btn-secondary btn-sm"
								onclick="f_selectwidget()">선택 위젯 추가</button>
						</div>
						<div>
							<button class="btn btn-success btn-rounded btn-sm"
								onclick="fcompact()">자동정렬</button>
							<button class="btn btn-danger btn-rounded btn-sm"
								onclick="f_removeAll()">전체삭제</button>
							<button class="btn btn-primary btn-rounded btn-sm"
								onclick="f_postionSave()">위젯정보저장</button>
							<button class="btn btn-dark btn-rounded btn-sm"
								onclick="f_postionLoad()">위젯불러오기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 포틀릿 메뉴 끝 -->

		<!-- 포틀릿 시작 -->
		<div class="grid-stack"></div>
		<!-- 포틀릿 끝 -->

		<!-- todo 생성 모달 창 시작 -->
		<div class="modal center-modal fade" id="createTodo" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">
							<strong>To-Do 추가</strong>
						</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form>
							<div class="form-group">
								<label class="form-label"><strong>내용 입력</strong></label>
								<textarea rows="5" class="form-control non-resizable-textarea"
									id="newTodoText" placeholder="최대 45자 이하로 입력하세요." maxlength="45"></textarea>
							</div>
						</form>
					</div>
					<div class="modal-footer modal-footer-uniform">
						<button type="button" class="btn btn-danger"
							data-bs-dismiss="modal">취소</button>
						<button type="button" class="btn btn-primary float-end"
							onclick="f_createTodo()">완료</button>
					</div>
				</div>
			</div>
		</div>
		<!-- todo 생성 모달 창 끝 -->
		<!-- todo 상세 모달 창 시작 -->
		<div class="modal center-modal fade" id="detailTodo" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">
							<strong>To-Do 수정</strong>
						</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<form>
							<div class="form-group">
								<label class="form-label"><strong>내용</strong></label>
								<textarea rows="5" class="form-control non-resizable-textarea"
									id="modTodoText" placeholder="최대 30자 이하로 입력하세요." maxlength="30"></textarea>
							</div>
						</form>
					</div>
					<div class="modal-footer modal-footer-uniform">
						<button type="button" class="btn btn-danger"
							data-bs-dismiss="modal">취소</button>
						<button type="button" class="btn btn-primary float-end"
							id="saveTodoChanges">완료</button>
					</div>
				</div>
			</div>
		</div>
		<!-- todo 상세 모달 창 끝 -->
	</section>
</div>
<script>
	var wgList = [];
</script>
<c:forEach items="${widgetList}" var="widget" varStatus="status">
	<script>
		var ywCont = '${widget.content}';

		// alert(ywCont);
		if (ywCont.length) {
			ywCont = JSON.parse('${widget.content}');
		}

		var wgData = {
			x : parseInt("${widget.x}"),
			y : parseInt("${widget.y}"),
			w : parseInt("${widget.w}"),
			h : parseInt("${widget.h}"),
			label : ywCont,
			content : null,
			id : "${widget.widType}"
		}
		wgList.push(wgData);
	</script>
</c:forEach>
<!-- 스크립트 -->
<script type="text/javascript">
	console.log("가져온 데이터(wgList) : ", wgList);
	var memNo = parseInt("${member.memNo}");
	var memRole = "${member.memRole}";

	var noticeBoard;
	var academicCal;
	var todo;
	var classBoard;
	var memo;
	var grid;
	var items = [];

	var toDoList = [];
	for(var i=0; i< wgList.length; i++){
		if(Array.isArray(wgList[i].label)){
			toDoList = wgList[i].label;
			break;
		}
	}
	
	var todoContent;

	$(function() {

		var itemList = wgList;

		for (var i = 0; i < itemList.length; i++) {
			var item = {};

			item.x = itemList[i].x;
			item.y = itemList[i].y;
			item.w = itemList[i].w;
			item.h = itemList[i].h;

			if (itemList[i].id === 'WID001') {
				item.id = 'classBoard';
				item.content = classBoard;
			} else if (itemList[i].id === 'WID002') {
				item.id = 'todo';
				item.content = todo;
			} else if (itemList[i].id === 'WID003') {
				item.id = 'academicCal';
				item.content = academicCal;
			} else if (itemList[i].id === 'WID004') {
				item.id = 'noticeBoard';
				item.content = noticeBoard;
			} else if (itemList[i].id === 'WID005') {
				item.id = 'memo';
				item.content = memo;
			}

			items.push(item);
		}

		grid = GridStack.init(gridOption);

		loadGrid(items);
		console.log("items", items);
	})
</script>
<script
	src="${pageContext.request.contextPath}/resources/js/mainPage.js"></script>
