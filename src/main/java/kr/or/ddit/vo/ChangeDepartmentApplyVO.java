package kr.or.ddit.vo;

import lombok.Data;


// 전과 신청
@Data
public class ChangeDepartmentApplyVO {

	
	private int chDprtNo;
	private int memNo;
	private int dprtNo;
	private String chDprtMsg;
	private String chDprtApDate;
	private String chDprtStatusCode;
	private String chDprtReject;
}
