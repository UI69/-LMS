package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

// 강의 관리 

@Data
public class MyClassVO {

	
	private int    classNo         ;
	private int    lecNo           ;
	private int    memNo           ;
	private String roomNo          ;
	private String valueType       ;
	private String className       ;
	private int    lecPoint        ;
	private String semester         ;
	private String classReqCode   ;
	private int    classMaxMem    ;
	private int    classTotalTime ;
	private int    examProprion    ;
	private int    hwPropotion     ;
	private int    atPropotion     ;
	private String classStatusCode	;
	private int    classWeekCnt   	;
	private String classNote       ;
	private String classReject     ;
	private int    fileNo          ;

	private String classScore;
	private String lsStatusCode;
	
	private String dprtCategory;
	private String dprtName;
	
	private int classRegCnt;
	private int lecScr;
	
	// 강의 일정	
	private int lecSchNo;
	private String lecStartDate;
	private String lecEndDate;
	private String lecStartTime;
	private String lecEndTime;
	private String lecDowCode;
	
	//private List<LectureScheduleVO> lecScheduleList;
}
