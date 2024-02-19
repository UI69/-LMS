package kr.or.ddit.vo;

import lombok.Data;

// 성적 정정신청
@Data
public class ChangeScoreApplyVO {

	private int chApNo;
	private int lecScrNo;
	private String chStatusCode;
	private String chReason;
	private String chApReject;
	
}
