package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;


// 설문 조사 문항
@Data
public class SurveyQuestionVO {

	private int srvQstNo;
	private int srvNo;
	private int qstNo;
	private String srvQst;
	private String srvQstType;
	
	private List<SurveyQuestionChoiceVO> srvQstChList;
}
