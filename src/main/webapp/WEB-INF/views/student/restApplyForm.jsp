<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
    
<!DOCTYPE html>
 <div class="container-full">
 <!-- Content Header (Page header) -->
<div class="content-header">
	<div class="d-flex align-items-center">
		<div class="me-auto">
			<!-- 현재 메뉴명 --><h3 class="page-title">학적 변동</h3>
			<div class="d-inline-block align-items-center">
				<nav>
					<ol class="breadcrumb">
						<!-- 홈아이콘 --><li class="breadcrumb-item"><a href="#"><i class="mdi mdi-home-outline"></i></a></li>
						<!-- 상위메뉴명 --><li class="breadcrumb-item" aria-current="page">학적변경 신청</li>
						<!-- 하위메뉴명(현재메뉴명) --><li class="breadcrumb-item active" aria-current="page">학적 변경 신청 </li>
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



<div class="box">

    <!-- /.box-header -->
    <form class="form" action="/DYUniv/restApplyForm.do" id="restForm" name="" method="post" enctype="multipart/form-data">
        <div class="box-body">
            <h4 class="box-title text-info mb-0"><i class="ti-user me-15"></i> 학적 변동신청</h4>
            <hr class="my-15">
            <div class="row">
              <div class="col-md-6">
                <div class="form-group">
                    <label class="form-label">학적변동유형 </label>
					<select name="restType" id="restType" class="form-select">
						<option value="">---선택---</option>
					    <c:choose>
					        <c:when test="${memberInfo.studentInfoVO.memStatusCode eq 'MEM001'}">
					            <option value="rst001">휴학</option>
					            <option value="rst003">자퇴</option>
					        </c:when>
					        <c:when test="${memberInfo.studentInfoVO.memStatusCode eq 'MEM002'}">
					            <option value="rst002">복학</option>
					            <option value="rst003">자퇴</option>
					        </c:when>
					    </c:choose>
					</select>
                  </div>
              </div>

              <div class="col-md-6">
                <div class="form-group">
                  <label class="form-label">학과</label>
                  <input id="deptment" name="deptment" type="text" class="form-control"
                   placeholder="학과" readonly="readonly" value="${memberInfo.departmentVO.dprtName }">
               		
                </div>
              </div>


              
              <div class="col-md-6">
                <div class="form-group">
                  <label class="form-label">이름</label>
                  <input id="memName" name="memName" type="text" class="form-control" 
                  placeholder="" readonly="readonly" value="${memberInfo.memName }">
                </div>
              </div>


            <div class="col-md-6">
                <div class="form-group">
                  <label class="form-label">연락처</label>
                  <input id="tell" name="tell" type="text" class="form-control" 
                  placeholder="" readonly="readonly" value="${memberInfo.memPh }">
                </div>
            </div>

              <div class="col-md-6">
                <div class="form-group">
                  <label class="form-label">학번</label>
                  <input id="clsNum" name="clsNum" type="text" class="form-control" 
                  placeholder="학번" readonly="readonly" value="${memberInfo.memId }">
                </div>
              </div>

              <div class="col-md-6">
                <div class="form-group">
                  <label class="form-label">학년</label>
                  <input id="grad" name="grad" type="text" class="form-control" 
                  	placeholder="학년" readonly="readonly" value="${memberInfo.studentInfoVO.memStdGrade }">
                </div>
              </div>

            <div class="form-group">
                <label class="form-label">신청 사유</label>
                <textarea id="restApReason" name="restApReason" rows="5" cols="3" class="form-control" placeholder=""></textarea>
            </div>



            <div class="box-footer">
                <button type="button" id="listBtn" class="btn btn-warning me-1">
                  <i class="si-list si"></i> 뒤로가기
                </button>
                <button type="button" id="insertBtn" value="" class="btn btn-primary">
                  <i class="si-pencil si"></i> 등록
                </button>
                <button type="button" value="" class="btn btn-danger-light" id="insertTest">
                  test
                </button>
            </div>  
            <hr class="my-15">
        </div>
        <!-- /.box-body -->
        </div>
    </form>
    </div>
    </section>
  </div>
  
<script type="text/javascript">
$(function(){

  var insertBtn = $("#insertBtn");  // 등록
  var listBtn = $("#listBtn");
  
  
  insertBtn.on("click", function (){
	  var restForm = $("#restForm");
	  
	  var restType = $("#restType").val();
	  
	  var restApReason = $("#restApReason").val();
    
	  var appliFile = $("#appliFile").val();
	 
	  console.log("restType",restType);
	  console.log("restApReason",restApReason);
	  console.log("appliFile",appliFile);
	  
	  restForm.submit();
	  
  });
  
	listBtn.on("click", function () {
		location.href = "/DYUniv/mainpage.do";
	});
  
});

$("#insertTest").on("click", function () {
	$("#restType").val("rst001");
	$("#restApReason").val("어학연수를 하려고 합니다.");
})

</script>