package kr.or.ddit.vo;

import lombok.Data;

// 강의 일정
@Data
public class LectureScheduleVO {

	private int lecSchNo;
	private int classNo;
	private String lecDowCode;
	private String lecStartTime;
	private String lecEndTime;
	private String lecStartDate;
	private String lecEndDate;
	
	private String lecDowStr;
	private String lecStartTimeStr;
	private String lecEndTimeStr;
	
	public void setLecDowStr(String lecDowStr) {

		this.lecDowStr = lecDowStr;
		
		if ("월".equals(lecDowStr)) {
			lecDowCode = "LDW001";
		} else if("화".equals(lecDowStr)) {
			lecDowCode = "LDW002";
		} else if("수".equals(lecDowStr)) {
			lecDowCode = "LDW003";
		} else if("목".equals(lecDowStr)) {
			lecDowCode = "LDW004";
		} else if("금".equals(lecDowStr)) {
			lecDowCode = "LDW005";
		} else if("토".equals(lecDowStr)) {
			lecDowCode = "LDW006";
		} else if("일".equals(lecDowStr)) {
			lecDowCode = "LDW007";
		}
	}
	
	public void setLecStartTime(String lecStartTime) {
		this.lecStartTime = lecStartTime;
		lecStartTimeStr = dow(lecStartTime);
	}
	
	public void setLecEndTime(String lecEndTime) {
		this.lecEndTime = lecEndTime;
		lecEndTimeStr = dow(lecEndTime);
	}
	
	
	private String dow(String timeCode) {
		String timeStr = "";
		if ("LET001".equals(timeCode)) {
			timeStr ="1";
		} else if("LET002".equals(timeCode)) {
			timeStr ="2";
		} else if("LET003".equals(timeCode)) {
			timeStr ="3";
		} else if("LET004".equals(timeCode)) {
			timeStr ="4";
		} else if("LET005".equals(timeCode)) {
			timeStr ="5";
		} else if("LET006".equals(timeCode)) {
			timeStr ="6";
		} else if("LET007".equals(timeCode)) {
			timeStr ="7";
		} else if("LET008".equals(timeCode)) {
			timeStr ="8";
		} else if("LET009".equals(timeCode)) {
			timeStr ="9";
		} else if("LET010".equals(timeCode)) {
			timeStr = "10";
		}
		return timeStr;
	}
}
