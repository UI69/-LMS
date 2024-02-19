package kr.or.ddit.vo;

import lombok.Data;

// 셔틀 버스 
@Data
public class ShuttleBusVO {

	private int shuttleNo;
	private String shuttleUpdate;
	private String shuttleName;
	private String shuttleRoute;
	private String shuttleTime;
	private int fileNo;

}
