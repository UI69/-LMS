package kr.or.ddit.vo;

import lombok.Data;

// 장학 정보
@Data
public class ScholarshipVO {

	private int schNo;
	private int sclSociety;
	private int schAmount;
	private String schName;
	private String schStartDate;
	private String schEndDate;
	private String schCont;
	private int fileNo;
	
}
