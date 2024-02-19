<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<body class="col-12 row hold-transition light-skin sidebar-mini theme-primary fixed">
	<div class="col-10">
		<div class="col-12 row text-center">
			<h1>강의 평가</h1>
			<div class="col-4"><h4>(강의)</h4></div>
			<div class="col-4"></div>
			<div class="col-4"><h4>(이름)</h4></div>
		</div>
		
		
		<div class="col-12">
			<form action="/DYUniv/class/ratingForm.do" method="post">
			
			<table class="table">
				<thead class="bg-primary">
					<tr>
						<th width="40%">#</th>
						<th width="12%">매우 그렇다</th>
						<th width="12%">그렇다</th>
						<th width="12%">보통이다</th>
						<th width="12%">그렇지 않다</th>
						<th width="12%">매우 그렇지않다</th>
					</tr>
				</thead>
				<tbody id="ratingTable">
					<tr>
						<td>1. 수업의 강의 계획서는 내용이 충분하였다</td>

						<td><font style="vertical-align: inherit;"><input type="radio" name="qst1" id="qst1-1"><label for="qst1-1" class="h-20 p-10 mb-0"></label></font></td>
						<td><font style="vertical-align: inherit;"><input type="radio" name="qst1" id="qst1-2"><label for="qst1-2" class="h-20 p-10 mb-0"></label></font></td>
						<td><font style="vertical-align: inherit;"><input type="radio" name="qst1" id="qst1-3"><label for="qst1-3" class="h-20 p-10 mb-0"></label></font></td>
						<td><font style="vertical-align: inherit;"><input type="radio" name="qst1" id="qst1-4"><label for="qst1-4" class="h-20 p-10 mb-0"></label></font></td>
						<td><font style="vertical-align: inherit;"><input type="radio" name="qst1" id="qst1-5"><label for="qst1-5" class="h-20 p-10 mb-0"></label></font></td>
					</tr>
					<tr>
						<td>2. 수업이 규정된 시간을 준수하여 진행되었다</td>

						<td><font style="vertical-align: inherit;"><input type="radio" name="qst2" id="qst2-1"><label for="qst2-1" class="h-20 p-10 mb-0"></label></font></td>
						<td><font style="vertical-align: inherit;"><input type="radio" name="qst2" id="qst2-2"><label for="qst2-2" class="h-20 p-10 mb-0"></label></font></td>
						<td><font style="vertical-align: inherit;"><input type="radio" name="qst2" id="qst2-3"><label for="qst2-3" class="h-20 p-10 mb-0"></label></font></td>
						<td><font style="vertical-align: inherit;"><input type="radio" name="qst2" id="qst2-4"><label for="qst2-4" class="h-20 p-10 mb-0"></label></font></td>
						<td><font style="vertical-align: inherit;"><input type="radio" name="qst2" id="qst2-5"><label for="qst2-5" class="h-20 p-10 mb-0"></label></font></td>
					</tr>
					<tr>
						<td>3. 수업의 준비가 충실한 상태로 진행되었다</td>

						<td><font style="vertical-align: inherit;"><input type="radio" name="qst3" id="qst3-1"><label for="qst3-1" class="h-20 p-10 mb-0"></label></font></td>
						<td><font style="vertical-align: inherit;"><input type="radio" name="qst3" id="qst3-2"><label for="qst3-2" class="h-20 p-10 mb-0"></label></font></td>
						<td><font style="vertical-align: inherit;"><input type="radio" name="qst3" id="qst3-3"><label for="qst3-3" class="h-20 p-10 mb-0"></label></font></td>
						<td><font style="vertical-align: inherit;"><input type="radio" name="qst3" id="qst3-4"><label for="qst3-4" class="h-20 p-10 mb-0"></label></font></td>
						<td><font style="vertical-align: inherit;"><input type="radio" name="qst3" id="qst3-5"><label for="qst3-5" class="h-20 p-10 mb-0"></label></font></td>
					</tr>
					<tr>
						<td>4. 교수님은 강의와 열정을 가지고 수업을 진행하였다</td>

						<td><font style="vertical-align: inherit;"><input type="radio" name="qst4" id="qst4-1"><label for="qst4-1" class="h-20 p-10 mb-0"></label></font></td>
						<td><font style="vertical-align: inherit;"><input type="radio" name="qst4" id="qst4-2"><label for="qst4-2" class="h-20 p-10 mb-0"></label></font></td>
						<td><font style="vertical-align: inherit;"><input type="radio" name="qst4" id="qst4-3"><label for="qst4-3" class="h-20 p-10 mb-0"></label></font></td>
						<td><font style="vertical-align: inherit;"><input type="radio" name="qst4" id="qst4-4"><label for="qst4-4" class="h-20 p-10 mb-0"></label></font></td>
						<td><font style="vertical-align: inherit;"><input type="radio" name="qst4" id="qst4-5"><label for="qst4-5" class="h-20 p-10 mb-0"></label></font></td>
					</tr>
					<tr>
						<td>5. 교수님은 수업의 내용을 충실하게 설명하였다</td>

						<td><font style="vertical-align: inherit;"><input type="radio" name="qst5" id="qst5-1"><label for="qst5-1" class="h-20 p-10 mb-0"></label></font></td>
						<td><font style="vertical-align: inherit;"><input type="radio" name="qst5" id="qst5-2"><label for="qst5-2" class="h-20 p-10 mb-0"></label></font></td>
						<td><font style="vertical-align: inherit;"><input type="radio" name="qst5" id="qst5-3"><label for="qst5-3" class="h-20 p-10 mb-0"></label></font></td>
						<td><font style="vertical-align: inherit;"><input type="radio" name="qst5" id="qst5-4"><label for="qst5-4" class="h-20 p-10 mb-0"></label></font></td>
						<td><font style="vertical-align: inherit;"><input type="radio" name="qst5" id="qst5-5"><label for="qst5-5" class="h-20 p-10 mb-0"></label></font></td>
					</tr>
					<tr>
						<td>6. 시험이 수업의 이해에 대해 적절하게 실시되었다</td>

						<td><font style="vertical-align: inherit;"><input type="radio" name="qst6" id="qst6-1"><label for="qst6-1" class="h-20 p-10 mb-0"></label></font></td>
						<td><font style="vertical-align: inherit;"><input type="radio" name="qst6" id="qst6-2"><label for="qst6-2" class="h-20 p-10 mb-0"></label></font></td>
						<td><font style="vertical-align: inherit;"><input type="radio" name="qst6" id="qst6-3"><label for="qst6-3" class="h-20 p-10 mb-0"></label></font></td>
						<td><font style="vertical-align: inherit;"><input type="radio" name="qst6" id="qst6-4"><label for="qst6-4" class="h-20 p-10 mb-0"></label></font></td>
						<td><font style="vertical-align: inherit;"><input type="radio" name="qst6" id="qst6-5"><label for="qst6-5" class="h-20 p-10 mb-0"></label></font></td>
					</tr>
					<tr>
						<td>7. 과제물이 적절하였으며 과제에 대한 평가가 적절하였다</td>

						<td><font style="vertical-align: inherit;"><input type="radio" name="qst7" id="qst7-1"><label for="qst7-1" class="h-20 p-10 mb-0"></label></font></td>
						<td><font style="vertical-align: inherit;"><input type="radio" name="qst7" id="qst7-2"><label for="qst7-2" class="h-20 p-10 mb-0"></label></font></td>
						<td><font style="vertical-align: inherit;"><input type="radio" name="qst7" id="qst7-3"><label for="qst7-3" class="h-20 p-10 mb-0"></label></font></td>
						<td><font style="vertical-align: inherit;"><input type="radio" name="qst7" id="qst7-4"><label for="qst7-4" class="h-20 p-10 mb-0"></label></font></td>
						<td><font style="vertical-align: inherit;"><input type="radio" name="qst7" id="qst7-5"><label for="qst7-5" class="h-20 p-10 mb-0"></label></font></td>
					</tr>
					<tr>
						<td>8. 이 수업에 만족하며 이 강의를 추천할 것이다.</td>

						<td><font style="vertical-align: inherit;"><input type="radio" name="qst8" id="qst8-1"><label for="qst8-1" class="h-20 p-10 mb-0"></label></font></td>
						<td><font style="vertical-align: inherit;"><input type="radio" name="qst8" id="qst8-2"><label for="qst8-2" class="h-20 p-10 mb-0"></label></font></td>
						<td><font style="vertical-align: inherit;"><input type="radio" name="qst8" id="qst8-3"><label for="qst8-3" class="h-20 p-10 mb-0"></label></font></td>
						<td><font style="vertical-align: inherit;"><input type="radio" name="qst8" id="qst8-4"><label for="qst8-4" class="h-20 p-10 mb-0"></label></font></td>
						<td><font style="vertical-align: inherit;"><input type="radio" name="qst8" id="qst8-5"><label for="qst8-5" class="h-20 p-10 mb-0"></label></font></td>
					</tr>
					<tr></tr>
					<tr>
						<td class="text-center"><h3>총평</h3></td>
						<td colspan="4">
							<textarea rows="3" cols="80" class="form-control" id="comment" name="comment"></textarea>
						</td>
						<td> </td>
					</tr>
				</tbody>
			</table>
			</form>
			<div class="text-end"><button class="btn btn-primary-light" id="testBtn">테스트</button></div>
			<div class="text-end"><button class="btn btn-primary-light" id="ratingApplyBtn">제출</button></div>
		</div>
	</div>
</body>

<script>
	var classNo = ${listenerVO.classNo }
	var listenNo = ${listenerVO.listenNo }
	
	var ratingApplyBtn = $("#ratingApplyBtn");
	
	var ratingData = {}; 
	
	$("#testBtn").on("click", function () {
		$("label[for=qst1-1]").trigger("click");
		$("label[for=qst2-2]").trigger("click");
		$("label[for=qst3-2]").trigger("click");
		$("label[for=qst4-1]").trigger("click");
		$("label[for=qst5-3]").trigger("click");
		$("label[for=qst6-1]").trigger("click");
		$("label[for=qst7-4]").trigger("click");
		$("label[for=qst8-1]").trigger("click");
		$("#comment").val("정말 알찬 수업이었습니다.")
	})
	
	ratingApplyBtn.on("click", function () {
		
		var comm = $("#comment").val();
		
		if(comm == null || comm == ""){
			alert("총 평가를 입력해주세요.");
			return;
		}
		
		var ratingSelect = $("#ratingTable").find("tr");
		ratingData = [];
			
		for (var i = 0; i < 8; i++) {
			//console.log($(ratingSelect[i]).find("input:checked"));
			var str = $(ratingSelect[i]).find("input:checked").attr("id");
			
			if(str != null && str != ""){
				data = {
						"lecQstChoice" : str.substring(5, 6),
						"lecQstNo" : (i+1)
				}
				ratingData.push(data);
			}
		}
		
		console.log("ratingData :",ratingData);
		
		ratingData = {
				"classNo" : classNo,
				"listenNo" : listenNo,
				"lecRatingList" : ratingData,
				"classComment" : comm
		}
		
		//console.log(ratingData.lecRatingList.length);
		
		var msg = "";
		
		if( (8-ratingData.lecRatingList.length) != 0){
			msg = (8-ratingData.lecRatingList.length) + "개의 선택하지 않은 응답이 남아 있습니다.\n"
		}
			
		if(confirm(msg+"제출 하시겠습니까?")){
			$.ajax({
				 type : 'post',
				 url : '/DYUniv/class/ratingForm.do',
				 contentType : "application/json; charset=utf-8",
				 data : JSON.stringify(ratingData),
				 success : function(res) { // 결과 성공 콜백함수       
					 console.log(res);
					 if(res == "OK"){
						 location.href = "/DYUniv/student/class/myClassScore.do";
					 } else {
						 alert("저장에 실패하였습니다.");
					 }
				 }
			})
		}
		
	})
</script>
