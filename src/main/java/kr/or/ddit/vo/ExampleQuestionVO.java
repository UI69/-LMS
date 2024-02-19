package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

// 시험 문제 
@Data
public class ExampleQuestionVO {

	private int examQstNo;
	private int examNo;
	private int qstNo;
	private String examQst;
	private int qstScore;
	private String qstType;
	private String qstCorrect;
	private int fileNo;
	
	private List<QuestionChoiceVO> qstChList;
}
