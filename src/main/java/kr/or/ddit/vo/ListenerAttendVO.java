package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;


// 수강생 신청관리 / 출석체크
@Data
public class ListenerAttendVO {

	private int listenNo;
	private int classNo;
	private int memNo;
	private String classScore;
	private String lsStatusCode;
	private int classWeekCnt;
	

	private List<LectureScheduleVO> lecScheduleList;
	private List<AttendVO> attendList;
	private List<MemberVO> member;
	
}
