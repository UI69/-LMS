<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    

<!-- 커뮤니티 일정  MODAL -->
<div id="add-community-events">
	<div class="modal-content" id="mContent">
		<div class="modal-header">
			<h4 class="modal-title">
				<strong>Add</strong> schedule
			</h4>
			<button type="button" class="btn-close" onclick="mClose()" ></button>
		</div>
		<hr/>
		<form action="/DYUniv/facility/facReservation.do" method="post" method="post" id="facResrvForm">
			<input type="hidden" name="facNo" id="facNo" value=""/>
			<div class="modal-body">
				<div class="form-body">
					<div class="row">
						<h3 id="brSelect" style="font-weight: bold;"></h3>
						<h4 id="frSelect" style="color: rgb(92,158,237);"></h4>
					</div>
					<br/>
					<div class="row">
						<div class="form-group row">
							<label class="col-form-label col-md-2">예약일자</label>
							<div class="col-md-10">
								<div class="row">
									<div class="col-6">
										<input class="form-control" type="date" id="facRsvDate"/>
									</div>
								</div>						
							</div>
							<br/>
							<label class="col-form-label col-md-2">예약시간</label>
							<div class="col-md-10">
								<div class="row">			
									<div class="col-6">
										<div class="input-group">
											<div class="input-group-addon">
												<i class="fa fa-clock-o"></i>
											</div>
											<input type="number" min="0" max="24" class="form-control timepicker" placeholder="0-24" id="facViewStartDate" name="facViewStartDate"/>
											<input type="hidden" id="facRsvStartDate" name="facRsvStartDate"/>
										</div>
									</div>
									<div class="col-6">
										<div class="input-group">
											<div class="input-group-addon">
												<i class="fa fa-clock-o"></i>
											</div>
											<input type="number" min="0" max="24" class="form-control timepicker" placeholder="0-24" id="facViewEndDate" name="facViewEndDate"/>
											<input type="hidden" id="facRsvEndDate" name="facRsvEndDate"/>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<div class="d-flex justify-content-between align-items-center">
					<div class="btn float-left"  >
						<button type="button" class="btn btn-success save-category" id="facResrvBtn">Save</button>
						<button type="button" class="btn btn-danger" onclick="mClose()">Close</button>
					</div>
<!-- 					<div class="btn float-right">
						<button type="button" class="btn btn-danger" id="deleteBtn">Delete</button>
					</div> -->
				</div>
			</div>
		</form>
	</div>
</div>
<!-- END MODAL -->

