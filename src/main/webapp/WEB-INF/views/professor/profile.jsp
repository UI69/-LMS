<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
<form action="/DYUniv/updProfile.do" method="post" id="proUpdateForm" enctype="multipart/form-data">
	<div class="row m-15">
	<!-- 프로필 -->
    <div class="widget-user-image col-2">
		<c:if test="${empty promember.memProfile }">
			<img class="border-radius" src="${pageContext.request.contextPath }/resources/images/user3-128x128.jpg" 
				name="memProfile" alt="User Avatar" style="width: 220px;">
			<div>프로필 이미지</div>
		</c:if>
	    <c:if test="${!empty promember.memProfile }">
	      <img class="border-radius" src="${pageContext.request.contextPath }/resources/files${promember.memProfile }"
	      	name="memProfile" alt="User Avatar" style="width: 220px;">
		</c:if>
	   <br>     
	   <input class="form-control mt-15" type="file" id="memProfileFile">
	   <input class="form-control" type="hidden" id="memProfile" name="memProfile">
    </div>
	
    <div class="col-5">
        <!-- 학번 -->
        <div class="form-group row">
          <label for="example-text-input" class="col-sm-3 col-form-label">아이디</label>
          <div class="col-sm-5">
            <input class="form-control" type="text" value="${promember.memId }" 
            	name="memId" id="memId" readonly>
          </div>
        </div>
        <!-- 학번 -->

        <!-- 비번 -->
        <div class="form-group row">
            <label for="example-password-input" class="col-sm-3 col-form-label">비밀번호</label>
            <div class="col-sm-5">
              <input class="form-control" type="password" value="" 
              name="memPw" id="memPw" >
            </div>
        </div>

        <div class="form-group row">
            <label for="example-password-input" class="col-sm-3 col-form-label">2차 비밀번호 확인</label>
            <div class="col-sm-5">
              <input class="form-control" type="password" value="" 
              name="memPw2" id="memPw2">
            </div>
        </div> 
	
        <!-- 비번 -->

        <!-- 생년월일 -->
        <div class="form-group row">
            <label for="example-date-input" class="col-sm-3 col-form-label">생년/월/일</label>
            <div class="col-sm-5">
                <input class="form-control" type="text" value="${promember.memBir }" 
                name="memBir" id="memBir" readonly="readonly">
            </div>
          </div>
          <!-- 생년월일 -->
          <!-- 국적 -->
          <div class="form-group row">
              <label for="example-text-input" class="col-sm-3 col-form-label">국적</label>
              <div class="col-sm-5">
                  <input class="form-control" type="text" value="${promember.memNationCode }" 
                 	 name="memNationCode" id="memNationCode" readonly>
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
	            <c:if test="${promember.memGen eq 'M' }">
	            	<c:set value="남자" var="gender"/>
	            </c:if>
	            <c:if test="${promember.memGen eq 'F' }">
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
	            <input class="form-control" type="email" value="${promember.memEmail }" 
	           	 	name="memEmail" id="memEmail">
	          </div>
	        </div>
	         <!-- 이메일 -->
	
			<!-- 주소 -->
	        <div class="form-group row">
	            <label for="example-text-input" class="col-sm-3 col-form-label">우편 번호</label>
	            <div class="col-sm-5">
	                <input class="form-control" type="text" value="${promember.memPostcode }" 
	                name="memPostcode" id="memPostcode"  readonly="readonly">
			    <span class="input-group-append">
					  <button type="button" onclick="DaumPostcode()" class="btn btn-secondary btn-flat">우편번호 찾기</button>
			    </span>
	            </div>
	        </div>
	        
	        <div class="form-group row">
	            <label for="example-text-input" class="col-sm-3 col-form-label">주소</label>
	            <div class="col-sm-5">
	                <input class="form-control" type="text" value="${promember.memAddr1 }" 
	               	 	name="memAddr1" id="memAddr1" >
	            </div>
	        </div>	
	
	        <div class="form-group row">
	            <label for="example-text-input" class="col-sm-3 col-form-label">상세 주소</label>
	            <div class="col-sm-5">
	                <input class="form-control" type="text" value="${promember.memAddr2 }" 
	               	 	name="memAddr2" id="memAddr2" >
	            </div>
	        </div>
			<!-- 주소 -->
	
	        <!-- 폰번호 -->
	        <div class="form-group row">
	          <label for="example-tel-input" class="col-sm-3 col-form-label">전화번호</label>
	          <div class="col-sm-5">
	            <input class="form-control" type="tel" value="${promember.memPh }" 
	            	name="memPh" id="memPh">
	          </div>
	        </div>
	        
	
	    </div>
	  </div>
	</form>
	<div class="col-sm-10 col-md-2"
		style="float: right;">
		<button type="button" id="updBtn" class="waves-effect waves-light btn btn-success mb-5">
	       	<i class="fa fa-check"></i> 변경하기 
	    </button>
    </div>
	        <!-- 폰번호 -->
 <h4 class="box-title mt-40">교수 정보</h4>
  <div class="table-responsive">
    <table class="table">
        <tbody>
            <tr>
                <td width="390">대학 </td>
                <td><%-- ${promember.departmentVO.dprtCategory} --%>
		           	<c:set var="dpc" value=""/>
		            <c:if test="${promember.departmentVO.dprtCategory eq 'DPC001' }">
		            	<c:set value="인문" var="dpc"/>
		            </c:if>
		            <c:if test="${promember.departmentVO.dprtCategory eq 'DPC002' }">
		            	<c:set value="사회" var="dpc"/>
		            </c:if>
		            <c:if test="${promember.departmentVO.dprtCategory eq 'DPC003' }">
		            	<c:set value="교육" var="dpc"/>
		            </c:if>
		            <c:if test="${promember.departmentVO.dprtCategory eq 'DPC004' }">
		            	<c:set value="공학" var="dpc"/>
		            </c:if>
		            <c:if test="${promember.departmentVO.dprtCategory eq 'DPC005' }">
		            	<c:set value="자연" var="dpc"/>
		            </c:if>
		            <c:if test="${promember.departmentVO.dprtCategory eq 'DPC006' }">
		            	<c:set value="의약" var="dpc"/>
		            </c:if>
		            <c:if test="${promember.departmentVO.dprtCategory eq 'DPC007' }">
		            	<c:set value="예체능" var="dpc"/>
		            </c:if>
                	${dpc }대학
                </td>

            </tr>
            <tr>
            <td>학과 </td>
            	<td>
                	${promember.departmentVO.dprtName }
             	</td>
            </tr>
            <tr>
                <td></td>
                <td class="text-end">
                
                </td>
            </tr>
        </tbody>
    </table>
</div>
</section>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<script type="text/javascript">
var memProfileFile = $("#memProfileFile");

//파일 업로드
memProfileFile.on("change", function (event) {
  console.log("file name : " + $(this).val());
  
  var file = event.target.files[0];
  
  //사진여부 확인
  if(!isImageFile(file)){
      console.log("not img file...");
      alert("사진만 등록 가능합니다.");
      examImg.val("");
      return false;
  }
  
  var formData = new FormData();
  formData.append("files", file);
  
  $.ajax({
      url : "/DYUniv/profileFileUpload.ajax",
      type : "post",
      data : formData,
      processData : false,
      contentType : false,
      success : function(res){
      	console.log("res : "+ res);
      	
      	if(res == "failed"){
              alert("파일 업로드 실패...");
          } else {
          	$("#memProfile").val(res);
          }
      },
      error : function(request,status,error){        
          alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);  
      }
  })
})


function isImageFile(file) {
	var ext = file.name.split(".").pop().toLowerCase();		//파일명의 확장자를 가져온다
	//확장자중 이미지에 해당하는 확장자가 아닌경우 -1 리턴 (false)
	return ($.inArray(ext, ["jpg", "jpeg", "gif", "png"]) === -1) ? false : true
}


$(function () {
	var proUpdateForm = $("#proUpdateForm");
	var updBtn = $("#updBtn");
	
	updBtn.on("click", function (event) {
		event.preventDefault();
		var memPw	= $("#memPw").val();
		var memPw2	= $("#memPw2").val();
		var memEmail	= $("#memEmail").val();
		var memPostcode = $("#memPostcode").val();
		var memAddr1	= $("#memAddr1").val();
		var memAddr2	= $("#memAddr2").val();
		var memPh	= $("#memPh").val();
		
		
		if(memPw == null || memPw==""){
			alert("비밀번호를 입력해주세요 ");
			return false;
		}
		if(memEmail == null || memEmail==""){
			alert("이메일 입력해주세요 ");
			return false;
		}
		if(memPostcode == null || memPostcode==""){
			alert("주소 를 입력해주세요 ");
			return false;
		}
		if(memPh == null || memPh==""){
			alert("전화 번호 를 입력해주세요 ");
			return false;
		}
		
		if(memPw != memPw2){
			alert("입력한 값이 일치 하지 않습니다");
			memPw.value ="";
			memPw2.value ="";
			memPw.focus();
	
			
		}else{
			 if(confirm("변경 하시겠습니까?")) {
				 proUpdateForm.submit();
	         }
		}
	});
	
	
});
</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function DaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
 
            }
            
            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('memPostcode').value = data.zonecode;
            document.getElementById("memAddr1").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("memAddr2").focus();
        	}
    
   		 }).open();
    
   		}

   
</script>

  