package kr.or.ddit.vo;

import lombok.Data;

@Data
public class MemberStdInsVO {

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
	private String memNationCode;
	
	private String memRegDate;
	private String memGrdDate;
	private String memStatusCode;
	private int memStdGrade;
}
