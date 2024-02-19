package kr.or.ddit.vo;

import lombok.Data;

// 현상 실습 후기
@Data
public class TrainingReviewVO {

	private int trnRvNo;
	private int trnNo;
	private int memNo;
	private String memName;
	private String trnRvCont;
	
}
