<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 일정 캘린더 -->
<section>
	<form action="/fileUpload" method="post" enctype="multipart/form-data" id="fileUpload">
		<input type="text" id="brdTitle" name="brdTitle">
		<!-- <button type="button" id="file_test">file</button> -->
		<input type="file" id="files" name="files"> <!-- style="display: none;" -->
		<button type="submit" id="uploadBtn">upload</button>
	</form>
</section>


<script>
$("#file_test").on("click", function () {
   $("#file").trigger("click");
})

$("#uploadBtn").on("click", function () {
	$("#fileUpload").submit();
})
</script>

<!-- dayGridMonth -->