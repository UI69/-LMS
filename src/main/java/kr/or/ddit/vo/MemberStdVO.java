package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

// 대학인원
@Data
public class MemberStdVO {	
	private int memNo;
	private int dprtNo;
	private String memId;
	private String memPw;
	private String memName;
	private String memGen;
	private String memBir;
	private String memPh;
	private String memEmail;
	private int memPostcode;
	private String memAddr1;
	private String memAddr2;
	private String otpKey;
	private String memProfile;
	private String memRole;
	private String memTempPw;
	private String memTotalGrade;	// 학생 총 성적(평균)
	
	private DepartmentVO departmentVO;	//학과
	
//	private String dprtName;	// 학과명
//	private String dprtCategory;	// 대학분류

	private StudentInfoVO studentInfoVO; // 학생 정보 

	
	private List<ClassVO> classList;
	private List<ListenerVO> listenerList;
	private List<LectureScoreVO> lectureScoreList;
	
}
