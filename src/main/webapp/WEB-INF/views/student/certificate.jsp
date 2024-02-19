<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

 <div class="container-full">
 <!-- Content Header (Page header) -->
<div class="content-header">
	<div class="d-flex align-items-center">
		<div class="me-auto">
			<!-- 현재 메뉴명 --><h3 class="page-title">증명서 발급</h3>
			<div class="d-inline-block align-items-center">
				<nav>
					<ol class="breadcrumb">
						<!-- 홈아이콘 --><li class="breadcrumb-item"><a href="#"><i class="mdi mdi-home-outline"></i></a></li>
						<!-- 상위메뉴명 --><li class="breadcrumb-item" aria-current="page">증명서 발급</li>
						<!-- 하위메뉴명(현재메뉴명) --><li class="breadcrumb-item active" aria-current="page">증명서 발급</li>
					</ol>
				</nav>
			</div>
		</div>

	</div>
</div>
 
 
<section class="content">  
	<div class="col-12">
	    <div class="box">
	      </div>
	 </div>



<div class="col-12 col-lg-11">
			  <div class="box">
				<div class="box-header with-border">
				  <h4 class="box-title">증명서 선택</h4>
				</div>
				<!-- /.box-header -->
				<div class="box-body">
					<div class="table-responsive">
					 <form action=""></form>
					  <table class="table mb-0">
						  <thead class="table-light">
							<tr>
							  <th scope="col">증명서 종류</th>
							  <th scope="col">옵션</th>
							</tr>
						  </thead>
						  <tbody>
							<tr>
							  <th scope="row">
							  	<select class="form-control select2" name="certificate" id="certificate">
							  		<option value="">-선택-</option>
							  		<option value="graduationPrice" id="graduationPrice">졸업 증명서</option>
							  		<option value="score" id="score">성적 증명서</option>
							  		<option value="enrollment" id="enrollment">재학 증명서</option>
							  	</select>
							   </th>
							  <td>
								
								<input class="form-control" name="crfCount" id="crfCount" type="number" min="0" max="5" placeholder="0" style="display: block">	  
							  </td>
							</tr>
							
							
							<tr>
								<td>
								</td>
								<td class="">
									총<input id="totalPrice" type="text" class="form-control" placeholder="총금액" readonly="readonly">
								</td>
							</tr>
							
						  </tbody>
						</table>
						<div class="text-end m-15">
							<button type="submit" class="btn btn-danger-light pull-right" id="paymentTest" >test</button>
							<button type="submit" class="btn btn-primary-light pull-right" id="payment" >카카오페이</button>
                    	 	<button type="button" class="btn btn-primary-light pull-right" >무통장입금</button>
                    		 <button type="button" class="btn btn-primary-light pull-right" >신용카드</button>
						</div>
					</div>
				</div>
			</div>
				<!-- /.box-body -->
		</div>
			  <!-- /.box -->
	</section>
</div>


<script>
$(document).ready(function() {
  var price = 2000;
  
	function priceTotal () {
		var total = $('#crfCount').val()*price;
	 	console.log("test: "+total );
	 	// 총 금액을 나타내는 readonly 속성의 입력 필드를 업데이트
    	$('#totalPrice').val(total);
	}
	
	// 모든 input 박스에 변경 이벤트를 연결
	$('#crfCount').change(function() {
	    priceTotal();
	});
	
	// "결제" payment 버튼에 클릭 이벤트
	$('#payment').click(function() {
	    var totalAmount = $('input[readonly="readonly"]').val();
	    console.log('총 금액:', totalAmount);
 
	    var crfCount = $('#crfCount').val();	// 증명서 갯수
	    var certificate = $('#certificate option:selected').val(); // 선택된 증명서 이름
	    
	    console.log("crfCount : " +crfCount);
	    console.log("certificate : " +certificate);
	    if(certificate == null || certificate ==""){
	    	alert("증명서 선택 해주세요");
	    	return false;
	    }
	    if(crfCount == 0  || crfCount ==""){
	    	alert("증명서 갯수 를  선택 해주세요");
	    	return false;
	    }
	    
	    var certificate = {
	    	certificate : certificate,	// 종류
	    	crfCount : crfCount,		// 갯수
            totalAmount : totalAmount	// 가격

	    }
	    
	    var option =  "width = 500, height = 500, top = 100, left = 200, location = no";
	    var name = "popup";
	    
 		/* console.log("certificate : :",certificate); */
		$.ajax({
			type : "post",
			url : "/DYUniv/payment/ready",
			data: JSON.stringify(certificate),
			contentType : "application/json; charset=utf-8",
			success : function(res) {
				console.log("res" +res);
			   	//location.href = res.next_redirect_pc_url;		// 결제 페이지로 이동 
				window.open(res.next_redirect_pc_url, name, option);
			}
		})
		
	});
});

$("#paymentTest").on("click", function () {
	$("#certificate").val("enrollment");
	$("#crfCount").val("2").trigger("change");
})


</script>



