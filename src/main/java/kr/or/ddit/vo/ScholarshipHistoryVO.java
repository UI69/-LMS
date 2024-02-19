package kr.or.ddit.vo;

import lombok.Data;

// 장학금 내역
@Data
public class ScholarshipHistoryVO {

	private int sclNo;
	private int memNo;
	private int schNo;
	private String schType;
	private String sclDate;
	
	private int schMoney;
	private String schName;
	private String sclSociety;
	private String schCont;
	
}
