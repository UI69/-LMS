package kr.or.ddit.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

// 강의 관리 

@Data
public class ClassVO {
	
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

	// 여기까지 데이터 컬럼 값
	private String dprtName;
	private String dprtCategory;
	private int totalListener;
	
	private String memName;
	private String memPh;
	private String memEmail;
	
	private String fileName;
	
	private ScoreValueVO scoreValue;
	private RoomVO roomVO;
	private ListenerVO listenerVO;
	private MemberVO memberVO;
	
	private FilesVO file;
	
	private List<LectureVO> lectureList;
	private List<DepartmentVO> departmentList;
	private List<LectureScheduleVO> lecScheduleList;
	private List<ListenerVO> listenerList;
	
	private String classReqStr;
	private String classStatusStr;
	
	public void setClassStatusCode(String classStatusCode) {

		this.classStatusCode = classStatusCode;
		
		if ("CLS001".equals(classStatusCode)) {
		    classStatusStr = "신청";
		} else if("CLS002".equals(classStatusCode)) {
		    classStatusStr = "개설";
		} else if("CLS003".equals(classStatusCode)) {
		    classStatusStr = "반려";
		} else if("CLS004".equals(classStatusCode)) {
		    classStatusStr = "모집";
		} else if("CLS005".equals(classStatusCode)) {
		    classStatusStr = "진행";
		} else if("CLS006".equals(classStatusCode)) {
		    classStatusStr = "폐쇄";
		} else if("CLS007".equals(classStatusCode)) {
		    classStatusStr = "종료";
		}
	}
	
	public void setClassReqCode(String classReqCode) {
		
		this.classReqCode = classReqCode;
		if ("CLR001".equals(classReqCode)) {
		    classReqStr = "전공필수";
		} else if("CLR002".equals(classReqCode)) {
		    classReqStr = "전공선택";
		} else if("CLR003".equals(classReqCode)) {
		    classReqStr = "교양필수";
		} else if("CLR004".equals(classReqCode)) {
		    classReqStr = "교양선택";
		}
	}
	
}
