package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;


// 일정 정보 
@Data
public class ScheduleDataVO {

	private int schDataNo;
	private int memNo;
	private String schName;
	private String schStart;
	private String schEnd;
	private String schDataCode;
	private String schStartTime;
	private String schEndTime;
	
	private List<Integer> memNoList;
}
