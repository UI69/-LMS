package kr.or.ddit.vo;

import lombok.Data;


// 동아리 가입자 
@Data
public class ClubMemberVO {

	private int clubMemNo;
	private int clubNo;
	private int memNo;
	private String clubJoinDate;
	private String clubRegDate;
	private String clubRegMsg;
	private String clubRegStatusCode;
	
	
}
