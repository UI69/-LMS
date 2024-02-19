<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<c:set value="Save" var="name"/>
<c:if test="${status eq 'u' }">
	<c:set value="Modify" var="name"/>
</c:if>

<!-- 학사일정 등록  MODAL -->
<div id="add-new-events">
	<div class="modal-content" id="mContent">
		<div class="modal-header">
			<h4 class="modal-title">
				<strong>Add</strong> schedule
			</h4>
			<button type="button" class="btn-close" onclick="mClose()" ></button>
		</div>
		<hr/>
		<form action="/DYUniv/employer/addSchedule.do" method="post" id="scheduleForm">
			<input type="hidden" name="page" id="page" />
			<input type="hidden" name="univSchNo" id="univSchNo"/>
			<div class="modal-body">
				<div class="form-body">
					<div class="row">
						<div class="col-md-12">
							<div class="form-group">
								<label class="fw-700 fs-16 form-label" for="univSchName">제목</label>
								<input type="text" class="form-control" id="univSchName" name="univSchName" value=""/>
							</div>
						</div>
					</div>
					<div class="col-md-12">
						<div class="form-group">
							<label class="fw-700 fs-16 form-label">일정 설명</label>
							<textarea class="form-control p-15" rows="4" id="univSchCont" name="univSchCont"></textarea>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label class="form-label">분류</label>
								<select class="form-select" id="univSchType" name="univSchType">
									<option value="">== 선택 ==</option>
									<option value="UST001">사무</option>
									<option value="UST002">장학</option>
									<option value="UST003">행사</option>
									<option value="UST004">기타</option>
								</select>
							</div>
							<input type="hidden" id="univSchSem" name="univSchSem">
						</div>
					</div>
					<br/>
					<div class="row">
						<div class="form-group row">
							<label class="col-form-label col-md-2">시작일자</label>
							<div class="col-md-10">
								<input class="form-control" type="date" id="univSchStartDate" name="univSchStartDate">
							</div>
							<label class="col-form-label col-md-2">종료일자</label>
							<div class="col-md-10">
								<input class="form-control" type="date" id="viewEndDate" name="viewEndDate">
								<input class="form-control" type="hidden" id="univSchEndDate" name="univSchEndDate">
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<div class="d-flex justify-content-between align-items-center">
					<div class="btn float-left"  >
						<button type="button" class="btn btn-success save-category" id="addBtn">Save</button>
						<button type="button" class="btn btn-danger" id="deleteBtn">Delete</button>
						<button type="button" class="btn btn-danger" id="closeBtn">Close</button>
					</div>
					<div class="btn float-right">
						<button type="button" class="btn btn-info btn-xl" onclick="f_univCont()">시연용</button>
						<script type="text/javascript">
							function f_univCont() {
								$("#univSchName").val("상반기 체육대회");
								$("#univSchCont").val("공과대학 상반기 체육대회를 개최합니다.");
							}
						</script>
					</div>
				</div>
			</div>
		</form>
	</div>
</div>
<!-- END MODAL -->