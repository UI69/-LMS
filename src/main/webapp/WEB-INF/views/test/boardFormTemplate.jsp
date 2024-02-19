<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<section class="content m-10">
	<h2>게시판</h2>

	<section class="content">
	  <div class="row">
		<div class="col-12">          
		  <div class="box">
			<div class="box-header">
			  <h4 class="box-title">CK Editor</h4>
			 <div class="form-group row">
				<div class="col-md-12">
					<input class="form-control" type="text" placeholder="제목">
				</div>
			</div>
			</div>
			<div class="box-body">
			  <form>
				<textarea id="editor1" name="editor1" rows="10" cols="80">This is my textarea to be replaced with CKEditor.</textarea>
			  </form>
			</div>
		  </div>
		</div>
	  </div>
	</section>
	
</section>

<script src="${pageContext.request.contextPath}/resources/assets/vendor_components/ckeditor/ckeditor.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/pages/editor.js"></script>
<script>

</script>