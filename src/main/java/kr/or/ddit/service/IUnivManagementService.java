package kr.or.ddit.service;

import java.util.List;

import kr.or.ddit.entity.ServiceResult;
import kr.or.ddit.vo.BuildingVO;
import kr.or.ddit.vo.FacilityRentVO;
import kr.or.ddit.vo.FacilityVO;
import kr.or.ddit.vo.PaginationVO;
import kr.or.ddit.vo.UnivScheduleVO;

public interface IUnivManagementService {
	// 학사일정
	public List<UnivScheduleVO> univScheduleList(PaginationVO<UnivScheduleVO> pagingVO);
	
	public List<UnivScheduleVO> univSchedule();
	
	public int univSchCnt(PaginationVO<UnivScheduleVO> pagingVO);
	
	public ServiceResult addSchedule(UnivScheduleVO scheduleVO);
	
	public List<UnivScheduleVO> univScheduleWidget();
	
	public int updateSchedule(UnivScheduleVO univScheduleVO);
	
	public int updateSchedule1(UnivScheduleVO scheduleVO);
	
	public int deleteSchedule(UnivScheduleVO univScheduleVO);
	
	
	// 시설
	public List<FacilityRentVO> facilityRentList(PaginationVO<FacilityRentVO> pagingVO);
		
	public List<BuildingVO> buildingList();
	
	public BuildingVO buildingSelect(BuildingVO buildingVO);
	
	public FacilityVO facilitySelect(FacilityVO facilityVO);
	
	public List<BuildingVO> getBuildingData();
	
	public List<FacilityRentVO> getfacilityResvData(PaginationVO<FacilityRentVO> pagingVO);
	
	public int facilityResvCnt(PaginationVO<FacilityRentVO> pagingVO);
	
	public int updateFacilityResvStatus(FacilityRentVO facilityRentVO);
	
	public ServiceResult facReservation(FacilityRentVO facilityRentVO);

	public List<FacilityRentVO> facilityRentCal(int facNo);

	

	
}