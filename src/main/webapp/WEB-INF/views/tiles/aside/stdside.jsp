<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
  <aside class="main-sidebar">
    <!-- sidebar-->
    <section class="sidebar position-relative">	
	  	<div class="multinav">
		  <div class="multinav-scroll" style="height: 100%;">	
			  <!-- sidebar menu-->
			  <ul class="sidebar-menu" data-widget="tree">	
			  
				<!-- <li class="header">학생사이드(확인용)</li> -->
				<li class="header">MAIN</li>
				
				<!-- 메인페이지 이동 -->
				<li>
				  <a href="/DYUniv/mainpage.do">
					<i class="icon-Layout-4-blocks"><span class="path1"></span><span class="path2"></span></i>
					<span>메인 페이지</span>
				  </a>
				</li>
				
				<!-- 수강 -->
				<!-- <li class="treeview">
				  <a href="#">
					<i class="icon-File"><span class="path1"></span><span class="path2"></span></i>
					<span>수강 신청</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>
				  <ul class="treeview-menu">
				  </ul>
				</li> -->
				
				<!-- 출석, 성적 조회 -->
				<li class="treeview">
				  <a href="">
					<i class="icon-Write"><span class="path1"></span><span class="path2"></span></i>
					<span>강의</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>
				  <ul class="treeview-menu">
					<li><a href="/DYUniv/student/lecture/lectureList.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>수강신청</a></li>
					<li><a href="/DYUniv/student/class/myClassList.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>내 강의 목록</a></li>
					<li><a href="/DYUniv/student/class/classSchedule.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>수강 시간표 조회</a></li>
					<li><a href="/DYUniv/student/class/myClassScore.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>성적 조회</a></li>
				  </ul>
				</li>
				
				<!-- 동아리-->
				<!-- <li class="treeview">
				  <a href="#">
					<i class="icon-Cart"><span class="path1"></span><span class="path2"></span></i>
					<span>동아리</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>
				  <ul class="treeview-menu">
					<li><a href="/DYUniv/clubList.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>동아리 목록</a></li>
					<li><a href="/DYUniv/student/myClub.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>내 동아리</a></li>									
				  </ul>
				</li> -->

				<!-- 모임 그룹 관리 -->
				<li class="treeview">
				  <a href="#">
					<i class="icon-Layout-grid"><span class="path1"></span><span class="path2"></span></i>
					<span>커뮤니티</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>
				  <ul class="treeview-menu">
					<li><a href="/DYUniv/student/communityHome.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>커뮤니티 홈</a></li>
					<li><a href="/DYUniv/student/myCommunity.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>내 커뮤니티 목록</a></li>					
				  </ul>
				</li>

				<!-- 학교 시설 이용 신청 -->
				<li class="treeview">
				  <a href="#">
					<i class="icon-Layout-4-blocks"><span class="path1"></span><span class="path2"></span></i>
					<span>학교 시설 이용</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>
				  <ul class="treeview-menu">
					<li><a href="/DYUniv/facility/rentForm.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>시설 예약 하기</a></li>
					<li><a href="/DYUniv/facility/rentList.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>예약 내역</a></li>					
				  </ul>
				</li>
			
				<!-- 설문조사-->
				<li class="">
				  <a href="/DYUniv/surveyList.do">
					<i class="icon-Chart-pie"><span class="path1"></span><span class="path2"></span></i>
					<span>설문조사</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>
				  <!-- <ul class="treeview-menu">
					<li><a href="/DYUniv/surveyList.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>설문조사 목록</a></li>
					<li><a href="/DYUniv/student/survey/mySurveyList"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>참여한 설문 확인</a></li>					
				  </ul> -->
				</li>
				
				<!-- 기타 -->
				<!-- <li class="treeview">
				  <a href="#">
					<i class="icon-Chat-locked"><span class="path1"></span><span class="path2"></span></i>
					<span>기타</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>
				  <ul class="treeview-menu">
					<li><a href="/DYUniv/counsel/counselList.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>상담</a></li>
					<li><a href="/DYUniv/student/univInfo/professorList.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>교수 정보 검색</a></li>					
					<li><a href="/DYUniv/student/univInfo/campusMap.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>대학교 맵</a></li>					
					<li><a href="/DYUniv/student/univInfo/shuttleBus.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>셔틀버스 배차 확인</a></li>					
					<li><a href="/DYUniv/student/univInfo/report.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>온라인 신고</a></li>					
				  </ul>
				</li> -->	
				
				
				<!-- 상담 -->
				<li class="">
				  <a href="/DYUniv/counsel/counselList.do">
					<i class="icon-Chat-locked"><span class="path1"></span><span class="path2"></span></i>
					<span>상담</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>
				</li>
				
				<!-- 게시판 사용 -->
				<li class="header">BOARD</li>
				<li class="treeview">
				  <a href="#">
					<i class="icon-Library"><span class="path1"></span><span class="path2"></span></i>
					<span>게시판</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>
				  <ul class="treeview-menu">
					<li><a href="/DYUniv/noticeBoard.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>공지사항</a></li>
					<li><a href="/DYUniv/univSchedule.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>학사 일정</a></li>
					<li><a href="/DYUniv/anonymouseBoard.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>대나무숲</a></li>
					<li><a href="/DYUniv/lostItemBoard.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>분실물</a></li>
				  </ul>
				</li>
				
				
				<!-- 마이페이지 -->
				<li class="header">MYPAGE</li>	
				<li class="treeview">
				  <a href="#">
					<i class="icon-User"><span class="path1"></span><span class="path2"></span></i>
					<span>마이페이지</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>
				  <ul class="treeview-menu">
				  	<li><a href="/DYUniv/passCheck.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>내 정보</a></li>	
					<li><a href="#"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>민원 신청 목록</a></li>
					<li><a href="/DYUniv/restApplyForm.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>학적 변동 신청</a></li>
					<li><a href="/DYUniv/departChange.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>전과 신청</a></li>
					<!-- <li><a href="/DYUniv/scholshipTuition.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>등록금 및 장학금</a></li> -->
					<li><a href="/DYUniv/certificate"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>증명서 </a></li>
				  </ul>
				</li>		
				
			  </ul>
		  </div>
		</div>
    </section>
	<div class="sidebar-footer">
		<!-- <a href="javascript:void(0)" class="link" data-bs-toggle="tooltip" title="Settings"><span class="icon-Settings-2"></span></a>
		<a href="mailbox.html" class="link" data-bs-toggle="tooltip" title="Email"><span class="icon-Mail"></span></a> -->
		<a href="/logout.do" class="link" data-bs-toggle="tooltip" title="Logout" style="width: 100%;"><span class="icon-Lock-overturning"><span class="path1"></span><span class="path2"></span></span></a>
	</div>
  </aside>