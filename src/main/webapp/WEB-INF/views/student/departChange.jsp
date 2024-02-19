<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
    
<!DOCTYPE html>

<hr>
 <div class="container-full">
 <!-- Content Header (Page header) -->
<div class="content-header">
	<div class="d-flex align-items-center">
		<div class="me-auto">
			<!-- 현재 메뉴명 --><h3 class="page-title">전과 </h3>
			<div class="d-inline-block align-items-center">
				<nav>
					<ol class="breadcrumb">
						<!-- 홈아이콘 --><li class="breadcrumb-item"><a href="#"><i class="mdi mdi-home-outline"></i></a></li>
						<!-- 상위메뉴명 --><li class="breadcrumb-item" aria-current="page">전과 신청</li>
						<!-- 하위메뉴명(현재메뉴명) --><li class="breadcrumb-item active" aria-current="page">전과 신청 </li>
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
<!--     
	<div class="box-header with-border">
      <h4 class="box-title">학적 변동 신청 </h4>
    </div> 
-->
    <!-- /.box-header -->
    <form class="form" action="/DYUniv/departChange.do" id="deptmentForm" name="deptmentForm" method="post" enctype="multipart/form-data">
        <div class="box-body">
            <h4 class="box-title text-info mb-0"><i class="ti-user me-15"></i> 전과 신청 </h4>
            <hr class="my-15">
            <div class="row">
           <div class="col-md-6">
			    <div class="form-group">
			        <label class="form-label">희망 전과명</label>
			        <select id="deptmentType" name="deptmentType" class="form-control" >
			            <c:forEach var="departList" items="${departList}">
			            <c:if test="${memberDpart.departmentVO.dprtName ne departList.dprtName }">
			                <option value="${departList.dprtNo}">${departList.dprtName}</option>
			            </c:if>
			            </c:forEach>
			        </select>
			    </div>
			</div>

              <div class="col-md-6">
                <div class="form-group">
                  <label class="form-label">전공 </label>
                  <input id="memName" name="memName" type="text" class="form-control" 
                  placeholder="" readonly="readonly" 
                  	value="${memberDpart.departmentVO.dprtName }"><c:if test=""></c:if>
                </div>
              </div>

              
              <div class="col-md-6">
                <div class="form-group">
                  <label class="form-label">이름</label>
                  <input id="memName" name="memName" type="text" class="form-control" 
                  placeholder="" readonly="readonly" value="${memberDpart.memName }">
                </div>
              </div>
              

            <div class="col-md-6">
                <div class="form-group">
                  <label class="form-label">연락처</label>
                  <input id="" name="" type="text" class="form-control" 
                  placeholder="" readonly="readonly" value="${memberDpart.memPh }">
                </div>
            </div>
            
            
              <div class="col-md-6">
                <div class="form-group">
                  <label class="form-label">학년</label>
                  <input id="" name="" type="text" class="form-control" 
                  placeholder="학년" readonly="readonly" value="${memberDpart.studentInfoVO.memStdGrade }">
                </div>
              </div>
              <div class="col-md-6">
                <div class="form-group">
                  <label class="form-label">학번</label>
                  <input id="" name="" type="text" class="form-control" 
                  placeholder="학번" readonly="readonly" value="${memberDpart.memNo }">
                </div>
              </div>
        	
              <div class="col-md-6">
                <div class="form-group">
                  <label class="form-label">성적</label>
                  <input id="" name="" type="text" class="form-control" 
                  	placeholder="" readonly="readonly" value="${memberDpart.memTotalGrade }">
                </div>
              </div>

            <div class="form-group">
                <label class="form-label">신청 사유</label>
                <textarea id="chDprtMsg" name="chDprtMsg" rows="5" cols="3" class="form-control" placeholder=""></textarea>
            </div>


            <div class="box-footer">
                <button type="button" class="btn btn-warning me-1">
                  <i class="si-list si"></i> 뒤로가기
                </button>
                <button type="button" id="insertBtn" value="" class="btn btn-primary">
                  <i class="si-pencil si"></i> 등록
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

  insertBtn.on("click", function (){
	  var deptmentForm = $("#deptmentForm");
	  
	  var deptmentType = $("#deptmentType").val();
	  
	  var chDprtMsg = $("#chDprtMsg").val();
	 
	  console.log("deptmentType",deptmentType);
	  console.log("chDprtMsg",chDprtMsg);
	  
	 deptmentForm.submit();
	  
  });
});
</script> 