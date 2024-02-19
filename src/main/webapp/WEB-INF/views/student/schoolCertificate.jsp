<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
  
   
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
  </head>
  <body>
    <div class="page">
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
            <td>${member.studentInfoVO.memRegDate }</td>
          </tr>
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
 