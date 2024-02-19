package kr.or.ddit.vo;

import javax.validation.constraints.Future;

import lombok.Data;

// 시설 예약 목록
@Data
public class FacilityRentVO {
	private int facRentNo;
	private int memNo;
	private int facNo;
	private String memName;
	private String facRegDate;
	@Future
	private String facRsvStartDate;
	@Future
	private String facRsvEndDate;
	private String facRentStatusCode;
	private String facReject;
	
	private BuildingVO buildingVO;
	private FacilityVO facilityVO;
	private MemberVO memberVO;
	
	private String facRentStatusStr;
	
	public void setFacRentStatusCode(String facRentStatusCode) {
		this.facRentStatusCode = facRentStatusCode;
		
		if("FAC001".equals(facRentStatusCode)) {
			facRentStatusStr = "신청";
		} else if("FAC002".equals(facRentStatusCode)) {
			facRentStatusStr = "승인";
		} else if("FAC003".equals(facRentStatusCode)) {
			facRentStatusStr = "반려";
		} else if("FAC004".equals(facRentStatusCode)) {
			facRentStatusStr = "취소";
		}
	}
}
