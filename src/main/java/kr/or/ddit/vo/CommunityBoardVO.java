package kr.or.ddit.vo;

import lombok.Data;


// 그룹 게시판
@Data
public class CommunityBoardVO {

	private int cmBrdNo;
	private int cmNo;
	private int memNo;
	private String memName;
	private String cmBrdCont;
	private String cmBrdDate;
	private int fileNo;
	
}
