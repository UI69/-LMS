package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;


// 시험
@Data
public class ExampleVO {
	
	private int examNo;
	private int classNo;
	private String examName;
	private String examDate;
	private int examTime;
	private String examType;
	private int examTotalScore;
	private String examMarkType;
	private String examYn;
	
	private String className;
	
	private List<ExampleQuestionVO> examQstList;
}
