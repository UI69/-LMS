<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<div class="col-md-6 col-12">
	<div class="box box-solid bg-primary">
		<div class="box-header">
			<h4 class="box-title">
				<strong>과제 등록</strong>
			</h4>
		</div>

		<div class="box-body">
			<h3 class="box-title">C++프로그램</h3>
			<h4>2023년 2학기 | 전공 필수</h4>
		</div>
	</div>
	<div class="row m-10">
		<div class="col-md-5">
			<div class="form-group">
				<strong>학부/학과</strong>
				<div class="b-2 border-dark rounded p-2 ps-4">공과대</div>
			</div>
		</div>
		<div class="col-md-5">
			<div class="form-group">
				<strong>전공</strong>
				<div class="b-2 border-dark rounded p-2 ps-4">컴퓨터공학과</div>
			</div>
		</div>
	</div>
		<div class="table-responsive">
					  <table class="table mb-0"> 
							<tr>
							  <td class="table-dark">제목</td>
							  <td><span class="text-danger">*</span><input type="text" value="제목을 입력하세요"></td>
							
							</tr>

							<tr>
							  <th class="table-dark">작성자</th>
							  <td><span class="text-danger">*</span><input type="text" value="민지현"></td>
							  <td class="table-dark">작성일</td>
							  <td><span class="text-danger">*</span><input type="text" value="2023/12/19"></td>
							</tr>

						</table>
					</div>
		<div>		
		<h3>첨부파일</h3><span class="text-danger">*</span><input type="file" name="file" class="form-control" required="" aria-invalid="false">
			</div>
	<div class="form-group">
		<h3>
		<span class="text-danger">*</span>내용 
		</h3>
		<div class="controls">
			<textarea name="textarea" id="textarea" class="form-control"
				required="" placeholder="내용을 입력하세요"></textarea>
			<div class="help-block"></div>
		</div>
	</div>

</div>



