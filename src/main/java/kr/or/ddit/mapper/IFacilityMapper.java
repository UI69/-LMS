package kr.or.ddit.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.ddit.vo.BuildingVO;
import kr.or.ddit.vo.FacilityRentVO;
import kr.or.ddit.vo.PaginationVO;

public interface IFacilityMapper {
	public List<BuildingVO> getBuildingData();
	
	public List<FacilityRentVO> getfacilityResvData(@Param("pagingVO") PaginationVO<FacilityRentVO> pagingVO);
	
	public int facilityResvCnt(PaginationVO<FacilityRentVO> pagingVO);

	public int updateFacilityResvStatus(FacilityRentVO facilityRentVO);
	
	public List<FacilityRentVO> facilityRentCal(int facNo);		// 시설 예약 리스트(캘린더)
}
