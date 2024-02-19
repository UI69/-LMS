package kr.or.ddit.vo;

import lombok.Data;

// 등록금 내역
@Data
public class TuitionVO {

	private int tuitionNo;
	private int memNo;
	private int amount;
	private String semester;
	private String depositDate;
	private String tuitionStatusCode;
	
	
	private int dprtTuition;
	
}
