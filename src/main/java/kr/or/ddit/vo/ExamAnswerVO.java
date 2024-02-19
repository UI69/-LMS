package kr.or.ddit.vo;

import lombok.Data;


// 시험 제출 답안
@Data
public class ExamAnswerVO {

	private int answerNo;
	private int examQstNo;
	private int examNo;
	private int memNo;
	private String answer;
	private int getScore;
	private String answerDate;
	
	private String memName;
	private String memId;
	
	private int totalScore;
	private String examName;
}
