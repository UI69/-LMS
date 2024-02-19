<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Excel</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<body>
	<h2>엑셀저장하기</h2>
	<form action="/DYUniv/excel/exceldownload" method="post" id="excelForm">
		<table border="1">
			<tr>
				<th>번호</th>
				<th>아이디</th>
				<th>비밀번호</th>
				<th>이름</th>
			</tr>
			<c:set value="${list }" var="excelList"/>
			<c:choose>
				<c:when test="${empty list }">
					<tr>
						<td colspan="5">조회하신 정보가 존재하지 않습니다.</td>
					</tr>
				</c:when>
				
				<c:otherwise>
					<c:forEach items="${excelList }" var="excel">
						<tr>
							<td>${excel.excelNo }</td>
							<td>${excel.userId }</td>
							<td>${excel.password }</td>
							<td>${excel.userName }</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
			<tr>
				<td colspan="5"><input type="button" id="excelBtn" value="excel다운로드" /></td>
			</tr>
		</table>
	</form>
	<br/>
	

	
	
	
</body>

<script type="text/javascript">
$(function(){
	var excelBtn = $("#excelBtn");
	var excelForm = $("#excelForm");

	
	excelBtn.on("click", function(){
		var userId = $("#userId").val();
		var password = $("#password").val();
		var userName = $("#userName").val();
		
		excelForm.submit();	
	});

});




function save() {
    if(confirm("업로드 여부")) {
       
       const form = $('#excelUploadForm')[0];
       const formData = new FormData(form);
   
       $.ajax({
    	  url : "/DYUniv/excel/excelUpload.do",
    	  data: formData,
    	  cache: false,
          contentType: false,
          processData: false,
    	  success : function(result) {
              if(result.code=="1") {
                  console.log("data 전송 성공");
                  alert(result.msg);
                  location.href = "/employer/proList.do";
              } else {
                  console.log("data 전송 실패");
                  alert(result.msg);        	
              }
          },
          error : function(request, status, error) {
              console.log("error");
              alert("code : " + request.status + "\n" + "message : " + request.responseText + "\n" + "error : " + error);    
          },
          type : "POST"
    	  
       });
    	
	}
}


</script>

</html>














