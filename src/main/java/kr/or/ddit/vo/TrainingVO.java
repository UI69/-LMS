package kr.or.ddit.vo;

import lombok.Data;


// 현장 실습 목록
@Data
public class TrainingVO {

	private int trnNo;
	private int classNo;
	private String trnName;
	private String trnSociety;
	private String trnStatusCode;
	private int trnMaxMem;
	private String trnStartDate;
	private String trnEndDate;
	private String trnContent;
	
}
