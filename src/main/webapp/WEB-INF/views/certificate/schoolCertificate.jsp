<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>	
  
   
 <!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
     <style type="text/css">
      * {
        box-sizing: border-box;
        -moz-box-sizing: border-box;
      }
      body {
      	
        margin: 0;
        padding: 0;
      }
      .page {
        width: 21cm;
        height: 29.7cm;
        padding: 1.5cm 1.5cm 2cm 1.5cm;
        border: 1px solid #ccc;
        position: relative;
        background: white;
        z-index: -10;
      }
      @media print {
        .page {
          margin: 0;
          border: initial;
          border-radius: initial;
          width: initial;
          min-height: initial;
          box-shadow: initial;
          page-break-after: always;
        }
      }
      @page {
        size: A4;
        margin: 0;
      }
      .box {
        width: 100%;
        height: 100%;
        text-align: center;
        table-layout: fixed;
        position: relative;
        border-style: double;
        border-width: 7px;
        border-color: #828282;
      }
      .box > * {
        position: absolute;
      }
      .header {
        top: 5%;
        left: 5%;
      }
      .title {
        top: 10%;
        left: 50%;
        transform: translate(-50%, -10%);
      }
      .userData {
        top: 20%;
        right: 15%;
        text-align: left !important;
      }
      .userTitle {
        display: inline-flex;
        justify-content: space-between;
        width: 100px;
        letter-spacing: 3px;
      }
      table { 
        width: 100%;
        max-height: 40%;
        top: 38%;
      }
      td {
        padding: 15px;
      }
      thead {
        background-color: #ccc;
      }
      .footer {
        display: flex;
        flex-direction: column;
        bottom: 3%;
        left: 0;
        width: 100%;
        height: 20%;
      }
      .footer > * {
        width: 100%;
      }
      .dojang {
        bottom: 3%;
        right: 25%;
      }
      .dojang img {
        width: 100px;
        height: 100px;
        opacity: 0.7;
      }
      .logo {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        z-index: -1;
      }
      .logo img {
        width: 550px;
        height: 550px;
        opacity: 0.3;
      }
    </style>

    <title>재학증명서</title>
<!-- 제이쿼리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/vendor_components/jquery-ui/jquery-ui.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui-touch-punch/0.2.3/jquery.ui.touch-punch.min.js"></script>

<!-- pdf -->
<script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.4/jspdf.min.js"></script> 
    
  </head>
  <body>
	<div>
    <div class="page" id="capture">
      <div class="box">
        <div class="header">
          <p>제 2024-049589 호</p>
        </div>
        <div class="title">
          <h1>재 학 증 명 서</h1>
        </div>
        <div class="userData">
          <p>
            <span class="userTitle"><span>성</span><span>명</span></span> :
            <span>${member.memName }</span>
          </p>
          <p>
            <span class="userTitle"><span>생년</span><span>월일</span></span> :
            <span>${member.memBir }</span>
          </p>
        </div>

        <table>
          <thead>
            <tr>
              <td colspan="">대학</td>
              <td colspan="">전공</td>
              <td colspan="">입학년월일</td>
            </tr>
          </thead>
          <tr>
          <td>
	          <c:set var="dpc"/>
		          <c:if test="${member.departmentVO.dprtCategory eq 'DPC001' }">
		          	<c:set var="dpc" value="인문"/>
		          </c:if>
		          <c:if test="${member.departmentVO.dprtCategory eq 'DPC002' }">
		          	<c:set var="dpc" value="사회"/>
		          </c:if>
		          <c:if test="${member.departmentVO.dprtCategory eq 'DPC003' }">
		          	<c:set var="dpc" value="교육"/>
		          </c:if>
		          <c:if test="${member.departmentVO.dprtCategory eq 'DPC004' }">
		          	<c:set var="dpc" value="공학"/>
		          </c:if>
		          <c:if test="${member.departmentVO.dprtCategory eq 'DPC005' }">
		          	<c:set var="dpc" value="자연"/>
		          </c:if>
		          <c:if test="${member.departmentVO.dprtCategory eq 'DPC006' }">
		          	<c:set var="dpc" value="의약"/>
		          </c:if>
		          <c:if test="${member.departmentVO.dprtCategory eq 'DPC007' }">
		          	<c:set var="dpc" value="예체능"/>
		          </c:if>   
		         ${dpc }대학 ${member.departmentVO.dprtName }
          	</td>
            
           <td>${member.departmentVO.dprtName }</td><!-- 전공 -->
            	<td>${fn:substring(member.studentInfoVO.memRegDate, 0, 10) }</td>
          </tr>
        </table>

        <div class="footer"> 
           <p>위 사실을 증명합니다.</p> 
           <p>2024년 02월 16일</p>
           
           <h2>대 육 대 학 교 총 장</h2>
        </div>

       <div class="dojang">
          <img src="${pageContext.request.contextPath}/resources/images/dojang.png" alt="" />
        </div>

        
        <div class="logo">
          <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="">
      </div>
      </div>
    </div>
    </div>
  </body>
</html>
 <script type="text/javascript">

 html2canvas(document.querySelector("#capture")).then(canvas => {
		// html2canvas를 사용하여 ID가 "capture"인 요소의 내용을 캡처

		var imgData = canvas.toDataURL('image/jpeg');
		// 캔버스 데이터를 JPEG 형식의 데이터 URL로 변환
		// PDF의 초기 매개변수를 설정

		var imgWidth = 210; 
		var pageHeight = imgWidth * 1.414; 
		var imgHeight = canvas.height * imgWidth / canvas.width;
		var heightLeft = imgHeight;
		var margin = 0;

		// jsPDF 라이브러리를 사용하여 새로운 PDF 문서를 생성
		var doc = new jsPDF('p', 'mm', 'a4');
		var position = 0;

		// 첫 페이지에 이미지를 추가합니다.
		doc.addImage(imgData, 'jpeg', margin, position, imgWidth, imgHeight);
		heightLeft -= pageHeight; // 남은 높이 갱신
		// 이미지 높이가 페이지 높이보다 클 경우 추가 페이지를 생성
		while (heightLeft >= 20) {
			position = heightLeft - imgHeight;
			doc.addPage();
			doc.addImage(imgData, 'jpeg', margin, position, imgWidth, imgHeight);
			heightLeft -= pageHeight;
			}

		// 생성된 PDF를 'sample.pdf'로 저장
		doc.save('sample.pdf');

		});

</script>