package kr.or.ddit.vo;

import lombok.Data;


// 상담 일정
@Data
public class CounselVO {

	private int    cnslNo			;
	private int    memNo2			;
	private int    memNo1			;
	private String memName1			;
	private String memName2			;
	private String cnslType			;
	private String cnslStartDate	;
	private String cnslEndDate		;
	private String cnslRegDate		;
	private String cnslStatusCode	;
	private String cnslReason		;
	private String cnslDetails		;
	private String cnslReject		;
	
	private MemberVO counselor;
	private MemberVO student;
}
