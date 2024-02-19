<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
  <aside class="main-sidebar">
    <!-- sidebar-->
    <section class="sidebar position-relative">	
	  	<div class="multinav">
		  <div class="multinav-scroll" style="height: 100%;">	
			  <!-- sidebar menu-->
			  <ul class="sidebar-menu" data-widget="tree">	
						
				<li class="header">MAIN</li>	
				
				<!-- 메인페이지 이동 -->
				<li>
				  <a href="/DYUniv/mainpage.do">
					<i class="icon-Layout-4-blocks"><span class="path1"></span><span class="path2"></span></i>
					<span>메인 페이지</span>
				  </a>
				</li>
				
				<!-- 강의 관리 -->
				<!-- <li class="treeview">
				  <a href="#">
					<i class="icon-Layout-4-blocks"><span class="path1"></span><span class="path2"></span></i>
					<span>강의 관리</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>
				  <ul class="treeview-menu">
					<li><a href="/DYUniv/lectureManagementForm.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>관리자 승인</a></li>
				  </ul>
				</li> -->
				
				<!-- 학생/교수 관리 -->
				<li class="treeview">
				  <a href="#">
					<i class="icon-Layout-grid"><span class="path1"></span><span class="path2"></span></i>
					<span>학생/교수 관리</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>
				  <ul class="treeview-menu">
					<li><a href="/DYUniv/employer/stuList.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>학생 관리</a></li>
					<li><a href="/DYUniv/employer/proList.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>교수 관리</a></li>
				  </ul>
				</li>
				
				<!-- 교무 관리 -->
				<li class="treeview">
				  <a href="#">
					<i class="icon-Write"><span class="path1"></span><span class="path2"></span></i>
					<span>교무 관리</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>
				  <ul class="treeview-menu">
					<li><a href="/DYUniv/dprtManagementForm.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>학과(전공) 관리</a></li>
					<li><a href="/DYUniv/lectureManagementForm.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>교과목 관리</a></li>
				  </ul>
				</li>		
				
				<!-- 등록금 및 장학금 -->
				<!-- <li class="treeview">
				  <a href="#">
					<i class="icon-File"><span class="path1"></span><span class="path2"></span></i>
					<span>등록금 및 장학금</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>
				  <ul class="treeview-menu">
					<li><a href="#"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>등록금 입금 관리</a></li>
					<li><a href="#"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>장학금 관리</a></li>
					<li><a href="#"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>장학생 관리</a></li>
				  </ul>
				</li>	 -->	
				
				<!-- 학생 관리 -->
				<li class="treeview">
				  <a href="#">
					<i class="icon-Library"><span class="path1"></span><span class="path2"></span></i>
					<span>학생 관리</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>
				  <ul class="treeview-menu">
					<!-- <li><a href="#"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>봉사활동</a></li> -->
					<li><a href="#"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>상담</a></li>
					<li><a href="#"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>전과 신청</a></li>
					<li><a href="#"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>학적 변동 신청</a></li>
					<!-- <li><a href="#"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>학생 정보</a></li> -->
					<!-- <li><a href="#"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>동아리</a></li> -->
					<!-- <li><a href="#"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>스터디</a></li> -->
				  </ul>
				</li>				
				
				<!-- 증명서 -->
				<!-- <li class="treeview">
				  <a href="#">
					<i class="icon-Cart"><span class="path1"></span><span class="path2"></span></i>
					<span>증명서</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>
				</li> -->	
				
				<!-- 설문조사 -->
				<li class="treeview">
				  <a href="#">
					<i class="icon-Chat-locked"><span class="path1"></span><span class="path2"></span></i>
					<span>설문조사</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>
				  <ul class="treeview-menu">
					<li><a href="/DYUniv/surveyManagementForm.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>설문조사 등록</a></li>			
					<li><a href="/DYUniv/surveyResult.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>설문조사 결과</a></li>			
				  </ul>
				</li>	
					
				<!-- 기타 -->
				<li class="treeview">
				  <a href="#">
					<i class="icon-Layout-4-blocks"><span class="path1"></span><span class="path2"></span></i>
					<span>기타</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>
				  <ul class="treeview-menu">		
					<li><a href="/DYUniv/facilityManage.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>시설 예약 목록</a></li>			
					<li><a href="#"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>강의실</a></li>		
					<li><a href="#"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>셔틀버스</a></li>	
					<li><a href="#"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>신문고</a></li>			
				  </ul>
				</li>
				
				
				<!-- 게시판 -->
				<li class="header">BOARD</li>
				<li class="treeview">
				  <a href="#">
					<i class="icon-Chat-locked"><span class="path1"></span><span class="path2"></span></i>
					<span>게시판</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>
				  <ul class="treeview-menu">
					<li><a href="/DYUniv/univSchedule.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>학사 일정</a></li>	
					<li><a href="/DYUniv/noticeBoard.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>공지사항</a></li>	
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
				  </ul>
				</li> 
			  </ul>
		  </div>
		</div>
    </section>
	<div class="sidebar-footer">
		<!-- <a href="javascript:void(0)" class="link" data-bs-toggle="tooltip" title="Settings"><span class="icon-Settings-2"></span></a>
		<a href="mailbox.html" class="link" data-bs-toggle="tooltip" title="Email"><span class="icon-Mail"></span></a> -->
		<a href="/logout.do" class="link" data-bs-toggle="tooltip" title="Logout"  style="width: 100%;"><span class="icon-Lock-overturning"><span class="path1"></span><span class="path2"></span></span></a>
	</div>
  </aside>