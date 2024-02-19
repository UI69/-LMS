package kr.or.ddit.vo;

import lombok.Data;

// 성적 입력
@Data
public class LectureScoreVO {

	private int lecScrNo;
	private int listenNo;
	private int memNo;
	private int lecScr;
	
	private int lecPoint;
	private String classScore;
	private String semester;
	private String className;
	private String classNo;
}
