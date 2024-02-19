<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   

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
          background: initial;
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
        top: 0;
        left: 3%;
      }
      .title {
        top: 5%;
        left: 50%;
        transform: translate(-50%, -10%);
      }
      .table1 {
        border: 1px solid #ccc;
        width: 100%;
        top: 14%;
      }
      .table1 td {
        border: 1px solid #ccc;
      }
      .table2 {
        width: 100%;
        max-height: 50%;
        top: 25%;
        font-size: small;
      }
      .table2 td {
        border-bottom: 1px solid #ccc;
      }
      td {
        padding: 10px;
      }
      .color {
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

    <title>성적증명서</title>
<!-- 제이쿼리 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/assets/vendor_components/jquery-ui/jquery-ui.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui-touch-punch/0.2.3/jquery.ui.touch-punch.min.js"></script>

<!-- pdf -->
<script src="https://html2canvas.hertzen.com/dist/html2canvas.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.4/jspdf.min.js"></script> 
 
</head>

<c:if test="${empty memberStdVO }">
<script>
	alert("데이터가 없습니다.");
	location.href = "/DYUniv/certificate";
</script>
</c:if>
 
<body>
<div>
    <div class="page" id="capture">
      <div class="box">
        <div class="header">
          <p>제 2024-049589 호</p>
        </div>
        <div class="title">
          <h1>성 적 증 명 서</h1>
        </div>

        <table class="table1">
          <tr>
            <td colspan="1" class="color">성명</td>
            <td colspan="3">${memberStdVO.memName }</td>
            <td colspan="1" class="color">학번</td>
            <td colspan="3"><!-- 20201234 -->${memberStdVO.dprtNo }</td>
          </tr>
          <tr>

            <td colspan="1" class="color">학과 </td>
            <td colspan="3">
				  <c:set var="dpc"/>
		          <c:if test="${memberStdVO.departmentVO.dprtCategory eq 'DPC001' }">
		          	<c:set var="dpc" value="인문"/>
		          </c:if>
		          <c:if test="${memberStdVO.departmentVO.dprtCategory eq 'DPC002' }">
		          	<c:set var="dpc" value="사회"/>
		          </c:if>
		          <c:if test="${memberStdVO.departmentVO.dprtCategory eq 'DPC003' }">
		          	<c:set var="dpc" value="교육"/>
		          </c:if>
		          <c:if test="${memberStdVO.departmentVO.dprtCategory eq 'DPC004' }">
		          	<c:set var="dpc" value="공학"/>
		          </c:if>
		          <c:if test="${memberStdVO.departmentVO.dprtCategory eq 'DPC005' }">
		          	<c:set var="dpc" value="자연"/>
		          </c:if>
		          <c:if test="${memberStdVO.departmentVO.dprtCategory eq 'DPC006' }">
		          	<c:set var="dpc" value="의약"/>
		          </c:if>
		          <c:if test="${memberStdVO.departmentVO.dprtCategory eq 'DPC007' }">
		          	<c:set var="dpc" value="예체능"/>
		          </c:if>   
		         ${dpc }대학 ${memberStdVO.departmentVO.dprtName }      	
            </td>

            <td colspan="1" class="color">학적상태</td>
			 	<td colspan="3"><!-- 재학 -->
		 		<c:set var="stuInfo"/>
				  <c:choose>
					    <c:when test="${memberStdVO.studentInfoVO.memStatusCode eq 'MEM001'}">
					      <c:set var="stuInfo" value="재학"/>
					    </c:when>
					    <c:when test="${memberStdVO.studentInfoVO.memStatusCode eq 'MEM002'}">
					      <c:set var="stuInfo" value="휴학"/>
					    </c:when>
					    <c:when test="${memberStdVO.studentInfoVO.memStatusCode eq 'MEM003'}">
					      <c:set var="stuInfo" value="제적"/>
					    </c:when>
					    <c:when test="${memberStdVO.studentInfoVO.memStatusCode eq 'MEM004'}">
					      <c:set var="stuInfo" value="졸업"/>
					    </c:when>
					    <c:when test="${memberStdVO.studentInfoVO.memStatusCode eq 'MEM005'}">
					      <c:set var="stuInfo" value="수료"/>
					    </c:when>
				  </c:choose>
				  ${stuInfo }
				</td>
          </tr>
        </table>
        <table class="table2">
          <tr>
            <td colspan="2" class="color">학기</td>
            <td colspan="2" class="color">취득학점</td>
            <td colspan="2" class="color"></td>
            <td colspan="2" class="color">성적</td>
          </tr>
			  <tr>
         		<c:forEach items="${memberStdVO.classList}" var="member" >
			   		<td colspan="2"> ${member.semester } / 1학기</td>
		        	<td colspan="2"> ${member.lecPoint } /4.5 학점</td>
         		</c:forEach>
         		<c:forEach items="${memberStdVO.lectureScoreList }" var="member">
         			<td colspan="2"> ${member.lecScr } /점</td>
         		</c:forEach>
				<c:forEach items="${memberStdVO.listenerList}" var="member">
            		<td colspan="2"> ${member.classScore} </td>
				</c:forEach>
			  </tr>
			
			  <tr>
         		<c:forEach items="${memberStdVO.classList}" var="member" >
			   		<td colspan="2"> ${member.semester } / 2학기</td>
		        	<td colspan="2"> ${member.lecPoint } /4.5 학점</td>
         		</c:forEach>
         		<c:forEach items="${memberStdVO.lectureScoreList }" var="member">
         			<td colspan="2"> ${member.lecScr } /점</td>
         		</c:forEach>
				<c:forEach items="${memberStdVO.listenerList}" var="member">
            		<td colspan="2"> ${member.classScore} </td>
				</c:forEach>
			  </tr>
          		

<%--      <tr>
            <td colspan="2">2020년 / 1학기 ${member.ClassVO.semester } </td>
            <td colspan="2">2  ${member.ClassVO.lecPoint }</td>
           <td colspan="2">A+  ${member.ListenerVO.classScore }</td>
          </tr>
          <tr>
            <td colspan="2">2020년 / 1학기  ${member.ClassVO.semester }</td>
            <td colspan="2">2  ${member.ClassVO.lecPoint }</td>
            <td colspan="2">A+  ${member.ListenerVO.classScore }</td>
          </tr>
          <tr>
            <td colspan="2">2020년 / 1학기  ${member.ClassVO.semester }</td>
            <td colspan="2">2  ${member.ClassVO.lecPoint }</td>
            <td colspan="2">A+  ${member.ListenerVO.classScore }</td>
          </tr> --%>
         </table>

        <div class="footer">
          <p>위 사실을 증명합니다.</p>
          <p>2024년 01월 16일</p>

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


<script>

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

const grades = [
	  { grade: "A+", credit: 3 },
	  { grade: "A", credit: 3 },
	  { grade: "B+", credit: 2 },
	  { grade: "B", credit: 2 },
	  { grade: "C+", credit: 1 },
	  { grade: "C", credit: 1 },
	  { grade: "D", credit: 1 },
	  { grade: "F", credit: 1 },
	];

	function calculate(grades) {
	  let totalCredits = 0;
	  let totalGradePoints = 0;

	  for (let i = 0; i < grades.length; i++) {
	    let grade = grades[i].grade;
	    let credit = grades[i].credit;
	    let score = parseInt(document.getElementById(`score${i}`).value);

	    switch (grade) {
	      case "A+":
	        totalGradePoints += 4.5 * credit * score;
	        break;
	      case "A":
	        totalGradePoints += 4.0 * credit * score;
	        break;
	      case "B+":
	        totalGradePoints += 3.5 * credit * score;
	        break;
	      case "B":
	        totalGradePoints += 3.0 * credit * score;
	        break;
	      case "C+":
	        totalGradePoints += 2.5 * credit * score;
	        break;
	      case "C":
	        totalGradePoints += 2.0 * credit * score;
	        break;
	      case "D":
	        totalGradePoints += 1.0 * credit * score;
	        break;
	      case "F":
	        totalGradePoints += 0.0 * credit * score;
	        break;
	      default:
	        console.log("Invalid grade");
	    }
			
	    totalCredits += credit;
	  }

	  let gpa = totalGradePoints / totalCredits;
	  return gpa.toFixed(2);
	}

		

</script>

