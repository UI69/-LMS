package kr.or.ddit.vo;

import lombok.Data;


// 교내 봉사활동 신청 목록
@Data
public class UnivVolunteerApplyVO {

	private int univVlntApNo;
	private int univVlntNo;
	private int memNo;
	private String memName;
	private String univVlntDate;
	
}
