package kr.or.ddit.vo;

import lombok.Data;


// 신고 목록
@Data
public class ReportVO {

	private int rptNo;
	private String rptDetails;
	private String rpt_Date;
	private String rptPerson;
	private int fileNo;
	
}
