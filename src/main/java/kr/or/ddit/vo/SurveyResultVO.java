package kr.or.ddit.vo;

import lombok.Data;

// 설문 조사 결과 
@Data
public class SurveyResultVO {

	private int srvResNo;
	private int srvNo;
	private int srvQstNo;
	private int memNo;
	private String svrResAns;
	private String svrResDate;
	
}
