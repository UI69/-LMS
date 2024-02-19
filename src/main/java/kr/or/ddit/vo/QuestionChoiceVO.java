package kr.or.ddit.vo;

import lombok.Data;

// 보기  ( 시험)
@Data
public class QuestionChoiceVO {

	private int qstChNo;
	private int examQstNo;
	private int examNo;
	private int chNo;
	private String chStr;
	
	
	public QuestionChoiceVO() {	}
	public QuestionChoiceVO(String chStr) {
		this.chStr = chStr;
	}
}
