package kr.or.ddit.vo;

import lombok.Data;


// 강의실
@Data
public class RoomVO {

	private String roomNo;
	private int buildingNo;
	private String roomName;
	private int roomCap;
	
}
