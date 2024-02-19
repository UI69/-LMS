package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;



// 건물 목록
@Data
public class BuildingVO {

	private int buildingNo;
	private String buildingName;
	private String locationInfo;
	
//	private FacilityVO facilityVO;
	private List<FacilityVO> facilityList;
	
}
