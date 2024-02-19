package kr.or.ddit.vo;

import lombok.Data;

// 설문 조사 보기
@Data
public class SurveyQuestionChoiceVO {

	private int qstChNo;
	private int srvQstNo;
	private int srvNo;
	private int chNo;
	private String chStr;
	
	public SurveyQuestionChoiceVO() {	}
	public SurveyQuestionChoiceVO(String chStr) {
		this.chStr = chStr;
	}
}
