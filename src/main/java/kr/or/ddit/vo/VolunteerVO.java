package kr.or.ddit.vo;

import lombok.Data;


// 교외 봉사 활동 
@Data
public class VolunteerVO {

	private int vlntNo;
	private int memNo;
	private String memName;
	private String vlntStatusCode;
	private String vlntSociety;
	private String vlntExp;
	private int vlntTime;
	private String vlntReject;
	private String vlntDate;
	private int fileNo;
	
}
