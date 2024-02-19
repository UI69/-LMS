package kr.or.ddit.vo;

import lombok.Data;

@Data
public class CalendarVO {
	private String id;
	private String title;
	private String start;
	private String end;
	
	private String className = "bg-secondary";
	
	private String univSchType;
	
	public void setUnivSchType(String univSchType) {
		this.univSchType = univSchType;
		if(univSchType.equals("UST001")) {
			className = "bg-success";
		}
		if(univSchType.equals("UST002")) {
			className = "bg-info";
		}
		if(univSchType.equals("UST003")) {
			className = "bg-warning";
		}
	}
	
	public void setId(int id) {
		this.id = String.valueOf(id);
	}
	public void setId(String id) {
		this.id = id;
	}
	
//	public CalendarVO() {}
//	
//	public CalendarVO(UnivScheduleVO univVO) {
//		this.start = univVO.getUnivSchStartDate().substring(0,10);
//		this.end = univVO.getUnivSchEndDate().substring(0,10);
//		//...
//	}
}
