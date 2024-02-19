package kr.or.ddit.vo;

import lombok.Data;


// 동아리 게시판
@Data
public class ClubBoardVO {

	private int clubBrdNo;
	private int clubNo;
	private int memNo;
	private String clubBrdTitle;
	private String clubBrdCont;
	private String clubBrdWriteDate;
	private int clubBrdHitCount;
	private int fileNo;
	
	
}
