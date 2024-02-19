package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;


// 수강생 신청관리
@Data
public class ListenerVO {

	private int listenNo;
	private int classNo;
	private int memNo;
	private String classScore;
	private String lsStatusCode;
	
	private MemberVO member;
	private ClassVO classVO;
	
	private List<ExampleVO> exampleList;
	private int totalExamScore;
	
	private List<HomeworkVO> hwList;
	private int totalHwScore;
	
	private List<AttendVO> attendList;
	

	
}
