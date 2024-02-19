package kr.or.ddit.vo;

import lombok.Data;

// 교과목 관리
@Data
public class LectureVO {

	private int lecNo;
	private int memNo;
	private int dprtNo;
	private String lecName;
	private int lecPoint;
	private String lecNote;

	private String dprtName;
	
}
