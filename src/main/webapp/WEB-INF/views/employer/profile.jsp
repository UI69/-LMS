<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>


<div class="container-full">
<div class="content-header">
	<div class="d-flex align-items-center">
		<div class="me-auto">
			<!-- 현재 메뉴명 --><h3 class="page-title">개인정보</h3>
			<div class="d-inline-block align-items-center">
				<nav>
					<ol class="breadcrumb">
						<!-- 홈아이콘 --><li class="breadcrumb-item"><a href="#"><i class="mdi mdi-home-outline"></i></a></li>
						<!-- 상위메뉴명 --><li class="breadcrumb-item" aria-current="page">개인정보</li>
						<!-- 하위메뉴명(현재메뉴명) --><li class="breadcrumb-item active" aria-current="page">개인정보</li>
					</ol>
				</nav>
			</div>
		</div>

	</div>
</div>

<section class="content"> 
<div class="m-40"></div>
<form action="/DYUniv/proUpdProfile.do" method="post" id="proUpdateForm" enctype="multipart/form-data">
<div class="row m-15">
<!-- 프로필 -->
    <div class="widget-user-image col-2">
      <img class="border-radius" src="${pageContext.request.contextPath }/resources/images/user3-128x128.jpg" 
      name="memProfile" alt="User Avatar">
   <br>     프로필 이미지
   <input class="form-control" type="file" id="memProfile">
    </div>

    <div class="col-5">
        <!-- 학번 -->
        <div class="form-group row">
          <label for="example-text-input" class="col-sm-3 col-form-label">ID</label>
          <div class="col-sm-5">
            <input class="form-control" type="text" value="${empmember.memId }" id="example-text-input" readonly>
          </div>
        </div>
        <!-- 학번 -->

        <!-- 비번 -->
        <div class="form-group row">
            <label for="example-password-input" class="col-sm-3 col-form-label">비밀번호</label>
            <div class="col-sm-5">
              <input class="form-control" type="password" value="hunter2" id="example-password-input" >
            </div>
        </div>

        <div class="form-group row">
            <label for="example-password-input" class="col-sm-3 col-form-label">2차비밀번호</label>
            <div class="col-sm-5">
              <input class="form-control" type="password" value="hunter2" id="example-password-input">
            </div>
        </div>

        <!-- 비번 -->

        <!-- 생년월일 -->
        <div class="form-group row">
            <label for="example-date-input" class="col-sm-3 col-form-label">생년/월/일</label>
            <div class="col-sm-5">
                <input class="form-control" type="text" value="${empmember.memBir }" id="example-date-input">
            </div>
          </div>
          <!-- 생년월일 -->
          <!-- 국적 -->
          <div class="form-group row">
              <label for="example-text-input" class="col-sm-3 col-form-label">국적</label>
              <div class="col-sm-5">
                  <input class="form-control" type="text" value="${empmember.memNationCode }" id="example-text-input" readonly>
              </div>
          </div>
          <!-- 국적 -->

    </div>


    <div class="col-5">


        <!-- 성별 -->
		 <div class="form-group row">
		            <label for="example-text-input" class="col-sm-3 col-form-label">성별</label>
		            <div class="col-sm-5">
		            <c:set var="gender" />
		            <c:if test="${empmember.memGen eq 'M' }">
		            	<c:set value="남자" var="gender"/>
		            </c:if>
		            <c:if test="${empmember.memGen eq 'F' }">
		            	<c:set value="여자" var="gender"/>
		            </c:if>
		                <input class="form-control" type="text" value="${gender }"
		                id="example-text-input" readonly>
		            </div>
		        </div>
        <!-- 성별 -->

        <!-- 이메일 -->
        <div class="form-group row">
          <label for="example-email-input" class="col-sm-3 col-form-label">Email</label>
          <div class="col-sm-5">
            <input class="form-control" type="email" value="${empmember.memEmail }" id="example-email-input">
          </div>
        </div>
         <!-- 이메일 -->

<!-- 주소 -->
        <div class="form-group row">
            <label for="example-text-input" class="col-sm-3 col-form-label">주소</label>
            <div class="col-sm-5">
                <input class="form-control" type="text" value="${empmember.memAddr1 }" id="example-text-input" >
            </div>
        </div>


        <div class="form-group row">
            <label for="example-text-input" class="col-sm-3 col-form-label">상세 주소</label>
            <div class="col-sm-5">
                <input class="form-control" type="text" value="${empmember.memAddr2 }" id="example-text-input" >
            </div>
        </div>
<!-- 주소 -->


        <!-- 폰번호 -->
        <div class="form-group row">
          <label for="example-tel-input" class="col-sm-3 col-form-label">전화번호</label>
          <div class="col-sm-5">
            <input class="form-control" type="tel" value="${empmember.memPh }" id="example-tel-input">
          </div>
        </div>
        <!-- 폰번호 -->
    </div>
    <!-- /.col -->
  </div>
</form>
</section>
</div>


  