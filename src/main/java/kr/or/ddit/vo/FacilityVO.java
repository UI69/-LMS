package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;


// 시설 목록
@Data
public class FacilityVO {

	private int facNo;
	private int buildingNo;
	private String facName;
	private String facType;
	
	private FacilityRentVO facilityRentVO;
	private List<FacilityRentVO> facilityRentList;
	
}
