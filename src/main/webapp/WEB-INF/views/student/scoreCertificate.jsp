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
  </head>
  <body>
    <div class="page">
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
            <td colspan="3">${member.memName }</td>
            <td colspan="1" class="color">학번</td>
            <td colspan="3"><!-- 20201234 -->${member.dprtNo }</td>
          </tr>
          <tr>

            <td colspan="1" class="color">학과 </td>
            <td colspan="3">
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

            <td colspan="1" class="color">학적상태</td>
			 	<td colspan="3"><!-- 재학 -->
		 		<c:set var="stuInfo"/>
				  <c:choose>
					    <c:when test="${member.studentInfoVO.memStatusCode eq 'MEM001'}">
					      <c:set var="stuInfo" value="재학"/>
					    </c:when>
					    <c:when test="${member.studentInfoVO.memStatusCode eq 'MEM002'}">
					      <c:set var="stuInfo" value="휴학"/>
					    </c:when>
					    <c:when test="${member.studentInfoVO.memStatusCode eq 'MEM003'}">
					      <c:set var="stuInfo" value="제적"/>
					    </c:when>
					    <c:when test="${member.studentInfoVO.memStatusCode eq 'MEM004'}">
					      <c:set var="stuInfo" value="졸업"/>
					    </c:when>
					    <c:when test="${member.studentInfoVO.memStatusCode eq 'MEM005'}">
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
         		<c:forEach items="${member.classList}" var="member" >
			   		<td colspan="2"> ${member.semester } / 1학기</td>
		        	<td colspan="2"> ${member.lecPoint } /4.5 학점</td>
         		</c:forEach>
         		<c:forEach items="${member.lectureScoreList }" var="member">
         			<td colspan="2"> ${member.lecScr } /점</td>
         		</c:forEach>
				<c:forEach items="${member.listenerList}" var="member">
            		<td colspan="2"> ${member.classScore} </td>
				</c:forEach>
			  </tr>
			
			  <tr>
         		<c:forEach items="${member.classList}" var="member" >
			   		<td colspan="2"> ${member.semester } / 2학기</td>
		        	<td colspan="2"> ${member.lecPoint } /4.5 학점</td>
         		</c:forEach>
         		<c:forEach items="${member.lectureScoreList }" var="member">
         			<td colspan="2"> ${member.lecScr } /점</td>
         		</c:forEach>
				<c:forEach items="${member.listenerList}" var="member">
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
          <p>2024년 01월 12일</p>

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
  </body>
</html>


<script>





</script>

