<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
  <aside class="main-sidebar">
    <!-- sidebar-->
    <section class="sidebar position-relative">	
	  	<div class="multinav">
		  <div class="multinav-scroll" style="height: 100%;">	
			  <!-- sidebar menu-->
			  <ul class="sidebar-menu" data-widget="tree">	
			  
			  	<!-- <li class="header">교수사이드(확인용)</li> -->
				<li class="header">MAIN</li>
				
				<!-- 메인페이지 이동 -->
				<li>
				  <a href="/DYUniv/mainpage.do">
					<i class="icon-Layout-4-blocks"><span class="path1"></span><span class="path2"></span></i>
					<span>메인 페이지</span>
				  </a>
				</li>
				
				<!-- 강의 관리 -->
				<li class="treeview">
				  <a href="#">
					<i class="icon-Layout-4-blocks"><span class="path1"></span><span class="path2"></span></i>
					<span>강의 관리</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>
				  <ul class="treeview-menu">
					<li><a href="/DYUniv/professor/classOpenList.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>개설 신청 목록</a></li>
				  </ul>
				</li>			
				
				<!-- 수업 관리 -->
				<li class="treeview">
				  <a href="#">
					<i class="icon-Layout-grid"><span class="path1"></span><span class="path2"></span></i>
					<span>수업 관리</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>
				  <ul class="treeview-menu">
					<li><a href="/DYUniv/myProgressClassList.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>수업 목록</a></li>
					<li><a href="/DYUniv/professor/scoreSetting.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>학점 현황</a></li>								
					<li><a href="#"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>이의 신청</a></li>
				  </ul>
				</li>
				
				<!-- 성적 관리 -->
				<!-- <li class="treeview">
				  <a href="#">
					<i class="icon-Write"><span class="path1"></span><span class="path2"></span></i>
					<span>성적 관리</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>
				  <ul class="treeview-menu">			
				  </ul>
				</li>	 -->
				
				<!-- 상담 관리 -->	
				<li class="treeview">
				  <a href="#">
					<i class="icon-Group-chat"><span class="path1"></span><span class="path2"></span><span class="path3"></span></i>
					<span>상담 관리</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-right pull-right"></i>
					</span>
				  </a>					
				  <ul class="treeview-menu">					
					<li><a href="/DYUniv/counsel/counselorSchedule.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>상담 일정 설정</a></li> 		
					<li><a href="/DYUniv/counsel/counselList.do"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>상담 신청 목록</a></li> 		
				  </ul>
				</li>
 
 
				<!-- 게시판  -->
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
					<li><a href="#"><i class="icon-Commit"><span class="path1"></span><span class="path2"></span></i>시간표 조회</a></li>					
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