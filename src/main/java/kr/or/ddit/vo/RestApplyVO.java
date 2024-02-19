package kr.or.ddit.vo;

import lombok.Data;


/// 휴 복학 신청
@Data
public class RestApplyVO {

	private int restNo;
	private int memNo;
	private String restApReason;
	private String restDate;
	private String restApDate;
	private String restApStatusCode;
	private String restType;
	private String restApReject;
	private int fileNo;
	
}
